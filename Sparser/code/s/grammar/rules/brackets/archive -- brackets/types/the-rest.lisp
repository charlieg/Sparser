;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1991,1992,1993  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "brackets"
;;;   Module:  "grammar;rules:brackets:"
;;;  Version:   June 1993

;; initiated 4/26/91, extended 4/30
;; Required assignments to the source start/end pulled 11/24
;; 6/15/93 v2.3 added punctuation

(in-package :sparser)

;;;------------------
;;; plain boundaries
;;;------------------

;; already loaded by the "required" file
;;
;(define-bracket :[ :after  phrase)   ;; phrase.[
;(define-bracket :] :before phrase)   ;; ].phrase

(define-bracket :] :after  phrase)  ;; phrase].
(define-bracket :[ :before phrase)  ;; .[phrase


;;;----------------------------
;;; phrase-specific boundaries
;;;----------------------------

(define-bracket :]  :before  verb)
(define-bracket :[  :before  verb)

(define-bracket :[  :before  np)
(define-bracket :]  :after   np)

(define-bracket :]  :before  conjunction)
(define-bracket :[  :after   conjunction)

(define-bracket :]  :before  punctuation)  ;; ].punctuation
(define-bracket :[  :after   punctuation)  ;; punctuation.[

