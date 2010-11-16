;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "save results"
;;;    Module:   "interface;SUN:"
;;;   Version:   December 1994

;; initiated 12/13/94

(in-package :sparser)


;;;-------------
;;; entry point
;;;-------------

(defun dump-smu-annotations-to-file (namestring)
  (with-open-file (*smu-outfile* namestring
                   :direction :output
                   :if-exists :supersede)
    (smu/readout-entire-discourse-history *smu-outfile*)))





;;;----------------------------------
;;; driver to run over the instances
;;;----------------------------------

(defun smu/Readout-entire-discourse-history ( &optional
                                              (stream *smu-outfile*) )
  (let ((categories (object-types-in-discourse-history))
        instances  parent-category )
    (format t "~%~%Reading out ~A categories" (length categories))
    (dolist (c categories)
      (format stream "~&~%~%~%;;;------- ~A"
              (string-downcase (symbol-name (cat-symbol c))))
      (setq instances (discourse-entry c))
      (dolist (i/dh instances)
        (smu/readout-individual (first i/dh) c stream)))))


(defun smu/Readout-individual (individual category
                               &optional (stream *smu-outfile*))
  (let ((word (value-of 'word individual))
        (pos (value-of 'pos individual))
        (feature (value-of 'feature individual))
        (class category))
    
    (format stream "~&( \"~A\"~15,8T~A~22,8T~A~30,8T~A )~%"
            (etypecase word
              (word (word-pname word))
              (polyword (pw-pname word)))
            (string-downcase (symbol-name pos))
            (string-downcase (symbol-name feature))
            (string-downcase (symbol-name (cat-symbol class))))

    individual ))



(defun save-instance-for-later-restoration ()
  (let ((s *smu-outfile*)
        (individual *smu/current-instance*))
    (let ((word (value-of 'word individual))
          (pos (value-of 'pos individual))
          (feature (value-of 'feature individual))
          (field (value-of 'semantic-field individual))
          (category (itype-of individual)))

      (format s "~&~%~%~%")

      ;; setup the Let 
      (format
       s "~&(let* (" )

      ;; first the word/pw
       (if (polyword-p word)
         (then (break "put double quotes in")
        (format
         s "(word-list (mapcar #'define-word~
            ~%             '~A))~
            ~%       (pw (define-polyword/from-words word-list))"
         (mapcar #'word-pname
                 (pw-words word))
         (pw-pname word)))

        (format s "(w  (define-word \"~A\" ))"
                (word-pname word)))

      ;; now the individual
       (format s "~&       (i~
                  ~%        (define-individual '~A"
       (string-downcase (symbol-name (cat-symbol category))))


      ;; and its word or words
      (if (polyword-p word)
        (format
         s "~&          :word  pw" )
         
        (format
         s "~&          :word  w" ))


      ;; and the rest of its properties
      (format
       s "~%          :pos  :~A~
          ~%          :feature :~A~
          ~%          :semantic-field :~A ))"
       (string-downcase (symbol-name pos))
       (string-downcase (symbol-name feature))
       (string-downcase (symbol-name field)))

      ;; now the cfr
      (if (polyword-p word)
        (format
         s "~%       (cfr (pw-fsa pw)))~%" )

        (format
         s "~%       (cfr~
            ~%        (define-cfr category::~A~
            ~%                    (list (word-named \"~A\"))~
            ~%          :form category::np~
            ~%          :referent i )))~%"
         (symbol-name (cat-symbol category))
         (word-pname word)))

      (when (polyword-p word)
        (format
         s "~%  (setf (cfr-referent cfr) i)"))

      ;; and the association between the cfr and the individual
      (format
       s "~&  (bind-variable 'rule cfr i)~
          ~%  i )~%")

      (setq *smu/current-instance* nil)
        ;; this is the instance finished on the last run
      individual )))



;;;----------
;;; mistakes
;;;----------

(defun save-mistakes-to-a-file (&optional
                                (stream *standard-output*))
  (let ((mistake-categories
         (sort-categories 
          (cat-lattice-position (category-named 'mistake)))))
    (dolist (c mistake-categories)
      (let* ((sparser-symbol
             (intern (symbol-name (cat-symbol c))
                     *sparser-source-package*))
             (strings
              (instances-of-mistake sparser-symbol)))

        (format stream
                "~&~%~%;;------ ~A~%"
                (string-downcase (symbol-name (cat-symbol c))))
        (dolist (s strings)
          (format stream
                  "~%\"~A\"" s))))))





;;;------------------
;;; restore routines
;;;------------------

;;--- entries and where they begin

(defparameter *entry#->filepos* (make-hash-table))

(defun define-entry-start (&key entry filepos)
  (setf (gethash entry *entry#->filepos*) filepos)
  entry )

(defun count-number-of-entries ()
  (let ((counter 0))
    (maphash #'(lambda (key value)
                 (declare (ignore key value))
                 (incf counter))
             *entry#->filepos*)
    counter ))


;;--- the number of mistakes in an entry

(defparameter *entry#->error-count* (make-hash-table))

(defun define-mistake-data (&key entry count)
  (setf (gethash entry *entry#->error-count*) count)
  (values entry count))

(defun errors-per-entry (&optional (stream *standard-output*))
  (maphash #'(lambda (entry count)
               (format stream
                       "~&~%~A~10,2T~A mistakes~%"
                       entry count))
           *entry#->error-count*))



;;--- particular mistakes

(defparameter *mistake->cases* (make-hash-table))

(defun define-instance-of-mistake (mistake-category string)
  (setf (gethash mistake-category *mistake->cases*)
        (push string (gethash mistake-category *mistake->cases*))))

(defun instances-of-mistake (mistake-category)
  (gethash mistake-category *mistake->cases*))

