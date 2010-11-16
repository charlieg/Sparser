;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.
;;; copyright (c) 1992 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "traces"
;;;   Module:  "interface;AssetNet:"
;;;  version:  January 1992

;;; copyright (c) 1992 David D. McDonald  -- all rights reserved

(in-package :sparser)

;;;-----------
;;; debugging
;;;-----------

(defparameter *trace-chart-scan* nil)
;(setq *trace-chart-scan* t)
;(setq *trace-chart-scan* nil)

(defparameter *trace-Msg-construction* nil)
;(setq *trace-Msg-construction* t)
;(setq *trace-Msg-construction* nil)

(defparameter *check-cmd-line-dispatch* nil)
;(setq *check-cmd-line-dispatch* t)
;(setq *check-cmd-line-dispatch* nil)

(defparameter *tick-while-sleeping* nil
  "Read in Analyze-all-the-files/start-at-N, ticks every
   *sleep-between-stop-checks* seconds.")
;(setq *tick-while-sleeping* t)
;(setq *tick-while-sleeping* nil)


;;;------------------
;;; part of the demo
;;;------------------

(defparameter *testing-Wait-for-next-article-file*  t
  "Called from Wait-for-next-article-file, writes a msg to 
   *standard-output* just as the call to Sleep is made.
   Currently overloaded to act as a hook to put demo info on
   the screen -- the msg is 'Waiting for Headline:' ")

(defparameter *write-ticks* t
  "Called from Wait-for-next-article-file, writes ' . ' to
   *standard-output* every *how-long-to-sleep-between-probes*
   until the next file appears in the input directory.")

(defparameter *trace-message-being-sent*
              ;; "~%~%~%Message for client: ~A~%~%"
              ;; revision for 3 value interface
              "~%~%~%Message for client:~
              ~% ~A  ~A  ~A"
  "Checked in Send-earnings-report-to-client/globals just
   after the message went out.  Value is the string that is
   printed.")


