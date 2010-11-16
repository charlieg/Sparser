;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993,1994  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "names"
;;;   Module:  "model;core:names:companies:"
;;;  version:  1.2 March 1994

;; initiated 5/22/93 v2.3, added indexing routines 6/7
;; 1.1 (10/30) simplified the indexing scheme
;;     (1/11/94) added the slot "the", analogous to an inc-term
;; 1.2 (3/8) starting to add more kinds of company names

(in-package :sparser)

;;;--------
;;; object
;;;--------

(define-category  company-name
  :instantiates nil
      ;; the company is entered into the discourse model,
      ;; not the company's name
  :specializes name
  :index (:special-case :find find/company-name
                        :index index/company-name
                        :reclaim reclaim/company-name)

  :binds ((first-word . name-word)
          (prefix . sequence)
          (rest . sequence)
          (inc-term . inc-term)
          (the  :primitive word)))


#| A name is ultimately identified as such by its context. That aside,
 we should view a name as consisting of just a sequence of items.
 These items, usually individual words but also polywords or abbreviations,
 may be 'pure names', like "George", where we don't understand anything
 about the word other than it is a name, or they may be independently
 meaningful as in "Northeast Airlines".  In this second case we populate
 the name sequence with the objects rather than with name-words, but
 in doing so we'll have to be careful to ensure that we are controlling
 the form of expression of the object when we do this, since we must
 reflect the _form_ of the name's elements as well as their identity. |#


;;;------------------------
;;; indexing company names
;;;------------------------


(defun find/company-name (&key first prefix rest inc)
  ;; /// this will only work when there are a small number of names
  ;; Will have to go to something akin to what's done for sequences
  ;; if there are to be lots and lots of companies defined.
  ;; /// has to look in the local discourse first !!!!!!!!!!!
  (let ((instances (cat-instances category::company-name))
        with-n1  with-prefix  with-rest  with-inc )
    (when instances

      ;; "first" is required, at least of the others is as well,
      ;; but which one/s will vary

      (dolist (name instances)
        (when (eq first (value-of 'first-word name))
          (kpush name with-n1)))
      (if with-n1
        (when (null (cdr with-n1))
          (return-from find/company-name (kpop with-n1)))
        (return-from find/company-name nil))

      (when prefix
        (dolist (name with-n1)
          (if prefix
            (when (eq prefix (value-of 'prefix name))
              (kpush name with-prefix))
            (kpush name with-prefix)))        
        (if with-prefix
          (when (null (cdr with-prefix))
            (return-from find/company-name (kpop with-prefix)))
          (return-from find/company-name nil)))

      (when rest
        (dolist (name (or with-prefix
                          with-n1))
          (when (eq rest (value-of 'rest name))
            (kpush name with-rest)))
        (if with-rest
          (when (null (cdr with-rest))
            (return-from find/company-name (kpop with-rest)))
          (return-from find/company-name nil)))

      (when inc
        (dolist (name (or with-rest
                          with-prefix
                          with-n1))
          (if inc
            (when (eq inc (value-of 'inc-term name))
              (kpush name with-inc))
            (kpush name with-inc)))
        (if with-inc
          (when (null (cdr with-inc))
            (return-from find/company-name (kpop with-inc)))
          (return-from find/company-name nil)))

      nil )))



(defun index/company-name (name company-name bindings)
  ;; The purpose of this routine is to store the name object where
  ;; we can find it again given this same list of items.
  ;; We don't care what the name is bound to -- that indexing is 
  ;; type-specific.
  (declare (ignore bindings))
  (let* ((instances (cat-instances company-name)))
    (if instances
      (setf (cat-instances company-name)
            (kcons name (cat-instances company-name)))
      (setf (cat-instances company-name)
            (kcons name nil)))))




;;;---------------
;;; non-terminals
;;;---------------

(define-category company-name-prefix)


;;;------------------------
;;; printing company names
;;;------------------------

;(define-special-printing-routine-for-category  company-name
;  )


(defun princ-company-name (name stream)
  (let ((first-name (value-of 'first-word name))
        (rest (value-of 'rest name))
        (inc-term (value-of 'inc-term name)))
    (princ-name-word first-name stream)))


(defun princ-name-word (nw stream)
  (let ((word (value-of 'name nw)))
    (princ-word word stream)))

