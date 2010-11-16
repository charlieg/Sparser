;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993-1996  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "objects"
;;;   Module:  "model;core:money:"
;;;  version:  January 1996

;; initiated 10/22/93 v2.3 from treatment of 11/91. Added a sort routine 11/15/95
;; Added a proper definition for stuff like "cents" 1/16/96

(in-package :sparser)

;;;---------
;;; objects
;;;---------

(define-category  denomination/money
  :specializes  nil
  :instantiates :self
  :binds ((name  :primitive word))
  :index (:permanent :key name)
  :realization
    (:common-noun name))


(define-category  currency
  :specializes  unit-of-measure
  :instantiates :self
  :binds ((denomination . denomination/money)
          (country . country))
  :index (:permanent
          :sequential-keys country denomination))


(define-category  money
  :specializes  amount
  :instantiates :self
  :binds ((number . number)
          (currency . currency))
  :index (:temporary
          :sequential-keys currency number))




;;;-----------------
;;; specializations
;;;-----------------

(define-category  fractional-denomination/money
  :specializes denomination/money
  :instantiates self
  :binds ((name  :primitive word)
          (reference-denomination . denomination/money)
          (fraction))
  :index (:permanent :key name)
  :realization (:common-noun name))


;; Need this to get the other slot values set up.
;;
(defun define-fractional-denomination-of-money (string
                                                &key reference-denomination
                                                     fraction)
  (let ((reference-obj (find-individual 'denomination/money
                          :name reference-denomination)))

    (let ((obj (define-individual 'fractional-denomination/money
                 :name string)))

      (bind-variable 'reference-denomination reference-obj obj)
      (bind-variable 'fraction fraction obj)
      obj )))


;; Called from the cfr
;;
(defun equivalent-amount-in-reference-currency (number fractional-denomination)
  (let ((integer (value-of 'value number))
        (reference-denomination (value-of 'reference-denomination
                                          fractional-denomination))
        (fraction (value-of 'fraction fractional-denomination)))

    (let* ((fractional-value (* fraction integer))
           (value-as-number-obj (define-individual 'number
                                  :value fractional-value))
           (presumed-currency (define-individual 'currency
                                :denomination reference-denomination
                                :country (find-individual 'country
                                           :name "United States"))))
      (define-individual 'money
        :number value-as-number-obj
        :currency presumed-currency))))
    





;;;---------------
;;; sort function
;;;---------------

(define-sort-function 'money 'sort-money-by-numerical-value)

(defun sort-money-by-numerical-value (m1 m2)
  (let ((n1 (value-of 'number m1))
        (n2 (value-of 'number m2)))
    (sort-number-individuals-by-value n1 n2)))

