;; -*- Package: co; Base: 10; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;


;;; This file contains the basic functions for killing a concept or a role
;;; or changing the name of a concept or a role.


;;; Trying to figure out what needs to be recompleted and what doesn't in
;;; the face of kill or change name is a massive problem, one that we
;;; almost solved in KREME in a slightly different context but one which is
;;; far beyond the scope of our current aims.

;;; In order to make the programming tractable we RECOMPLETE THE ENTIRE
;;; NETWORK after changing the name of a concept or role or killing a
;;; concept.  Roles CANNOT BE KILLED if there are any slots that use them
;;; as we would not know what to substitute, so killing a role that is not
;;; used as a slot-name by any concept does not require the recompletion of
;;; the entire network.

;;; Actually, we relent a bit.  When killing a concept only have to
;;; recomplete and redo class from msg on downwards.  When changing name,
;;; if there are no inverse restrictions, then complete and redo classes
;;; from concept downward.  If there are inverse restrictions, then have to
;;; do whole network as we cant track down every possible link.  If
;;; changing name of unused role dont recomplete whole network.




;;; Killing a concept......

;;; The MSG is the "Most Specific General" concept (name) above the being
;;; killed concept.  If a concept has a single parent then the msg is the
;;; single parent.  If a concept has multiple parents than the msg is the
;;; single common ancestor, if all else fails, it is thing.

;;; For now this is the single entry point for killing a single concept.
;;; Later we would like to include code to kill an entire branch.

(defvar *concept-being-killed* nil)

