;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "of genitive"
;;;   Module:  "grammar;rules:tree-families:"
;;;  version:  October 1994

;; initiated 10/17/94.

(in-package :sparser)

(define-exploded-tree-family   of/genitive
  :binding-parameters ( larger  smaller )
  :labels ( np  possessive  complement  base-np  result-type )
  :cases
     ((possessive-formation (possessive/-s  (possessive  apostrophe-s)
                              :head left-edge))

      (possessive+np  (np  (possessive/-s  base-np)
                        :head right-edge
                        :instantiate-individual result-type
                        :binds (larger left-edge
                                smaller right-edge)))

      (of-complement  (of-/complement  ("of"  complement)
                         :head right-edge))

      (np+genitive-of (np  (base-np  of-/complement)
                        :head left-edge
                        :instantiate-individual result-type
                        :binds (larger right-edge
                                smaller left-edge)))))

