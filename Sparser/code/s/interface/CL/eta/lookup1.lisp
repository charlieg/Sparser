;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "lookup"
;;;   Module:  "interface;PRW"
;;;  Version:   1.2  November 1990
;;;

(in-package :CTI-source)

;; Change Log:
;;   1.1  (v1.3)  Moved the "unintern" routine to the delete file
;;   1.2  (v1.5)  cat-rules => cat-rule-set


;;;-----------
;;; interning
;;;-----------

#|  This is the routine for "interning" an evidence-topic-association.
The primary key is the evidence, e.g. a word or polyword.  The link
that will be used at runtime to initiate an action off of this
association is the :rules field of the evidence.  That points to a
rule-set, with the field :triggered-actions, that contains a list
of objects that constitute actions to be taken when the evidence object
is found by the Analysis engine.
   We look in the :triggered-actions field for a topic association
object whose topic (the secondary key) is the one indicated by the
rule.  An EQ test is assumed.
   If such an object is found, it is returned.  Otherwise a new object
is built and added to the list.  Unless the Intern for symbols, no
information is given as to whether a new object was made or not, though
that would be easy enough to add.
|#

(defun Intern-topic-association (evidence-object
                                 topic-object)
  (let ((rule-set
         (etypecase evidence-object
           (word (word-rules   evidence-object))
           (polyword (pw-rules evidence-object))
           (category (cat-rule-set evidence-object))))
        eta
        new? )

    (if (null rule-set)
      (then
        (setq rule-set
              (etypecase evidence-object
                (word
                 (setf (word-rules evidence-object)
                       (make-rule-set :backpointer evidence-object)))
                (polyword
                 (setf (pw-rules evidence-object)
                       (make-rule-set :backpointer evidence-object)))
                (category
                 (setf (cat-rule-set evidence-object)
                       (make-rule-set :backpointer evidence-object)))))
        (setf (rs-triggered-actions rule-set)
              (list (setq eta (make-evidence-topic-association
                               :evidence evidence-object
                               :topic    topic-object))))
        (setq new? t))

      (else
        (let ((triggered-actions (rs-triggered-actions rule-set)))
          (if triggered-actions
            (then
              (dolist (action triggered-actions)
                (when (typep action 'evidence-topic-association)
                  (when (eq (eta-topic action)
                            topic-object)
                    (setq eta action)
                    (return))))
              (unless eta
                (setq new? t)
                (push (setq eta (make-evidence-topic-association
                                 :evidence evidence-object
                                 :topic    topic-object))
                      (rs-triggered-actions rule-set))))
            (else
              (setq new? t)
              (push (setq eta (make-evidence-topic-association
                               :evidence evidence-object
                               :topic    topic-object))
                    (rs-triggered-actions rule-set)))))))

    (when new?
      (catalog/evidence-topic-association eta))

    eta ))


;;;------
;;; find
;;;------

(defun Find-topic-association (evidence-object topic)
  ;; called by the deletion routine to retrieve the association object
  (let ((rule-set
         (etypecase evidence-object
           (word    (word-rules evidence-object))
           (polyword  (pw-rules evidence-object))
           (category (cat-rule-set evidence-object)))))
    (if rule-set
      (let ((triggered-actions (rs-triggered-actions rule-set)))
        (if triggered-actions
          (then
            (dolist (action triggered-actions)
              (when (typep action 'evidence-topic-association)
                (when (eq (eta-topic action)
                          topic)
                  (return-from Find-topic-association
                               action))))
            nil)
          nil))
      nil)))

