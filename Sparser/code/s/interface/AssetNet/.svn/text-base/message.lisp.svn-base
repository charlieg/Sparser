;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;; copyright (c) 1992 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "message"
;;;  version:  "interface;AssetNet:"

;; tweeked 2/7 to adapt it to ISSA's interface

(in-package :CTI-source)

;;;--------
;;; driver
;;;--------

(defun construct-msg-string/globals ()
  (let ((stock-symbol-word  *company-stock-symbol*)
        (quarter-edge       *quarter*)
        (earnings-edge      *earnings*))

    (if (and stock-symbol-word quarter-edge earnings-edge)
      (let ((stock-symbol (word-pname stock-symbol-word))
            (quarter-number (extract-number-from-quarter/edge
                             quarter-edge))
            (dollars-string (amount-of-earnings/shr-as-dollars/edge
                             earnings-edge)))
        ;(break "!")
        (construct-message-string/ISSA
         stock-symbol quarter-number dollars-string))

      (when *trace-Msg-construction*
        (format t "~%The headline did not contain all the needed ~
                   information.~%No report will be made.~%")))))


(defun construct-msg-string/globals1 ()
  (let ((stock-symbol-word  *company-stock-symbol*)
        (quarter-edge       *quarter*)
        (earnings-edge      *earnings*))

    (if (and stock-symbol-word quarter-edge earnings-edge)
      (let ((stock-symbol (word-pname stock-symbol-word))
            (quarter-number (extract-number-from-quarter/edge
                             quarter-edge))
            (dollars-string (amount-of-earnings/shr-as-dollars/edge
                             earnings-edge)))
        ;(break "!")
        ;; revision for ISSA three value interface
        (values  ;; construct-message-string/ISSA
         stock-symbol quarter-number dollars-string))

      (when *trace-Msg-construction*
        (format t "~%The headline did not contain all the needed ~
                   information.~%No report will be made.~%")))))



;;;------------------------------
;;; Actually making the message
;;;------------------------------

(defun construct-message-string/ISSA (stock-symbol
                                      quarter-number
                                      dollars-string)
  (let ((string                
         (concatenate 'string
                      stock-symbol
                      "|"
                      "Q"
                      "|"
                      quarter-number
                      "|"
                      dollars-string
                      "
")))

    string ))


;;;-------------
;;; subroutines
;;;-------------

(defun extract-number-from-quarter/edge (quarter-edge)
  (let ((ref (edge-referent quarter-edge)))
    (unless (composite? ref)
      (break "referent has unexpected form: not a composite~%~A" ref))

    (unless (eq (first ref) category::fiscal-quarter)
      (break "referent has unexpected form: it's not a fiscal-quarter"))

    (let ((ordinal (second ref)))
      (unless (eq (first ordinal) category::number+th)
        (break "referent has unexpected form: ordinal isn't a number+th"))

      (let ((number (second ordinal)))
        (unless (typep number 'number/obj)
          (break "referent has unexpected form: the number isn't a ~
                  number/obj"))

        (word-pname (number-digit-sequence number))))))


(defun amount-of-earnings/shr-as-dollars/edge (earnings-edge)
  (let ((ref (edge-referent earnings-edge)))
    (unless (composite? ref)
      (break "referent has unexpected form: not a composite~%~A" ref))

    (unless (eq (first ref) category::earnings)
      (break "referent has unexpected form: it's not an earnings"))

    (let ((profit? (eq (second ref) category::profit))
          (money (third ref)))

      (unless (and (composite? money)
                   (eq (first money)
                       category::money/country.[amount-&-denomination] ))
          (break "referent has unexpected form: not the usual kind of money"))

      (let* ((number (second money))
             (digit-sequence (number-digit-sequence number))
             (number-string (etypecase digit-sequence
                              (word (word-pname digit-sequence))
                              (polyword (pw-pname digit-sequence))))
             (denomination (third money))
             (kind-of-denomination (denomination-of-money-name denomination)))

        (when (eq kind-of-denomination word::|cent|)
          (when (= (length number-string) 1)
            (setq number-string
                  (concatenate 'string "0" number-string)))
          (setq number-string
                (concatenate 'string "." number-string)))

        (when (not profit?)
          (setq number-string
                (concatenate 'string "-" number-string)))

        number-string ))))

