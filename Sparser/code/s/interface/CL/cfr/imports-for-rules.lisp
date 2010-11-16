;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "imports for rules"
;;;   Module:  "interface;PRW:cfr:"
;;;  Version:   1.0  October 1990
;;;

(in-package :CTI-source)


;; These are the symbols needed to define and manage context free rules.

(import '(CTI-source:Def-cfr
          CTI-source:Def-cfr/multiple-rhs
          CTI-source:Display-all-cfrs
          CTI-source:Delete-cfr
          CTI-source:Delete-cfr/symbol
          CTI-source:Delete-cfr/cfr
          CTI-source:unDef-cfr
          )
        (find-package :interface-testing))

