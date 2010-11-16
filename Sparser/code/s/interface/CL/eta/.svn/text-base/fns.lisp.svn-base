;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "fns"
;;;   Module:  "interface;PRW"
;;;  Version:   1.2   September 1990
;;;

(in-package :CTI-source)

;; Change Log:
;;  1.1  Extended the delete routine to handle nonterminal categories
;;       as well as words & polywords.
;;  1.2  Added an alternative delete routine whose spelling is a close
;;       match to the defining routine and so easier to use by cut & paste
;;       into the Listener.


;;;------------------------------------
;;; intermediary for the defining form
;;;------------------------------------

(defun Associate-evidence-with-topic (evidence-object topic)
  (intern-topic-association evidence-object topic))



;;;-------------------
;;; deletion routines
;;;-------------------

(export '(Delete-association-of-evidence-with-topic
          Delete-association-with-topic))

(defun Delete-association-of-evidence-with-topic (evidence-expression
                                                  topic)
  (let* ((evidence (resolve evidence-expression))
         (eta (find-topic-association evidence topic)))
    (if (null eta)
      (error "No association between the evidence ~A~
              ~%   and the topic ~A~
              ~%   has been defined."
             evidence topic)
      (un-intern-topic-association evidence eta))
    eta ))


(defun delete-association-with-topic (evidence-expression topic)
  "A variant spelling for the eta deletion routine.  This spelling
   is convenient when operating by cut and paste between buffers
   and the listener."
  (delete-association-of-evidence-with-topic  evidence-expression
                                              topic))

