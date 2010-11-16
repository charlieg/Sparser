;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994,1995 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "ops structure"
;;;   Module:  "objects;model:categories:"
;;;  version:  December 1995

;; broken out from [object] file 8/12/94. 12/8 added Category-instantiates as
;; an access fn. from the category-level

(in-package :sparser)


;;;--------
;;; object
;;;--------

(defstruct (category-operations
            (:conc-name #:cat-ops-)
            (:print-function print-operations-data-structure))

  category  ;; backpointer to the category whose operations these are

  instantiate  ;; a category or list of categories that any individual
               ;; of this category is to be cross-indexed against

  find  ;; a symbol fbound to a function of a category and
        ;; (optionally) a list of bindings.

  index  ;; ditto -- these functions are specific to the description
         ;; of the category's index as given in its definition.

  reclaim  ;; ditto

  print  ;; a function of an individual and a stream

  )


;;--- access fns

(defun category-instantiates (c)
  (let ((ops-str (cat-operations c)))
    (when ops-str
      (cat-ops-instantiate ops-str))))

