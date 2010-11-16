;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;      File:   "loader"
;;;    Module:   "grammar;rules:words:basics:"
;;;   Version:   1.3  July 1991

;; 1.1  (1/2 v1.6)  Broke out the words that are specifically referenced
;;      in the analysis algorithms so that they could be explicitly loaded
;;      by the master loader regardless of what the grammar configuration
;;      is.  This file is "grammar;rules:words:basics:required".
;; 1.2  (2/1 v1.8)  moved punctuation file to words;
;; 1.3  (7/15 v1.8.6)  arranged for the sections file to be explicitly
;;      loaded by the master load file as part of recognizing sections.
;; (11/17 v2.1) removed its files as redundant [whitespace] or misleveled
;;      [format1]

(in-package :CTI-source)

(lload "basic-words;format1")
(lload "basic-words;whitespace")

