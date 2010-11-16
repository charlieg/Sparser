;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:APPLE-INTERFACE -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "pseudo characters"
;;;   Module:  "interface;Apple:"
;;;  Version:  1.0 June 1994

(in-package :apple-interface)

(defun define-pseudo-character (multi-word-string)
  ;; this provides syntactic sugar and a hook in case we want to do
  ;; something more elaborate with these
  (sparser::define-polyword
    multi-word-string))


;;--- apple keys or key combinations

(define-pseudo-character "&apple")

(define-pseudo-character "&printer")

(define-pseudo-character "&clover")

(define-pseudo-character "&clover-s")
(define-pseudo-character "&clover-*s")

(define-pseudo-character "&clover-option-o")
(define-pseudo-character "&clover-*option-*o")  ;; .dis version

(define-pseudo-character "&clover-option-x")
(define-pseudo-character "&clover-*option-*x")

(define-pseudo-character "&clover-option-shift-delete")
(define-pseudo-character "&clover-*option-*shift-*delete")

(define-pseudo-character "&clover-option-up")
(define-pseudo-character "&clover-*option-*up")

(define-pseudo-character "&clover-option-down")
(define-pseudo-character "&clover-*option-*down")

(define-pseudo-character "&clover-option-right")
(define-pseudo-character "&clover-*option-*right")



;;--- compensations for small character set

(define-pseudo-character "&mdash")

