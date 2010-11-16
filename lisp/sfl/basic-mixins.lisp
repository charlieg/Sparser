;;; -*- Mode: LISP; Syntax: Common-lisp; Package: co; Base: 10 -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;;; THIS FILE CONTAINS UNDERLYING BASIC CLASS MIXINS....

;;; NAMED-OBJECTS have a NAME and a DESCRIPTION slot. They store themselves on the
;;; :OBJECT property of their name so that they can be accessed by the NAME.
;;; Note that the names of named objects define a name-space. 
;;; They also store themselves under the class-name property of their name symbol.

(defgeneric name (object))

(defmethod name ((self t))
  (class-name (class-of self)))

(defmethod name ((symbol symbol))
  symbol)

(defclass named-object-mixin ()
  ((name :initform nil :type symbol :initarg :name :accessor name)
   (export? :initform nil :initarg :export? :accessor export?)
   (description :initform nil :initarg :description :accessor description))
  (:documentation "NAMED-OBJECTS store themselves, i.e., their instances, under
                   the (class-name (class-of self) property of their name symbol
                   as well as under the :object property of their name symbol."))

(eval-when (compile load eval)
  (export '(named-object-mixin name) (find-package :co)))

(defmethod print-object ((self named-object-mixin) stream)
  (let ((name (name self)))
    (format stream "#<~:(~a~):~:[(unnamed)~;~a~]>"
	    (class-name (class-of self)) name name)))

(defmethod initialize-instance :after ((self named-object-mixin) &key
				       &aux (the-name (name self)))
  (declare (ignore rest))
  (when the-name 
    (setf (get the-name :object) self)))

(defmethod maybe-export ((mixin named-object-mixin) new-export?)
  (with-slots (name export?) mixin
    (if new-export?
	(progn
	  (setf (export? mixin) t)
	  (export name (symbol-package name)))
      (multiple-value-bind (symbol value)
	  (find-symbol (string name))
	(unless (and symbol (eq value :inherited))
	  (setf (export? mixin) nil)
	  (unexport name (symbol-package name)))))))

(defmethod unexport-in-menu-p ((mixin named-object-mixin))
  (with-slots (name export?) mixin
    (or
     (null export?)
     (multiple-value-bind (symbol value)
	 (find-symbol (string name) (symbol-package name))
       (and symbol (eq value :external))))))

(eval-when (eval load compile)
  (export 'unexport-in-menu-p :co))

;;; Note that things which aren't named-objects will also have kill methods.  note
;;; also that more specific things that define :after methods on kill shouldn't
;;; depend upon the name->instance link existing. Some thought should be given to
;;; making this a "two pass" method?

(defgeneric kill (thing))

(defmethod kill ((self t)))

(defmethod kill ((self named-object-mixin) &aux (the-name (name self)))
  (when the-name
    (remprop the-name :object)))

(defclass object-with-properties ()
  ((property-list :initarg :property-list :initform nil)))

(defmethod get-value ((self object-with-properties) key)
  (cdr (assoc key (slot-value self 'property-list))))

(defclass marker-mixin ()
  ((visited-p :accessor visited-p :initform 0)))

;;; Mixins to support loading and saving sfl networks.

(defclass source-file-mixin
    ()
  ((source-files :accessor source-files :initform nil)))

(defmethod record-pathname ((mixin source-file-mixin) filename)
  (with-slots (source-files) mixin
    (let ((pathname (if (pathnamep filename)
			filename
		      (merge-pathnames filename))))
      (pushnew pathname source-files :test 'equal))))

(defmethod delete-pathname ((mixin source-file-mixin) pathname)
  (with-slots (source-files) mixin
    (setq source-files (delete pathname source-files :test 'equal))))

(defclass multiple-files-mixin
    ()
  ((file-object-type :accessor file-object-type :initform 'basic-file-object)
   (file-loading :accessor file-loading :initform nil)
   (active-files :accessor active-files :initform nil)))

(defmethod find-file-object ((mixin multiple-files-mixin) pathname)
  (with-slots (active-files) mixin
    (loop for file-object in active-files
	  when (equal (file-pathname file-object) pathname)
	return file-object)))

(defmethod maybe-add-file-object ((mixin multiple-files-mixin) filename)
  (with-slots (file-object-type active-files) mixin
    (let ((pathname (if (pathnamep filename)
			filename
		      (merge-pathnames filename))))
      (or
       (find-file-object mixin pathname)
       (let ((file-object (make-instance file-object-type
			    :file-pathname pathname)))
	 (push file-object active-files)
	 (unless (open pathname :direction :probe :if-exists nil)
	   (save-sfl-internal *sfl-files* pathname))
	 file-object)))))

(defmethod clear-active-files ((mixin multiple-files-mixin))
  (with-slots (active-files) mixin
    (setq active-files nil)))

(defmethod active-pathnames ((mixin multiple-files-mixin))
  (with-slots (active-files) mixin
    (loop for file-object in active-files
	collect (file-pathname file-object))))

(defclass sfl-files
    (multiple-files-mixin)
  ((file-object-type :accessor file-object-type :initform 'sfl-file-object)))

(defmethod modified-pathnames ((mixin sfl-files))
  (with-slots (active-files) mixin
    (loop for file-object in active-files
	when (modified-p file-object)
	collect (file-pathname file-object))))

(defmethod set-all-modified-p ((mixin sfl-files) &optional value)
  (with-slots (active-files) mixin
    (loop for file-object in active-files
	do (setf (modified-p file-object) value))))

(defmethod set-package ((mixin sfl-files))
  (declare (special *package*))
  (with-slots (active-files file-loading) mixin
    (let ((file-object (find-file-object mixin file-loading)))
      (when file-object
	(setf (package-co file-object) *package*)))))

(defclass basic-file-object ()
  ((file-pathname :accessor file-pathname :initform nil :initarg :file-pathname)))

(defclass sfl-file-object (basic-file-object)
  ((modified-p :accessor modified-p :initform nil)
   (package :accessor package-co :initform nil)))

(defmethod native-package-name ((file-object sfl-file-object))
  (with-slots (package) file-object
    (if package
	(package-name package)
      :co)))

(defmethod native-package-name ((mixin sfl-files))
  (with-slots (active-files file-loading) mixin
    (if active-files
	(native-package-name (first active-files))
      :co)))

(defmethod load-sfl-file-internal ((mixin multiple-files-mixin) pathname)
  (with-slots (file-loading) mixin
    (unwind-protect
	(progn
	  (maybe-add-file-object mixin pathname)
	  (setq file-loading pathname)
	  (load file-loading :verbose nil))
      (setq file-loading nil))))

(defmethod set-file-modified-p ((mixin multiple-files-mixin) pathname value)
  (let ((file-object (find-file-object mixin pathname)))
    (when file-object
      (setf (modified-p file-object) value))))

(defmethod save-sfl-internal :after ((mixin multiple-files-mixin) pathname)
  (set-file-modified-p mixin pathname nil))

(eval-when (eval compile load)
  (export '(clear-active-files active-pathnames modified-pathnames
	    set-package set-file-modified-p native-package-name) :co))
