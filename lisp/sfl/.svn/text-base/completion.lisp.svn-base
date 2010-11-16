;;; -*- Package: co; Base: 10; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;;; THIS FILE CONTAINS THE CODE THAT COMPUTES THE COMPLETE SET OF EFFECTIVE SLOTS
;;; AT A CONCEPT, GIVEN THAT CONCEPT'S DEFINED SLOTS AND ITS PARENTS.



;;; The complete set of effective slots at a concept is found, by finding, for each relevant
;;; role, the most specific slot from the set of slots that include any the concept locally
;;; defined and any for the concepts parents.

;;; DEFINED SLOTS are the slots explicitly defined by the user before
;;; any completion is done.  It is possible for a DEFINED SLOT not to be included
;;; in the completed set of SLOTS.

;;; LOCAL SLOTS are slots that are either defined at this concept
;;; or caused to come into creation by the compute-slots process -- that
;;; is they are defined nowhere above. A slot, whether it be part of the definition
;;; or part of the completed set, is defined to be local iff the concept name is the
;;; CONCEPT-DEFINING of the slot.

;;; SLOTS are the completed set of slots.  This set can include defined
;;; slots, slots that are inheritted from the concept's parents or slots
;;; that are created during the course of completion. Slots that come into being
;;; during the course of completing the slots at a concept are sometimes referred
;;; to as INDUCED SLOTS -- these slots can be distinguished by the fact
;;; that they are local but not defined.


(defvar *roles-to-be-considered* nil)

(defmethod complete ((self inheritance-handling-mixin))
  )

(defmethod complete ((self concept))
  (complete-1 self))



;;; If we have specializations then cascade the completion downward.

;;; We want to do the completion on a specialization after all its parents have been completed.
;;; We assume that things which are not specializations of this one are completed correctly.

;;; We first mark all the specializations except the immediate ones, the immediate
;;; ones get put on the *COMPLETION-Q*.

;;; After completion is done on the TOPLEVEL thing, we go to work on the queue, completing
;;; the items on it and then putting the specializations of the completed item on the
;;; quueu, PROVIDING THAT ANY OF ITS PARENTS THAT NEED TO BE COMPLETED HAVE ALREADY
;;; BEEN COMPLETED. 

;;; Unless something is marked it has either been completed in this cycle, or it doesn't
;;; need to be (i.e. a parent of some deep specialization that is not a specialization
;;; of the toplevel thing).

;;; When something is completed any flavor connected to it is invalidated as well
;;; as any for any of its children.

;;; We invalidate the toplevel thing and its children, conveniently, right here.

(defvar *completion-q*)
(defmethod complete :before ((self inheritance-handling-mixin))
  (incf *completion-sweeper*)			;Note that the top thing is left unmarked.
  (setq *completion-q*
	(collect-concept-instances (specializations self)))
  (loop for s in *completion-q*
	do (mark-for-completion-sweep s)))

;;; Note that first level is unmarked -- just collected into completion q (which, normally
;;; causes an unmark).

(defmethod mark-for-completion-sweep ((self inheritance-handling-mixin))
  (loop for s in (specializations self)
	do (mark-for-completion-sweep-1 (concept s))))

(defmethod mark-for-completion-sweep-1 ((self inheritance-handling-mixin))
  (with-slots (completion-sweeper) self
    (unless (eql completion-sweeper *completion-sweeper*)
      (setq completion-sweeper *completion-sweeper*)
      (loop for s in (specializations self)
	    do (mark-for-completion-sweep-1 (my-instance s))))))

;;; After completion on the TOPLEVEL thing is done start working through the q,
;;; calling complete-2 on each element.
;;; Complete-2 will call complete-1 to do the actual completion and then will
;;; try to put specializations on the q.

(defmethod complete :after ((self inheritance-handling-mixin))
  (loop for ai = (pop *completion-q*)
	while ai
	do (complete-2 ai)))

(defmethod complete-2 ((self concept))
  (complete-1 self)
  (loop for s in (specializations self)
	do (maybe-put-on-completion-q (concept s))))


