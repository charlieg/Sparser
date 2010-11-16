;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1995  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "Switchboard"
;;;   Module:  "init;workspaces:"
;;;  version:  January 4, 1995

(in-package :sparser)

;;;----------
;;; settings
;;;----------

(dm&p-setting)
(setq *dm&p-forest-protocol* 'no-forest-level-operations)
;(setq *dm&p-forest-protocol* 'parse-forest-and-do-treetops)

;(Top-edges-setting/ddm)


;;;-------
;;; files
;;;-------

(unless (boundp '*location-of-Switchboard-corpus*)
  (defparameter *location-of-Switchboard-corpus*
                "Moby:ddm:projects:Switchboard:"))

(defparameter sw2025 (concatenate 'string
                       *location-of-Switchboard-corpus*
                       "sw2025.txt"))
;(analyze-text-from-file sw2025)


;;;-------------------
;;; tentative add-ons
;;;-------------------

(assign-brackets/expr (category-named 'number)
                      (list  ].phrase .[np ))


;;;--------
;;; markup
;;;--------

(define-colon-delimited-header-label "a" 'speaker-A
  :initiation-action 'starting-A
  :termination-action 'termination-A)

(defun starting-A (edge pos)
  (declare (ignore edge pos))
  ;(format t "~&~%----- Switching to A at p~A~%"
  ;        (pos-token-index pos))
  )

(defun termination-A (pos)
  (declare (ignore pos))
  ;(format t "~&~%----- Finished ply of A's at p~A~%"
  ;        (pos-token-index pos))
  )


(define-colon-delimited-header-label "B" 'speaker-B
  :initiation-action 'starting-B
  :termination-action 'termination-B)

(defun starting-B (edge pos)
  (declare (ignore edge pos))
  ;(format t "~&~%----- Switching to B at p~A~%"
  ;        (pos-token-index pos))
  )

(defun termination-B (pos)
  (declare (ignore pos))
  ;(format t "~&~%----- Finished ply of B's at p~A~%"
  ;        (pos-token-index pos))
  )

