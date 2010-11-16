;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1993,1994,1995 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "object"
;;;   Module:  "model;core:collections:"
;;;  version:  June 1993

;; initiated 6/7/93 v2.3, added Sequence 6/9.
;; 6/13/95 added searching routine: collection-of-type/dh

(in-package :sparser)

;;;----------------
;;; generic object
;;;----------------

(define-category  collection
  :instantiates self
  :specializes nil
  :index (:special-case :find find/collection
                        :index index/collection
                        :reclaim reclaim/collection)

  :binds ((items :primitive list)
          (type)
          (number :primitive integer)))



;;;-----------------
;;; specializations
;;;-----------------

(define-category  sequence     ;; order matters
  :instantiates collection
  :specializes collection
  :binds ((items :primitive list)   ;;/// ought to do inheritance
          (item)    ;; i.e. each individual item
          (type)
          (number :primitive integer))

  :index (:special-case :find find/sequence
                        :index index/sequence
                        :reclaim reclaim/sequence))



;;;-----------------------------
;;; predicates over collections
;;;-----------------------------

(defun collection-of-type/dh (collections-dh-entry  &rest possible-types )
  (let ( instances  instance   )
    (dolist (item collections-dh-entry)
      (setq instance (first item))
      ;(break)
      (when (member (first (value-of 'type instance))
                    possible-types :test #'eq)
        (push instance instances)))
    (nreverse instances)))
