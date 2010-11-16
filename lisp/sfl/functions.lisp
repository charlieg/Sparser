;;; -*- Package: co; Base: 10; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

(defun collect-concept-instances (concept-names)
  (loop for name in concept-names
	when (concept name)
	  collect it))

(defun collect-concept-names (concept-instances)
  (loop for instance in concept-instances
	collect (name instance)))


;;;This takes a list of concept names and returns the names of the ones that are not
;;;subsumed or equal to any of the others.  All concepts are assumed to be taxonomized.

(defun most-specific-concepts (concept-names)
  (collect-concept-names
    (most-specific-only
      (collect-concept-instances concept-names))))

(defun most-general-concepts (concept-names)
  (collect-concept-names
    (most-general-only
      (collect-concept-instances concept-names))))

(defun collect-role-instances (role-names)
  (loop for name in role-names
	for instance = (role name)
	when instance
	  collect instance))

(defun collect-role-names (role-instances)
  (loop for instance in role-instances
	collect (name instance)))

;;;This takes a list of role names and returns the names of the ones that are not
;;;subsumed or equal to any of the others.  All roles are assumed to be taxonomized.

(defun most-specific-roles (role-names)
  (collect-role-names
    (most-specific-only
      (collect-role-instances role-names))))

(defun most-general-roles (role-names)
  (collect-role-names
    (most-general-only
      (collect-role-instances role-names))))



#+ignore
(defvar *all-leaves* nil)
#+ignore
(defun concept-tree-bottoms (c-names)
  (incf *visited*)
  (setq *all-leaves* nil)
  (loop for cn in c-names
	for c = (concept cn)
	when c
	  do (add-tree-leaves c))
  *all-leaves*)

#+ignore
(defmethod add-tree-leaves ((self concept))
  (with-slots (specializations name visited-p) self
    (unless (= *visited* visited-p)
      (setq visited-p *visited*)
      (if specializations
	  (loop for s in specializations
		for si = (concept s)
		do (add-tree-leaves si))
	  (push name *all-leaves*)))))



;;;(defun new-sfl-taxonomy ()
;;;  (loop for c in *concepts*
;;;	do (remprop (name c) 'concept))
;;;  (loop for r in *roles*
;;;	do (remprop (name r) 'role))
;;;  (setq *concepts* nil *roles* nil)
;;;  (make-instance 'top-concept)
;;;  (make-instance 'top-role))
;;; NLC-06/06/94
(defun new-sfl-taxonomy ()
  (loop for c in (all-concept-objects *vsfl-master*) #+NLC *concepts*
      do (remprop (name c) 'concept))
  (loop for r in (all-role-objects *vsfl-master*) #+NLC *roles*
      do (remprop (name r) 'role))
  #+NLC (setq *concepts* nil *roles* nil)
  (clear-concept-objects *vsfl-master*)
  (clear-role-objects *vsfl-master*)
  (make-instance* 'top-concept)
  (make-instance* 'top-role))

;;; be sure top-concept and top-role are around before completing the loading of SFL
;;;(eval-when (load)
;;;  (unless (top-concept)
;;;    (make-instance 'top-concept))
;;;  (unless (top-role)
;;;    (make-instance 'top-role)))
;;; NLC-06/06/94
(eval-when (load)
  (unless (top-concept)
    (make-instance* 'top-concept))
  (unless (top-role)
    (make-instance* 'top-role)))


;;;The most specific generalization of a concept is the concept that subsumes all
;;;of the concepts parents, or its single lone parent.

;;;This is a quick and dirty and very dumb algorithm.

(defmethod msg ((self concept))
  (with-slots (abstractions) self
    (loop with msg-parents = (copy-list abstractions)
	  for top = (pop msg-parents)
	  for ctop = (concept top)
	  when (or (equal top *most-general-concept*)
		   (null msg-parents))
	    return (name ctop)
	  else
	    when (intersect-p (all-specializations ctop)
			      msg-parents)
	      do (nadd-on top msg-parents)
          else
	    do (setq msg-parents (union msg-parents (abstractions ctop))))))




(defun all-concept-names ()
  (mapcar #'name (all-concept-objects *vsfl-master*) #+NLC *concepts*))

(defun all-concepts ()
  (all-concept-objects *vsfl-master*) #+NLC *concepts*)

(defun all-role-names ()
  (mapcar #'name 
	  (all-role-objects *vsfl-master*)
	  #+NLC *roles*))

(defun all-roles ()
  (all-role-objects *vsfl-master*)
  #+NLC *roles*)

(defun clear-all-concept-instance ()
  (mapc #'clear-instances (all-concept-objects *vsfl-master*) #+NLC *concepts*))






;;; Satisfies-p deals with :and :or and :not forms
;;; concept names are of the form concept-name or (a/an concept-name)

(defmethod satisfies-p ((self inheritance-handling-mixin) form)
  (cond ((symbolp form)
	 (and (concept? form) (subsumes-or-equal (concept form) self)))
	((concept-formp form)
	 (subsumes-or-equal (concept-of-concept-form form) self))
	((eq (car form) :and)
	 (loop for form in (cdr form)
	       always (satisfies-p self form)))
	((eq (car form) :or)
	 (loop for form in (cdr form)
	       thereis (satisfies-p self form)))
	((eq (car form) :not)
	 (null (satisfies-p self (cdr form))))))
