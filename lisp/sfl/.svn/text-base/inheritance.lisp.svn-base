;;; -*- Package: co; Base: 10; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;;;FLAVOR DEFS AND BASIC METHODS FOR THE MIXIN THAT KEEPS TRACK OF INHERITANCE FOR
;;;CONCEPTS AND ROLES

(defclass inheritance-handling-mixin
    (marker-mixin)
  ((abstractions :initform nil :initarg :abstractions :accessor abstractions)
   (defined-abstractions :initform nil :initarg :defined-abstractions 
			 :accessor defined-abstractions)
   (specializations :initform nil :initarg :specializations
		    :accessor specializations)
   (completion-sweeper :initform 0 :initarg :completion-sweeper 
		       :accessor completion-sweeper)))

(defmethod add-specialization ((self inheritance-handling-mixin)
			       specialization-name)
  (with-slots (specializations) self
    (push specialization-name specializations)))

(defmethod remove-specialization ((self inheritance-handling-mixin)
				  specialization-name)
  (with-slots (specializations) self
    (setq specializations (delete specialization-name specializations))))

(defmethod parent-type ((self inheritance-handling-mixin) parent-name)
  (if (member parent-name (abstractions self))
      :DIRECT-DEFINED
      :DEFINED-BUT-NOT-DIRECT))

;;;This is mixed into the flavor that defines the single top-of-lattice instances
;;;for concepts and roles.

(defclass top-of-lattice
	  (inheritance-handling-mixin)
  ())

(defmethod set-abstractions-to-most-specific-only ((self
						    inheritance-handling-mixin))
  (with-slots (abstractions defined-abstractions) self
    (setq abstractions (most-specific-only-n defined-abstractions self))))

;;;Note that in the case of restrictions the "names" are the instances
;;;and simply return themselves -- restrictions are not named-objects.

(defmethod collect-instances ((self inheritance-handling-mixin) names)
  (loop for name in names
	collect (my-instance name)))

(defmethod match-defined-parent-p ((self inheritance-handling-mixin) parent-name)
  (member parent-name (defined-abstractions self)))

;;; These are for mapping up ALL abstractions, or down to ALL specializations.
;;; They use VISITED-P.

