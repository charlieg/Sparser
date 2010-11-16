;;; -*- Package: co; Base: 10; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;;;THIS FILE CONTAINS THE FLAVOR DEFINITIONS AND METHODS THAT DEFINE
;;;THE BASIC NOTIONS OF CONCEPTS AND ROLES.

;;;Common to both roles and concepts.

(defclass basic-role-concept-mixin
    (named-object-mixin
     inheritance-handling-mixin
     source-file-mixin)
  ())

;;; The basic class definition for concept.

(defclass concept
    (basic-role-concept-mixin
     slot-handling-mixin
     class-making-mixin)
  ((instances :initform nil :initarg :instances :accessor instances)))

(eval-when (compile load eval)
  (export 'concept (find-package :co)))

;;; Roles define TWO-PLACE relations between concepts.  Another way of
;;; looking at roles is that define NAMED KIND OF SLOT IN A FRAME
;;; (concept).

;;; Roles store a list of the concepts that originate slots for them 

(defclass role
	(basic-role-concept-mixin)
  ((slots-for-me :initform nil :initarg :slots-for-me :accessor slots-for-me)))

(eval-when (compile load eval)
  (export 'role (find-package :co)))

(defmethod initialize-instance :after ((self concept) &key)
  #+NLC (push self *concepts*)
  (record-concept-object *vsfl-master* self)
  (setf (get (name self) 'concept) self))

(defmethod initialize-instance :after ((self role) &key)
  #+NLC (push self *roles*)
  (record-role-object *vsfl-master* self)
  (setf (get (name self) 'role) self))

(defmethod kill :after ((self concept))
  #+NLC (delete self *concepts*)
  (delete-concept-object *vsfl-master* self)
  (remprop (name self) 'concept)
  (mapc #'kill (instances self)))

(defmethod kill :after ((self role))
  (delete-role-object *vsfl-master* self)
  #+NLC (delete self *roles*)
  (remprop (name self) 'role))


;;;Roles and concepts form SEPARATE namespaces.  
;;;That is, it is perfectly legal to have
;;;a concept named foo and a role also named foo.

(defmethod relevant-instance ((self concept) other-name)
  (concept other-name))
  
(defmethod relevant-instance ((self role) other-name)
  (role other-name))

;;; But if the symbol is exported, it must be exported for both the
;;; concept and the role.

(defmethod (setf export?) :after (value (concept concept))
  (with-slots (name) concept
    (let ((role (role name)))
      (when role
	(with-slots (export?) role
	  (setq export? value))))))

(defmethod (setf export?) :after (value (role role))
  (with-slots (name) role
    (let ((concept (concept name)))
      (when concept
	(with-slots (export?) concept
	  (setq export? value))))))

;;;BOTH CONCEPTS AND ROLES EXIST IN A ROOTED TAXONOMY. 

(defvar *most-general-concept* 'thing)

(defclass top-concept
    (top-of-lattice
     concept)
  ((name :initform *most-general-concept*)))

(defmethod top-name ((self concept))
  *most-general-concept*)

(defmethod top-object ((self concept))
  (concept *most-general-concept*))


(defvar *most-general-relation* '*relation*)

(defclass top-role
	  (top-of-lattice
	    role)
    ((name :initform *most-general-relation*)))

(defmethod top-name ((self role))
  *most-general-relation*)

(defmethod top-object ((self role))
  (role *most-general-relation*))

(defmethod find-instance ((self concept) instance-name)
  (loop for instance in (all-instances self)
	when (eql (name instance) instance-name)
	  return instance))


(proclaim '(inline conceptp rolep))
(defun conceptp (thing)
  (typep thing 'concept))

;;;This  sees if the name is a concept
(defmacro concept? (name)
  `(concept ,name))

(defun rolep (thing)
  (typep thing 'role))

(defmacro role? (name)
  `(role ,name))

(defmacro c. (name)
  `(concept ',name))

(defmacro r. (name)
  `(role ',name))


(eval-when (compile load eval)
  (export '(c. r.)
	  (find-package :co)))


;;;This stuff gets all the concept names out of any kind of complex vr form.

(defun concepts-of (form)
  (if (symbolp form)
      (when (concept form)
	(ncons form))
      (when (and (listp form)
		 (member (car form)
			 '(a an and* or* not* ;;these are for compatability only
			     :a :an :and :or :not)))
	(ndelete-dupes (mapcan #'concepts-of (cdr form))))))



;;; This gets the things that should be concepts -- those symbols inside the special
;;; forms a an :and :or :not.

(defun non-concepts-of-1 (form)
  (if (symbolp form)
      (when (not (concept form))
	(ncons form))
      (when (and (listp form)
		 (member (car form) *concept-form-keyword-list*))
	(ndelete-dupes (mapcan #'non-concepts-of-1 (cdr form))))))

(defun non-concepts-of (form)
  (and (listp form)
       (member (car form) *concept-form-keyword-list*)
       (ndelete-dupes (mapcan #'non-concepts-of-1 (cdr form)))))

(defun top-concept ()
  (concept *most-general-concept*))

(defun top-role ()
  (role *most-general-relation*))


(defmethod slots-with-role-name-abstraction ((concept concept)
					     role-name-abstraction)
  (with-slots (slots) concept
    (loop for slot in slots
	  when (member role-name-abstraction (abstractions (role (role-name slot))))
	  collect slot)))

(defmethod slot-names-with-role-name-abstraction ((concept concept)
						  role-name-abstraction)
  (loop for slot in (slots-with-role-name-abstraction concept role-name-abstraction)
      collect (role-name slot)))

#+allegro
(defmethod role-file-names-source ((role role) (action (eql :export)))
  (with-slots (slots-for-me source-files) role
    (or 
     source-files
     (remove-duplicates
      (loop for slot in slots-for-me
	  append (source-files (concept (defining-concept slot))))
      :test 'excl::pathname-equalp))))

#+allegro
(defmethod role-file-names-source ((role role) (action (eql :add-parent)))
  (with-slots (defined-abstractions source-files) role
    (or
     source-files
     (remove-duplicates
      (loop for role-name in defined-abstractions
	  append (source-files (role role-name)))
      :test 'excl::pathname-equalp))))

(eval-when (compile load eval)
  (export '(slots-with-role-name-abstraction
	    slot-names-with-role-name-abstraction)
	  (find-package :co)))
