;;; -*- Mode: Lisp; Syntax: COMMON-LISP; Base:10; -*-
;;; $Id$
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved

;;; /nlp/Poirot/poirot-after-mumble.asd

;; initiated 9/17/09

(defpackage :poirot-after-mumble-asd
  (:use :common-lisp :asdf))

(in-package :poirot-after-mumble-asd)

(defsystem :poirot-after-mumble
  :serial t
  ;; depends on Mumble, which isn't loaded via asdf
  :components ((:file "resources")))
