;;; -*- Package: co; Base: 10; Syntax: Common-Lisp; Mode: LISP -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;;; This file contains the basic stuff for making classes out of frames (concepts/roles)

;;; We set things up so that it IS NOT NECESSARY FOR ALL CONCEPTS TO BE CLASSES.

;;; Concepts that are going to be INSTANTIATED and concepts that want to have methods
;;; attached must be classes.

;;; In this VSFL (very simple SFL) the user explicitly defines whether or not
;;; a frame requires a class to be made from it and the class is defined (or redefined)
;;; everytime defconcept is called.

;;; Frames (concepts) can have mixins that are entirely outside the frame system
;;; They are stored as concept-superclasses.

;;; For example, we might have a class called AGENT
;;; with ivs such as current-activities and a ton of methods attached.  We don't want
;;; this class to be a concept as it does not really exist at the knowledge level -- it
;;; is a system class.  However we might have a concept called person which, when
;;; instantiated, acts as an agent.  It could have agent as an other-mixin which would let
;;; the class corresponding to person inherit the ivs and behaviours of agent without
;;; having agent be a concept.

;;; A TRUE META-CLASS!!!!

(defclass class-making-mixin ()
    ((make-class? :initform nil :accessor make-class? :initarg :make-class?)
     (concept-superclasses :initform nil :accessor concept-superclasses :initarg :concept-superclasses)))

;;; temporary hack so that the editor will work
(defmethod other-mixins ((class-making-mixin class-making-mixin))
  (with-slots (concept-superclasses) class-making-mixin
    concept-superclasses))

(defmethod initialize-instance :after ((self class-making-mixin) &key)
  (with-slots (concept-superclasses make-class?) self
    (when concept-superclasses
      (setq make-class? t))))


;;; When we make a class for a concept, the  parent mixins are the abstractions
;;; that have a class made for them (make-class? = t)

;;; The ivs of the class corresponding to the concept are all the slot names that
;;; are not ivs of of any PARENT MIXIN.  This is not the same as the "owned" slots, and
;;; is not the same as the local slots as the CONCEPT COULD INHERIT SLOTS FROM AN
;;; ABSTRACTION THAT IS NOT A CLASS AND THOSE SLOTS WOULD THEN HAVE TO BE LOCAL IVS.

;;; This is the fundamental trick for the sparse class taxonomy -- allowing us to have
;;; fewer classes than concepts.

(defmethod parent-mixins ((self class-making-mixin))
  (most-specific-only
    (loop for f in (all-abstractions self)
	  for fi = (my-instance f)
	  when (make-class? fi)
	    collect fi)))

(defun local-ivs-and-defaults-for-concept-class (slots parent-mixins)
  (loop for slot in (loop with local = slots
			  for pm in parent-mixins
			  do (setq local (filter-out (slots pm) local))
			  finally (progn (return local)))
	collect (role-name-and-default slot)))

;;; All concept classs have the system class kobject mixed in to get various
;;; instance saving and accessing functionality.

(defmethod maybe-make-class ((self class-making-mixin))
  (when (make-class? self) (make-class self)))

;;; +++Symbolics specific code -- sys:inhibit-fdefine-warnings.l
(defmethod make-class ((self class-making-mixin))
  (with-slots (concept-superclasses slots name) self
    (let* ((parent-mixins (parent-mixins self))
	   (mixins (if parent-mixins
		       #+NLC (append (mapcar #'name parent-mixins) concept-superclasses)
		       (append concept-superclasses (mapcar #'name parent-mixins))
		       #+NLC (cons 'kobject concept-superclasses)
		       (append concept-superclasses (list 'kobject))))
	   (ivs-and-defaults (local-ivs-and-defaults-for-concept-class slots parent-mixins)))
      #+symbolics
      (unwind-protect
	  (progn (setq sys:inhibit-fdefine-warnings t)
		 (eval `(defobject ,name
			,mixins
			  ,ivs-and-defaults)))
	(setq sys:inhibit-fdefine-warnings nil))
      #-symbolics
      (eval `(defobject ,name
			,mixins
			  ,ivs-and-defaults)))))




