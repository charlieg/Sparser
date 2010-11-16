;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1997  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "compile BBN"
;;;    Module:   "init;scripts:"
;;;   version:   August 1997

;; This file sets up the parameter settings to drive the loading
;; of the system in it's "copy all the files to a new directory" mode.
;; It is intended to be launched from toplevel.
;; Note the hard pathnames at the end

;; cloned from [copy everything] 8/17/97.  8/19 modified it to run under
;; control of an alternative within the toplevel load file rather than
;; to be launched directly.

(in-package :cl-user)

(unless (find-package :sparser)
  (error "Sparser package isn't defined yet. Check that this file was ~
          called from a properly configured Sparser loader."))

(in-package :sparser)


;;;----------------------
;;; setup the parameters
;;;----------------------

(defparameter sparser::*compile* t)

;; When testing on the Mac, the system will have been 
;; copied into unix format before this compilation routine is run.
(defparameter cl-user::*unix-file-system-inside-mac*  #+apple t
                                                      #+unix nil)

(defparameter cl-user::*mac-file-system* #+apple t
                                         #+unix nil)

(defparameter cl-user::*unix-file-system* #+apple nil
                                          #+unix t)



;;;--------------------------------------------------
;;; do the compilation (and load the compiled files)
;;;--------------------------------------------------

(load (concatenate 'string
        cl-user::location-of-sparser-directory
        #+apple "code:s:"  
        #+unix  "code/s/"
        #+apple "init:scripts:BBN" 
        #+unix  "init/scripts/BBN" 
        ))
 


;; Do these by hand, since they are loaded with "load" rather than "lload"
;; and won't have been seen.

(format t "~%~%Beginning compilation of the bootstrap loader~%~%")


(just-compile "init;everything")

(just-compile "init;Lisp:kind-of-lisp")
(just-compile "init;Lisp:grammar-module")
(just-compile "init;Lisp:ddef-logical")
(just-compile "init;Lisp:lload")

;(just-compile "init;scripts:BBN loader") ;; renamed and moved by this time
(just-compile "init;scripts:BBN")
(just-compile "init;scripts:compile BBN")

(just-compile "version;loaders:grammar")
(just-compile "version;loaders:grammar modules")
(just-compile "version;loaders:lisp-switch-settings")
(just-compile "version;loaders:logicals")
(just-compile "version;loaders:master-loader")
(just-compile "version;loaders:stubs")

(just-compile "version;salutation")
(just-compile "version;updating")

(just-compile "config;launch")
(just-compile "config;load")

(just-compile "grammar-configurations;bbn")


:finished-compilation

