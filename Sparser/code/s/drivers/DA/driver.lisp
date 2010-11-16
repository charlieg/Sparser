;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994,1995  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "driver"
;;;   Module:  "drivers;DA:"
;;;  Version:  May 1995

;; initiated 10/26/94 v2.3.  Enriched it 5/5/95. Tweeked ..5/18

(in-package :sparser)

;;;-------------
;;; entry point
;;;-------------

(defun consider-debris-analysis ()
  ;; Called from Parse-forest-and-do-treetops or After-quiescence as
  ;; the next stage of processing at the forest level.
  (tr :beginning-da)
  (if *do-debris-analysis*
    (walk-pending-treetops-for-debris-analysis)
    (else
      ;; //trace
      (do-treetop-triggers))))


;;;------
;;; loop
;;;------

(defun walk-pending-treetops-for-debris-analysis ()
  (let ((start-pos  *left-boundary/treetop-actions*)
        (end-pos    *rightmost-quiescent-position*)
        tt  position  next-position  multiple? )
    (tr :looking-for-analyzable-debris start-pos end-pos)

    (setq position start-pos)
    (loop
      (when (eq position end-pos)
        (return))

      (multiple-value-setq (tt next-position multiple?)
        (next-treetop/rightward position))

      (when multiple?
        (setq tt (reduce-multiple-initial-edges tt)))

      (setq *da-dispatch-position*
            (look-for-and-execute-any-DA-pattern
             tt position next-position))
     
      (setq position (or *da-dispatch-position*
                         next-position))
      (tr :resuming-DA-walk-at position))

    (tr :moving-to-do-treetops)
    (do-treetop-triggers)))