(defmethod maybe-put-on-completion-q ((self inheritance-handling-mixin))
  (with-slots (completion-sweeper) self
    (when (and (= completion-sweeper *completion-sweeper*)
	       (all-abstractions-completed-or-on-q? self))
      (decf completion-sweeper)
      (nadd-on self *completion-q*))))


;;; Check all abstractions for NOT being marked.  Those we will have to 
;;; complete are marked at the beginning and unmarked as placed on the q.
;;; The ones THAT NEED TO BE DONE, BUT AREN'T YET will be marked.

;;; Note that THE UNMARKING IS DONE WHEN THINGS ARE PLACED ON THE Q, NOT WHEN
;;; THEY ARE ACTUALLY COMPLETED.

;;; We don't complete something until all its abstractions (that need to be completed during
;;; this cycle) have been completed.

(defmethod all-abstractions-completed-or-on-q? ((self inheritance-handling-mixin))
  (loop for a in (abstractions self)
	when (= *completion-sweeper* (completion-sweeper (my-instance a)))
	  return nil
	finally (return t)))



(defmethod complete-1 :before ((self inheritance-handling-mixin) &aux (my-name (name self)))
  (with-slots (defined-abstractions abstractions) self
    (let* ((new-abstractions (most-specific-only-n defined-abstractions self))
	   (superfluous-abstractions (and abstractions
					  (filter-out new-abstractions abstractions))))
      (loop for s in superfluous-abstractions
	    do (remove-specialization (my-instance s) my-name))
      (setq abstractions new-abstractions))))

(defmethod complete-1 ((self slot-handling-mixin))
  ;;For simplicity we don't check slot equivalence.  We simply kill the old slots
  ;;and recomplete.  Note that the old-defined-slots don't matter since we don't store
  ;;any backpointers to them.  Backpointers are only stored for the effective slots.
  (loop for slot in (local-effective-slots self)
	do (kill slot))
  (setf (slots self) (compute-slots self))
  (update-slot-backpointers self))



;;; This is the hairy part.

;;; COMPUTE THE EFFECTIVE SLOTS FROM THE DEFINED SLOTS AND THE PARENTS AND RETURN THEM.

(defmethod compute-slots ((self slot-handling-mixin) )
  (compute-roles-to-be-considered self)
  (loop for role-name in *roles-to-be-considered*
	collect (effective-slot-for-role role-name self)))

;;; COMPUTE THE LIST OF ROLE NAMES THAT THE CONCEPT WILL HAVE EFFECTIVE SLOTS FOR.....

;;;We look through (once only) all our DEFINED slots and all the EFFECTIVE slots
;;;for each of our abstractions.  For each unique role we store a list of the
;;;the MOST-SPECIFIC-ONLY slots.

;;;Complexities arise because we have to consider, for a given role, all slots for that
;;;role as well as all slots for that roles parents. 

;;; Note the order of the loops.  We put the inheritted on first so that, if we define
;;; a slot that is subsumption equivalent to one we could inherit, we prefer the inherited
;;; one.  This reduces the updating and size of the backpointer lists and makes for a
;;; considerably cleaner network.

(defmethod compute-roles-to-be-considered ((self slot-handling-mixin))
  (with-slots (defined-slots name) self
    (setq *roles-to-be-considered* nil)
    (loop for slot in defined-slots
	  do (new-role-to-be-considered
	       (role-name slot) slot))
    (loop for a in (abstractions self)
	  do (compute-roles-to-be-considered-1 (concept a) name))
    (merge-slots-of-parent-roles)))

(defmethod compute-roles-to-be-considered-1 ((self slot-handling-mixin) for-concept-name)
  (loop for slot in (slots self)
	for role-name = (role-name slot)
	when (member role-name *roles-to-be-considered*)
	  do (maybe-add-slot-to-be-considered role-name slot for-concept-name)
	else do (new-role-to-be-considered
		  role-name slot)))

