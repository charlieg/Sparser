;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993-1997 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "loader"
;;;   module:  "model;core:amounts:"
;;;  Version:  0.1 December 1995

;; 9/18/93 v2.3 redid everything to put in new semantics
;; 0.1 (10/27/94) reordered the files to get referential categories before they're used
;;     (12/22/95) added [amount-change verbs], [amount-change relationships] on 12/26

(in-package :sparser)

(gload "amounts;unit of measure")
(gload "amounts;quantities")
(gload "amounts;measurements")
(gload "amounts;object1")
(gload "amounts;amount-change verbs")
(gload "amounts;amount-chg relation")

(gload "amounts;rules1")

#| loaded from dossiers
  (gload "amount-dossier;units of measure")
  (gload "amount-dossier;quantities")  |#

