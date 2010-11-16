;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "loader"
;;;   Module:  "interface;PRW:eta:"     ("evidence-topic association")
;;;  Version:   1.6  January 1991
;;;

(in-package :CTI-source)

;; Change Log:
;;  1.1  (released with v1.3)  Dispersed the fns file into forms and
;;       a new file named "delete"
;;  1.2  (v1.5)  Reflects changes to individual files forced by changes
;;       to the Analysis Engine.
;;  1.3  (v1.5)  catches change to setup file ("setup1")
;;  1.4  (v1.5)  changed the algorithm in Setup, and bumped its version
;;       number so as to keep a clean version of the former alg. around
;;       as a safety precaution
;;  1.5  (1/4, v1.7)  Pathname changes
;;  1.6  (1/14 v1.7) Bumped the version of Setup to keep a clean copy
;;       around of the way it looked before changes
;;

(load "C&L;eta:object")
(load "C&L;eta:lookup1")
(load "C&L;eta:delete1")
(load "C&L;eta:forms1")
(load "C&L;eta:setup3")
(load "C&L;eta:testing")

