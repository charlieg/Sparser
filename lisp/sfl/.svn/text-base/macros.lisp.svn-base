;;; -*- Package: co; Base: 10; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;


;;; Macros and functions that need to be defined PRIOR to defining the basic classes..



;;;To reduce the ugliness of the relevant instance stuff

(defmacro my-instance (name)
  `(relevant-instance self ,name))

(defmacro concept (symbol)
  `(get ,symbol 'concept))

(defmacro role (symbol)
  `(get ,symbol 'role))




;;; +++Rumor is that tables are preferable to plists as regards swapping overhead --
;;; +++maybe rewrite FIND/DEFINE-COMPARISON-FUNCTION using a table.

(defun find-comparison-function (pred1 pred2)
  (getf (get pred1 :comparison-functions) pred2))

(defun define-comparison-function1 (pred1 pred2 args body)
  (if (listp pred2)
      `(progn
	,@(loop for pr2 in pred2 collect
	   (define-comparison-function1 pred1 pr2 args body)))
      `(setf (getf (get ',pred1 :comparison-functions) ',pred2)
	#'(lambda ,args
	    ,@body))))

(defmacro define-comparison-function ((pred1 . pred2) args . body)
  (define-comparison-function1 pred1 pred2 args body))

(defmacro define-comparison-functions (predicate . body)
  `(progn . ,(mapcar #'(lambda (subdef)
			 (define-comparison-function1
			    predicate
			    (car subdef)
			    (cadr subdef)
			    (cddr subdef)))
		     body)))
