;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.
;;; copyright (c) 1991,1992,1993  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "CA"
;;;   Module:  "drivers;treetop:"
;;;  Version:   1.4 October 1991

;; initiated in November 1990
;; 1.1 (2/13/91 v1.8.1)  Added between-tt actions.
;; 1.2 (4/10 v1.8.2)  Added traces to Do-conceptual-action
;; 1.3 (7/18 v1.8.6)  Removed form category as a way to trigger
;;      an action.
;; 2.0 (10/31 v2.0) flushed the call to check-for-triggered-action
;; 3.0 (7/16/92 v2.3) Changed things to trigger off form rather than category

(in-package :sparser)


(defun do-conceptual-analysis-off-new-treetop (tt)
  ;; called from Do-treetop
  (etypecase tt
    (edge (let ((action (CA-action (edge-form tt))))
            (do-conceptual-action action tt)))
    (word (let ((action (CA-action tt)))
            (do-conceptual-action action tt)))
    (polyword )))



(defun do-conceptual-action (action tt)
  (if action
    (then
      (when *trace-CA*
        (format t "~&CA: doing action: ~A~
                   ~%  for treetop: ~A~%" action tt))
      (when *trace-treetop-hits*
        (format t "~%TT:  doing CA ~A for ~A~%"
                action tt))
      (funcall action tt))
    (else
      (when *trace-CA*
        (format t "~&CA: no actions for ~A" tt)))))

