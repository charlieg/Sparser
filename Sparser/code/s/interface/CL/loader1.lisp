;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 199,1991  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "loader"
;;;   Module:  "interface;PRW"
;;;  Version:   1.2  January 1991
;;;

(in-package :CTI-source)

;; Change Log:
;;   1.1  Changed for system release 1.2. The interface is aggregated
;; into two subdirectories.  "prw;eta:" has the code released earlier
;; for the "evidence-topic associations".  The testing file in this
;; directory has been modified extensively to exercise the paragraph
;; and source-descriptor facilities.   The second is "prw;cfr", where
;; a tiny example grammar is given for bankruptcy and tnm, including
;; setting up demo topic-associations for them.
;;
;;   This loader queries whether to load the two subdirectories, 
;; as well as establishing the testing package ("it" -- "interface-
;; testing") The imported functions and symbols needed for interface
;; are made in the two testing files.
;;
;;  1.2  (1/4, v1.7)  Pathname changes



;;;-----------------
;;; testing package
;;;-----------------

;; n.b. this package is used for all the operations in the
;; testing and rule files.

(or (find-package :it)
    (make-package :it
                  :nicknames '(:interface-testing)
                  :use :lisp))


;;;-------------------------------
;;; evidence -> semantic objects
;;;-------------------------------

(when (y-or-n-p "load the evidence-topic association code?")
  (load "C&L;eta:loader"))


;; included here for completeness, but not loaded
;; with the module since it will typically be overridden
;; by PRW's real version
;(load "C&L;eta:dummy call")



;;;-----------------------------------------
;;; example grammar and tests exercising it
;;;-----------------------------------------

(when (y-or-n-p "Load the sample context-free rules?")
  (load "C&L;cfr:loader"))

