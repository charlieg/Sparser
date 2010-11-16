;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "per share"
;;;   Module:  "model;core:money:"
;;;  version:  May 1991    (v1.8.3)

(in-package :CTI-source)

;;;---------------------------------------
;;; capitalized version for within titles
;;;---------------------------------------

(def-cfr share-of-stock ("Shr"))

(def-cfr share-of-stock ("-" share-of-stock))


(def-cfr a-share-of-stock ("A" share-of-stock))


(def-cfr amount-per-share (money share-of-stock)
  :referent (:daughter left-edge))

(def-cfr amount-per-share (money a-share-of-stock)
  :referent (:daughter left-edge))

