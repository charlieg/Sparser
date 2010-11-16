;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;      File:   "required"
;;;    Module:   "grammar;rules:words:basics:"
;;;   Version:   1.1  February 1991

;; 1.1  (2/15 v1.8.1) Added comma and period.

(in-package :CTI-source)


;;;--------- marking the start and end of the source character stream

(define-punctuation end-of-source
                    (code-char 0))

;(define-sectionizing-marker
(define-punctuation source-start (code-char 1))


;;;-------- the most frequent word

(define-number-of-spaces one-space " ")


;;---------- newline, etc.

(define-punctuation newline  #\return)
(define-punctuation linefeed #\linefeed)

(defparameter *newline-is-a-word* nil
  "A flag set within headers and specialized sublanguages.")


;; ///  These are referenced (found out the hard way).  Have to locate
;; the reference and see if it can be modified.

(define-punctuation  comma #\, )
(define-punctuation  period #\. )

