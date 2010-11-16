;;; -*- Package: co; Base: 10; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;;; THIS FILE CONTAINS THE FLAVOR DEFINITIONS AND VARIOUS METHODS FOR SLOTS.

(proclaim '(inline concept-formp concept-name-of-concept-form
		   concept-of-concept-form simple-conjunctive-formp concept-type-vr))

(defun concept-formp (form)
  (and (listp form) (member (car form) '(a an))))

(defun concept-name-of-concept-form (form)
  (and (concept-formp form) (second form)))

(defun concept-of-concept-form (form)
  (concept (concept-name-of-concept-form form)))

(defun simple-conjunctive-formp (form)
  (and (listp form)
       (eql (car form) :and)
       (flat-listp (cdr form))))

(defun concept-type-vr (form)
  (and (listp form)
       (member (car form) *concept-form-keyword-list*)))

;;; Things that are associated with a specific defining concept..
;;; Note that the defining concept is a NAME, not a concept object...

(defclass concept-attribute-mixin ()
  ((defining-concept :accessor defining-concept :initarg :defining-concept :initform nil)))

(defmethod local-to ((self concept-attribute-mixin) concept-name)
  (eq concept-name (defining-concept self)))

(defmethod defining-concept-object ((self concept-attribute-mixin) )
  (concept (defining-concept self)))

;;; Slots are the basic way to store properties with concepts.

(defclass slot (concept-attribute-mixin marker-mixin)
  ((role-name :initform nil :initarg :role-name :accessor role-name)
   (description :initform nil :initarg :description :accessor description)
   (value-restriction :initform nil :initarg :value-restriction
		      :accessor value-restriction)
   (nr-max :initform nil :initarg :nr-max :accessor nr-max)
   (nr-min :initform nil :initarg :nr-min :accessor nr-min)
   (resolved-vr-concept :initform nil :initarg :resolved-vr-concept 
			:accessor resolved-vr-concept)
   (normal-vr-form :initform nil :initarg :normal-vr-form :accessor normal-vr-form)
   (default :initform nil :initarg :default :accessor default)))

(defmethod name ((self slot))
  (role-name self))

(defmethod print-object ((self slot) stream)
  (with-slots (role-name defining-concept) self
    (format stream "#<SLOT ~a  at ~a>"
	    role-name defining-concept)))

;;; Checking role subsumption.

(defmethod of-role-type ((self slot) other-role)
  (subsumes-or-equal other-role (role (role-name self))))

(defmethod concepts-of-vr ((self slot))
  (concepts-of (value-restriction self)))

(defmethod singleton-p ((self slot))
  (with-slots (nr-max) self
    (and nr-max (= nr-max 1))))

;;; Used for defining class of concept..
(defmethod role-name-and-default ((self slot))
  (with-slots (role-name default) self
    (list role-name default)))

(defmethod normal-vr-form :before ((self slot))
  (with-slots (normal-vr-form value-restriction) self
    (unless normal-vr-form (setq normal-vr-form (reduced-cnf value-restriction)))))

(defmethod role-object ((self slot))
  (role (role-name self)))

(defmethod vr-concept-name ((self slot))
  (resolved-vr-concept self))

(defmethod vr-concept ((self slot))
  (concept (resolved-vr-concept self)))

(defmethod simple-conjunctive-value-restriction ((self slot))
  (simple-conjunctive-formp (value-restriction self)))

(defmethod concept-vr? ((self slot))
  (concept-type-vr (value-restriction self)))

(defmethod complex-vr? ((self slot))
  (with-slots (value-restriction resolved-vr-concept) self
    (and value-restriction (not resolved-vr-concept))))

(defmethod resolve-vr ((self slot))
  (with-slots (resolved-vr-concept value-restriction normal-vr-form) self
    (setq resolved-vr-concept 
	  (if (concept-formp value-restriction)
	      (second value-restriction)
	      nil))
    (setq normal-vr-form (reduced-cnf value-restriction))))

(defmethod initialize-instance :after ((self slot) &key)
  (resolve-vr self))

;;; When we kill a slot we must remove the slot from the backpointers stored with the role
;;; and with the vr-concepts.

(defmethod kill :before ((self slot))
  (with-slots (value-restriction role-name) self
    (loop for cn in (concepts-of value-restriction)
	  for cno = (concept cn)
	  do (setf (inverse-slots cno)
		   (delete self (inverse-slots cno))))
    (setf (slots-for-me (role role-name)) (delete self (slots-for-me (role role-name))))))


;;; NUMBER RESTRICITIONS....

(defmethod nr-list ((self slot))
  (with-slots (nr-min nr-max) self
    (list nr-min nr-max)))

(proclaim '(inline valid-nr nr-equal nr-subsumes nr-subsumes-or-equal))
(defun valid-nr (min max)
  (not (and min (*> min max))))

(defmethod nr-valid? ((self slot))
  (with-slots (nr-min nr-max) self
    (valid-nr nr-min nr-max)))

(defun nr-equal (min max other-min other-max)
  (and (=* min other-min)
       (=* max other-max)))

(defun nr-subsumes (min max other-min other-max)
  (or (and (>* other-min min)
	   (*<= other-max max))
      (and (=* other-min min)
	   (*< other-max max))))

(defun nr-subsumes-or-equal (min max other-min other-max)
  (or (nr-subsumes min max other-min other-max)
      (nr-equal min max other-min other-max)))

(defmethod subsumes-other-nr-attributes? ((self slot) other-slot)
  (with-slots (nr-min nr-max) self
    (nr-subsumes nr-min nr-max (nr-min other-slot) (nr-max other-slot))))

(defmethod equal-other-nr-attributes? ((self slot) other-slot)
  (with-slots (nr-min nr-max) self
    (nr-equal nr-min nr-max (nr-min other-slot) (nr-max other-slot))))

(defmethod subsumes-or-equal-other-nr-attributes? ((self slot) other-slot)
  (with-slots (nr-min nr-max) self
    (nr-subsumes-or-equal nr-min nr-max
			  (nr-min other-slot) (nr-max other-slot))))


;;;This will turn a number restriction into a list of nr-min and nr-max.
;;;NR's going in could be nil (returns (list nil nil)), a single number (returns (list n n)),
;;;a single element list (returns (list (car nr)(car nr)) or a list of two numbers.
;;;If the NR is invalid will return (list nil nil).

(defun parse-number-restriction (nr)
  (if (null nr)
      (list nil nil)
      (if (integerp nr)
	  (list nr nr)
	  (if (listp nr)
	      (if (and (null (cdr nr))		; a singleton
		       (or (null (setq nr (car nr)))
			   (integerp nr)))
		  (list nr nr)
		  (let ((min (first nr))(max (second nr)))
		    (if (and (or (null min)
				 (integerp min))
			     (or (null max)
				 (integerp max))
			     (valid-nr min max))
			(list (first nr) (second nr))
			(list nil nil))))
	      (list nr nr)))))


;;; SUBSUMPTION FOR SLOTS.  WE COMPARE TWO SLOTS TO SEE WHETHER ONE IS MORE SPECIFIC THAN
;;; THE OTHER OR WHETHER THEY ARE SUBSUMPTION EQUIVALENT.

;;; WE PROVIDE A UNIFORM INTERFACE WITH SUBSUMES-P AND SUBSUMES-OR-EQUAL.

;;; Slots that are considered COMPLEX have value-restrictions that 
;;; CANNOT BE RESOLVED TO THE NAME OF ANY CONCEPT.
;;; Complex value restrictions are not SUBSUMPTION RELATED to ANY OTHER VALUE RESTRICTION.

;;; Role and nr are equal.

(defmethod equal-attributes-1 ((self slot) other-slot)
  (with-slots (role-name nr-min nr-max) self
    (and (eq role-name (slot-value other-slot 'role-name))
	 (nr-equal nr-min nr-max
		   (slot-value other-slot 'nr-min)
		   (slot-value other-slot 'nr-max)))))

;;; Neither complex, above true and resolved-vr-concepts the same.

(defmethod equal-attributes ((self slot) other-slot)
  (and  ;; explicit equivalence test is too expensive for complex VRs -- don't do it here
    (not (or (complex-vr? self)(complex-vr? other-slot)))
    (equal-attributes-1 self other-slot)
    (eq (slot-value self 'resolved-vr-concept)
	(slot-value other-slot 'resolved-vr-concept))))

;;; Part of the subsumes-or-equal-attributes test.
;;; Either roles the same and nr-subsumes-or-equal OR
;;; One role is more general than the other AND the more general role has an nr-max
;;; that is strictly greater +++Example??

(defmethod subsumes-or-equal-attributes-1 ((self slot) other-slot)
  (with-slots (role-name nr-min nr-max) self
    (let ((other-role-name (slot-value other-slot 'role-name)))
      (if (eq role-name other-role-name)
	  (nr-subsumes-or-equal
	    nr-min nr-max (slot-value other-slot 'nr-min) (slot-value other-slot 'nr-max))
	  (and (subsumes-p (role role-name) (role other-role-name))
	       (*<= (slot-value other-slot 'nr-max) nr-max))))))

;;; Above true AND either neither is complex AND our resolved vr concept subsumes the other
;;; OR compare-complex comes back T.

(defmethod subsumes-or-equal-attributes ((self slot) other-slot)
  (with-slots (resolved-vr-concept) self
    (and (subsumes-or-equal-attributes-1 self other-slot)
	 (if (or (complex-vr? self)(complex-vr? other-slot))
	     (complex-vrs-subsumes-or-equal self other-slot)
	     (subsumes-or-equal (concept resolved-vr-concept)
				(concept (slot-value other-slot 'resolved-vr-concept)))))))

;;; This should NEVER be called unless SUBSUMES-OR-EQUAL-ATTRIBUTES-1 is true.
;;; If either vr-form is a "non-concept" vr form, return nil
(defmethod complex-vrs-subsumes-or-equal ((self slot) other-slot)
  (when (and (concept-vr? self)(concept-vr? other-slot))
    (case (compare-slots-1 (normal-vr-form self) (normal-vr-form other-slot) nil)
      (LESS-RESTRICTIVE t)
      (EQUIVALENT t)
      (otherwise nil))))


;;; Now finally we are ready for the main routines that are callable outside of here.
;;; These provide a uniform interface for subsumes-p and subsumes-or-equal for slots,
;;; even though slots do not store abstraction/specialization links.

(defmethod subsumes-p ((self slot) other-slot)
  (with-slots (value-restriction) self
    (or (and (null value-restriction)
	     (value-restriction other-slot))
	(null value-restriction)
	(and (value-restriction other-slot)
	     (not (equal-attributes self other-slot))
	     (subsumes-or-equal-attributes self other-slot)))))

(defmethod subsumes-or-equal ((self slot) other-slot)
  (with-slots (value-restriction) self
    (or (null value-restriction)
	(and (not (null (value-restriction other-slot)))
	     (or (equal-attributes self other-slot)
		 (subsumes-or-equal-attributes self other-slot))))))

(defmethod subsumption-equivalent ((self slot) other-slot)
  (with-slots (value-restriction resolved-vr-concept) self
    (and (equal-attributes-1 self other-slot)
	 (or (eql value-restriction (value-restriction other-slot))
	     (and (concept-vr? self)
		  (concept-vr? other-slot)
		  (if (or (complex-vr? self) (complex-vr? other-slot))
		      (eql 'EQUIVALENT (compare-slots-1 (normal-vr-form self)
							(normal-vr-form other-slot) nil))
		      (eql resolved-vr-concept (resolved-vr-concept other-slot))))))))


;;; This is called from redefine to check exact equivalence
;;; We check all the fields.

(defmethod equivalent-to ((self slot) other-slot)
  (with-slots (value-restriction default description) self
    (or (eql self other-slot)
	(and (equal-attributes-1 self other-slot)
	     (equal value-restriction (value-restriction other-slot))
	     (equal default (default other-slot))
	     (equal description (description other-slot))))))





