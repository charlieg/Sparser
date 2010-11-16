;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992-1997  David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2007 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$
;;;
;;;     File:  "loader"
;;;   Module:  "model;core:places:"
;;;  version:  1.2 May 1995

;; initiated in December 1990, added flags 12/28/91 v2.1
;; 1.0 (10/12/92 v2.3) Shadowing to gradually introduce the new semantics
;; 1.1 (10/17/93) revivifying the old stuff. 
;;     (1/17/94) added [rules].  (3/10) uncommented [U.S. States].
;;     (4/4) added [other]
;;     (1/9/95) added [directions], [directional rules] and [compass points]
;;     (3/18) fixed the one non-logical
;; 1.2 (5/1) move cities object file up to [places;] level
;; 1.3 (9/4/07) bumped [directions] to 1.

(in-package :sparser)

;; This whole loader is gated on *location* by the master loader


(gate-grammar *locations-core*
  (gload "places;object")
  (gload "places;directions1")
  (gload "places;compass points")
  (gload "places;directional rules"))

(gate-grammar *countries*
  (gload "countries;loader1"))

(gate-grammar *cities*
  (gload "places;city"))
 
(gate-grammar *US-States*
  (gload "places;U.S. States"))

(gate-grammar *other-locations*
  (gload "places;other"))


;; rules have to load last so that referential versions of the
;; various categories are formed rather than simple categories
(gate-grammar *locations-core*
  (gload "places;rules2"))

