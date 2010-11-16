;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(USER LISP) -*-
;;; copyright (c) 1993  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "DA"                  'debris analysis'
;;;    Module:   "init;scripts:"
;;;   version:   January 1993

;; initiated 1/5/93

(in-package :user)


;;;--------------------
;;; define the package
;;;--------------------

(or (find-package :sparser)
    (make-package :sparser
                  :nicknames '(:CTI-source :cs) ;; former spellings
                  :use #+:apple '(ccl lisp)
                       ))

(or (boundp 'sparser::*CTI-source-package*)
    (defconstant sparser::*CTI-source-package*
                   (find-package :sparser)))


;;;----------------------
;;; setup the parameters
;;;----------------------

(defparameter sparser::*load-the-grammar* t)

(defparameter sparser::*include-model-facilities* nil)

(defparameter sparser::*DA* t)


;;;-------------
;;; do the load
;;;-------------

(load  "Moby:Sparser:code:init:everything")

