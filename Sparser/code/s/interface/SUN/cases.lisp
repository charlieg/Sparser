;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "cases"
;;;    Module:   "interface;SUN:"
;;;   Version:   December 1994

;; initiated 12/13/94, elaborated ...12/16

(in-package :sparser)


;;;--------------------------------
;;; table:  keywords -> categories
;;;--------------------------------

(defparameter *smu/classif-keyword-to-category* (make-hash-table))

(defun category-for-smu-classification (keyword)
  (gethash keyword *smu/classif-keyword-to-category*))


;;;-----------------------------
;;; creating new classfications
;;;-----------------------------

(defun define-smu-classification (keyword)
  (let* ((cat-name (intern (symbol-name keyword)
                          *sparser-source-package*))
        (category
         (define-category/expr cat-name
           '(:specializes nil
             :instantiates self
             :binds ((word :primitive word)
                     (pos  :primitive symbol)
                     (feature :primitive symbol)
                     (semantic-field :primitive symbol)
                     (rule  :primitive cfr))
             :index (:key word)))))

    (setf (gethash keyword *smu/classif-keyword-to-category*)
          category)
    category ))

(unless (boundp '*smu-outfile*)
  (defparameter *smu-outfile* *standard-output*))


(defun define-smu-subtype (string parent-category)
  (let ((cat-name (intern string
                           *sparser-source-package*)))
    (if (boundp cat-name)
      (symbol-value cat-name)

      (let ((category
             (define-category/expr cat-name
               `(:specializes ,(cat-symbol parent-category)
                              :instantiates self
                              :binds ((word :primitive word)
                                      (pos  :primitive symbol)
                                      (feature :primitive symbol)
                                      (semantic-field :primitive symbol)
                                      (rule  :primitive cfr))
                              :index (:key word)))))

        (unless (member category
                        (cat-lattice-position parent-category)
                        :test #'eq)
          (setf (cat-lattice-position parent-category)
                (push category
                      (cat-lattice-position parent-category))))
        
        ;; save it
        (format *smu-outfile*
                "~%~%~
                 ~%(define-smu-subtype \"~A\"~
                 ~%                    (category-named '~A))~%~%"
                string
                (cat-symbol parent-category))
        
        category ))))


;;;------------------------------------
;;; anonymously creating an individual
;;;------------------------------------

(defun smu/Instantiate-category (category edge)
  (let* ((word
          (if (eq (pos-edge-ends-at edge)
                  (chart-position-after (pos-edge-starts-at edge)))
            ;; it's one word long
            (edge-left-daughter edge)
          
            ;; it's the result of completing a polyword
            (smu/make-polyword-for-span edge)))
         (word-symbol (word-symbol word)))

    (define-individual category
      :word word)))


(defun smu/Make-polyword-for-span (edge)
  (let* ((word-list (words-between (pos-edge-starts-at edge)
                                  (pos-edge-ends-at edge)))
         (polyword
          (define-polyword/from-words word-list)))
    polyword ))


;;;------------------------------------------------
;;; recording and instance of a category as a rule
;;;------------------------------------------------

(defun write-cfr-for-smu-tag-derived-edge (edge category instance)

  ;; Called from smu/Classify-phrase.
  ;; We've decided to annotate the phrase spanned by this
  ;; edge as this instance of this category. To record this so
  ;; we don't have to do it again, we write this edge.
  ;;   Later, the Save-instance-for-later-restoration will write
  ;; it to a file for use in the next session.  For later in this
  ;; session the routine Record-phrase will check for this same
  ;; sequence of words and find this edge.

  (let ((word-list (words-between (pos-edge-starts-at edge)
                                  (pos-edge-ends-at edge))))
    (if (cdr word-list)
      ;; When more than one word is involved, there will have
      ;; been a pw and its cfr created by the call to
      ;; smu/Instantiate-category in order for there to be
      ;; something to index to.  We look up them up and
      ;; mung the referent on the cfr so that the next time
      ;; that it runs it will show up as a 'self-marked' edge
      (let* ((pw
              (polyword-named/list-of-words word-list))
             (cfr (pw-fsa pw)))
        (setf (cfr-referent cfr) instance)
        cfr )
      (let ((cfr
             (define-cfr category  word-list
               :form category::np
               :referent instance )))
        
        (bind-variable 'rule cfr instance)
        cfr ))))
        

;;;----------------
;;; toplevel cases
;;;----------------

(define-smu-classification :kind)
(define-smu-classification :proper-name)
(define-smu-classification :machine-type)
(define-smu-classification :file-name)

(define-smu-classification :other)


;;;---------------------
;;; predefined subtypes
;;;---------------------

(define-smu-subtype "command" (category-named 'proper-name))
(define-smu-subtype "menu"    (category-named 'proper-name))

(define-smu-subtype "command-source" (category-named 'kind))
(define-smu-subtype "widget"         (category-named 'kind))

