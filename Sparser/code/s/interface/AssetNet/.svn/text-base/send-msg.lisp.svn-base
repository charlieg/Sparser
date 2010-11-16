;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.
;;; copyright (c) 1992 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "send msg"
;;;  version:  "interface;AssetNet:"
;;;  version:  January 1992

;; tweeked 2/7 to adapt it to ISSA's interface

(in-package :SPARSER)

;;;--------
;;; driver
;;;--------

(defun send-earnings-report-to-client (msg-string)
  ;; a shell to contain the various alternative means of
  ;; getting the message to the client

  (when *online-to-client*
    (ecase *physical-link-to-client*
      (:file
       (write-clents-message-to-file msg-string))
      (:ffc
       (write-clents-message-through-ffc msg-string))))

  (when *trace-message-being-sent*
    (format t *trace-message-being-sent* msg-string)))



(defun send-earnings-report-to-client1 (stock-symbol
                                        quarter-number
                                        dollars-string)
  ;; revision for ISSA three value interface

  (when *online-to-client*
    (ecase *physical-link-to-client*
      ;(:file
      ; (write-clents-message-to-file msg-string))
      (:ffc
       (write-clents-message-through-ffc
        stock-symbol quarter-number dollars-string))))

  (when *trace-message-being-sent*
    (format t *trace-message-being-sent*
            stock-symbol quarter-number dollars-string)))

