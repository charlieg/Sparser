;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1995  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "generic"
;;;   Module:  "init;workspaces:"
;;;  version:  January 1995

;; broken out from [init;versions:v2.3a:workspace:in progress] 1/30/95

(in-package :sparser)


;;;------------------------
;;; fancy trace operations
;;;------------------------

#|(set-traces-hook 988 992
                  '(*trace-network*
                    *trace-fsas*))
(turn-off-traces-hook)
|#


;;;-----------------
;;; useful routines
;;;-----------------

(defun quietly (form)
  (let ((*display-word-stream* nil)
        (*readout-segments* nil))
    (eval form)))

