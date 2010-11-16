;;; -*- Mode: LISP; Syntax: Common-lisp; Package: co; Base: 10 -*-
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
;;;************************************************************NLC-06/06/94
(defun make-instance* (CLASS-NAME &rest ARGS)
  (apply #'make-instance CLASS-NAME ARGS))

;;;************************************************************************
;;; From BASIC-MIXINS.lisp
;;;************************************************************NLC-06/03/94

(defclass named-object-mixin ()
  ((name :initform nil :type symbol :initarg :name :accessor name)
   (export? :initform nil :initarg :export? :accessor export?)
   (description :initform nil :initarg :description :accessor description))
  (:documentation "NAMED-OBJECTS store themselves, i.e., their instances, under
                   the (class-name (class-of self) property of their name symbol
                   as well as under the :object property of their name symbol."))

(defclass object-with-properties ()
  ((property-list :initarg :property-list :initform nil)))

(defclass marker-mixin ()
  ((visited-p :accessor visited-p :initform 0)))

;;;************************************************************************
;;; From CONCEPT-ROLE.LISP
;;;************************************************************NLC-06/03/94
(defvar *most-general-concept* 'thing)

(defclass top-concept
    (top-of-lattice
     concept)
  ((name :initform *most-general-concept*)))


(defvar *most-general-relation* '*relation*)

(defclass top-role
	  (top-of-lattice
	    role)
    ((name :initform *most-general-relation*)))

(defclass basic-role-concept-mixin
    (named-object-mixin
     inheritance-handling-mixin
     source-file-mixin)
  ())

(defclass concept
    (basic-role-concept-mixin
     slot-handling-mixin
     class-making-mixin)
  ((INSTANCES :initform nil
	      :initarg :instances
	      :accessor instances)))

(defclass role
	(basic-role-concept-mixin)
  ((slots-for-me :initform nil
		 :initarg :slots-for-me
		 :accessor slots-for-me)
   ))

;;;************************************************************************
;;; From INHERITANCE.LISP
;;;************************************************************NLC-06/03/94

(defclass inheritance-handling-mixin
    (marker-mixin)
  ((abstractions :initform nil
		 :initarg :abstractions
		 :accessor abstractions)
   (defined-abstractions :initform nil
     :initarg :defined-abstractions
     :accessor defined-abstractions)
   (specializations :initform nil
		    :initarg :specializations
		    :accessor specializations)
   (completion-sweeper :initform 0
		       :initarg :completion-sweeper
		       :accessor completion-sweeper)
   ))

(defclass top-of-lattice
	  (inheritance-handling-mixin)
  ())

;;;************************************************************************
;;; From MAKE-CLASSES.LISP
;;;************************************************************NLC-06/03/94
(defclass class-making-mixin ()
    ((make-class? :initform nil :accessor make-class? :initarg :make-class?)
     (concept-superclasses :initform nil :accessor concept-superclasses :initarg :concept-superclasses)))


;;;************************************************************************
;;; From SLOTS.LISP
;;;************************************************************NLC-06/03/94
(defclass concept-attribute-mixin ()
  ((defining-concept :accessor defining-concept :initarg :defining-concept :initform nil)))

(defclass slot (concept-attribute-mixin marker-mixin)
  ((role-name :initform nil
	      :initarg :role-name
	      :accessor role-name)
   (description :initform nil
		:initarg :description
		:accessor description)
   (value-restriction :initform nil
		      :initarg :value-restriction
		      :accessor value-restriction)
   (nr-max :initform nil
	   :initarg :nr-max
	   :accessor nr-max)
   (nr-min :initform nil
	   :initarg :nr-min
	   :accessor nr-min)
   (resolved-vr-concept :initform nil
			:initarg :resolved-vr-concept
			:accessor resolved-vr-concept)
   (normal-vr-form :initform nil
		   :initarg :normal-vr-form
		   :accessor normal-vr-form)
   (default :initform nil
     :initarg :default
     :accessor default)
   ))

;;;************************************************************************
;;; From SLOT-HANDLING.LISP
;;;************************************************************NLC-06/03/94

(defclass slot-handling-mixin (named-object-mixin)
  ((defined-slots :initform nil
     :initarg :defined-slots
     :accessor defined-slots)
   (slots :initform nil
	  :initarg :slots
	  :accessor slots)
   (inverse-slots :initform nil
		  :initarg :inverse-slots
		  :accessor inverse-slots)
   (slot-order :initform nil
	       :initarg :slot-order
	       :accessor slot-order)
   ))

;;;************************************************************************
;;; source-file-mixin
;;;************************************************************NLC-06/06/94
(defclass source-file-mixin
    ()
  ((source-files :accessor source-files :initform nil)))

(defclass multiple-files-mixin
    ()
  ((file-object-type :accessor file-object-type :initform 'basic-file-object)
   (file-loading :accessor file-loading :initform nil)
   (active-files :accessor active-files :initform nil)))

(defclass sfl-files
    (multiple-files-mixin)
  ((file-object-type :accessor file-object-type :initform 'sfl-file-object)))

(defclass basic-file-object ()
  ((file-pathname :accessor file-pathname :initform nil :initarg :file-pathname)))

(defclass sfl-file-object (basic-file-object)
  ((modified-p :accessor modified-p :initform nil)
   (package :accessor package :initform nil)))



