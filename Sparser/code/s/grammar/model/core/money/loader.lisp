;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993-1997  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "loader"
;;;   Module:  "grammar;model:core:money:"
;;;  version:  April 1995

;; initiated 10/22/93 v2.3 from Tipster memo of 11/91
;; 4/19/95 added [printers]

(in-package :sparser)

(gload "money;objects")
(gload "money;printers")
(gload "money;rules")

#| in dossiers:
  (gload "money-dossier;denominations of money")
  (gload "money-dossier;currencies")  |#

