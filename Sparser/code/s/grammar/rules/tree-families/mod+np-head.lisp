;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "mod+np-head"
;;;   Module:  "grammar;rules:tree-families:"
;;;  version:  October 1994

;; initiated 4/28/94 v2.3.  ... 10/24 added some variations and set up name change
;; to mod+np-head since it was designed for numbers and needed more specific name

(in-package :sparser)


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




#|  "7 tons", "44 years"

  The result is an NP.  It doesn't need a determiner.
  The category of the np is different from the category of the head
    but the head does contribute information  |#

(define-exploded-tree-family  quantity+kind
  :binding-parameters ( quantity base )
  :labels ( np modifier np-head result-type )
  :cases
     ((:modifier (np (modifier np-head)
                  :instantiate-individual result-type
                  :binds (quantity left-edge
                          base right-edge)))

      (:hyphenated  (np-head ("-" np-head)
                      :daughter right-edge))))




;; Same thing, but the head doesn't contribute any information.
;; e.g. "(47 years) old"

(define-exploded-tree-family  quantity+idiomatic-head
  :binding-parameters ( quantity )
  :labels ( np modifier np-head result-type )
  :cases
     ((:modifier (np (modifier np-head)
                  :instantiate-individual result-type
                  :binds (quantity left-edge)))

      (:hyphenated  (np-head ("-" np-head)
                      :daughter right-edge))))





#|  "the Southeast Bank unit"

  The result is an NP.  It requires a _definite_ determiner.
  The modifier is a specific individual, hence the requirement of
   a definite determiner. 
|#

(define-exploded-tree-family  def+proper+np-head
  :incorporates  np-common-noun/definite
  :binding-parameters ( individual  base )
  :labels ( np n-bar proper-modifier np-head result-type )
  :cases
     ((:modifier (n-bar (proper-modifier np-head)
                    :instantiate-individual result-type
                    :binds (individual left-edge
                            base right-edge)))))
