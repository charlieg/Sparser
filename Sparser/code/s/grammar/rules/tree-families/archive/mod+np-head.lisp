;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994,2011 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "mod+np-head"
;;;   Module:  "grammar;rules:tree-families:"
;;;  version:  February 2011

;; initiated 4/28/94 v2.3.  ... 10/24 added some variations and set up name change
;; to mod+np-head since it was designed for numbers and needed more specific name.
;; 2/20/11 Added initial listing comment. Removed quantity+kind as redundant.
;; ditto def+proper+np-head   ===== Nothing left. Pulling from loader.
;; Hmm... already wasn't loaded. Should have deleted it. 
;;  ==========>>>> use PRE-HEAD-NP-MODIFIERS instead

(in-package :sparser)

#| Resurect this file iff there's something to be gained from it's named. |#


(define-exploded-tree-family  foo  ;;mod+np-head
  :binding-parameters (  )
  :labels ( np modifier np-head result-type )
  :cases
     ((:modifier (np (modifier np-head)
                  :instantiate-individual result-type
                  :binds (quantity left-edge
                          base right-edge)))

      (:hyphenated  (np-head ("-" np-head)
                      :daughter right-edge))))


 
