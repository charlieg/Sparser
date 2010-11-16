;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1996  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "compile academic"
;;;    Module:   "init;scripts:"
;;;   version:   June 1996

;; This file sets up the parameter settings to drive the loading
;; of the system in it's "copy all the files to a new directory" mode.
;; It is intended to be launched from toplevel.
;; Note the hard pathnames at the end

;; cloned from [compile-everything] 6/25/96

(in-package :cl-user)

;;;--------------------
;;; define the package
;;;--------------------

(or (find-package :sparser)
    (make-package :sparser
                  :use #+:apple '(ccl common-lisp)
                       #+:unix  '(common-lisp)
                       ))

;;;----------------------
;;; setup the parameters
;;;----------------------

(defparameter sparser::*compile*  t)



;;;--------------------------------------------------
;;; do the compilation (and load the compiled files)
;;;--------------------------------------------------

(in-package :sparser)

(defparameter cl-user::location-of-sparser-directory
  "Moby:Sparser archive:JDP:Sparser:")

(setq *load-verbose* t)

(load (concatenate 'string cl-user::location-of-sparser-directory
                   "code:s:init:versions:"
                   "v2.7:"
                   "loaders:lisp-switch-settings"))

(load (concatenate 'string
                   cl-user::location-of-sparser-directory
                   "code:s:init:"
                   "scripts:v2.3ag"
                   ))
 

(just-compile "init;everything")

(just-compile "init;Lisp:kind-of-lisp")
(just-compile "init;Lisp:grammar-module")
(just-compile "init;Lisp:ddef-logical")
(just-compile "init;Lisp:lload")

(just-compile "init;scripts:Academic version")
(just-compile "init;scripts:compile academic")
(just-compile "init;scripts:copy-everything")
(just-compile "init;scripts:v2.3ag")   ;; "academic grammar"

(just-compile "version;loaders:grammar")
(just-compile "version;loaders:grammar modules")
(just-compile "version;loaders:lisp-switch-settings")
(just-compile "version;loaders:logicals")
(just-compile "version;loaders:master-loader")
(just-compile "version;loaders:model")
(just-compile "version;loaders:save routine")
(just-compile "version;loaders:stubs")

(just-compile "version;salutation")
(just-compile "version;updating")

(just-compile "config;image")
(just-compile "config;launch")
(just-compile "config;load")

(just-compile "grammar-configurations;academic grammar")

(just-compile "images;do-the-save")


:finished-compilation

