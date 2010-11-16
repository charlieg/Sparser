;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1996  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "elaborations to money"
;;;   Module:  "model;core:finance:"
;;;  Version:  January 1996

;; initiated 1/13/96

(in-package :sparser)


;;;--------
;;; object
;;;--------

(define-category  augmented-money
  :specializes money
  :instantiates money
  :binds ((money . money)
          (amount-per-share . amount-per-share)
          ;; //add more slots as more variations become apparent
          )
  :index (:temporary :key money))



;;;-----------------
;;; rules for cases
;;;-----------------

(def-cfr money (money or-amount-per-share)
  :form np
  :referent (:instantiate-individual augmented-money
             :with (money left-edge
                    amount-per-share right-edge)))


;;;----------
;;; printers
;;;----------

(defun string/augmented-money (am)
  (let ((money (value-of 'money am))
        (amt/shr (value-of 'amount-per-share am)))

    (cond
     ((and money amt/shr)
      (format nil "~A + ~A"
              (string-for money) (string-for amt/shr)))
     (t (when *break-on-new-cases*
          (break "new case of what subfields are available:~
                  ~%  ~A~%" am))
        "..." ))))


(define-special-printing-routine-for-category  augmented-money
  :full ((format stream "#<money+  ~A  ~A,~A>" 
                 (string/augmented-money obj)
                 (indiv-id obj) (indiv-uid obj)))
  :short ((format stream "#<~A>" (string/augmented-money obj))))
