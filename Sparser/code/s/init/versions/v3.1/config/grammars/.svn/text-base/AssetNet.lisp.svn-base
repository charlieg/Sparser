;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1991,1992  David D. McDonald  -- all rights reserved
;;;
;;;      File:  "AssetNet"
;;;    Module:  "<version>;config:grammar:"
;;;   version:  February 1992

(in-package :sparser)

;;;-----------------------------------
;;; large-scale structure of the text
;;;-----------------------------------

(include-grammar-module  *paragraph-detection*)


;;;------------------------------------------
;;; empty definitions for closed-class words
;;;------------------------------------------

(include-grammar-module  *groups-of-spaces*)
(include-grammar-module  *punctuation*)


;;;------------------------------------
;;; optional facities (done with FSAs)
;;;------------------------------------

(include-grammar-module  *polywords*)
(include-grammar-module  *abbreviations*)


;;;-------------------------
;;; general syntactic rules
;;;-------------------------

(include-grammar-module  *standard-syntactic-categories*)


;;;-----------------------
;;; core semantic modules
;;;-----------------------

(include-grammar-module  *countries*)
(include-grammar-module  *numbers*)
(include-grammar-module  *time*)
(include-grammar-module  *money*)
(include-grammar-module  *finance*)

