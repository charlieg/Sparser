;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "prw grammar cases"
;;;   Module:  "grammar;tests:"
;;;  version:  1.3  January 1991       v1.7

;; 1.1  (12/3) reorganized a bit to serve as just a single-file loading
;;      procedure for PRW's C&L environment, plus a few sanity checks.  The
;;      substantial tests have been moved to "grammar;tests:C&L QA test set
;;      driver"
;; 1.2  (12/17) Pulled out the sanity checks to "C&L sanity checks"
;; 1.3  (1/4, v1.7)  Renamed paths to accomodate to rationalization of
;;      non-CTI;C&L directory
;;

(in-package :CTI-source)


;;;----------------------------
;;; getting the grammar loaded
;;;----------------------------

(or (find-package :grammar)
    (make-package :grammar
                  :use '(:user :lisp)))

(defun c&L-interface ()
  (load "C&L;testing pkg")
  (load "C&L;eta:loader1")
  (load "C&L;eta:dummy call"))

(defun c&L-grammar ()
  (load "CTI-code;xx non-CTI:C&L:gr:12/12:Grammar:adapter code"))

(C&L-interface)
(C&L-grammar)   ;; n.b. continue the "error" about Require

