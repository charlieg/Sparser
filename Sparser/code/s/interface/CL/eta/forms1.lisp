;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "forms"
;;;   Module:  "interface;PRW:eta:"
;;;  Version:   1.2  November 1990
;;;

(in-package :CTI-source)

;; Change Log:
;;  1.1  (v1.3) Moved over the intermediary function the primary form
;;       uses.  No code changed.
;;  1.2  (v1.5) Changed Define-association-with-topic to reflect
;;       the shift of polwords to the chart.


;;;--------------------------------------------
;;; Forms for associating evidence with topics
;;;--------------------------------------------

(export '(Define-association-with-topic
          Define-association-with-topics
          Define-topic-associations
          ))


(defun Define-association-with-topic (string topic-object)
  (let ((evidence-object
         (if (and (stringp string)
                  (multi-word-string string))
           (cfr-category
            (define-cfr (resolve/make
                         (equivalent-uppercase-symbol-with-hyphens
                          string (find-package :user)))
                       (tokens-in-short-string/no-whitespace
                        string)))
           (resolve/make  string))))

    (associate-evidence-with-topic evidence-object topic-object)))



(defun Define-association-with-topics (string topic-objects)
  (let ( association-objects )
    (dolist (topic topic-objects)
      (push (define-association-with-topic string topic)
            association-objects))
    (nreverse association-objects)))


(defun Define-topic-associations (topic-object
                                  list-of-strings)
  (let ( association-objects )
    (dolist (string list-of-strings)
      (push (define-association-with-topic string topic-object)
            association-objects))
    (nreverse association-objects)))



;;;------------------------------------
;;; intermediary for the defining form
;;;------------------------------------

(defun Associate-evidence-with-topic (evidence-object topic)
  (intern-topic-association evidence-object topic))

