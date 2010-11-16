;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:APPLE-INTERFACE -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "pseudo characters"
;;;   Module:  "interface;Apple:"
;;;  Version:  2.0  August 14, 1994

;; Changelog
;;  2.0  made substantial changes to the way characters were defined as
;; Sparser structures.

(in-package :apple-interface)


(sparser::def-form-category  apple-key)

(defun define-pseudo-character (multi-word-string)

  "All pseudo-character are treated the same by the grammar. They are
   given the label 'apple-key' in their category field. The
   identity of the pseudo-character is represented by a polyword that
   allows its different character types to be treated as a single
   entity at the lowest level of the parsing process.  The edge formed
   for a pseudo character points to a term in its referent field."

  (let ((pw (sparser::define-polyword
              multi-word-string)))

    (sparser::define-individual-for-term pw
      :form category::proper-noun
      :specified-category category::apple-key)
        
    ))




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


;;8/1
(define-pseudo-character "&clover-option-up arrow")
(define-pseudo-character "&clover-option-down arrow")



;;--- compensations for small character set

(define-pseudo-character "&mdash")

(let ((pw (sparser::polyword-named "&mdash")))
  (sparser::assign-brackets/expr pw
     (list sparser::].phrase
           sparser::phrase.[ )))

(define-pseudo-character "&ellipsis")
 ;; appears in (new) PowerTalk Chap6 as part of a menu item

(define-pseudo-character "&at")  ;; this is "@" -- why is is special?
(define-pseudo-character "&colon")   ;; ditto

