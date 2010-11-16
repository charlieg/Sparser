;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved
;;; $Id$
;;;
;;;      File:  "loader"
;;;    Module:  "objects/import
;;;   version:  August 2009

;; initiated 8/27/09. Elaborated through 8/31

(in-package :sparser)

(gate-grammar *poirot*
  (lload "objects;import:poirot-interface"))
