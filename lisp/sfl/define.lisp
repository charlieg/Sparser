;;; -*- Package: co; Base: 10; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;;; THIS FILE CONTAINS THE DEFCONCEPT AND DEFROLE MACROS.

;;; CONCEPT-DEFINITION....

;;; The code for evaluating a defconcept form.

#+ignore
(defmacro defconcept (concept-name &body rest)
  `(defconcept-1 ',concept-name
		 ,.(loop for (key value) on rest by #'cddr
		       nconc `(,key ',value))))

;;; Allow defconcept to mimic defclass for name, supers, and slots
(defmacro defconcept (concept-name &body rest)
  (if (keywordp (car rest))
      `(defconcept-1 ',concept-name
	   ,.(loop for (key value) on rest by #'cddr
		 nconc `(,key ',value)))
    `(defconcept-1 ',concept-name
	 :specializes ',(first rest)
	 :slots ',(second rest)
	 ,.(loop for (key value) on (cddr rest) by #'cddr
	       nconc `(,key ',value)))))

(defun defconcept-1 (name
		     &key
		     description
		     specializes
		     slots
		     other-mixins concept-superclasses
		     make-class?
		     export?
		     &allow-other-keys
		     &aux (concept-object (concept name)))
  (unless specializes
    (setq specializes (list *most-general-concept*)))
  (if concept-object
      (redefine-concept
	concept-object
	description
	specializes
	(build-slot-objects slots name)
	make-class?
	(or concept-superclasses other-mixins)
	export?)
      (define-new-concept
	name
	description
	specializes
	slots
	make-class?
	(or concept-superclasses other-mixins)
	export?)))

(eval-when (compile load eval)
  (export 'defconcept (find-package :co)))


;;;(defun define-new-concept (name description defined-parents
;;;			   defined-slot-forms make-class? concept-superclasses
;;;			   &optional (class-name 'concept)
;;;			   &aux new-concept abstractions)
;;;  (maybe-define-as-default-concepts defined-parents)
;;;  (setq abstractions (most-specific-concepts defined-parents))
;;;  (setq new-concept (make-instance class-name
;;;				   :name name
;;;				   :description (if (listp description)
;;;						    description 
;;;						    (list description))
;;;				   :defined-abstractions defined-parents
;;;				   :abstractions abstractions
;;;				   :make-class? make-class?
;;;				   :concept-superclasses concept-superclasses))
;;;  ;;Must build slots after the concept is made in order to avoid getting screwed if a
;;;  ;;VR is the same concept.
;;;  (setf (defined-slots new-concept) (build-slot-objects defined-slot-forms name))
;;;  (insert-into-network new-concept)
;;;  (when (not *inhibit-completion-flag*)
;;;    (maybe-make-class new-concept))
;;;  new-concept)
;;; NLC-06/06/94
(defun define-new-concept (name description defined-parents
			   defined-slot-forms make-class? concept-superclasses export?
			   &optional (class-name 'concept)
			   &aux new-concept abstractions)
  (maybe-define-as-default-concepts defined-parents)
  (setq abstractions (most-specific-concepts defined-parents))

  ;;; NLC-06/06/94
  (setq new-concept (make-instance* class-name
				    :name name))
  (setf (description new-concept) (if (listp description)
				      description 
				    (list description)))
  (setf (defined-abstractions new-concept) defined-parents)
  (setf (abstractions         new-concept) abstractions)
  (setf (make-class?          new-concept) make-class?)
  (setf (concept-superclasses new-concept) concept-superclasses)

  ;;Must build slots after the concept is made in order to avoid getting screwed if a
  ;;VR is the same concept.
  (setf (defined-slots new-concept) (build-slot-objects defined-slot-forms name))
  (insert-into-network new-concept)
  (when (not *inhibit-completion-flag*)
    (maybe-make-class new-concept))
  (maybe-export new-concept export?)
  new-concept)

(defmethod insert-into-network ((self concept))
  (with-slots (abstractions name) self
    (unless *inhibit-completion-flag*		;When loading a file we turn this off
						;and do it all at once.
      (complete self))
    (loop for a in abstractions
	  do (add-specialization (concept a) name))
    self))

(defun maybe-define-as-default-concepts (concepts)
  (loop for c in concepts
	unless (concept c)
	  do (create-default-concept c)))

;;;(defun create-default-concept (name &key source-pathname)   ;;; NLC-05/16/94
;;;  (let ((concept (make-instance 'concept
;;;				:name name
;;;				:defined-abstractions (list *most-general-concept*)
;;;				:abstractions (list *most-general-concept*)
;;;				:default-p t)))
;;;    (when source-pathname
;;;      (record-pathname concept source-pathname))
;;;
;;;    (add-specialization (concept *most-general-concept*) name)
;;;    concept))
;;; NLC-06/06/94
(defun create-default-concept (name &key source-pathname make-class?)   ;;; NLC-05/16/94
  (let ((concept (make-instance* 'concept
				 :name name
				 :default-p t)))
    ;;; NLC-06/06/94
    (setf (defined-abstractions concept) (list *most-general-concept*))
    (setf (abstractions         concept) (list *most-general-concept*))
    (setf (make-class?          concept) make-class?)

    (when source-pathname
      (record-pathname concept source-pathname))

    (add-specialization (concept *most-general-concept*) name)
    concept))


;;; REDEFINE an EXISTING concept.

(defmethod redefine-concept
    ((self concept) new-description new-defined-abstractions new-defined-slots
     new-make-class? new-concept-superclasses new-export?)
  (with-slots (concept-superclasses description make-class? abstractions
	       defined-slots slots defined-abstractions export?) self
    (let* ((slots-changed-p (not (equal-defined-slots self new-defined-slots)))
	   #+ignore
	   (concept-superclasses-changed-p 
	    (not (set-equivalence concept-superclasses new-concept-superclasses)))
	   (new-make-class-p (and new-make-class? (not make-class?))))
      (setq description (if (listp new-description) new-description (list new-description))
	    concept-superclasses new-concept-superclasses
	    make-class? new-make-class?)
      (maybe-define-as-default-concepts new-defined-abstractions)
      (let* ((new-abstractions (most-specific-concepts new-defined-abstractions))
	     (abstractions-changed-p (not (equal new-abstractions abstractions))))
	(when abstractions-changed-p
	  (update-connections self new-abstractions))
	(setq defined-abstractions new-defined-abstractions)
	(cond ((and (not *inhibit-completion-flag*)
		    (or slots-changed-p abstractions-changed-p
			(null slots)))
	       (setq defined-slots new-defined-slots)
	       (complete self))
	      (*inhibit-completion-flag*
	       (setq defined-slots new-defined-slots)))
	(unless *inhibit-completion-flag*
	  (if make-class?
	      (progn
		(make-class self)
		(when new-make-class-p
		  (make-class-for-specializations self)))
	    (make-class-for-specializations self)))
	(maybe-export self new-export?)
	self))))
    
(defmethod make-class-for-specializations ((concept concept))
  (with-slots (specializations) concept
    (loop for concept-name in specializations
	for specialization = (concept concept-name)
	when (make-class? specialization)
	   do (make-class specialization)
	else do (make-class-for-specializations specialization))))

(defmethod remember-modifications-1 ((SELF concept) 
				     &key 
				     (new-description          nil NEW-DESCRIPTION-P)
				     (new-defined-abstractions nil NEW-DEFINED-ABSTRACTIONS-P)
				     (new-defined-slots        nil NEW-DEFINED-SLOTS-P)
				     (new-make-class?          nil NEW-MAKE-CLASS?-P)
				     (new-other-mixins         nil NEW-OTHER-MIXINS-P)
				     (new-concept-superclasses nil NEW-CONCEPT-SUPERCLASSES-P)
				     (new-export?              nil NEW-EXPORT?-P)
				     &allow-other-keys
				     )
  new-other-mixins
  (and NEW-OTHER-MIXINS-P
       (error "Using other-mixins keyword!"))
  (redefine-concept
   SELF
   (if NEW-DESCRIPTION-P          new-description          (description SELF))
   (if NEW-DEFINED-ABSTRACTIONS-P new-defined-abstractions (defined-abstractions SELF))
   (if NEW-DEFINED-SLOTS-P	  new-defined-slots        (defined-slots SELF))
   (if NEW-MAKE-CLASS?-P	  new-make-class?          (make-class? SELF))
   (if NEW-CONCEPT-SUPERCLASSES-P new-concept-superclasses (concept-superclasses SELF))
   #+NLC (if NEW-OTHER-MIXINS-P	  new-other-mixins         (concept-superclasses SELF))
   (if NEW-EXPORT?-P new-export? (export? SELF))
   )
  #+NLC (initialize self network-concept)
  #+NLC (unmodify-and-redisplay SELF)
  )

(defmethod remember-modifications ((SELF concept))
  (remember-modifications-1 SELF))

;;; ROLE DEFINITION....

#+ignore
(defmacro defrole (name &body rest)
  `(defrole-1 ',name ,@(loop for (key value) on rest by #'cddr
			   nconc `(',key ',value))))

(defmacro defrole (name &body rest)
  (if (keywordp (car rest))
      `(defrole-1 ',name 
	   ,@(loop for (key value) on rest by #'cddr
		 nconc `(',key ',value)))
    `(defrole-1 ',name 
	 :specializes ',(car rest)
	 ,@(loop for (key value) on (cdr rest) by #'cddr
	       nconc `(',key ',value)))))

(defun defrole-1 (name
		  &key
		  description
		  specializes
		  export?
		  &allow-other-keys
		  &aux (role-object (role name)))
  (unless specializes
    (setq specializes (list *most-general-relation*))) 
  (if role-object
      (redefine-role role-object description specializes export?)
    (define-new-role name description specializes export?)))

(eval-when (compile load eval)
  (export 'defrole (find-package :co)))

;;;(defun define-new-role (name description defined-parents 
;;;			&aux abstractions)
;;;  (maybe-define-as-default-roles defined-parents)
;;;  (setq abstractions (most-specific-roles defined-parents))
;;;  (let ((new-role (make-instance 'role
;;;				 :name name
;;;				 :description (if (listp description)
;;;						     description 
;;;						     (list description))
;;;				 :defined-abstractions defined-parents
;;;				 :abstractions abstractions)))
;;;    (insert-into-network new-role)))
(defun define-new-role (name description defined-parents export?
			&aux abstractions)
  (maybe-define-as-default-roles defined-parents)
  (setq abstractions (most-specific-roles defined-parents))
  (let ((new-role (make-instance* 'role
				  :name name)))
    ;;; NLC-06/06/94
    (setf (description               new-role) (if (listp description)
						   description 
						 (list description)))
    (setf (defined-abstractions      new-role) defined-parents)
    (setf (abstractions              new-role) abstractions)
    
    (insert-into-network new-role)
    (maybe-export new-role export?)))


(defmethod insert-into-network ((self role))
  (with-slots (abstractions name) self
    (loop for a in abstractions
	  do (add-specialization (role a) name))
    self))

(defun maybe-define-as-default-roles (roles)
  (loop for c in roles
	unless (role c)
	  do (create-default-role c)))

;;;(defun create-default-role (name &key source-pathname)	;;; NLC-05/16/94
;;;  (let ((role (make-instance 'role
;;;		:name name
;;;		:defined-abstractions (list *most-general-relation*)
;;;		:abstractions (list *most-general-relation*)
;;;		:default-p t)))
;;;    (when source-pathname
;;;      (record-pathname role source-pathname))
;;;    (add-specialization (or
;;;			 (role *most-general-relation*)
;;;			 (make-instance 'top-role))
;;;			name)
;;;    role))
(defun create-default-role (name &key source-pathname)	;;; NLC-05/16/94
  (let ((role (make-instance* 'role
			      :name name
			      :default-p t)))
    ;;; NLC-06/06/94
    (setf (defined-abstractions role) (list *most-general-relation*))
    (setf (abstractions         role) (list *most-general-relation*))

    (when source-pathname
      (record-pathname role source-pathname))
    (add-specialization (or
			 (role *most-general-relation*)
			 (make-instance 'top-role))
			name)
    role))

;;; REDEFINE an EXISTING role.

(defmethod redefine-role ((self role) new-description new-defined-abstractions new-export?)
  (with-slots (description defined-abstractions export?) self
    (maybe-define-as-default-roles new-defined-abstractions)
    (setq description (if (listp new-description) new-description (list new-description)))
    (let ((new-abstractions (most-specific-roles new-defined-abstractions)))
      (setq defined-abstractions new-defined-abstractions)
      (update-connections self new-abstractions)
      (maybe-export self new-export?))
    self))

(defmethod remember-modifications-1 ((SELF role) 
				     &key 
				     (new-description          nil NEW-DESCRIPTION-P)
				     (new-defined-abstractions nil NEW-DEFINED-ABSTRACTIONS-P)
				     (new-export?              nil NEW-EXPORT?-P)
				     &allow-other-keys
				     )
  (redefine-role
   SELF
   (if NEW-DESCRIPTION-P          new-description          (description SELF))
   (if NEW-DEFINED-ABSTRACTIONS-P new-defined-abstractions (defined-abstractions SELF))
   (if NEW-EXPORT?-P              new-export?              (export? SELF))
   )
  #+NLC (initialize self network-concept)
  #+NLC (unmodify-and-redisplay self)
  )

(defmethod remember-modifications ((SELF role))
  (remember-modifications-1 SELF))



;;; SLOT DEFINITION

;;; MAKING SLOT OBJECTS FROM FORMS.......

;;;(defun build-slot-objects (slot-specs concept-name)
;;;  (loop for (role-name vr nr default description) in slot-specs
;;;	for (min max) = (parse-number-restriction nr)	;always returns a list of (min max)
;;;						;will signal invalid if illegal and force
;;;						;user to enter valid NR.
;;;	for slot = (make-instance 'slot
;;;				  :role-name role-name
;;;				  :default default
;;;				  :description description
;;;				  :defining-concept concept-name
;;;				  :value-restriction
;;;				  (progn (loop for c in (non-concepts-of vr)
;;;					       do (create-default-concept c))
;;;					 vr)
;;;				  :nr-min min
;;;				  :nr-max max)
;;;	do (clean-up-for-new slot)
;;;	collect slot))
(defun make-slot (DEFINING-CONCEPT ROLE-NAME
		       &key 
		     (peristent?          t)
		     (visited-p           nil VISITED-P-P)
		     (default             nil DEFAULT-P)
		     (normal-vr-form      nil NORMAL-VR-FORM-P)
		     (resolved-vr-concept nil RESOLVED-VR-CONCEPT-P)
		     (nr-min              nil NR-MIN-P)
		     (nr-max              nil NR-MAX-P)
		     (value-restriction   nil VALUE-RESTRICTION-P)
		     (description         nil DESCRIPTION-P))
  peristent? 
  (let ((NEW-SLOT (make-instance* 'slot
				  :role-name ROLE-NAME
				  :defining-concept DEFINING-CONCEPT
				  ;;; :persistentp PERISTENT?
				  )))
    (and VISITED-P-P
	 (setf (visited-p NEW-SLOT) visited-p))
    (and DEFAULT-P
	 (setf (default NEW-SLOT) default))
    (and NORMAL-VR-FORM-P
	 (setf (normal-vr-form NEW-SLOT) normal-vr-form))
    (and RESOLVED-VR-CONCEPT-P
	 (setf (resolved-vr-concept NEW-SLOT) resolved-vr-concept))
    (and NR-MIN-P
	 (setf (nr-min NEW-SLOT) nr-min))
    (and NR-MAX-P
	 (setf (nr-max NEW-SLOT) nr-max))
    (and VALUE-RESTRICTION-P
	 (setf (value-restriction NEW-SLOT) value-restriction))
    (and DESCRIPTION-P
	 (setf (description NEW-SLOT) description))
    NEW-SLOT))


(defun build-slot-objects (slot-specs concept-name &key (peristent? t))
  peristent?
  (loop for (role-name vr nr default description) in slot-specs
      for (min max) = (parse-number-restriction nr) ;always returns a list of (min max)
					;will signal invalid if illegal and force
					;user to enter valid NR.
      for slot = (make-slot concept-name role-name
			    :peristent?        peristent?
			    :default           default
			    :description       description
			    :value-restriction (progn (loop for c in (non-concepts-of vr)
							  do (create-default-concept c))
						      vr)
			    :nr-min            min
			    :nr-max            max)
      do (clean-up-for-new slot)
      collect slot))

(defmethod clean-up-for-new ((self slot))
  (with-slots (value-restriction role-name resolved-vr-concept) self
    (unless value-restriction
      (setq value-restriction (articalize *most-general-concept*)))
    (unless (role role-name)
      (create-default-role role-name))
    (loop for c in (non-concepts-of value-restriction)
	  do (create-default-concept c))
    (resolve-vr self)
    ;;If the vr is a simple conjunctive form we see if the network contains the a single
    ;;meet for the conjunction.  If it does we substitute the meet for the conjunction.
    ;;Note that we may take this out as it creates a slight ordering dependency.
    (when (and (null resolved-vr-concept)
	       (simple-conjunctive-formp value-restriction))
      (let ((meet (car (find-most-general-children
			 (most-specific-only (collect-concept-instances
					       (cdr value-restriction)))))))
	(when meet
	  (setq value-restriction (articalize meet))
	  (resolve-vr self))))))

;;; NLC-02/18/97
(defun concept-has-defined-slot-role? (CONCEPT ROLE)
  (let ((DEFINED-SLOTS (defined-slots CONCEPT))
	(ROLE-NAME (name ROLE)))
    (loop for DF in DEFINED-SLOTS
	when (eql (role-name DF) ROLE-NAME)
	return t)))