(defun new-role-to-be-considered (role-name slot)
  (nadd-on role-name *roles-to-be-considered*)
  (putprop role-name (list slot) :msp-slots-for-completion))



;;;Have a slot for role that we have already started.  Add it to list unless there is
;;;a more specific one on the list.  If we add it to list, delete from list any that
;;;are more general than it.

(defun maybe-add-slot-to-be-considered (role-name slot for-concept-name)
  (let ((existing-slots (get role-name :msp-slots-for-completion)))
    (unless (member slot existing-slots)
      (loop with already-in = nil
	    for old-slot in existing-slots
	    do (cond (already-in
		      ;;Slot already in list, see if we should get rid of old ones.
		      (when (subsumes-p old-slot slot)
			(putprop role-name
				 (delete old-slot existing-slots)
				 :msp-slots-for-completion)))
		     ;;Slot not yet in list, see if we should add it.  If slot is more
		     ;;general than an old one, it cant be equivalent or more specific
		     ;;than any other (we only keep the most specific ones) so return.
		     (t
		      (if (subsumes-p slot old-slot)
			  (return nil)
			  (if (subsumption-equivalent slot old-slot)
			      ;;See if we subst new for old.
			      (progn (when (if (equivalent-to slot old-slot)
					       ;;If exact, prefer inherited.
					       (eql (defining-concept old-slot)
						    for-concept-name)
					       ;;If ss equ, but not exact, prefer local.
					       (eql (defining-concept slot) for-concept-name))
				       (putprop role-name
						(nsubst slot old-slot existing-slots)
						:msp-slots-for-completion))
				     (return nil))	;only one ss equ slot allowed.
			      (when (subsumes-p old-slot slot)
				(putprop role-name
					 (nsubst slot old-slot existing-slots)
					 :msp-slots-for-completion)
				;;Must check to see if old subsumes others already in
				;;and get rid of them.
				(setq already-in t))))))
	    finally (unless already-in
		      (putprop role-name
			       (cons slot existing-slots)
			       :msp-slots-for-completion))))))



;;; The most-specific-slots-for-completion must contain all the most specific slots
;;; for a role as well as those for ANY OF THE ROLES PARENTS.
;;; However if a slot for a subsumer-role is INHERITTED from the same CONCEPT
;;; as a subsumee role we dont do the merge because the completion algorithm has already
;;; taken this into account at the more abstract concept.

(defun merge-slots-of-parent-roles ()
  (loop for role-name in *roles-to-be-considered*
	for role = (role role-name)
	do (loop for rn2 in *roles-to-be-considered*
		 when (and (not (eq role-name rn2))
			   (subsumes-p role (role rn2)))
		   do (maybe-add-slots-for-subsumer-role role-name rn2))))

(defun maybe-add-slots-for-subsumer-role (role-name subsumee-role-name)
  (loop with any-added? = nil
	with subsumee-role-slots = (get subsumee-role-name :msp-slots-for-completion)
	for subsumer-role-slot in (get role-name :msp-slots-for-completion)
	do (loop for subsumee-role-slot in subsumee-role-slots
		 when (subsumes-p subsumer-role-slot subsumee-role-slot)
		   return nil
		 finally (progn
			   (push subsumer-role-slot subsumee-role-slots)
			   (setq any-added? t)))
	finally (if any-added?
		    (putprop subsumee-role-name
			     subsumee-role-slots
			     :msp-slots-for-completion))))



;;; GIVEN A SET OF SLOTS FOR A ROLE COMPUTE THE MOST SPECIFIC RESTRICTION OF THOSE
;;; SLOTS BY COMBINING THE MOST SPECIFIC VALUE RESTRICTION WITH THE MOST SPECIFIC
;;; NUMBER RESTRICTION.......

