;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2008 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$
;;;
;;;     File:  "location kinds"
;;;   Module:  "model;dossiers:"
;;;  version:  June 2008

;; initiated 1/17/94 v2.3
;; Started populating it 6/18/08

(in-package :sparser)

(define-kind-of-location "city")
(define-kind-of-location "country")
(define-kind-of-location "parish")
(define-kind-of-location "town")
(define-kind-of-location "village")
(define-kind-of-location "ward")




