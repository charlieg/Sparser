;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "loader"
;;;   Module:  "interface;PRW:cfr:"
;;;  Version:   1.2  January 1991
;;;

(in-package :CTI-source)

;; Change Log:
;;  1.1  Broke out the symbol imports as its own file so they can be
;;       loaded independently of the whole set of rules and tests
;;  1.2  (1/4, v1.7)  Pathname changes


;;;-------------------------------------------
;;; importing symbols into interface-testing
;;;-------------------------------------------

(load "C&L;cfr:imports for rules")


;;;----------------------------------
;;; recognition rules for Bankruptcy
;;;----------------------------------

(load "C&L;cfr:bankruptcy")

;;;-------------------------------------------------------
;;; recognition rules for "Tenders, Mergers, Acquisitions
;;;-------------------------------------------------------

(load "C&L;cfr:TNM")

;;;---------------
;;; testing those
;;;---------------

(load "C&L;cfr:test BCY/TNM")

