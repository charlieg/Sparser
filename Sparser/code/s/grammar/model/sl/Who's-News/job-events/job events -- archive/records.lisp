;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "records"
;;;   Module:  "model forms;sl:whos news:acts:job events"
;;;  version:  1.2 April 1991

;; initiated in January 1991
;; 1.1  (3/8 v1.8.1)  Renamed main routine.
;; 1.2  (4/10 v1.8.2)  Rewrote Report-and-stash-salient-object/job-event
;;      to check if it got an edge that starts at the same point as one
;;      its already gotten of that category.

(in-package :CTI-source)


;;;------------------------------------------
;;; grabbing the object when the edge occurs
;;;------------------------------------------

#|  original
(defun report-and-stash-salient-object/job-event (je)
  ;; this is called as a generic-treetop-action
  ;;
  (push je *pending-salient-objects*))  |#


(defun report-and-stash-salient-object/job-event (je)
  ;; This is called as a generic-treetop-action hooked to
  ;; the object type.
  (multiple-value-bind (most-recent-on-list its-cell)
                       (find-first-edge-of-same-category
                        je *pending-salient-objects*)

    (when most-recent-on-list
      (when (eq (edge-starts-at je)
                (edge-starts-at most-recent-on-list))
        ;; the new one is presumably a longer version of the
        ;; old one.  Splice the old one out of the list
        (if (eq its-cell *pending-salient-objects*)
          (setq *pending-salient-objects*
                (cdr *pending-salient-objects*))
          (else
            (rplaca its-cell (car (cdr its-cell)))
            (rplacd its-cell (cdr (cdr its-cell)))))))

    (push je *pending-salient-objects*)))


(defun find-first-edge-of-same-category (edge list)
  (let ((target-category (edge-category edge)))
    (do* ((cell list (cdr list))
          (edge2 (car cell) (car cell)))
         ((null edge2) nil )
      (when (eq (edge-category edge2) target-category)
        (return (values edge2 cell))))))


;;;--------------------------------------
;;; reading out the object from the edge
;;;--------------------------------------

(defun write-record-for-salient-object/job-event (edge)
  ;; called from Readout-pending-salient-objects after (!!) the
  ;; whole article has been analyzed.
  ;;
  (readout-into-globals/job-event edge)
  (when *display-salient-objects*
    (display/job-event/variables))

  (if (evaluate-validity/job-event/variables)
    (write-db-record/job-event/distribute-plurals)
    (format t "~%~%Incomplete job event: ~A~%" edge)))


;;;--------------------
;;; writing the record
;;;--------------------

(defun write-db-record/job-event
       (&key event-type person title company
             former-company former-title)
  (declare (ignore former-company former-title))
  (initialize-record)
  (mapcar
   #'(lambda (string)
       (write-next-field string))
   (list (label-for-job-event-type event-type)
         (db-form/person  person)
         (db-form/title   title)
         (db-form/company company)
         ""  ;; former-company
         ""  ;; former-title
         ))
  (terminate-record))


;;;---------------------------------------------
;;; db routines for the individual field values
;;;---------------------------------------------

(defun label-for-job-event-type (et)
  (symbol-name (job-event-name et)))

(defun dB-form/person (person)
  (with-output-to-string (stream)
    (princ-name-of-a-person (person-name person)
                            stream)))

(defun dB-form/title (title)
  (with-output-to-string (stream)
    (princ-title (title-name title) stream)))

(defun dB-form/company (company)
  (with-output-to-string (stream)
    (princ-name-of-a-company (company-name company)
                             stream)))
                            

;;;---------------------------------------------------------------
;;; checking if the job-event object is complete enough to report
;;;---------------------------------------------------------------

(defun evaluate-validity/job-event/variables ()
  (if (and *job-event/title*
           *job-event/person*
           *job-event/company*)
    t
    nil))


;;;----------------------
;;; distributing plurals
;;;----------------------

(defun write-db-record/job-event/distribute-plurals ()
  (cond ((multiple-people)
         (write-db-record/job-event/distribute-people))
        ((multiple-titles)
         (write-db-record/job-event/distribute-titles))
        (t (write-db-record/job-event
            :event-type *job-event/event*
            :person     *job-event/person*
            :title      *job-event/title*
            :company    *job-event/company* ))))


;;;--------
;;; people
;;;--------

(defun write-db-record/job-event/distribute-people ()
  (dolist (person (multiple-people))
    (cond ((multiple-titles)
           (write-db-record/job-event/distribute-titles
            :person person))
          (t (write-db-record/job-event
              :event-type *job-event/event*
              :person     *job-event/person*
              :title      *job-event/title*
              :company    *job-event/company* )))))


        
(defun multiple-people ()
  (let ((person-object *job-event/person*))
    (etypecase person-object
      (person nil)
      (list
       (etypecase (car person-object)
         )))))

;;;--------
;;; titles
;;;--------

(defun write-db-record/job-event/distribute-titles (&key person)
  (dolist (title (multiple-titles))
    (write-db-record/job-event
     :event-type *job-event/event*
     :person     (or person *job-event/person*)
     :title      title
     :company    *job-event/company* )))


(defun multiple-titles ()
  (let ((title-object *job-event/title*))
    (etypecase title-object
      (title nil)
      (list (distribute-into-list/title title-object)))))

(defun distribute-into-list/title (composite-title)
  (let ((composite composite-title)
        pending-components
        titles )
    (loop
      (etypecase composite
        (title (push composite titles))
        (list
         (ecase (cat-symbol (first composite))
           (c::plural-title
            (push (second composite) pending-components)
            (push (third  composite) pending-components))
           (c::title+status
            (push (second composite) pending-components)))))
      (if pending-components
        (setq composite (pop pending-components))
        (return)))

    (nreverse titles)))

