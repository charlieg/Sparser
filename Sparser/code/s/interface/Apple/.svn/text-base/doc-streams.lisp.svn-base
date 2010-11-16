;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "doc streams"
;;;   Module:  "interface;Apple:"
;;;  Version:  1.1  September 5, 1994

;;Changelog
;; 1.1 Set up the filelists as concatenations with parameterized components
;; of the hard pathnames to make it simpler to customize them to a given
;; site.

(in-package :sparser)

;;;------------------------------------
;;; parameters for the hard file names
;;;------------------------------------

(unless (boundp '*Apple-documents-directory*)
  (defparameter *Apple-documents-directory*
                ;;"HitchHiker 120:Apple documents:"
                "Macintosh HD:Apple documents:"
                ))
  ;; This is a pathname from the root -- note the final colon



;;;----------------------------------------------
;;; Document streams for Powertalk and Reference
;;;----------------------------------------------

(define-document-stream '|Documentation|
  :superstream t )

(define-document-stream '|PowerTalk|
  :substream-of '|Documentation|
  :style-name 'Apple
  :file-list
    (mapcar #'(lambda (number-string)
                (concatenate 'string
                             *Apple-documents-directory*
                             "new PowerTalk:Chap"
                             number-string
                             ":body"
                             number-string
                             ".gml"))
            '( "1" "2" "3" "4" "5" "6" "7" "8" "A" "B" )))



(define-document-stream '|Reference|
  :substream-of '|Documentation|
  :style-name 'Apple
  :file-list
    (mapcar #'(lambda (number-string)
                (concatenate 'string
                             *Apple-documents-directory*
                             "new Reference:Chap"
                             number-string
                             ":body"
                             number-string
                             ".gml"))
            '( "1" "2" "3" "4" "5" "6"  "B" "C")))

