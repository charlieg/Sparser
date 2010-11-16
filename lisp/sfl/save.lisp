;;; -*- Package: co; Syntax: Common-Lisp -*-
(in-package :co)

;;;
;;;                        BBN Technologies
;;;                 A Division of BBN Corporation
;;;                           Copyright
;;;                      All Rights Reserved
;;;                              1999
;;;


;;; FUNCTIONAL INTERFACE FOR SAVING AN SFL FILE OF CONCEPTS AND ROLES.


(defvar *sort-alphabetically?* t)

(defvar *sfl-header*
    ";;; -*- Package: ~A; Syntax: Common-Lisp -*- ~3%(in-package :~a)~3%(set-package *sfl-files*)")

(defmethod defining-form ((concept concept))
  (with-slots (name description defined-abstractions defined-slots
               concept-superclasses make-class? export?) concept
    (flet ((collect-defining-forms (things)
             (loop for thing in things
                 collect (defining-form thing))))
      (let ((specializes (remove *most-general-concept* defined-abstractions)))
        `(defconcept ,name
             :specializes ,specializes
             :slots ,(collect-defining-forms defined-slots)
             ;; ,@(if specializes `(:specializes ,specializes))
             ;; ,@(if defined-slots `(:slots ,(collect-defining-forms defined-slots)))
             ,@(if (and description (car description))`(:description ,description))
             ;; ,@(if slot-order `(:slot-order ,(or slot-order (all-roles-of self))))
             ;; ,@(if defined-slot-equivalences
             ;; `(:slot-equivalences ,(collect-defining-forms defined-slot-equivalences)))
             ,@(if concept-superclasses `(:concept-superclasses ,concept-superclasses))
             ,@(if make-class? `(:make-class? t))
             ,@(if export? `(:export? t))
             ;; ,@(if unpatched-p `(:unpatched-p ,unpatched-p))
             )))))

(defmethod defining-form ((role role))
  (with-slots (name defined-abstractions role-relations generic-function inverse-role
               description export?) role
    (let ((specializes (remove *most-general-relation* defined-abstractions)))
      `(defrole ,name
           :specializes ,specializes
           ;;,@(if specializes `(:specializes ,specializes))
           ,@(if (and description (car description))`(:description ,description))
           ;; ,@(if role-relations
           ;; `(:role-relations ,(role-relation-save-list role-relations)))
           ;; ,@(and generic-function `(:generic-function ,generic-function))
           ;; ,@(and inverse-role `(:inverse-role ,inverse-role))
           ;; ,@(if unpatched-p `(:unpatched-p ,unpatched-p))
           ,@(if export? `(:export? t))
           ))))

(defmethod defining-form ((slot slot))
  (with-slots (role-name value-restriction nr-min nr-max default description) slot
    `(,role-name
      ,value-restriction
      (,nr-min ,nr-max)
      ,default
      ,description)))

(defun pretty-out-concept-role (def &optional (stream *terminal-io*))
  (let ((shortflag nil) (form def))
    (format stream "~%(~(~S~) ~s" (first form) (second form))
    (setq form (nthcdr 2 form))
    (if (and (or (< (flatlength form) 3)
                 (and (< (flatlength form) 4)
                      (every #'symbolp form))))
        (setq shortflag t))
    (loop for rest on form by #'cddr
        for key = (first rest) for val = (second rest)
        do (case key
             (:specializes
              (format stream " ~s" val))
             (:slots
              (loop initially (format stream "~%~5t(~@[~S~]" (car val))
                  for rl on (cdr val)
                  while rl do (format stream "~%")
                  do (format stream "~6t~S" (car rl))
                  finally (format stream ")")))
             (:description
              (if (listp val)
                  (loop initially (format stream "~%   ~(~S~) (~S" key (car val))
                      with tab = (format nil "~V@T" (+ 6 (length (string key))))
                      for rl on (cdr val)
                      while rl do (format stream "~%")
                      do (format stream "~A~S" tab (car rl))
                      finally (format stream ")"))
                (format stream "~%   ~(~S~) ~S" key val)))
             (otherwise  (format stream "~:[~%   ~; ~]~(~s~) ~s" shortflag key val)))
        finally (format stream ")~%"))))

(defmethod output-defining-form ((mixin basic-role-concept-mixin)
                                 &optional (stream *terminal-io*))
  (pretty-out-concept-role (defining-form mixin) stream))

(defmethod save-sfl-internal ((sfl-files sfl-files) pathname)
  (flet ((objects-for-file (objects pathname)
           (loop for object in objects
               when (member pathname (source-files object) :test 'equal)
               collect object)))
    (let* ((concepts-to-save
            (if *sort-alphabetically?*
                (sort-names-and-return-instances
                 (objects-for-file (all-concepts) pathname))
              (objects-for-file (all-concepts) pathname)))
              (roles-to-save
               (if *sort-alphabetically?*
                   (sort-names-and-return-instances
                    (objects-for-file (all-roles) pathname))
                 (objects-for-file (all-roles) pathname))))
      #+allegro
      (when (probe-file pathname)
        (let ((NEW-TYPE (format nil "~A~~" (pathname-type pathname))))
        ;;; NLC -- HANDLE TYPES OTHER THAN LISP
          #+NLC (rename-file
                 pathname (merge-pathnames (make-pathname :type "lisp~") pathname))
          (rename-file
           pathname (merge-pathnames (make-pathname :type NEW-TYPE) pathname))))
      #+MCL
      (rename-file pathname (merge-pathnames ".lisp~" pathname) :if-exist :supercede)
      (with-open-file (output-stream pathname :direction :output :if-exists :new-version)
        (let* ((*print-circle* nil)
               (file-object (find-file-object sfl-files pathname))
               (package-name (package-name (or (package-co file-object) *package*)))
               (*package* (find-package package-name)))
          (format output-stream *sfl-header* package-name package-name package-name)
          (format output-stream
                  "~3%;;;   ----------- Beginning ROLE definitions ----------~2%")
          (loop for role in roles-to-save
              unless (eq *most-general-relation* (name role))
              do (output-defining-form role output-stream))
          (format output-stream
                  "~2%;;;   ----------- Beginning CONCEPT definitions ----------~2%")
          (loop for concept in concepts-to-save
              unless (eq *most-general-concept* (name concept))
              do (output-defining-form concept output-stream)))))))

(defmethod new-file-set ((mixin basic-role-concept-mixin) new-source-files)
  (with-slots (source-files) mixin
    (let ((source-files-changed (set-exclusive-or source-files new-source-files
                                                  :test 'pathname-match-p)))
      (loop for source-file in source-files-changed
          do (set-file-modified-p *sfl-files* source-file t)))
    (setq source-files new-source-files)))

(defmethod save-sfl-network-internal ((sfl-files sfl-files) pathnames
                                      &optional (print-stream nil))
  (loop for pathname in (if (listp pathnames)
                            pathnames
                          (list pathnames))
      do (save-sfl-internal *sfl-files* pathname)
         (when print-stream
           (format print-stream "~&The SFL file ~a has been saved." pathname))))

(defun save-sfl-network (pathnames &key (print-stream t))
  (save-sfl-network-internal *sfl-files* pathnames print-stream))

(eval-when (compile eval load)
  (export '(save-sfl-network new-file-set) (find-package :co)))