;;; IV is 'abstractions or 'specializations (or others w/ names of instances)
;;; This goes depth first.  THESE CAN ONLY BE CALLED FROM WITHIN METHODS,
;;; e.g. (SEND-TO-ALL 'SPECIALIZATIONS :DELETE-REDUNDANT-SLOTS &rest args)

(defmacro mac-send-to-all (iv message args)
  `(loop for named in (slot-value self ,iv)
	 do (apply #'send-to-all1 (my-instance named) ,iv ,message ,args)))

(defmethod send-to-all1 ((self inheritance-handling-mixin) iv message &rest args)
  (with-slots (visited-p) self
    (unless (= *visited* visited-p)
      (setq visited-p *visited*)
      (apply message self args)
      (mac-send-to-all iv message args))))

(defmethod send-to-all ((self inheritance-handling-mixin) iv message &rest args)
  (incf *visited*)
  (mac-send-to-all iv message args))

;;; This goes breadth first.

(defmethod mac-send-to-all-breadth-first ((self inheritance-handling-mixin)
					  iv message args)
  (let ((collected-instances (collect-instances self (slot-value self iv))))
    (loop for instance in collected-instances
	  do (with-slots (visited-p) instance
	       (unless (= *visited* visited-p)
		 (setq visited-p *visited*)
		 (apply message instance args))))
    (loop for instance in collected-instances
	  do (funcall #'mac-send-to-all-breadth-first instance iv message args))))

(defmethod send-to-all-breadth-first ((self inheritance-handling-mixin)
				      iv message &rest args)
  (incf *visited*)
  (mac-send-to-all-breadth-first self iv message args))

;;; Do after abstractions sends thing a message after we ensure that
;;; message has been sent to all things that are more general than it.
;;; In a sense this is a breadth first search. Note that visited-p
;;; must be incremented outside this algorithm.

(defmethod do-after-abstractions ((self inheritance-handling-mixin)
				  message &rest args)
  (with-slots (visited-p abstractions) self
    (unless (= *visited* visited-p)
      (setq visited-p *visited*)
      (loop for a in abstractions
	    do (apply #'do-after-abstractions (my-instance a) message args))
      (apply message self args))))

;;; Append values of applying message from all IV (abstractions or
;;; specializations).

;;; E.G (COLLECT-FROM-ALL 'SPECIALIZATIONS 'instances) gets
;;; (non-destructively) all the instances of a concept and its
;;; specializations

(defmacro mac-collect-from-all (iv message args)
  `(loop for named in (slot-value self ,iv)
       append (apply 
	       #'collect-from-all1 (my-instance named) ,iv ,message ,args)))

(defmethod collect-from-all1 ((self inheritance-handling-mixin)
			      iv message &rest args)
  (with-slots (visited-p) self
    (unless (= *visited* visited-p)
      (setq visited-p *visited*)
      (let ((mine (apply message self args)))
	(if (listp mine)
	    (append mine (mac-collect-from-all iv message args))
	    (cons mine (mac-collect-from-all iv message args)))))))

(defmethod collect-from-all ((self inheritance-handling-mixin)
			     iv message &rest args)
  (incf *visited*)
  (mac-collect-from-all iv message args))

;;; Destructive version.
(defmacro nmac-collect-from-all (iv message args)
  `(loop for named in (slot-value self ,iv)
       nconc (apply
	      #'ncollect-from-all1 (my-instance named) ,iv ,message ,args)))

(defmethod ncollect-from-all1 ((self inheritance-handling-mixin) iv message
			       &rest args)
  (with-slots (visited-p) self
    (unless (= *visited* visited-p)
      (setq visited-p *visited*)
      (let ((mine (apply message self args)))
	(if (listp mine)
	    (nconc mine (nmac-collect-from-all iv message args))
	    (cons mine (nmac-collect-from-all iv message args)))))))

(defmethod ncollect-from-all ((self inheritance-handling-mixin) iv message
			      &rest args)
  (incf *visited*)
  (nmac-collect-from-all iv message args))



(defmacro mac-collect-from-all-fn (fn message args)
  `(loop for named in (funcall ,fn self)
       nconc (apply 
	      #'collect-from-all-fn1 (my-instance named) ,fn ,message ,args)))

(defmethod collect-from-all-fn1 ((self inheritance-handling-mixin) fn message
				 &rest args)
  (with-slots (visited-p) self
    (unless (= *visited* visited-p)
      (setq visited-p *visited*)
      (cons (apply message self args)
	    (mac-collect-from-all-fn fn message args)))))

(defmethod collect-from-all-fn ((self inheritance-handling-mixin) fn message
				&rest args)
  (incf *visited*)
  (mac-collect-from-all-fn fn message args))


;;; (FIND-ALL-THE 'SPECIALIZATIONS :match-defined-parent me)

(defmacro mac-find-all-the (iv message args)
  `(loop for named in (slot-value self ,iv)
	 nconc (apply  #'find-all-the1 (my-instance named) ,iv ,message ,args)))

(defmethod find-all-the1 ((self inheritance-handling-mixin) iv message
			  &rest args &aux val)
  (with-slots (visited-p) self
    (unless (= *visited* visited-p)
      (setq visited-p *visited*)
      (setq val (apply message self args))
      (if val
	  (cons (name self)
		(mac-find-all-the iv message args))
	  (mac-find-all-the iv message args)))))
						
(defmethod find-all-the ((self inheritance-handling-mixin) iv message &rest args)
  (incf *visited*)
  (mac-find-all-the iv message args))


;;; (TEST-IF-ANY 'ABSTRACTIONS :SUBSUME-P me) returns the first one (by name)
		
(defmacro mac-test-if-any (iv message args)
  `(loop for name in (slot-value self ,iv)
	 when  (apply #'test-if-any1 (my-instance name) ,iv ,message ,args)
	   return it))

(defmethod test-if-any1 ((self inheritance-handling-mixin) iv message &rest args)
  (with-slots (visited-p) self
    (unless (= *visited* visited-p)
      (setq visited-p *visited*)
      (if (apply message self args)
	  (name self)
	  (mac-test-if-any iv message args)))))

(defmethod test-if-any ((self inheritance-handling-mixin) iv message &rest args)
  (incf *visited*)
  (mac-test-if-any iv message args))


;;;Send message with arguments to me and all my parents/children

(defmethod map-to-me-and-my-parents ((self inheritance-handling-mixin) message
				     &rest args)
  (apply message self args)
  (apply #'send-to-all self 'abstractions message args))


(defmethod map-to-my-parents ((self inheritance-handling-mixin) message &rest args)
    (apply #'send-to-all self 'abstractions message args))

(defmethod map-to-my-direct-parents ((self inheritance-handling-mixin) message
				     &rest args)
  (loop for a in (abstractions self)
	do (apply message (my-instance a) args)))

(defmethod map-to-me-and-my-children ((self inheritance-handling-mixin) message
				      &rest args)
  (apply message self args)
  (apply #'send-to-all self 'specializations message args))

(defmethod map-to-my-children ((self inheritance-handling-mixin) message
			       &rest args)
  (apply #'send-to-all self 'specializations message args))

(defmethod map-to-my-direct-children ((self inheritance-handling-mixin) message
				      &rest args)
  (loop for a in (specializations self)
	do (apply message (my-instance a) args)))


;;;These return the NAMES of the members of the lattice above (abstractions)
;;;or below (specializations) the thing sent the message in the taxonomy.

;;;This uses a somewhat simplified and faster version of COLLECT-FROM-ALL

(defmethod collect-all-abstractions1 ((self inheritance-handling-mixin))
  (with-slots (visited-p abstractions) self
    (unless (= *visited* visited-p)
      (setq visited-p *visited*)
      (cons (name self)
	    (loop for a in abstractions
		  nconc (collect-all-abstractions1 (my-instance a)))))))


(defmethod all-abstractions ((self inheritance-handling-mixin))
  (incf *visited*)
  (loop for a in (abstractions self)
	nconc (collect-all-abstractions1 (my-instance a))))

(defmethod all-abstractions-and-self ((self inheritance-handling-mixin))
  (cons (name self) (all-abstractions self)))

(defmethod all-specializations ((self inheritance-handling-mixin))
  (collect-from-all self 'specializations #'name))

(defmethod all-specializations-and-self ((self inheritance-handling-mixin))
  (cons (name self) (all-specializations self)))

(defmethod specialization-instances ((self inheritance-handling-mixin))
  (loop for specialization in (specializations self)
	collect (my-instance specialization)))

(defmethod abstraction-instances ((self inheritance-handling-mixin))
  (loop for abstraction in (abstractions self)
	collect (my-instance abstraction)))

(defmethod all-abstraction-instances ((self inheritance-handling-mixin))
  (loop for abstraction in (all-abstractions self)
	collect (my-instance abstraction)))

(defmethod all-specialization-instances ((self inheritance-handling-mixin))
  (loop for spec in (all-specializations self)
	collect (my-instance spec)))

;;;Stuff that defines various useful versions of subsumption.  All of
;;;this assumes that the hierarchy is complete at the moment they are
;;;called -- that is these are useless for classifying anything that
;;;does not have its place in the taxonomy specified already.

;;;These work entirely by looking at the lattice structure -- that is this stuff
;;;defines subsumption by spot in lattice.

;;;Will return t if we strictly subsume other thing.
;;;Note that we check our name against all the abstractions of the other thing
;;;because all the abstractions are cached.

(defmethod subsumes-p ((self inheritance-handling-mixin) other-thing)
  (member (name self) (all-abstractions other-thing)))

(defmethod subsumed-by ((self inheritance-handling-mixin) other-name)
  (member other-name (all-abstractions self)))

(defmethod subsumed-by-any ((self inheritance-handling-mixin) other-names)
  (intersect-p other-names (all-abstractions self)))

;;;Will return t if we have the same name as other thing.
(defmethod equal-name ((self inheritance-handling-mixin) other-thing)
  (eq (name self) (name other-thing)))

;;;Will return t if we are the same or strictly subsume other thing.
(defmethod subsumes-or-equal ((self inheritance-handling-mixin) other-thing)
  (or (eq self other-thing)
      (subsumes-p self other-thing)))

(defun any-subsumes-or-equal (test-concept test-against-concepts)
  (loop for concept in test-against-concepts
	when (subsumes-or-equal concept test-concept)
	  return t))

;;;The others are assumed to be a list of NAMES.
(defmethod any-more-specific-than ((self inheritance-handling-mixin) others)
  (loop for other-name in others
	when (subsumes-p self (my-instance other-name))
	return t))

(defmethod any-more-specific-or-equal ((self inheritance-handling-mixin) others)
  (or (member (name self) others)
      (loop for other-name in others
	    when (subsumes-p self (my-instance other-name))
	      return t)))

(defmethod any-instances-more-specific-or-equal ((self inheritance-handling-mixin)
						 others)
  (or (member self others)
      (loop for other in others
	    when (subsumes-p self other)
	      return t)))

(defun match-concept-type  (c1 c2)
  (or (eql c1 c2)
      (let ((ci1 (concept c1))
	    (ci2 (concept c2)))
	(and ci1 ci2 (subsumes-p ci1 ci2)))))

(defun match-any-of-these-concept-types (match-to-concept-names concept-name
					 &aux match-with)
  (or (member concept-name match-to-concept-names)
      (and (setq match-with (concept concept-name))
	   (loop for cn in match-to-concept-names
		 for instance = (concept cn)
		 when (and instance (subsumes-p instance match-with))
		   return t))))

;;;This gets rid of things that have members in the input list that
;;;are more specific than they are.  Also duplicate instances are
;;;removed.

;;;Things are assumed to be instances that respond to the subsume and
;;;subsume-or-equal messages.

(defun most-specific-only (things)
  (loop for thing in things
	unless (any-instances-more-specific-or-equal thing (remove thing things))
	collect thing))

(defun most-general-only (things)
  (loop for thing in things
	unless (any-instances-more-general-or-equal thing (remove thing things))
	  collect thing))


(defun most-general-only-n (names root-instance)
  (mapcar #'name
    (most-general-only
      (collect-instances-from-names names root-instance))))

(defun most-specific-only-n (names root-instance)
  (mapcar #'name
	  (most-specific-only
	    (collect-instances-from-names names root-instance))))

(defmethod any-instances-more-general-or-equal ((self inheritance-handling-mixin)
						others)
  (loop for other in others
	when (subsumes-or-equal other self)
	return t))

(defun find-most-general-children (things)
  (most-general-only
    (apply #'intersection
	   (loop for thing in things
		 collect (all-specialization-instances thing)))))

(eval-when (compile load eval)
  (export '(subsumes-p subsumed-by) (find-package :co)))



