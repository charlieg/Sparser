;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1995-2001  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "per share"
;;;   Module:  "model;core:finance:"
;;;  Version:  1.0 February 2001

;; initiated 12/22/95. Cleaned up, moved to [finance] 1/13/96.
;; 1.0 (9/6/00) Reworking it drastically to fit the new psi-based model and
;;      reliance on realizations to do all the words. 12/22 finished it
;;      see paper notes. 2/24/01 Really finished it as there was a colision
;;      in the generated rules for amount-per-share -- had to create the 
;;      intermediate category per-share-of-stock to avoid it.

(in-package :sparser)


;;;-------------------
;;; design being used
;;;-------------------

(define-category  share-of-stock
  :specializes unit-of-measure
  :instantiates self
  :binds ((company . company))
  :realization (:common-noun "share")) 
;; // add "share(s) of stock (in IBM)", maybe shortcut the two metonomys ?

;; Define the category for "53 shares of IBM"


(define-category amount-per-share  ;; "32 cents per share"
  :specializes  proportional-measurement
  :instantiates self
  :binds ((quantity . money)
          (shares-in-a-company . share-of-stock))
  :realization (:tree-family N-per-unit
                :mapping ((type . :self)
                          (N . quantity)
                          (unit . shares-in-a-company)
                          (unit-head . share-of-stock)
                          (unit-np . per-share-of-stock)
                          (N-np . money)
                          (top-np . :self))))





#|   Alternative designs tried at the beginning of the design in 1995:

(define-category  price-of-shares
  :specializes  measurement  ;; well 'ratio' actually
  :instantiates self
  :binds ((value . money))
  :index (:key value)
  :realization (:tree-family item+idiomatic-head
                :mapping ((item . value)
                          (result-type . self)
                          (np . self)
                          (modifier . money)
                          (np-head . "per share")))) 

           ;; where do the alternative phrasings go
           ;; and wouldn't it be nice to get a useful fragment
           ;; from the word "share" by itself
 
 |#

