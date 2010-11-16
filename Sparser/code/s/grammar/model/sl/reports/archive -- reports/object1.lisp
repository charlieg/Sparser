;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "object"
;;;   Module:  "model;sl:reports:"
;;;  version:  July 1991

;; 1.1  (7/16 v1.8.6) moved out the def form to its own file

(in-package :CTI-source)


;;;--------
;;; object
;;;--------

(define-category report)  ;; (:event-type)
;  :slots ((name (word :verb))
;          (by (:or person company))
;          (of :unrestricted))
;  :index (:hash-on-slot name))

(defstruct (report
            (:print-function print-report-structure))
  rules name by of )


(defun Print-report-structure (obj stream depth)
  (declare (ignore depth))
  (write-string "#<report " stream)
  (princ-word (report-name obj) stream)
  (write-string ">" stream))


(defun Display-report (report stream)
  (display-word (report-name report) stream))


;;;------------
;;; ancilaries
;;;------------

(setf (cat-index (category-named 'category::report))
      (make-index/hash-on-slot))

(defun Find/report (word)
  (gethash word (cat-index (category-named/c-symbol
                            'category::report))))

(defun Report-named (string)
  (let ((word (resolve-string-to-word string)))
    (find/report word)))

(defun Index/report (word report)
  (setf (gethash word (cat-index (category-named/c-symbol
                                  'category::report)))
        report))

(defun all-Reports ()
  (let ( accumulating-reports )
    (maphash #'(lambda (word report)
                 (declare (ignore word))
                 (push report
                       accumulating-reports))
             (cat-index (category-named/c-symbol
                         'category::report)))
    accumulating-reports))

(defun List-the-reports ()
  (let ((the-reports (all-reports)))
    (pl (sort the-reports
              #'word-order :key #'report-name)
        nil)))


(defun Delete-report (string)
  (let* ((word (word-named string))
         (report (find/report word)))
    (unless report
      (error "There is no report named ~A" string))
    (delete/report report word)))

(defun Delete/report (report
                      &optional
                      (word (report-name report)) )
  ;; delete the rules that invoke it
  (dolist (rule (report-rules report))
    (delete-cfr/cfr rule))
  ;; strand it -- remove it from the catalog
  (remhash word (cat-index (category-named/c-symbol
                            'category::report)))
  report )

