;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.
;;; copyright (c) 1992 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "parameters"
;;;  version:  "interface;AssetNet:"
;;;  version:  January 1992

(in-package :sparser)


;;;--------------------------------
;;; characterizing the input files
;;;--------------------------------

(defparameter *source-file-directory*
              "Moby:Sparser:corpus:earnings-reports:test-headlines:"
              ;; "Earnings:News:"
  "The directory where the input files will be put")


(defparameter *file-alphabetic-prefix*
              "headline"
              ;; ""
  "The file starts with this case-sensitive character string")


(defparameter *file-alphabetic-postfix*
              ""
              ;; ".ERN"
  "The file ends with this case-sensitive character string
   whick follows the numerical index")


(defparameter *file-initial-index-number/number*
              0
  "The default number of the first input file to be read.")


;;;------------------------------------
;;; controlling when files are read in
;;;------------------------------------

(defparameter *online-to-file-source* nil)

(defparameter *how-long-to-sleep-between-probes*
              1  ;; in seconds
  "When waiting for the next input to appear in the directory,
   the system sleeps for this much time between probes.")

(defparameter *action-if-input-file-doesnt-exist*
              :return-to-command-line
  "Read by Construct-input-filename-N when the filename it makes
   isn't found by probe-file.")

;;;-----------------------------------------------
;;; controlling the output of the earnings report
;;;-----------------------------------------------

(defparameter *online-to-client*
              ; t
              nil
  "Controls whether the message containing the earnings report
   goes into the output stream (t), or just to the Lisp listener
   (nil).")

(defparameter *physical-link-to-client*
              :file
              ; :ffc
  "Dispatched off of in Send-earnings-report-to-client to determine
   which way of sending the message is used.")


;;------- (:ffc) report is going through a foreign function call
;;        interface


;;------- (:file) report is going to a file
;;
(defparameter *directory-for-messages-to-client*
              "CTI;results:earnings reports:"

  "Provides a string to use in concatenating the pathname defining
   where the client wants the file sent.  If the system is online
   to the client and this directory does not exist an error is
   generated.")



;;;-------------------------------------
;;; controlling input from the keyboard
;;;-------------------------------------

(defparameter *salutation*
              "~%~%Welcome to the Sparser natural language ~
               parsing system~
               ~%  copyright (c) 1991,1992  David D. McDonald, ~
               Content Technologies, Inc.~
               ~%"
  "Printed out when AssetNet-command-loop is started.")

(defparameter *command-line-prompt*
              "~%command> "
  "Accessed from Read-line-as-AssetNet-command.
   The string that will be printed to prompt input.")

(defparameter *wait-between-commanded-input-files*
              180
  "The amount of time (in seconds) the system sleeps between
   file probes/analyses")

(defparameter *sleep-between-stop-checks*
              2
  "The amount of time (in seconds) the system sleeps between
   checks for keyboard input indicating it should return to
   the command line rather than keep waiting for input files")
