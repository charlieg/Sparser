;;; -*- Mode: Lisp; Syntax: Common-lisp; -*-
;;; $Id$
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved

;; /Mumble/derivation-trees/loader.lisp

;; Initated 9/16/09

;;//// Replace with ASDF

(defvar *location-of-derivation-tree-code*
  (if (member :allegro *features*)
    (namestring
     (make-pathname :directory (pathname-directory *load-truename*)))
    (break "Not running under Allegro Common Lisp.~
          ~%Can't construct relative pathname to location of Mumble derivation tree code")))

;; types file is in the main mumble loader
;; conversions is is load-after-sparser

(load (string-append *location-of-derivation-tree-code* "make.lisp"))
;(load (string-append *location-of-derivation-tree-code* ""))
;(load (string-append *location-of-derivation-tree-code* "X.lisp"))
