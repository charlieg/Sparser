;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992,1993,1994 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "loader"
;;;   Module:  "model;core:names:proper"
;;;  version:  1.5 January 1994

;; 1.0 (10/14/92 v2.3) shadowing old version to redesign the name fsa
;; 1.1 (11/9) bumped initials and single letters to 2, names to 4, 
;;      added abbreviations.
;; 1.2 (5/15/93) added [fsa:driver, classifier, scan, record] flushed the 
;;      files that were grossly out of date
;; 1.3 (6/2) moved [transitions] and [classifications] to [loader-2d] so
;;      they could be loaded at the end of the grammar and not be hassled
;;      by the category references they make
;; 1.4 (11/1) changed the order so fsa routines could define generic states
;; 1.5 (1/27/94) broke [do transitions] our from [classify]

(in-package :sparser)

(lload "names;object")
(lload "names;single letters2")
(lload "names;initials2")
(lload "names;printing")

(lload "names;fsa:driver")
(lload "names;fsa:scan2")
(lload "names;fsa:resume scan")
(lload "names;fsa:classify")
(lload "names;fsa:transition rules")
(lload "names;fsa:do transitions")
(lload "names;fsa:embedded parse")
(lload "names;fsa:record")