(defun remember-concept (concept &aux (name (name concept)))
  (putprop name concept 'concept)
  #+NLC (push concept *concepts*)
  (record-concept-object *vsfl-master* concept))

(defun forget-concept (concept)
  (let ((name (name concept)))
    (remprop name 'concept)
    #+NLC (setq *concepts* (delete concept *concepts*))
    (delete-concept-object *vsfl-master* concept)))

(defun remember-role (role &aux (name (name role)))
  (putprop name role 'role)
  #+NLC (push role *roles*)
  (record-role-object *vsfl-master* role))

(defun forget-role (role)
  (let ((name (name role)))
    (remprop name 'role)
    #+NLC (setq *roles* (delete role *roles*))
    (delete-role-object *vsfl-master* role)))

(defmethod kill-concept ((self concept))
  (with-slots (name) self
    (let* ((msg (msg self))
	   (msg-concept (concept msg)))
      (mark-changed-files self)
      (setq *concept-being-killed* name)
      (kill-slots self)
      (change-slots-for-kill msg name)
      (disconnect-from-network self)
      (forget-concept self)
      (complete (concept msg))
      (mapc #'maybe-make-class (cons msg-concept (specialization-instances msg-concept))))))

(defmethod kill-slots ((self concept))
  (loop for slot in (local-effective-slots self)
      do (kill slot)))

;;; ================================================================================

(defun change-slots-for-kill (replacement-concept-name old-name)
  (map-to-my-children (top-concept)
		      #'maybe-replace-concept-name-in-slots replacement-concept-name old-name))

(defmethod maybe-replace-concept-name-in-slots ((self concept) replacement-concept-name old-concept-name)
  (with-slots (slots defined-slots name) self
    (unless (eql name *concept-being-killed*)
      (loop for slot in slots
	  do (maybe-replace-concept-name slot replacement-concept-name old-concept-name))
      (loop for slot in defined-slots
	  do (maybe-replace-concept-name slot replacement-concept-name old-concept-name)))))

(defmethod maybe-replace-concept-name ((self slot) replacement-concept-name old-concept-name)
  (with-slots (visited-p) self
    (unless (= visited-p *visited*) ;slots can exist in several places
      (setq visited-p *visited*)
      (maybe-replace-concept-name-in-vr self replacement-concept-name old-concept-name)
      (maybe-replace-concept-name-in-default self replacement-concept-name old-concept-name))))

(defmethod maybe-replace-concept-name-in-vr ((self slot) new old)
  (with-slots (value-restriction) self
    (setq value-restriction (nsubst-or-delete-from-flat new old value-restriction))
    (resolve-vr self)))

(defmethod maybe-replace-concept-name-in-default ((self slot) new old)
  (with-slots (default) self
    (when default
      (setq default (nsubst-atom-or-list new old default))
      #+ignore
      (setq default (nsubst-or-delete-from-flat new old default)))))

;;; ================================================================================


;;; Killing a role is simple, since we dont allow it to be done if the role has slots that
;;; use it.

(defmethod kill-role ((self role))
  (with-slots (slots-for-me) self
    (if slots-for-me
	(print "cant kill role -- has slots that use it")
      (progn
	(set-source-files-modified-p self t)
	(disconnect-from-network self)
	(forget-role self)))))


;;; ================================================================================


;;; CHANGE A CONCEPT NAME.......


;;;The places we need to worry about that could store a concepts name:

;;;1] DIRECT PARENTS store the concept name in their specializations list.

;;;2] SPECIALIZATIONS store the concept name in their abstractions and possibly
;;;   in their all-abstractions list.

;;;3] INVERSE SLOTS store the concept name in either the vr or default or both.
;;;   +++NOTE that we can appear as the default anywhere (backpointers not recorded)
;;;   +++and the old name could be left in a default the way the system currently works. 

;;;4] US.  Our name will appear in the where-defined list of our LOCAL slots.

;;; Lastly, we need to mark the files effected as changed. We actually do this first.

(defmethod new-name-for-abstraction ((self inheritance-handling-mixin) new old)
  (with-slots (defined-abstractions abstractions) self
    (setq defined-abstractions (nsubst new old defined-abstractions))
    (setq abstractions (nsubst new old abstractions))))

(defun nsubst-for-item (object slot-name new old)
  (setf (slot-value object slot-name) (nsubst new old (slot-value object slot-name))))

(defmethod new-name ((self concept) new-name)
  (with-slots (name export?) self
    (setq export? nil)
    (mark-changed-files self)
    (map-to-my-children (top-concept)
			#'maybe-replace-concept-name-in-slots new-name name)
    (map-to-my-direct-parents
     self #'nsubst-for-item 'specializations new-name name)
    (map-to-my-children self  #'new-name-for-abstraction new-name name)
    (change-in-my-name self new-name)
    (forget-concept self)
    (setq name new-name)
    (remember-concept self)
    (progn
      (complete self)
      (mapc #'maybe-make-class (cons self (specialization-instances self))))))

;;;Stuff in our local items where defined lists.

(defmethod change-in-my-name ((self concept) new-name)
  (loop for slot in (all-local-slots self)
      do (setf (defining-concept slot) new-name)))

;;; ================================================================================


;;; CHANGE THE NAME OF A ROLE.  If the role has any slots that use it we
;;; will recomplete the entire network as sorting out what needs to happen
;;; (including remaking new classes which suddenly have new slot names) is
;;; beyond the scope of this project.

;;; For a hint at some of the complexities see the file
;;; /home/sproket/sfl/editor/change-name on abala.

(defmethod new-name ((self role) new-name)
  (with-slots (name slots-for-me export?) self
    (setq export? nil)
    (mark-changed-files self)
    (map-to-my-direct-parents self #'nsubst-for-item 'specializations new-name name)
    (map-to-my-children self  #'new-name-for-abstraction new-name name)
    (if slots-for-me
	;;Go down entire network of concepts -- although we maintain the list of slots
	;;that DEFINE relations for me, there can be all sorts of inherited and derived slots
	;;that we dont point at.
	(progn (loop for concept in (all-concepts)
		   do (new-slot-name concept new-name name))
	       (forget-role self)
	       (setq name new-name)
	       (remember-role self)
	       (complete-all))
      (progn (forget-role self)
	     (setq name new-name)
	     (remember-role self)))))

(defmethod maybe-replace-role-name ((self slot) new old)
  (with-slots (role-name) self
    (when (equal role-name old)
      (setq role-name new))))

;;; A role name has been changed, for this concept.  Check to see if its slots,
;;; defined-slots, or slot-order list are affected.  If so, see if there is a concept
;;; stack item for the concept.  Update the slot order, defined-slots and slots.  Make a
;;; new stack item object-being-edited if necessary.

(defmethod new-slot-name ((self concept) new-slot-name old-slot-name)
  (with-slots (defined-slots slots) self
    (loop for slot in slots
	do (maybe-replace-role-name slot new-slot-name old-slot-name))
    (loop for slot in defined-slots
	do (maybe-replace-role-name slot new-slot-name old-slot-name))))


;;; ================================================================================

(defmethod maybe-mark-file-changed ((mixin basic-role-concept-mixin) object-name)
  (with-slots (name defined-abstractions defined-slots source-files) mixin
    (when source-files
      (when (or
	     (eq name object-name)
	     (member object-name defined-abstractions))
	(set-source-files-modified-p mixin t)))))

(defmethod maybe-mark-file-changed ((concept concept) concept-name)
  (with-slots (name defined-abstractions defined-slots source-files) concept
    (when source-files
      (when (or
	     (eq name concept-name)
	     (member concept-name defined-abstractions)
	     (loop for slot in defined-slots
		 thereis (or 
			  (member-tree concept-name (value-restriction slot))
			  (member-tree concept-name (default slot)))))
	(set-source-files-modified-p concept t)))))

(defmethod mark-changed-files ((mixin basic-role-concept-mixin))
  (with-slots (name) mixin
    (map-to-my-children (top-object mixin) #'maybe-mark-file-changed name)))

(defmethod mark-changed-files ((role role))
  (with-slots (name slots-for-me) role
    (loop for slot in slots-for-me
	do (mark-changed-files (concept (defining-concept slot))))))

#+ignore
(defmethod mark-changed-files ((concept concept))
  (with-slots (name) concept
    (map-to-my-children (top-concept) #'maybe-mark-file-changed name)))


