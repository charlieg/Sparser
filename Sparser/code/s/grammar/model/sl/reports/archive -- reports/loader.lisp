;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "loader"
;;;   Module:  "model;sl:reports:"
;;;  version:  July 1991

;; initiated in January 1991, system version 1.8
;; 1.1  (7/16 v1.8.6)  moved the def form from object into its own
;;      file.

(in-package :CTI-source)

(lload "reports;object1")
(lload "reports;lambdas")
(lload "reports;def form")
(lload "reports;cases1")
(lload "reports;rules")

