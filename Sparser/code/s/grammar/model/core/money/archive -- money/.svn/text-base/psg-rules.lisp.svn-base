;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "psg rules"
;;;   Module:  "model;core:money:"
;;;  version:  1.0  December 1990    (v1.6)

(in-package :CTI-source)



(def-cfr money (number denomination-of-money)
  :form NP
  :referent (:composite money/country.[amount-&-denomination]
                        left-edge right-edge))


(def-cfr money (denomination-of-money number)
  :form NP
  :referent (:composite money/country.[amount-&-denomination]
                        right-edge left-edge))

