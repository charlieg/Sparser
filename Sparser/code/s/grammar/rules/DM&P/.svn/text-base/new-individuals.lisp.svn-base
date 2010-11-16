;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:  "new individuals"
;;;    Module:  "grammar;rules:DM&P:"
;;;   version:  March 1994

;; initiated 3/28/94 v2.3

(in-package :sparser)


;;;-------------------------------------------------------
;;; the category all the individuals will be instances of
;;;-------------------------------------------------------

(define-category  unknown-term
  :specializes nil
  :instantiates self
  :binds ((word  :primitive word)
          (rewrite-rule  :primitive cfr)
          (category  :primitive category)

          ;; these are relationships to other words within
          ;; the same segment
          (classifies . anything)
          (adjacent/precedes . anything)  ;; do we need both given
          (adjacent/follows . anything)   ;; their reflexiveness ?

          (instance . segment)
          )
  :index (:temporary :key word))


(define-category  unknown-term+ed
  :specializes unknown-term
  :instantiates unknown-term)


(defun terms-word (term)
  (unless (individual-p term)
    (break "Argument is not an individual: ~A" term))
  (let ((word (value-of 'word term)))
    (if word
      word
      (case (cat-symbol (first (indiv-type term)))
        (category::number 
         (let ((plist (unit-plist term)))
           (or (cadr (member :ones plist))
               (cadr (member :teens plist))
               (cadr (member :tens plist))
               (cadr (member :multiplicand plist))
               (break "Can't find the right plist field for the word ~
                       for a number~%  ~A~%  ~A" plist term))))
        (otherwise
         (break "Don't know how to find a print form for a ~
                 term of type~% ~A -- ~A~%"
                (first (indiv-type term)) term))))))



;;;-----------------------------------------
;;; creating the object and an edge over it
;;;-----------------------------------------

(defun define-individual-for-unknown-term/span (word
                                                pos-before pos-after
                                                &key category
                                                     form)
  ;; called from a mining routine

  (multiple-value-bind (unkt cfr)
                       (define-individual-for-unknown-term
                         word :category category :form form)
    (let ((edge
           (make-chart-edge :starting-position pos-before
                            :ending-position pos-after
                            :left-daughter word
                            :right-daughter :single-term
                            :rule cfr
                            :referent unkt )))

        (values unkt edge))))


;;;---------------------
;;; creating the object
;;;---------------------

(defun define-individual-for-unknown-term (word
                                           &key category
                                                form )
  ;; called from a routine like scan-words-and-mine, where a segment
  ;; is being analyzed. We create an individual to represent this
  ;; word, a corresponding rule to use the next time this word occurs,
  ;; and we use the rule to put an edge over the word at the
  ;; indicated position. 

  (unless category
    ;; can't use an optional since an earlier caller may have been
    ;; given nil as its 'category' to pass through
    (setq category category::unknown-term))
                                                
  (cond
   ((function-word? word)
    (break "function word passed in"))
   
   ((punctuation? word)
    (break "punctuation passed in"))

   (t
    ;;(tr :dm&p/function-word-mined word)
    (if (word-p word)
      (let* ((stem (cadr (member :ls-stem (unit-plist word) :test #'eq)))
             (unkt (define-individual 'unknown-term
                     :word (or stem word)))
             (cfr (define-cfr category `(,word)
                    :form form
                    :referent unkt )))
        (bind-variable 'rewrite-rule cfr unkt)
        (values unkt cfr))

      (if (polyword-p word)
        (let* ((unkt (define-individual 'unknown-term
                       :word word ))
               (cfr (define-cfr category `(,word)
                      :form form
                      :referent unkt)))
          (bind-variable 'rewrite-rule cfr unkt)
          (values unkt cfr))

        (break "Threading bug: 'word' argument is neither a word ~
                or a polyword"))))))



(defun define-individual-for-unknown-term/verb (word stem)
  (let ((stem-term (define-individual'unknown-term
                     :word stem))
        (form (if (word-morphology word)
                (ecase (word-morphology word)
                  (:ends-in-s category::verb+s)
                  (:ends-in-ed category::verb+ed)
                  (:ends-in-ing category::verb+ing))
                category::verb)))

    (assign-brackets-as-a-main-verb word)

    (let ((cfr (define-cfr category::unknown-term (list word)
                 :form form
                 :referent stem-term)))

      (bind-variable 'rewrite-rule cfr stem-term)
      ;; this will add another binding for each call, which is fine
      ;; but has to be appreciated by the deletion routine now that
      ;; we're using just one term for all these surface-variant words

      stem-term )))

