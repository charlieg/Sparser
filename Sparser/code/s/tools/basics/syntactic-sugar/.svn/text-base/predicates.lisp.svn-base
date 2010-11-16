;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1990  Content Technologies Inc.
;;; copyright (c) 1992,1993  David D. McDonald  -- all rights reserved
;;; Copyright (c) 2007 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$
;;;
;;;      File:  "predicates"
;;;    Module:   "tools:basics:syntactic sugar"
;;;   Version:   January 2007

(in-package :sparser)


(defun more-than-one (list)
  (unless (listp list)
    (error "This routine presently only operates on lists"))
  (> (length list) 1))

(defun memq (item list)
  (member item list :test #'eq))

