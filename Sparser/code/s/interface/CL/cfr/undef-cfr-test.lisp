;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(interface-testing LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "undef-cfr test"
;;;   Module:  "interface;PRW:cfr:"
;;;  Version:   1.0  October 1990
;;;

(in-package :interface-testing)


;;; the set to delete
(def-cfr/multiple-rhs chapter-11
                      (("Chapter 11")
                       (chapter-11 of-the-bankruptcy-code)
                       ("under" chapter-11)))


;;; auxiliaries to make the second rule substantial
;;;
(def-cfr of-the-bankruptcy-code ("of" bankruptcy-code))

(def-cfr/multiple-rhs bankruptcy-code
                      (("Bankruptcy Code")
                       ("federal" bankruptcy-code)
                       ("the" bankruptcy-code)))


;;; ETAs to give us something to see
(define-association-with-topic 'bankruptcy-code 'bcy-code)
(define-association-with-topic 'chapter-11      'chap-11)


; (bcy2a)
(defun bcy2a ()   ;; extracted from 900711-0028. "a" version is still
                  ;; further abbreviated.
  (let ((cs::*initial-region* :text-body))
    (cs:analyze-text-from-string "
          that has jurisdiction over
          Lomas's proceedings under Chapter 11 of the federal
          Bankruptcy Code, which protects the company from creditors'
          lawsuits while it forms a plan to repay debts")))


(defun unDef-cfr-test ()
  (format t "~%~%~%Running BCY2a~%")
  (bcy2a)
  (format t "~%~%~%unDef-cfr'ing the category chapter-11~%")
  (unDef-cfr 'chapter-11)
  (display-all-cfrs)
  (display-all-etas)
  (format t "~%~%~%Running BCY2a again~%")
  (bcy2a)
  (format t "~%~%~%")
  "unDef-cfr-test completed")