;;;(defun effective-slot-for-role (role-name concept)
;;;  (let ((slots (get role-name :msp-slots-for-completion))
;;;	(concept-name (name concept)))
;;;    (if (= (length slots) 1)
;;;	(car slots)
;;;	(multiple-value-bind (min max vr)
;;;	    (merge-effective-restrictions-of-slots slots role-name concept-name)
;;;	  (make-instance 'slot
;;;			 :role-name role-name
;;;			 :defining-concept concept-name
;;;			 :value-restriction vr
;;;			 :nr-min min
;;;			 :nr-max max
;;;			 :default nil)))))
(defun effective-slot-for-role (role-name concept &key (persistent? t))
  persistent?
  (let ((slots (get role-name :msp-slots-for-completion))
	(concept-name (name concept)))
    (if (= (length slots) 1)
	(car slots)
      (multiple-value-bind (min max vr)
	  (merge-effective-restrictions-of-slots slots role-name concept-name)
	(let ((NEW-SLOT (make-instance* 'slot
					:role-name role-name
					:defining-concept concept-name
					  ;;; :persistentp persistent?
					)))
	  (setf (value-restriction NEW-SLOT) vr)
	  (setf (nr-min            NEW-SLOT) min)
	  (setf (nr-max            NEW-SLOT) max)
	  (setf (default           NEW-SLOT) nil)
	  NEW-SLOT
	  )))))

 
