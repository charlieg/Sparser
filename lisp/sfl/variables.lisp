;;; -*- Package: co; Base: 10; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;


;;; NLC-06/07/94 Moved to VSLF-MASTER.lisp
;;;(defvar *concepts* nil)
;;;(defvar *roles* nil)

(defvar *visited* 0)
;;; NLC-06/06/94 Moved to SFL-DEFCLASSES.lisp
;;; (defvar *most-general-concept* 'thing)
;;; (defvar *most-general-relation* '*relation*)
(defvar *completion-sweeper* 0)
(defvar *concept-form-keyword-list* '(a an :and :or :not))
(defvar *inhibit-fdefine-warnings* t)
(defvar *concepts-being-killed* nil)

(defvar *inhibit-completion-flag* nil)

(eval-when (compile eval load)
  (export '(thing *relation*) :co))
