;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.
;;; copyright (c) 1992 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "file link"
;;;  version:  "interface;AssetNet:"
;;;  version:  January 1992

(in-package :sparser)

;;;-----------
;;; file name
;;;-----------

(defun construct-name-of-earnings-report-file ()
  (unless (probe-file *directory-for-messages-to-client*)
    (error "The logical pathname bound to *directory-for-~
            messages-to-client*~
            ~%does not designate an existing directory.~
            ~%The client's message cannot be written."))

  (concatenate 'string
               *directory-for-messages-to-client*
               "earnings_"
               (hour-minute-second/string)
               ".Txt" ))

;;;--------
;;; driver
;;;--------

(defun write-clents-message-to-file (message-string)
  (let ((file-name
         (construct-name-of-earnings-report-file)))

    (with-open-file (file-stream file-name
                                 :direction  :output
                                 :if-exists  :supercede)
      (write-string message-string file-stream))))