(defun merge-effective-restrictions-of-slots (slots role-name for-concept-name)
  (let ((min (compute-effective-min slots role-name))
	(max (compute-effective-max slots)))
    (unless (valid-nr min max)
      (format
	t "~% Slot for role: ~a at concept: ~a inherits INCOMPATIBLE NUMBER RESTRICTION~
~%Min: ~a MAX: ~a~%Setting number restriction to nil." role-name for-concept-name min max)
      (setq min nil max nil))
    (values min max (most-specific-value-restriction slots))))


						
(defun most-specific-value-restriction (slots)
  (let (simple-vr-concepts complex-value-restrictions cmeet non-concept-vr)
    (multiple-value-setq (simple-vr-concepts complex-value-restrictions non-concept-vr)
      (most-specific-value-restriction-1 slots))
    (cond (non-concept-vr)
	  (complex-value-restrictions
	   (cond ((and (null (cdr complex-value-restrictions)) (null simple-vr-concepts))
		  ;; only a single complex VR (and no simple VRs)
		  (car complex-value-restrictions))
		 (t
		  `(:and ,.(merge-set-restrictions complex-value-restrictions)
			 ,. (collect-concept-names simple-vr-concepts)))))
	  ((null simple-vr-concepts)		;no vr at all
	   nil)
	  ((null (cdr simple-vr-concepts))
	   ;; only a single simple VR (and no complex VRs)
	   (articalize (name (car simple-vr-concepts))))
	  ;;If there are multiple simple vr forms we try to
	  ;;find their meet.  If one exists we make that the vr-form.  If none exist
	  ;; we make a simple AND form.
	  ((setq cmeet (car (find-most-general-children simple-vr-concepts)))
	   (articalize (name cmeet)))
	  (t
	   `(:and ,@(collect-concept-names simple-vr-concepts))))))

(defun most-specific-value-restriction-1 (slots)
  (loop with simple-concepts and complex-value-restrictions and non-concept-vr and vr-concept
	for slot in slots
	for value-restriction = (value-restriction slot)
	when value-restriction
	  do (setq vr-concept (concept-of-concept-form value-restriction))
	  and when vr-concept
		do (pushnew vr-concept simple-concepts)
	      else
	        when (concept-type-vr value-restriction)
		  do (pushnew slot complex-value-restrictions)
		     ;; Non- concept vr -- override all -- note if more than one we take
		     ;; arbitrary last one.
	        else do (setq non-concept-vr value-restriction)
	finally (return
		  (if non-concept-vr
		      (values nil nil non-concept-vr)
		      (values (most-specific-only simple-concepts)
			      (most-specific-cvrs-only complex-value-restrictions)
			      nil)))))



(defun merge-set-restrictions (cvrs)
  (do ((cvrs cvrs (cdr cvrs))
       cvr
       (new-cvrs nil)
       (merged-sets nil))
      ((null cvrs)
       (if merged-sets (cons merged-sets (nreverse new-cvrs)) (nreverse new-cvrs)))
    (setq cvr (car cvrs))
    ;;:within added by mrcrystal on 6/23/87
    (if (not (member (car cvr) '(and* or* not* satisfies
				    :and :or :not :satisfies :within :num)))
	;; CVR should be a COMPLEX value restriction, so no need for more explicit testing
	(setq merged-sets (nunion merged-sets cvr))
	(push cvr new-cvrs))))

(defun most-specific-cvrs-only (slots)
  (when slots
    (setq slots (cons nil slots))
    (do* ((prev-cons slots cvrs)
	  (cvrs (cdr slots) (cdr cvrs))
	  (cvr))
	 ((null cvrs) (mapcar #'value-restriction (cdr slots)))
      (setq cvr (normal-vr-form (car cvrs)))
      (when (do* ((cvrs (cdr slots) (cdr cvrs))
		  (cvr2))
		 ((null cvrs) (return nil))
	      (setq cvr2 (normal-vr-form (car cvrs)))
	      (when (and (not (eql cvr2 cvr))
			 (member (compare-slots-1 cvr cvr2 nil)
				 '(EQUIVALENT LESS-RESTRICTIVE)
				 :test 'eq))
		;; Found a (distinct) cvr which is more restrictive than or
		;; equivalent to the current one. Remove the current one from
		;; the list.
		(return t)))
	(setf (cdr prev-cons) (cdr cvrs))))))



;;; The MIN is the greatest lower bound, considering only slots for the specific
;;; role in question (not slots for any of the roles parents).  

;;; The reason the MIN's for the slots of the roles parents don't come into play
;;; is because of the NON-CLOSED-WORLD logic.  For example, if something has AT LEAST
;;; TWO LIMBS and SOME NUMBER OF ARMS it doesn't necessarily have to have at least two
;;; arms since it could have other kinds of limbs that are defined or that we don't
;;; know about.

;;; +++NOTE: There are more deductions we could make in the case of non-primitive
;;; +++concepts where we can assume a closed world -- we could make them if we
;;; +++know about DISJOINTESS AMONG SLOTS.  E.G if a NON-PRIMITIVE concept had at
;;; +++least 4 limbs and the only kinds of limbs specified where arms and legs and
;;; +++the arms and the legs where disjoint then we could make inferences about the
;;; +++minimum number of arms, if we knew the number of legs -- this is complex
;;; +++and something that probably won't be done for awhile. 

(defun compute-effective-min (slots role-name)
  (loop with min = nil
	for slot in slots
	for t-min = (nr-min slot)
	when (and (eq role-name (role-name slot))
		  (>*  t-min min))
	  do (setq min t-min)
	finally (return min)))

;;; The MAX is the lowest max of the restrictions of all the slots.
;;; Note that the max of slots for more general roles acts just like the max
;;; for the role in question -- placing a restriction on the upper bound.

(defun compute-effective-max (slots)
  (loop with max = nil
	for slot in slots
	for t-max = (nr-max slot)
	when (*< t-max max)
	  do (setq max t-max)
	finally (return max)))



;;; For all local slots (those slots in the SLOTS iv that were either defined at this
;;; concept or were induced by the compute-slots method -- i.e those that WERE NOT inheritted
;;; exactly from above) store backpointers at the vr-concept (if there is one) and at
;;; the role.

(defmethod update-slot-backpointers ((self slot-handling-mixin))
  (loop for s in  (local-effective-slots self)
	do (add-backpointers s)))

(defmethod add-backpointers ((self slot))
  (with-slots (value-restriction role-name) self
    (loop for cn in (concepts-of value-restriction)
	  for cno = (concept cn)
	  do (setf (inverse-slots cno)
		   (pushnew self (inverse-slots cno))))
    (setf (slots-for-me (role role-name)) (pushnew self (slots-for-me (role role-name))))))




