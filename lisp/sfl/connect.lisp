;;; -*- Base: 10; Package: co; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;;;THIS FILE CONTAINS THE CODE FOR CONNECTING, DISCONNECTING AND MODIFYING THE
;;;CONNECTIONS OF SOMETHING IN A SUBSUMPTION TAXONOMY.

(defmethod update-connections ((self inheritance-handling-mixin) new-abstractions)
  (with-slots (abstractions specializations) self
    (let ((added-abstractions (filter-out abstractions new-abstractions))
	  (deleted-abstractions (filter-out new-abstractions abstractions))
	  (my-name (name self)))
      (when (or added-abstractions deleted-abstractions)
	(loop for added-a in added-abstractions
	      do (add-specialization (my-instance added-a) my-name))
	(loop for deleted-abs in deleted-abstractions
	      do (remove-specialization (my-instance deleted-abs) my-name))
	;;Redefining something does not alter its specializations.
	;;However, some specialization might originally have been connected to
	;;one of our parents, that connection being deleted as redundant.  If we
	;;have deleted that thing as our parent, here, we want to reconnect the
	;;specialization to it.  In addition, if any specialization has one of my
	;;NEW parents as a parent, we want to remove that link as redundant.
	(loop for spec in specializations
	      do (update-links-for-parent-redefinition
		   (my-instance spec) added-abstractions deleted-abstractions))
	(setq abstractions new-abstractions)))))

(defmethod update-links-for-parent-redefinition
	   ((self inheritance-handling-mixin) added-parents deleted-parents
	    &aux (my-name (name self)))
  (with-slots (abstractions defined-abstractions) self
    (loop for added-p in added-parents
	  do (remove-specialization (my-instance added-p) my-name)
	  do (setq abstractions (delete added-p abstractions)))
    (loop for deleted-p in deleted-parents
	  ;;If a deleted parent of one of my abstractions is one of my defined
	  ;;parents any link between us and it was removed as superfluous.  We
	  ;;now need to add that link back.
	  when (and (member deleted-p defined-abstractions)
		    (not (member deleted-p (all-abstractions self))))
	    do (add-specialization (my-instance deleted-p) my-name)
	    and do (push deleted-p abstractions)
      	  ;; and do (print (list "adding back" (name self) deleted-p defined-abstractions))
	    )))



;;; REMOVE SOMETHING FROM A TAXONOMY:

;;; 1] Remove our name from SPECIALIZATIONS of direct parents.
;;; 2] Remove our name from the ABSTRACTIONS list of direct children.
;;; 4] Remove our name from the DEFINED-ABSTRACTIONS list of all children.
;;; 4] Link each of our parents to each of our children that they don't already subsume.

;;; Note that this routine does nothing to the thing being disconnected -- presumably
;;; it is being killed.

(defmethod disconnect-from-network
	   ((self inheritance-handling-mixin) &aux (my-name (name self)))
  (with-slots (abstractions) self
    (map-to-my-direct-parents self #'remove-specialization my-name)
    (map-to-my-direct-children self #'disconnect-parent my-name abstractions)
    (map-to-my-children self #'remove-from-defined-abstractions my-name)
    (map-to-my-children self #'complete)))

(defmethod disconnect-parent
	   ((self inheritance-handling-mixin) parent-name grandparents
	    &aux (my-name (name self)))
  (with-slots (abstractions defined-abstractions) self
    (setq abstractions (remove parent-name abstractions))
    (loop for gp in grandparents
	  unless (member gp (all-abstractions self))
	    do (add-specialization (my-instance gp) my-name)
	    and do (push gp abstractions)
	    and when (member parent-name defined-abstractions)
		  do (pushnew gp defined-abstractions))))

(defmethod remove-from-defined-abstractions ((self inheritance-handling-mixin) parent-name)
  (with-slots (defined-abstractions) self
    (setq defined-abstractions (delete parent-name defined-abstractions))))
