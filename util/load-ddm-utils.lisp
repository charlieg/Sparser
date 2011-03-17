;;; -*- Mode: Lisp; Syntax: COMMON-LISP; Base:10; -*-
;;; Copyright (c) 2011 David D. McDonald All Rights Reserved
;;; $Id$
;;;
;;;      File:  "load-ddm-utils"
;;;    Module:  /Sparser/utils/
;;;   Version:  February 2011

;; Initiated 2/17/11. This is an alternative to /utils/ddm-util.asd
;; which at this point causes Clozure to choak for some reason yet
;; to be diagnosed. 

(in-package :cl-user)

(unless (find-package :ddm-util) 
  (defpackage :ddm-util
    (:use :common-lisp 
          #+openmcl :ccl)))

(defvar *util-home*
  (make-pathame :directory (pathname-directory *load-truename*)))

(defun load-util (filename)
  (let ((namestring (concatenate 'string *util-home* filename)))
    (load namestring)))

(load-util "util")
(load-util "walk-directories")
(load-util "push-debug")
(load-util "indexed-object")
(load-util "indentation")
;;(load-util "csv-read") ;;/// change its package
(load-util "auto-gen")

