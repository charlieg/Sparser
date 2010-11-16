;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.
;;; copyright (c) 1992 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "drivers"
;;;   Module:  "interface;AssetNet:"
;;;  version:  January 1992

;; tweeked 2/7 to adapt it to ISSA's interface

(in-package :sparser)

;;;------------------------------------------
;;; variations supported by the command line
;;;------------------------------------------

(defun analyze-all-the-files ()
  (when *check-cmd-line-dispatch*
    (format t "~%--- Analyze-all-the-files ---~%"))
  ;; Set the file index to 1 and run through files forever
  (analyze-all-the-files/start-at-N 1))


(defvar *index-of-input-file* nil)

(defun analyze-all-the-files/start-at-N (n)
  (when *check-cmd-line-dispatch*
    (format t "~%--- Analyze-all-the-files/start-at-N : ~A ---~%" n))
  (setq *index-of-input-file* n)
  (let ((accumulated-sleep-time 0))
    (loop
      (analyze-file-N *index-of-input-file*)
      (block loop-to-check-for-abort
        (loop
          (sleep *sleep-between-stop-checks*)
          (when *tick-while-sleeping*
            (format t "tick "))
          (when (listen *standard-input*)
            ;; this will return on ANY character
            (return-from Analyze-all-the-files/start-at-N))
          (setq accumulated-sleep-time
                (+ *sleep-between-stop-checks*
                   accumulated-sleep-time))
          (when (> accumulated-sleep-time
                   *wait-between-commanded-input-files*)
            (return-from loop-to-check-for-abort))))
      
      ;; alternative to the interrupt loop
      ;(sleep *wait-between-commanded-input-files*)
      
      (incf *index-of-input-file*))))


(defun analyze-file-N (n)
  (when *check-cmd-line-dispatch*
    (format t "~%--- Analyse-file-N : ~A ---~%" n))
  (let ((filename (construct-input-filename-N n)))
    (analyze-text-from-file filename)
    (scan-chart-for-AN-information)

    ;; revision to fit ISSA's three arg interface 2/7/92
    ;; original:
    ;;(send-earnings-report-to-client
    ;; (construct-msg-string/globals))
    ;;
    (multiple-value-bind (stock-symbol quarter-number dollars-string)
                         (construct-msg-string/globals1)
      (send-earnings-report-to-client1
       stock-symbol quarter-number dollars-string))))

