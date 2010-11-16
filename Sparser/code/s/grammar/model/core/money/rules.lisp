;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993-1996  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "rules"
;;;   Module:  "model;core:money:"
;;;  version:  January 1996

;; initiated 10/22/93 v2.3 from treatment of 11/91.
;; 1/5/96 added two preposition cases. 1/16 added rule for "cents"

(in-package :sparser)


;;;--------------
;;; prepositions
;;;--------------

(def-cfr of-money ("of" money)
  :form pp
  :referent (:daughter right-edge))

(def-cfr to-money ("to" money)
  :form pp
  :referent (:daughter right-edge))



;;;-----------------
;;; rules for money
;;;-----------------

;; "10 dollar(s)"
(def-cfr money (number denomination/money)
  :form np
  :referent (:instantiate-individual money
                :with (number left-edge
                       denomination right-edge)))


;; "$10"
(def-cfr money (denomination/money number)
  :form np
  :referent (:instantiate-individual money
                :with (number right-edge
                       denomination left-edge)))


;; "72 cents"
(def-cfr money (number fractional-denomination/money)
  :form np
  :referent (:function equivalent-amount-in-reference-currency
                       left-edge right-edge))


;;;--------------------
;;; rules for currency
;;;--------------------

;; "Australian dollars"
(def-cfr currency (country denomination/money)
  :form np
  :referent (:instantiate-individual currency
                :with (denomination right-edge
                       country left-edge)))

