;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1990,1991,1992  Content Technologies Inc.
;;; copyright (c) 1992,1993  David D. McDonald  -- all rights reserved
;;;
;;;      File:  "loader"
;;;    Module:   "tools:basics:syntactic sugar"
;;;   Version:   1.0  July 1991

;; (12/30/93 v2.3) added [list hacking]

(in-package :sparser)

(lload "sugar;then-and-else")
(lload "sugar;strings")
(lload "sugar;alists")
(lload "sugar;predicates")
(lload "sugar;printing")
(lload "sugar;sorting")
(lload "sugar;list hacking")

