;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992-2005 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "loader"
;;;   Module:  "grammar;rules:tree-families:"
;;;  version:  0.2 March 2005

;; initiated 8/5/92 v2.3, added NP & morphology 8/31, added [that comp] 10/22/93
;; 10/7/94 added [group of type],  10/14 added [of genitive]
;; 0.1 (10/20) renamed mod+np-head to [pre-head np modifiers]
;; 0.2 (10/26) merged the 'of' etf in to one file: [of]
;;     (4/95) added [ditransitive]  (5/2) added [verbs taking pps]
;;     (5/28) added [indirect obj pattern]   (6/14) added [np adjuncts]
;;      and [prepositonal phrases]   (8/28) added [adjective phrases]
;;     (10/18) added [copula patterns]  (12/26) added [vp]  (3/9/05) added
;;     [adverbs]

(in-package :sparser)

(gload "tree-families;morphology")
(gload "tree-families;postprocessing")

(gload "tree-families;NP")
(gload "tree-families;np adjuncts")
(gload "tree-families;pre-head np modifiers")
(gload "tree-families;of")

(gload "tree-families;vp")

(gload "tree-families;transitive")
(gload "tree-families;ditransitive")
(gload "tree-families;indirect obj pattern")
(gload "tree-families;verbs taking pps")
(gload "tree-families;copula patterns")
(gload "tree-families;that comp")

(gload "tree-families;prepositional phrases")
(gload "tree-families;adjective phrases")
(gload "tree-families;adverbs")

