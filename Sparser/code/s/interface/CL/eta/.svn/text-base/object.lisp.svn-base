;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "object"
;;;   Module:  "interface;PRW"
;;;  Version:   1.0     July 1990
;;;

(in-package :CTI-source)

;;;--------
;;; object
;;;--------

(defstruct (evidence-topic-association
            (:conc-name "ETA-")
            (:print-function print-evidence-topic-association))

  evidence  ;; a word, polyword, or category --maybe other things later
  topic     ;; an object supplied by PRW via the rules that create these
  )

;;;------------------------
;;; cataloging the objects
;;;------------------------
;; n.b. interim, trivial version until the general facility is setup

(defvar *evidence-topic-associations* nil
  "An accumulator for all these objects as they are created.")

(defun Catalog/evidence-topic-association (eta)
  ;; called from the Intern routine
  (push eta *evidence-topic-associations*))

(defun Remove-from-catalog/evidence-topic-association (eta)
  (setq *evidence-topic-associations*
        (delete eta *evidence-topic-associations*)))


;;;------------------
;;; display routines
;;;------------------

(defun Print-evidence-topic-association (obj stream depth)
  (declare (ignore depth))
  (format stream
          "#<evidence/topic ~A |- ~A>"
          (eta-evidence obj)
          (eta-topic    obj)))


(defun Display-all-etas (&optional (stream *standard-output*))
  (dolist (eta *evidence-topic-associations*)
    (format stream "~%~A" eta))
  '*evidence-topic-associations*)

(export 'Display-all-etas)

