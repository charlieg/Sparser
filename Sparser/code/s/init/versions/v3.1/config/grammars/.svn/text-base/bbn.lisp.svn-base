;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1991-1997  David D. McDonald  -- all rights reserved
;;;
;;;      File:  "bbn"
;;;    Module:  "init;versions:v2.7:config:grammar:"
;;;   version:  0.1 October 1997

;; initialized ~6/91.  Added *punctuation* 3/28/94 as update since
;; that had gotten a gate around it in the interim. 8/14/97 moved in
;; the modules for segmentation. 
;; 0.1 (10/3/97) Replaced the include-  grammar-modules's with 'public-'
;;     (10/17) added digits-fsa

(in-package :sparser)

;;;-------------------------------------------------
;;; flags controlling what goes on the Sparser menu
;;;-------------------------------------------------

(public-grammar-module  *miscellaneous*)


;;;-----------------------------------
;;; large-scale structure of the text
;;;-----------------------------------

;;;------------------------------------------
;;; empty definitions for closed-class words
;;;------------------------------------------
;; these are read in the loader for rules;words

(public-grammar-module  *general-words*)
(public-grammar-module  *brackets*)
(public-grammar-module  *auxiliary-verbs*)
(public-grammar-module  *irregular-verbs*)
(public-grammar-module  *known-verbs*)
(public-grammar-module  *punctuation*)
(public-grammar-module  *conjunctions*)
(public-grammar-module  *adjectives*)
(public-grammar-module  *adverbs*)
(public-grammar-module  *interjections*)
(public-grammar-module  *prepositions*)
(public-grammar-module  *pronouns*)
(public-grammar-module  *comparatives*)
(public-grammar-module  *WH-words*)
(public-grammar-module  *quantifiers*)
(public-grammar-module  *determiners*)

;; These require the single-quote fsa, which I haven't vetted yet
;; for model-free operation. ///Certainly should though, as these
;; are useful if possibly not totally shaken down yet. 
;(public-grammar-module  *contractions*)


;;;------------------------------------
;;; optional facities (done with FSAs)
;;;------------------------------------

(public-grammar-module  *polywords*)


;;;-------------------------
;;; general syntactic rules
;;;-------------------------

(public-grammar-module  *standard-syntactic-categories*)

;;;-----------------------
;;; core semantic modules
;;;-----------------------

(include-grammar-module  *digits-fsa*)


;;;-----------------------
;;; more heuristic things
;;;-----------------------


