;;; -*- Package: co; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;


;;; FUNCTIONAL INTERFACE FOR LOADING A FILE OF CONCEPTS AND ROLES.


(defvar *sfl-files* nil)

(setq *sfl-files* (make-instance 'sfl-files))

(eval-when (eval compile load)
  (export '*sfl-files* :co))

(defvar *merge-same-named-concepts-flag* nil)
(defvar *hold-merge-flag* nil)
(defvar *merge-during-load* t)

(defmethod load-sfl-file-internal :around ((sfl-files sfl-files) pathname)
  (declare (special *merge-same-named-concepts-flag* *merge-during-load*))
  (unwind-protect
    (progn
      (setq *hold-merge-flag* *merge-same-named-concepts-flag*
            *merge-same-named-concepts-flag* *merge-during-load*)
      (setq *inhibit-completion-flag* t)
      (call-next-method))
    (setq *merge-same-named-concepts-flag* *hold-merge-flag*)
    (setq *inhibit-completion-flag* nil))
  pathname)

(defmethod maybe-record-pathname ((mixin basic-role-concept-mixin))
  (declare (special *sfl-files*))
  (let ((file-loading (file-loading *sfl-files*)))
    (when file-loading
      (record-pathname mixin file-loading))))

(defmethod initialize-instance :after ((mixin source-file-mixin) &key default-p)
  (unless default-p
    (maybe-record-pathname mixin)))

(defmethod redefine-concept :after ((mixin source-file-mixin) 
				    new-description new-defined-abstractions
				    new-defined-slots
				    new-make-class? new-concept-superclasses export?)
  (declare (ignore new-description new-defined-abstractions new-defined-slots 
		   new-make-class? new-concept-superclasses export?))
  (maybe-record-pathname mixin))

(defmethod redefine-role :after ((mixin source-file-mixin) 
				 new-description new-defined-abstractions export?)
  (declare (ignore new-description new-defined-abstractions export?))
  (maybe-record-pathname mixin))

(defmethod set-source-files-modified-p ((mixin basic-role-concept-mixin) value)
  (with-slots (source-files) mixin
    (loop for source-file in source-files
	do (set-file-modified-p *sfl-files* source-file value))))

;;; mark SFL files modified for concepts and roles being modified
(defmethod remember-modifications-1 :after ((mixin basic-role-concept-mixin)
					    &key &allow-other-keys)
  (set-source-files-modified-p mixin t))

;;; mark SFL files modified for concepts and roles being deleted
(defmethod disconnect-from-network :after ((mixin basic-role-concept-mixin))
  (set-source-files-modified-p mixin t))
  
(defun network-statistics (&key (print-stream t) &aux (concepts (all-concepts)))
  (format print-stream "~2%         **** SFL Network Statistics **** ~
~2% Number of Roles: ~48t ~a" (length (all-roles)))
  (loop with numc = (length concepts)
	for c in concepts
	sum (length (abstractions c)) into tot-p
	sum (length (induced-slots c)) into tot-is
	sum (length (defined-slots c)) into tot-ds
	finally (format print-stream "~& Number of Concepts: ~48t ~a~
~% Number of abstraction links: ~48t ~a~
~% Average number of abstractions per concept: ~48t ~4f~
~% Number of defined slots: ~48t ~a~
~% Number of completion added slots: ~48t ~a~
~% Total number of distinct slots: ~48t ~a~
~% Average number of slots per concept: ~48t ~4f ~2%"
		     numc
		     tot-p
		     (/ (float tot-p)(float numc))
		     tot-ds
		     tot-is
		     (+ tot-ds tot-is)
		     (/ (float (+ tot-ds tot-is))(float numc)))))


;;; We allow a file to be loaded in without completing or making classes
;;; until everything is loaded.

(defun complete-all (&optional (PRINT-STREAM t))
  (when PRINT-STREAM
    (format PRINT-STREAM "~2%Running SFL completion ..."))
  (complete (top-concept))
  (when PRINT-STREAM
	  (format PRINT-STREAM "~2%Defining SFL classes ..."))
  (mapc #'maybe-make-class 
	(all-concept-objects *vsfl-master*) #+NLC *concepts*))


(defmethod load-sfl-network-internal ((sfl-files sfl-files) pathnames 
				      &optional (new-sfl-taxonomy-p t) 
						(complete-p t) (PRINT-STREAM t)) ;;; NLC
  (with-slots (active-pathnames) sfl-files
    (let ((new-sfl-taxonomy-p
	   (or new-sfl-taxonomy-p
	       (null (concept *most-general-concept*))
	       (null (role *most-general-relation*)))))
      (when new-sfl-taxonomy-p
	(and PRINT-STREAM
	     (format PRINT-STREAM "~%Performing New SFL Network"))
	(new-sfl-taxonomy)
	(clear-active-files sfl-files)
	(when PRINT-STREAM
	  (format PRINT-STREAM "~%SFL network initialized ...~%")))
      (loop for pathname in (if (listp pathnames)
				pathnames
			      (list pathnames))
	  for merged-pathname = (merge-pathnames pathname *load-pathname*)
	  do (when PRINT-STREAM
	       (format PRINT-STREAM "~%Loading SFL file: ~a ..." merged-pathname))
	     (load-sfl-file-internal sfl-files merged-pathname))
      (when complete-p
	(complete-all PRINT-STREAM))
      (when PRINT-STREAM
	(network-statistics :print-stream PRINT-STREAM)))))

#+sed
(defun load-sfl-network (pathnames 
			 &key (new-sfl-taxonomy-p t) (complete-p t) (print-stream nil))
  (load-sfl-network-internal
   *sfl-files* pathnames new-sfl-taxonomy-p complete-p print-stream))

#+allegro
(defun load-sfl-network (pathnames 
			 &key (new-sfl-taxonomy-p t) (complete-p t) (print-stream nil))
  (let ((save-redefinition-warnings excl:*redefinition-warnings*)
	(excl:*redefinition-warnings* 
	 (set-difference excl:*redefinition-warnings* '(:operator :type))))
    (unwind-protect
	(load-sfl-network-internal
	 *sfl-files* pathnames new-sfl-taxonomy-p complete-p print-stream)
      (setq excl:*redefinition-warnings* save-redefinition-warnings))))

#+sed
(defun load-sfl-network (pathnames 
			 &key (new-sfl-taxonomy-p t) (complete-p t) (print-stream nil))
  (declare (special excl:*redefinition-pathname-comparison-hook*))
  (let ((saved-redefinition excl:*redefinition-pathname-comparison-hook*))
    (unwind-protect
	(progn
	  (unless new-sfl-taxonomy-p
	    (setq excl:*redefinition-pathname-comparison-hook*   
	      (list
	       (lambda (old-pathname new-pathname ignore-1 ignore-2)
		 (declare (ignore ignore-1 ignore-2))
		 (and 
		  (string-equal (pathname-name old-pathname) "load-sfl-files")
		  (string-equal (pathname-name new-pathname) "load-sfl-files"))))))
	  (load-sfl-network-internal *sfl-files* pathnames
				     new-sfl-taxonomy-p complete-p print-stream)))
    (setq excl:*redefinition-pathname-comparison-hook* saved-redefinition)))

(defun specify-new-sfl-pathname (NEW-PATHNAME &key print-stream)
  (declare (ignore print-stream))
  (maybe-add-file-object *sfl-files* NEW-PATHNAME))

(eval-when (compile eval load)
  (export '(load-sfl-network specify-new-sfl-pathname set-source-files-modified-p)
	  (find-package :co)))


