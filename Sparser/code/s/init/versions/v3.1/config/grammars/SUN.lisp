;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:  "SUN"
;;;    Module:  "init;versions:v2.3:config:grammars:"
;;;   version:  December 1994

;; copied from [full grammar] 12/11/94. Starting with nearly everything commented out
;; Tweeked 12/14: put in *miscellaneous* for the timing code and *paragraph-detection*
;; for one of its globals and anticipating it might be useful. Added *polywords* 12/16

(in-package :sparser)


;;;-------------------------------------------------
;;; flags controlling what goes on the Sparser menu
;;;-------------------------------------------------
;;  n.b. these aren't grammar modules, but there's a utility to
;;  being able to conditionalize the contents of the menu by version,
;;  and this is just such a place.

(defparameter *spm/include-grammar-modules* t)
(defparameter *spm/include-backup* t)
(defparameter *spm/include-citations* t)
(defparameter *spm/include-workbench* t)


;;---------------------------------------------------------
#|

(include-grammar-module  *other*)


(include-grammar-module  *testing*)
(include-grammar-module  *citations*)  |#
(include-grammar-module  *miscellaneous*)  #|


;;;-----------------------------------
;;; large-scale structure of the text
;;;-----------------------------------
|#
(include-grammar-module  *orthographic-structure*)

(include-grammar-module  *paragraph-detection*)
(include-grammar-module  *recognize-sections-within-articles*)
#|(include-grammar-module  *sgml*)
(include-grammar-module  *paired-punctuation*)|#
(include-grammar-module  *context-variables*)
#|(include-grammar-module  *glifs*)


;;;------------------------------------------
;;; empty definitions for closed-class words
;;;------------------------------------------
;; these are read in the loader for rules;words
|#
(include-grammar-module  *general-words*)
#|(include-grammar-module  *brackets*)
(include-grammar-module  *irregular-verbs*)|#
(include-grammar-module  *punctuation*)
#|(include-grammar-module  *conjunctions*)
(include-grammar-module  *adverbs*)
(include-grammar-module  *interjections*)
(include-grammar-module  *prepositions*)
(include-grammar-module  *pronouns*)
(include-grammar-module  *comparatives*)
(include-grammar-module  *WH-words*)
(include-grammar-module  *quantifiers*)
(include-grammar-module  *determiners*)
(include-grammar-module  *contractions*)
(include-grammar-module  *auxiliary-verbs*)



;;;------------------------------------
;;; optional facities (done with FSAs)
;;;------------------------------------
|#
(include-grammar-module  *finite-state-automata*)

(include-grammar-module  *polywords*) #|
(include-grammar-module  *abbreviations*)
(include-grammar-module  *initials*)
(include-grammar-module  *single-quote*)
(include-grammar-module  *hyphen*)



;;;-------------------------
;;; general syntactic rules
;;;-------------------------
;; these are read in the loader for rules;syntax

(include-grammar-module  *syntax*)

(include-grammar-module  *standard-syntactic-categories*)

(include-grammar-module  *tree-families*)

(include-grammar-module  *standard-syntactic-constructions*)
(include-grammar-module  *default-semantics-for-vg*)
(include-grammar-module  *default-semantics-for-NP*)
(include-grammar-module  *heuristics-from-morphology*)
(include-grammar-module  *conjunction*)
(include-grammar-module  *relative-clauses*)
(include-grammar-module  *possessive*)


;;;-----------------------
;;; core semantic modules
;;;-----------------------

(include-grammar-module  *model-core*)

(include-grammar-module  *standard-adjuncts*)
(include-grammar-module  *approximators*)
(include-grammar-module  *frequency*)
(include-grammar-module  *sequencers*)
(include-grammar-module  *proper-names*)
(include-grammar-module  *people*)
(include-grammar-module  *companies*)
  (include-grammar-module  *company-core*)
  (include-grammar-module  *kinds-of-companies*)
  (include-grammar-module  *company-generalization-words*)
  (include-grammar-module  *company-activity-words*)
  (include-grammar-module  *generic-company-words*)
  (include-grammar-module  *company-activity-nominals*)
  (include-grammar-module  *subsidiaries*)
(include-grammar-module  *numbers*)
(include-grammar-module  *amounts*)
(include-grammar-module  *time*)
(include-grammar-module  *money*)
(include-grammar-module  *finance*)
(include-grammar-module  *titles*)
  (include-grammar-module *titles-core*)
  (include-grammar-module *full-titles*)
  (include-grammar-module *title-heads*)
  (include-grammar-module *title-modifiers*)
  (include-grammar-module *title-qualifiers*)
(include-grammar-module  *location*)
(include-grammar-module  *countries*)
(include-grammar-module  *US-States*)
(include-grammar-module  *cities*)
(include-grammar-module  *other-locations*)
(include-grammar-module  *locations-core*)



;;;-----------------------
;;; more heuristic things
;;;-----------------------

(include-grammar-module  *heuristics*)

(include-grammar-module  *resolve-pronouns*)
(include-grammar-module  *topic*)

(include-grammar-module  *ha*)
  (include-grammar-module  *both-ends-of-segment-heuristic*)
  (include-grammar-module  *pending-determiner-heuristic*)

(include-grammar-module  *ca*)
  (include-grammar-module  *find-subject-for-VP*)



;;;-----------------
;;; debris analysis
;;;-----------------

(include-grammar-module  *da*)



;;;------------------------------
;;; domain mining and populating
;;;------------------------------

(include-grammar-module  *DM&P*)


;;;--------------
;;; sublanguages
;;;--------------

(include-grammar-module  *sublanguages*)

(include-grammar-module  *pct*)

(include-grammar-module  *whos-news*)
(include-grammar-module  *whos-news/core*)
(include-grammar-module  *job-events*)
(include-grammar-module  *whos-news-special-grammar*)

(include-grammar-module  *reports*)

(include-grammar-module  *load-Tipster-grammar-into-image*)
(include-grammar-module  *jv/phrases*)
(include-grammar-module  *jv/relations-via-categories*)
;;(include-grammar-module  *gl*)
|#

