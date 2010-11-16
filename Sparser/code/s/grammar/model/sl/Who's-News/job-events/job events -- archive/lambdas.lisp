;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "lambdas"
;;;   Module:  "model forms;sl:whos news:mf:acts:job events:"
;;;  version:  1.2  April 1991

;; split out from je;job event on 2/18
;; 1.1 (3/7 v1.8.1) Fixed bug in Readout-composite/job-event+person
;; 1.2 (4/10 v1.8.2) wrote Check-for-passive and modified Readout-
;;     composite/job-event+person to use it.

(in-package :CTI-source)



;;;----------------------------------
;;; lambda abstractions (composites)
;;;----------------------------------

(def-category  ;(define-composite-category
  job-event+title)
  ;; the model allows one to calculate what this needs to be
  ;; a full relation, e.g  (lambda (person company) ...), with
  ;; specializations of what is needed according to the dictates
  ;; of specific categories of job-event.
;  :slots ((job-event job-event)
;          (title     title))

(def-category  job-event+replacing)
  ;; job-event, person

(def-category  job-event+person)
  ;; person,job-event

(def-category  job-event+company)
  ;; job-event, company

(defparameter *composites-replacement-vector-table*
  `(((,c::job-event+title . ,c::title+company)
     . ,c::title)
    ))

;;;------------------
;;; readout routines
;;;------------------
;;  These assume that one item is pealed off and bound to a variable,
;;  and the other item passes back under the assumption that it is a
;;  composite itself, to be decomposed in a later pass through the loop

(defun readout-composite/job-event+title (je+t)
  (unless *job-event/title*
    (setq *job-event/title* (third je+t)))
  (second je+t))

(defun readout-composite/job-event+person (je+p)
  (check-for-passive (third je+p))
  (second je+p))

(defun readout-composite/job-event+company (je+c)
  (unless *job-event/company*
    ;; check if it was set by an edge at a higher level in
    ;; in the object
    (setq *job-event/company* (third je+c)))
  (second je+c))

(defun readout-composite/job-event+replacing (je+p)
  (setq *job-event/replacing* (third je+p))
  (second je+p))


(defun check-for-passive (nominal-subject)
  (if *passive*
    (setq *job-event/replacing* nominal-subject)
    (setq *job-event/person*    nominal-subject)))



;;---------- move these!
(defun title+status/title (t+s)
  (second t+s))
         
(defun title+status/status (t+s)
  (third t+s))

(defun title+company/title (t+c)
  (second t+c))

(defun title+company/company (t+c)
  (third t+c))

