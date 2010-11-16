;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.
;;; copyright (c) 1992 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "old driver"
;;;   Module:  "interface;AssetNet:"
;;;  version:  January 1992

(in-package :sparser)

;;;------
;;; init
;;;------

(defun assetnet-initializations ()
  (setq *curent-file-number/number* nil))


;;;-----------------------------
;;; main loop: original version
;;;-----------------------------

(defvar *AN-file-being-read* nil)

(defun assetNet-loop ()
  ;; called from Lisp at toplevel.
  ;; Loops forever, looking for successive files in the designated
  ;; format with incrementally increasing numbers at the end of
  ;; their name.

  (assetnet-initializations)
  ;; reset the input file index

  (catch 'terminate-AssetNet-loop
    (loop
      (setq *AN-file-being-read*
            (wait-for-next-article-file))

      (analyze-text-from-file *AN-file-being-read*)
      ;; standard routine. initializes and then populates
      ;; the chart

      (scan-chart-for-AN-information)
      ;; walks over the treetops of the entire chart looking
      ;; for unconnected burned-in categories that it sets to
      ;; globals

      (send-earnings-report-to-client
       (construct-msg-string/globals))
      ;; reads the globals and writes a string, then sends it
      ;; to the client

      ))

  :AssetNet-loop-terminated )

