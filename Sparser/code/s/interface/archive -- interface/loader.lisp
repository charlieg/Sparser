;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992,1993,1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:  "loader"
;;;    Module:  "interface;windows:"
;;;   version:  0.3 January 1994

;; initiated 3/29/92 v2.2
;; 0.1 (6/17/93 v2.3) commented out the unvetted bits
;; 0.2 (11/11) settled what to load. 
;; 0.3 (1/11/94) moved [new menus] back into loading all menu files,
;;      added [globals]

(in-package :sparser)

(lload "windows;globals")
(lload "windows;articles:loader")
(lload "windows;menus:loader")

