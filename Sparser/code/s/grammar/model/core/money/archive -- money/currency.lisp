;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "currency"
;;;   Module:  "model;core:money:"
;;;  version:  1.1  July 1990

;; 1.1 (7/18 v1.8.6)  Added "Yen"

(in-package :CTI-source)


(define-category  currency)
;  :slots ((name symbol)
;          (denomination denomination-of-money)
;          (country country))
;  :index (:hash-on-slot name))


(defstruct (currency
            (:print-function print-currency-structure))
  rules name denomination country )


(defun Print-currency-structure (obj stream depth)
  (declare (ignore depth))
  (write-string "#<currency " stream)
  (princ-country (currency-country obj) stream)
  (write-string " " stream)
  (when (currency-denomination obj)
    (princ-denomination-of-money (currency-denomination obj) stream))
  (write-string ">" stream))

(defun Princ-currency (c stream)
  (princ-country (currency-country c) stream)
  (write-string " " stream)
  (princ-denomination-of-money (currency-denomination c) stream))


;;;------------
;;; ancilaries
;;;------------

(setf (cat-index (category-named 'currency))
      (make-index/hash-on-slot))

(defun Find/currency (symbol)
  (gethash symbol (cat-index-of 'category::currency)))

(defun Currency-named (symbol)
  (find/currency symbol))


(defun Index/currency (symbol currency)
  (setf (gethash symbol (cat-index-of 'category::currency))
        currency))


(defun all-currency ()
  (let ( accumulating-currency )
    (maphash #'(lambda (symbol currency)
                 (push currency accumulating-currency))
             (cat-index-of 'category::currency))
    accumulating-currency))

(defun list-the-currency ()
  (let ((the-currency (all-currency)))
    (pl (sort the-currency 
              #'symbol-order :key #'currency-name)
        nil)))


(defun Delete-currency (symbol)
  (let* ((currency (currency-named symbol)))
    (unless currency
      (error "There is no currency named ~A" symbol))
    (delete/currency currency)))

(defun Delete/currency (currency)
  (dolist (rule (currency-rules currency))
    (delete-cfr/cfr rule))
  (remhash (currency-name currency)
           (cat-index-of 'category::currency))
  currency )


;;;--------------
;;; instantiator
;;;--------------

(defun Define-currency (name
                        denomination-name
                        country-name)

  (let ((country (country-named country-name))
        (denomination (denomination-of-money-named
                       denomination-name))
        currency )

    (if (setq currency (find/currency name))
      currency
      (else
        (setq currency (make-currency
                        :name name
                        :denomination denomination
                        :country country))

        (index/currency name currency)
        currency ))))


;;;-------
;;; cases
;;;-------

(define-currency  'US-dollar "dollar" "United States")
(define-currency  'Japanese-Yen  "yen"  "Japan")

