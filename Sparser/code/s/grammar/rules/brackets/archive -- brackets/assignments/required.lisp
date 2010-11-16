;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1991,1992  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "required"
;;;   Module:  "grammar;rules:brackets:assignments"
;;;  Version:   November 1991

;; pulled from all-in-one file 11/24 v2.1

(in-package :sparser)

;;;----------
;;; ss & eos
;;;----------

(assign-bracket source-start   phrase.[ )

(assign-bracket end-of-source  ].phrase )

