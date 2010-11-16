;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994,1995,1996  David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2009-2010 BBNT Solutions LLC. All Rights Reserved
;;; $Id$
;;;
;;;     File:  "semantics-free verbs"
;;;   Module:  "model;dossiers:"
;;;  version:  March 2010

;; initiated 7/27/94 v2.3 for autodef. 
;; Taken over 3/27/09 to hold the abbreviated self-categorizing definitions
;; of lots & lots of verbs. 3/26/10 Started fleshing it out using /rules/treefamilies/
;; shortcuts forms

(in-package :sparser)


#| For reasons unclear, this definition pattern hasn't survived
  (or has been renamed since this file was last used in the mid-1990s.

;; 4/27/95
(make-verb-rules/aux2  (define-word "give")
                       (define-category give) 
                       (define-category give)
  :past-tense "gave"
  :past-participle "given"
  :present-participle "giving"
  :third-singular "gives"
  :third-plural "give" )

;; 1/2/96
(make-verb-rules/aux2  (define-word "end")
                       (define-category end) 
                       (define-category end)
  :past-tense "ended"
  :past-participle "ended"
  :present-participle "ending"
  :third-singular "ends"
  :third-plural "end" )

|#

(svo "use")

