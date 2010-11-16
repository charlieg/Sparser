;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "SUN"
;;;    Module:   "init;scripts:"
;;;   version:   December 1994

;; created from scripts;BBN 12/11/94, debugged 12/12

(in-package :cl-user)

;;;--------------------
;;; define the package
;;;--------------------

(or (find-package :sparser)
    (make-package :sparser
                  :use #+:apple '(ccl common-lisp)
                       #+:unix  '(common-lisp)
                       ))


;;;-------------------------------------------------
;;; setup the parameters -- specialize the defaults
;;;-------------------------------------------------

(defparameter sparser::*sun* t)


;;;-------------
;;; do the load
;;;-------------

(defparameter cl-user::location-of-sparser-directory
    (cond ((probe-file "Book:David:")  ;; M&D's powerbook
           (setq cl-user::location-of-root-directory
                 "Book:David:Sparser:")
           "Book:David:Sparser:" )
          ((probe-file "ddm:stuff:")   ;; Br700
           (setq cl-user::location-of-root-directory
                 "ddm:stuff:Sparser:")
           "ddm:stuff:Sparser:" )
          ((probe-file "Sparser:writing:")  ;; ddm's II
           (setq cl-user::location-of-root-directory
                 "Sparser:")
           "Sparser:" )
          (t (break "No location specified for the Sparser directory"))))


(let ((everything/source
       (concatenate 'string
                    cl-user::location-of-sparser-directory
                    #+:apple "code:s:init:everything"
                    #+:unix "init/everything" )))

    (load everything/source))
