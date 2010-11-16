;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1991,1992  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "loader"
;;;   Module:  "grammar;model:sl:jv:"    ("joint ventures")
;;;  version:  June 1992    v2.2

(in-package :CTI-source)

(gate-grammar *gl*
  (lload "JV;standins")
  (lload "gl entries;establish")  ;; only does "established"
  (lload "gl entries;venture")    ;; only word is "venture"
  (lload "JV;make jv")
  (lload "JV;event/agent"))

(gate-grammar *jv/core-vocabulary/recognition-only*
  (lload "JV;first rules")
  (lload "JV;verbs"))

(lload "JV;patches")
(lload "JV;headers")

