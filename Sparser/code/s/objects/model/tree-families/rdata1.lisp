;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992-2005,2011 David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved
;;;
;;;     File:  "rdata"
;;;   Module:  "objects;model:tree-families:"
;;;  version:  1.3 February 2011

;; initiated 8/4/92 v2.3, fleshed out 8/10, added more cases 8/31
;; 0.1 (5/25/93) changed what got stored, keeping around a dereferenced
;;      version of the rdata so that individuals could prompt rule definition
;; 0.2 (10/25) Allowed mappings to multiple categories
;;     (1/17/94) added :adjective as a option for heads. 5/24 added 'time-deictic'
;;     5/26 aded 'adverb'  10/6 added option for a label to be a word
;; 0.3 (10/20) rewrote 'time-deictic' as 'standalone-word'
;; 0.4 (11/1) hacked Setup-rdata to have rules be written even when the head word
;;      specifies a variable rather than a word
;; 1.0 (12/6/97) bumped on general principles given new work on psi.
;;     (7/5/98) modified Decode-rdata-mapping to allow lists of words.
;; 1.1 (7/12) provided for multiple definitions.
;;     (6/24/99) Added standalone rdata assembler to solve timing problems.
;;     (7/3) renamed it '1'.
;; 1.2 (9/3) Adjusted Dereference-rdata to use the symbol :no-head-word
;;      when there isn't one, instead of the value nil. This solved a problem
;;      with the rdata of currency.
;;     (9/30) Tweaked Decode-rdata-mapping to appreciate the possibility that
;;      a parameter could get the value :self.
;;     (11/18) Added :preposition to the list in Vet-rdata-keywords and
;;      dereference-rdata. (7/11/00) added :quantifier.  (4/11/05) added check 
;;      to Decode-rdata-mapping to allow symbols to pass on through if they're
;;      the names of functions. (7/23/09) Added interjection.
;; 1.3 (2/21/11) Added define-marker-category as another standalone def form
;;      where we're defining a minimal category along with its realization. 

(in-package :sparser)


;;;---------------------
;;; standalone def form
;;;---------------------

;; This is marked '1' because there's no utility yet in reconciling
;; its argument signature with the earlier Define-realization that
;; is part of the mechanics of writing out contructed definitions.
;; See interface;workbench:def rule.

(defmacro define-realization1 (category &body rdata)
  `(if (category-named ',category)
     (setup-rdata (category-named ',category) ',rdata)
     (break "There is no category named ~a" ',category)))


(defmacro define-marker-category (category-name &key realization)
  "This amounts to reversible syntactic sugar for the light, 'glue'
   categories that don't add any content (variables) but indicate
   a context for a complement (folded into the realization by name)
   that controls how it's incorporated into larger phrases.
     The category that's created is just the minimal form of
   simple syntactic categories. For something substantive use
   full arguments with define-category."
  `(define-marker-category/expr ',category-name ',realization))

(defun define-marker-category/expr (category-name realization-expr)
  (let ((category (or (category-named category-name)
                      (find-or-make-category  
                       category-name :def-category))))
    (setup-rdata category realization-expr)))


;;;-----------------------------------------------------------
;;; entry point from the definition of a referential category
;;;-----------------------------------------------------------

;; Setup-rdata ia called from Decode-category-parameter-list as part of defining
;; a category This routine is responsible for decoding the rdata field,
;; the routines in [driver] are the ones that actually create the rules

