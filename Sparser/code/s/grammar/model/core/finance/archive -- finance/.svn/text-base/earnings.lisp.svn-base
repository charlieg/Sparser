;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "earnings"
;;;   Module:  "model;core:money:"
;;;  version:  May 1991    (v1.8.3)

(in-package :CTI-source)

;;;------------
;;; categories
;;;------------

(define-category  profit)
(define-category  loss)


;;;--------------
;;; earnings/shr
;;;--------------

(def-cfr earnings/shr ("Net" amount-per-share)
  :referent (:composite  earnings
                         (category-named 'profit)
                         right-edge))

;-- observed variants
; "Oper Net"
; "Net Cont Op"
; "Net Cont Oper"
; "Net [amt/shr] After Chg"

(def-cfr variant-net ("Oper Net")
  :referent profit )

(def-cfr variant-net ("Net Cont Op")
  :referent profit )


(def-cfr earnings/shr ( variant-net amount-per-share )
  :referent (:composite  earnings
                         left-edge right-edge))




(def-cfr earnings/shr ("Loss" amount-per-share)
  :referent (:composite  earnings
                         (category-named 'loss)
                         right-edge))

(def-cfr earnings/shr ("Losses" amount-per-share)
  :referent (:composite  earnings
                         (category-named 'loss)
                         right-edge))

;;;----------------
;;; total earnings
;;;----------------

(def-cfr earnings ("Net" money)
  :referent (:composite  earnings
                         (category-named 'profit)
                         right-edge))

(def-cfr earnings (variant-net money)
  :referent (:composite  earnings
                         left-edge right-edge))

(def-cfr earnings ("Loss" money)
  :referent (:composite  earnings
                         (category-named 'loss)
                         right-edge))

(def-cfr earnings ("Losses" money)
  :referent (:composite  earnings
                         (category-named 'loss)
                         right-edge))


;;;----------------------
;;; comparative earnings
;;;----------------------

(define-category  comparative-earnings/shr)
(define-category  comparative-earnings)
(define-category  comparative-amount-of-money)


(def-cfr comparator-phrase ("Vs"))
(def-cfr comparator-phrase ("vs"))


(def-cfr comparative-earnings/shr
         (comparator-phrase earnings/shr)
  :referent (:daughter right-edge))

(def-cfr comparative-earnings
         (comparator-phrase earnings)
  :referent (:daughter right-edge))

(def-cfr comparative-amount-of-money
         (comparator-phrase money)
  :referent (:daughter right-edge))

