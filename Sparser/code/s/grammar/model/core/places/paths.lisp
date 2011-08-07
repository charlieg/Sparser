;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2011  David D. McDonald  -- all rights reserved
;;; $Id:$
;;;
;;;     File:  "paths"
;;;   Module:  "model;core:places:"
;;;  version:  July 2011

;; initated 7/13/11

(in-package :sparser)

;;;-----
;;; top
;;;-----

(define-category  path
  :instantiates self
  :specializes location
;;  :realization  ?? where does "path" go?
  )


;;;------------------
;;; highway patterns
;;;------------------

;; Need "route 66" -- fold in here?

(define-category highway  ;; "MA 102"
  :instantiates self
  :specializes location
  :binds ((authority :or country state)
          (number . number))
  :realization (:tree-family pair-instantiates-category
                :mapping ((result-type . :self)
                          (np . :self)
                          (first . (country US-state))
                          (second . number)
                          (item1 . authority)
                          (item2 . number))))