(defun setup-rdata (category rdata)
  (let ((old-rules
         (when (cat-realization category)
           (cadr (member :rules (cat-realization category))))))

    (etypecase (first rdata)
      (cons (setup-for-multiple-rdata category rdata))
      (keyword (setup-single-rdata category rdata)))

    (let ((new-rules
           (cadr (member :rules (cat-realization category)))))

      (when old-rules      
        (dolist (cfr old-rules)
          (unless (member cfr new-rules :test #'eq)
            (format t "~A ~A~%  no longer supported by rdata for ~A"
                    (symbol-name (cfr-symbol cfr)) cfr category)
            (delete/cfr cfr))))

      new-rules )))


(defun setup-single-rdata (category rdata)
  ;; 1st check for spelling errors in the keywords
  (vet-rdata-keywords category rdata)
  ;; now dereference the symbols
  (dereference-and-store?-rdata-schema category rdata t))

(defun setup-for-multiple-rdata (category list-of-rdata)
  (let ( head-word  etf  mapping  rules  local-cases 
         all-schemas  all-rules )
    (dolist (rdata list-of-rdata)
      (vet-rdata-keywords category rdata)
      (multiple-value-setq (head-word etf mapping local-cases rules)
        (dereference-and-store?-rdata-schema category rdata nil))
      (push `(:schema (,head-word ,etf ,mapping ,local-cases))
            all-schemas)
      (setq all-rules (append rules all-rules)))
    (setf (cat-realization category)
          `(:rules ,all-rules ,@all-schemas))))


(defun dereference-and-store?-rdata-schema (category rdata store?)
  (multiple-value-bind (head-word etf mapping local-cases)
                       (apply #'dereference-rdata category rdata)

    (let ((rules (make-rules-for-realization-data
                  category head-word etf mapping local-cases)))

      (if store?
        (setf (cat-realization category)
              `(:schema (,head-word
                         ,etf
                         ,mapping
                         ,local-cases)
                :rules ,rules))
        (values head-word etf mapping local-cases rules)))))



(defun vet-rdata-keywords (category rdata)
  (do ((key (car rdata) (car rest))
       (rest (cddr rdata) (cddr rest)))
      ((null key))

    (unless (keywordp key)
      (error "Realization data for ~A includes ~A~
              ~%    which is in a keyword position but isn't a keyword"
             category key))

    (unless (member key
                    '(:tree-family :mapping
                      :main-verb :common-noun :proper-noun
                      :quantifier :adjective :interjection
                      :adverb :preposition :word :standalone-word
                      :special-case-head
                      :additional-rules )

                    :test #'eq)
      (error "In the realization data for ~A~
              ~%there is the key ~A~
              ~%which isn't one of the defined keys.~
              ~%Check the spelling."
             category key))))





  
;;;------------------------------------------------
;;; the real driver: symbols -> objects by keyword
;;;------------------------------------------------

(defvar *schematic?* nil
  "A device to communicate between Deref-rdata-word, where the fact
   that a head-word has been given as the name of a variable rather
   than a string defines the rdata as being schematic, and the
   function below, where I want to pass that fact back to its caller.")

(defun dereference-rdata (category
                          &key ((:tree-family tf-name))
                               mapping
                               ((:main-verb    mvb-name))
                               ((:common-noun  cn-name))
                               ((:proper-noun  pn-name))
                               standalone-word
                               adjective
                               quantifier
			       interjection
                               adverb
                               preposition
                               word
                               ((:special-case-head  no-head))
                               ((:additional-rules cases)))
  
  ;; called from Setup-rdata using 'apply'

  (setq *schematic?* nil)  ;; initialize the flag
  (let ((head-word
         ;; Since we're not going to instantiate the rules for these
         ;; right here, and since the next layer isn't keyword driven,
         ;; we have to encode the part-of-speech information here.
         (cond (mvb-name
                (cons :verb
                      (deref-rdata-word mvb-name category)))
               (cn-name
                (cons :common-noun
                      (deref-rdata-word cn-name category)))
               (adjective
                (cons :adjective
                      (deref-rdata-word adjective category)))
               (quantifier
                (cons :quantifier
                      (deref-rdata-word quantifier category)))
               (adverb
                (cons :adverb
                      (deref-rdata-word adverb category)))
               (interjection
                (cons :interjection
                      (deref-rdata-word interjection category)))
               (preposition
                (cons :preposition
                      (deref-rdata-word preposition category)))
               (standalone-word
                (cons :standalone-word
                      (deref-rdata-word standalone-word category)))
               (word
                (cons :word
                      (deref-rdata-word word category)))
               (pn-name
                (cons :proper-noun
                      (deref-rdata-word pn-name category)))
               (no-head )
               (t ;(break "No head word included with the rdata for ~A~
                  ;        ~%Continue if that's ok" category)
                  nil )))
        
        (tf (exploded-tree-family-named tf-name))
        decoded-mapping  decoded-cases )

    (when tf-name
      (unless tf
        (error "There is no tree family named ~A~
                ~% category = ~A" tf-name category))
      (setq decoded-mapping
            (decode-rdata-mapping mapping category tf)))

    (when cases
      (setq decoded-cases (decode-cases cases)))

    (values (if (or no-head
                    (null head-word))
              :no-head-word ;; previously nil (9/3/99
              head-word)
            tf
            decoded-mapping
            decoded-cases
            *schematic?* )))



(defun deref-rdata-word (string-or-symbol category)
  (etypecase string-or-symbol
    (list
     ;; its either multiple (synomymous) words or the specification
     ;; of special cases in the morphology or both
     (cond ((listp (first string-or-symbol))
            ;; its both
            (mapcar #'(lambda (string)
                        (deref-rdata-word string category))
                    string-or-symbol))
           ((some #'keywordp string-or-symbol)
            ;; its a specificiation
            (deref-rdata-word-with-morph string-or-symbol))
           (t  ;; multiple words
            (mapcar #'(lambda (string)
                        (deref-rdata-word string category))
                    string-or-symbol))))

    (symbol
     (if string-or-symbol
       (let ((var (find string-or-symbol (cat-slots category)
                        :key #'var-name)))
         (unless var
           (error "Rdata word field contains a symbol indicating it ~
                   denotes a variable~%but the symbol ~A does not ~
                   correspond to any of the ~%variables of ~A"
                  string-or-symbol category))
         (setq *schematic?*  ;; flag in the caller
               `t)
         var )
       (else
         (break "null string-or-symbol passed in")
         :foo )))

    (string
     (resolve-string-to-word/make string-or-symbol))))



(defun deref-rdata-word-with-morph (specification)
  ;; we pass back a list where the strings have been replaced
  ;; with words.
  (let ( dereffed )
    (dolist (term specification)
      (push (etypecase term
              (keyword term)
              (string (resolve-string-to-word/make term)))
            dereffed))
    (nreverse dereffed)))



(defun decode-cases (cases)
  ;; Additional cases don't use mappings. They use the names of
  ;; categories, words, or variables directly.  Given the way the
  ;; rest of the modularity has worked out, all we have to do is
  ;; look for strings and replace them since everything else will
  ;; have been handled by replace-from-mapping even though it's
  ;; really superfluous.
  (let ( relation rule lhs  rhs  referent  decoded-cases )
    (dolist (case cases)
      (setq relation (first case)
            rule (cadr case))
      (setq lhs (first rule)
            rhs (second rule)
            referent (cddr rule))

      (when (some #'stringp rhs)
        (let ( acc )
          (dolist (term rhs)
            (push (if (stringp term)
                    (resolve-string-to-word/make term)
                    term)
                  acc))
          (setq rhs (nreverse acc))))

      (push `(,relation (,lhs ,rhs
                              ,@referent ))
            decoded-cases))

    (nreverse decoded-cases)))




(defun decode-rdata-mapping (mapping category tf)

  ;; semantic parameters are decoded as variables
  ;; syntactic labels are decoded as categories

  (let ((parameters (etf-parameters tf))
        (labels (etf-labels tf))
        (variables (cat-slots category))
        term value var cat new-list )

    (dolist (pair mapping)
      (setq term (car pair)
            value (cdr pair))

      (when (listp value)
        ;; either there's a notation error and they've left off the dot
        ;; or there are several categories that are to be mapped to.
        ;; We check here for the notation error.
        (when (null (cadr value))
          (setq value (car value))
          (format t "~%Mapping values should be dotted pairs.~
                     ~%The ~A pair of ~A isn't a pair.~
                     ~%Continuing anyway." pair category)))
      (cond
       ((member term parameters :test #'eq)
        (if (eq value :self)
          (setq var category)
          (else
            (setq var (find value variables :key #'var-name))
            (unless var
              (if (ever-appears-in-function-referent term tf)
                (setq var value)
                (error "There is no variable named ~A in ~A,~
                        ~%as used in its rdata." term category)))))
        (push (cons term var)
              new-list))

       ((member term labels :test #'eq)
        (setq cat
              (cond ((eq value :self)
                     category)
                    ((stringp value)
                     (resolve-string-to-word/make value))
                    ((listp value)
                     (let ( acc )
                       (dolist (v value)
                         (if (stringp v)
                           (push (resolve-string-to-word/make v) acc)
                           (push (find-or-make-category-object
                                  v :def-category)
                                 acc)))
                       (nreverse acc)))
                    (t (find-or-make-category-object
                        value :def-category))))
        (push (cons term cat)
              new-list))

       (t (error "The term ~A in the rdata mapping for ~A~
                  ~%isn't defined for the exploded tree family ~A"
                 term category tf))))

    (nreverse new-list)))


(defun ever-appears-in-function-referent (term tf)
  ; The alternative to this rather deep check is to add another
  ; field to etf to hold this case of a simple symbol (the name
  ; of a function) that forestalls its interpretation as either
  ; a category or a binding variable by Decode-rdata-mapping.
  (let ((cases (etf-cases tf))
        referent  fn-exp  does-appear? )
    (dolist (schr cases)
      (setq referent (schr-referent schr))
      (when referent
        (setq fn-exp (cadr (memq :function referent)))
        (when fn-exp
          (when (memq term fn-exp)
            (setq does-appear? t)))))
    does-appear?))
