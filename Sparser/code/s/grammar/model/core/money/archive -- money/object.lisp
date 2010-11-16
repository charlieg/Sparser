;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.
;;; copyright (c) 1992  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "object"
;;;   Module:  "model;core:money:"
;;;  version:  1.0  December 1990    (v1.6)

(in-package :sparser)


(define-category  amount-of-money)
;  :slots ((amount number)
;          (currency currency))
;  :index (:two-stage-index
;           (:alist-on-slot currency)
;           (:hash-on-slot amount)))


(defstruct (amount-of-money
            (:conc-name "AOM-")
            (:print-function print-aom-structure))
  rules amount currency )


(defun Print-aom-structure (obj stream depth)
  (declare (ignore depth))
  (write-string "#<money " stream)
  (princ-number (aom-amount obj) stream)
  (write-string " " stream)
  (princ-currency (aom-currency obj) stream)
  (write-string ">" stream))

(defun Princ-aom (aom stream)
  (princ-number (aom-amount aom) stream)
  (write-string " " stream)
  (princ-currency (aom-currency aom) stream))


;;;------------
;;; ancilaries
;;;------------

(setf (cat-index (category-named 'amount-of-money))
      (make-alist-index))

(defun Find/amount-of-money (currency number)
  (let ((currency-entry
         (cdr (assoc currency (cat-index-of 'category::amount-of-money)))))
    (when currency-entry
      (gethash number currency-entry))))

(defun Amount-of-money (currency-symbol lisp-number)
  (let ((currency (currency-named currency-symbol)))
    (if (null currency)
      (break "There is no currency named ~A" currency-symbol)
      (let ((number (number-named lisp-number)))
        (when number
          (find/amount-of-money currency number))))))


(defun Index/amount-of-money (aom currency number)
  (let ((currency-entry
         (cdr (assoc currency (cat-index-of 'category::amount-of-money)))))

    (unless currency-entry
      (setf (cat-index (category-named 'category::amount-of-money))
            (acons currency
                   (setq currency-entry (make-hash-table :test #'eql))
                   (cat-index-of 'category::amount-of-money))))

    (setf (gethash number currency-entry) aom)))


(defun Find-or-make/amount-of-money (currency number)
  (or (find/amount-of-money currency number)
      (let ((aom (make-amount-of-money
                  :amount number
                  :currency currency)))
        (index/amount-of-money aom currency number))))

