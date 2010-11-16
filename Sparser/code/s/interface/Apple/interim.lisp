;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:APPLE -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "interim"
;;;   Module:  "interface;Apple:"
;;;  Version:  1.0 September 6, 1994

(in-package :apple)

;;;----------------------------------------
;;;  one-word-segment -> verb / "to" ___
;;;----------------------------------------

#| This rule doesn't apply if the preposition belongs to the verb
and in certain other productive contexts.  This list gets all the
cases seen in MacRef and PowerTalk, and provides a cheap way to get
the accuracy of the segmentation up while waiting on the development
of the verb+prep facility.  |#

;; This is checked by 'member' in Convert-segment-word-to-verb
(defparameter sparser::*hack-verb-conversion-stop-words*

  `(,(sparser::define-word "application")  ;; PT7 "from ___ to ___"
    ,(sparser::define-word "button")  ;; PT-B "Click the To button"
    ,(sparser::define-word "catalogs")     ;; PT-A "access to ___"
    ,(sparser::define-word "common")  ;; R6 "solutions to ___"
    ,(sparser::define-word "information")  ;; PT4  "access to ___"
    ,(sparser::define-word "item")         ;; PT8 "from ___ to ___"
    ,(sparser::define-word "letters")  ;; PT5 "replying to ___"
    ,(sparser::define-word "mail")     ;; PT5 "adding tags to ___"
    ,(sparser::define-word "mailer")   ;; PT7 "from ___ to ___"
    ,(sparser::define-word "options")  ;; R6 "point to ___"
    ,(sparser::define-word "program")  ;; R3  "from ___ to ___"
    ,(sparser::define-word "recipients")   ;; PT7 "an assurance to ___ that"
    ,(sparser::define-word "software")     ;; PT3 "access to ___"
    ,(sparser::define-word "trackball") ;; R5 "relative to ___"
    ,(sparser::define-word "users")        ;; PT4 "pointers to ___"
    ))
