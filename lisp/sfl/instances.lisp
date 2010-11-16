;;; -*- Package: co; Syntax: Common-Lisp; Base: 10 -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;;; SFL FRAMES ARE INSTANTIATED USING THE MAKE-OBJECT COMMAND.
;;; THE INSTANCES ARE INSTANCES OF SOME CONCEPT AND ALWAYS HAVE KOBJECT MIXED IN.

(defclass kobject ()
    ((concept-name :accessor concept-name :initarg :concept-name)))

;;; Kobjects are always of type CONCEPT-NAME.
;;; We keep a distinct namespace stored on the object property

(defmethod initialize-instance :around ((self kobject) &key)
	   (declare (ignore rest))
  (with-slots (concept-name) self
    (setf (concept-name self) (type-of self))
    (call-next-method)))


;;; REMEMBER INSTANCES CLASS......

;;; Some SHADOW CLASSES of concepts are instance recording.  The
;;; instances are stored with the concepts for those types of
;;; concepts.

;;; This is an EXTERNAL MIXIN for some concepts.

;;; Concepts have an iv called "instances" but only those concepts
;;; with instance-recording as an external will have that iv filled by
;;; instances made.

;;; Note that to get rid of an instance one must KILL IT, so that the connection,
;;; if any, between the instance and its name is broken.  If you do not
;;; kill instances properly they will come back to haunt you.

(defclass instance-recording-mixin ()
  ())

(defmethod initialize-instance :after ((self instance-recording-mixin) &key)
  (add-new-instance (concept (concept-name self)) self))

(defmethod kill :after ((self instance-recording-mixin) &aux my-concept)
  (when (setq my-concept (concept (concept-name self)))
    (remove-instance my-concept self)))

(defmethod add-new-instance ((self concept) instance)
  (with-slots (instances) self
    (push instance instances)))

(defmethod remove-instance ((self concept) instance)
  (with-slots (instances) self
    (setq instances (delete instance instances))))

;;; Maps down tree -- note that we assume an accessor called specializations
(defmethod all-instances ((self concept))
  (append (instances self) (collect-from-all self 'specializations #'instances)))

(defmethod clear-instances ((self concept))
  (setf (instances self) nil))

;;; Note: does not kill the instances!!!
(defun reset-all-instances ()
  (mapc #'clear-instances (all-concept-objects *vsfl-master*) #+NLC *concepts*))



(defmethod my-concept ((self kobject))
  (concept (concept-name self)))

(defmethod my-slots ((self kobject))
  (slots (my-concept self)))

(defmethod slot-names-of-role-type ((self kobject) role-name)
  (slot-names-of-role-type (my-concept self)(role role-name)))

(defmethod send-concept ((self kobject )message &rest args)
  (apply message (concept (concept-name self)) args))

(defmethod slot-names ((self kobject))
  (slot-names (concept-name self)))

(defmethod default-for-role ((kobject kobject) role-name)
  (let ((concept (my-concept kobject)))
    (default-for-role concept role-name)))

(defmethod vr-for-role ((kobject kobject) role-name)
  (let ((concept (my-concept kobject)))
    (vr-for-role concept role-name)))

(defmethod subsumes-p ((kobject kobject) other-thing)
  (subsumes-p (my-concept kobject) other-thing))

(defmethod subsumed-by ((kobject kobject) other-name)
  (subsumed-by (my-concept kobject) other-name))

;;; IN SFL make-object is the same as make-instance -- we assume that anything that
;;; is being MAKE-OBJECTed is already a class.

(defun make-object (concept-name &rest init-list)
  (apply #'make-instance concept-name init-list))

(defmacro a (concept-name &rest init-plist)
  `(make-object ',concept-name ,@init-plist))

(defmacro an (concept-name &rest init-plist)
  `(make-object ',concept-name ,@init-plist))

(eval-when (compile load eval)
  (export '(a an my-concept my-slots)
	  (find-package :co)))


#||
(shadow 'the)		     ; else you redefine cl:the (which is bad)
(defmacro the (concept-name)
  `(get ',concept-name :object))
||#
