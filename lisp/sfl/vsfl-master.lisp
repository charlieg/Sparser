;;; -*- Package: co; Base: 10; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;;;************************************************************************
;;; 
;;;************************************************************NLC-06/07/94
(defvar *concepts* nil)
(defvar *roles* nil)

(defclass vsfl-master ()
  ())

;;;
(defmethod record-concept-object ((SELF vsfl-master) NEW-CONCEPT-OBJECT)
  (push NEW-CONCEPT-OBJECT *concepts*))

(defmethod delete-concept-object ((SELF vsfl-master) OLD-CONCEPT-OBJECT)
  (setq *concepts* (delete OLD-CONCEPT-OBJECT *concepts*)))

(defmethod all-concept-objects ((SELF vsfl-master))
  *concepts*)

(defmethod clear-concept-objects ((SELF vsfl-master))
  (setq *concepts* nil))

;;;
(defmethod record-role-object ((SELF vsfl-master) NEW-ROLE-OBJECT)
  (push NEW-ROLE-OBJECT *roles*))

(defmethod delete-role-object ((SELF vsfl-master) OLD-ROLE-OBJECT)
  (setq *roles* (delete OLD-ROLE-OBJECT *roles*)))

(defmethod all-role-objects ((SELF vsfl-master))
  *roles*)

(defmethod clear-role-objects ((SELF vsfl-master))
  (setq *roles* nil))

(defvar *vsfl-master* (make-instance 'vsfl-master))
