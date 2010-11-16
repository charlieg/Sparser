;;; -*- Mode: Lisp; Syntax: COMMON-LISP; Base:10; -*-
;;; $Id$
;;;
;;; idea derived from Jake Beal's contributions to Poirot util.

(in-package :cl-user)

(defpackage :push-debug
  (:use :common-lisp)
  #+nil(:export '(push-debug ;;/// wrong syntax
	    pop-debug
	    peek-debug
	    clear-debug))
)

(in-package :push-debug)	    

;;;----------------------------
;;;      debugging stack
;;;----------------------------
;; Use this to stash "state of the system" variables instead of making globals

(defvar *debug-stack* '())
(defvar *debug* t)                      ; when false, nothing's stored
(defun push-debug (val) (when *debug* (push val *debug-stack*)))
(defun pop-debug () (pop *debug-stack*))
(defun peek-debug () (first *debug-stack*))
(defun clear-debug () (setf *debug-stack* '()))
(defun assq-debug (key) (assq key *debug-stack*))

;;///Fold into defpackage
(export '(push-debug ;;/// wrong syntax
	    pop-debug
	    peek-debug
	    clear-debug)
	(find-package :push-debug))


