;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "delete"               (formerly "fns")
;;;   Module:  "interface;PRW:eta"
;;;  Version:   1.4  November 1990
;;;

(in-package :CTI-source)

;; Change Log:
;;  1.1  Extended the delete routine to handle nonterminal categories
;;       as well as words & polywords.
;;  1.2  Added an alternative delete routine whose spelling is a close
;;       match to the defining routine and so easier to use by cut & paste
;;       into the Listener.
;;  1.3  (v1.3)  Added a routine for deleting all of the eta's in one go.
;;  1.4  (v1.5) Changed Define-association-with-topic to reflect
;;       the shift of polwords to the chart.


(export '(Delete-association-of-evidence-with-topic
          Delete-association-with-topic
          Delete-all-ETAs))


;;;-------------------
;;; deletion routines
;;;-------------------

(defun Delete-association-of-evidence-with-topic (evidence-expression
                                                  topic)
  (let* ((evidence
          (if (and (stringp evidence-expression)
                   (multi-word-string evidence-expression))
            (lookup/cfr/resolved
             (resolve
              (equivalent-uppercase-symbol-with-hyphens
               evidence-expression (find-package :user)))
             (tokens-in-short-string/no-whitespace
              evidence-expression))
            (resolve evidence-expression))))

    (unless evidence
      (break "Debugging deleting ETAs: couldn't resolve evidence"))

    (let ((eta (find-topic-association
                (if (and (stringp evidence-expression)
                         (multi-word-string evidence-expression))
                  (resolve
                   (equivalent-uppercase-symbol-with-hyphens
                    evidence-expression (find-package :user)))
                  evidence)
                topic)))
      
      (if (null eta)
        (error "No association between the evidence ~A~
                ~%   and the topic ~A~
                ~%   has been defined."
               evidence topic)
        (un-intern-topic-association evidence eta))
      eta )))


(defun Delete-association-with-topic (evidence-expression topic)
  "A variant spelling for the eta deletion routine.  This spelling
   is convenient when operating by cut and paste between buffers
   and the listener."
  (delete-association-of-evidence-with-topic  evidence-expression
                                              topic))


(defun Delete/eta (eta)
  (un-intern-topic-association (eta-evidence eta)
                               eta))


;;;-----------
;;; un-intern
;;;-----------

(defun un-intern-topic-association (evidence eta)
  (let* ((rule-set (rule-set-for evidence))
         (triggered-actions (rs-triggered-actions rule-set)))

    (setf (rs-triggered-actions rule-set)
          (delete eta triggered-actions))

    ;; /// consider deleting the evidence object from the grammar
    ;; if this association was its only reason for existence

    (remove-from-catalog/evidence-topic-association eta)
    eta ))
    

;;;-----------------------------------
;;; getting rid of everything at once
;;;-----------------------------------

(defun Delete-all-ETAs ()
  (dolist (eta *evidence-topic-associations*)
    (delete/eta eta))
  *evidence-topic-associations*)

