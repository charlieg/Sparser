;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 2005 David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$
;;;
;;;     File:  "adverbs"
;;;   Module:  "grammar;rules:tree-families:"
;;;  version:  May 2009

;; initiated 3/9/05
;; 0.1 (5/20/09) Added verb+ing and verb cases to pre-verb-adverb

(in-package :sparser)

#| ETFs in this file:

     pre-verb-adverb ------------ "today announced"
|#


(define-exploded-tree-family pre-verb-adverb
  :description ""
  :binding-parameters ( modifier )
  :labels ( adverb )
  :cases
    ((:modifier (verb+ed (adverb verb+ed)
                  :head right-edge
                  :binds (modifier left-edge)))
     (:modifier (verb+ing (adverb verb+ing)
                  :head right-edge
                  :binds (modifier left-edge)))
     (:modifier (verb (adverb verb)
                  :head right-edge
                  :binds (modifier left-edge)))))

(define-exploded-tree-family sentence-adverb
  :description ""
  :binding-parameters ( modifier )
  :labels ( adverb )
  :cases
    ((:modifier (s (adverb s)
                  :head right-edge
                  :binds (modifier left-edge)))
     (:modifier (vp (adverb vp)
                  :head right-edge
                  :binds (modifier left-edge)))
     (:modifier (s (s adverb)
                  :head left-edge
                  :binds (modifier right-edge)))
     (:modifier (vp (vp adverb)
                  :head left-edge
                  :binds (modifier right-edge)))))



