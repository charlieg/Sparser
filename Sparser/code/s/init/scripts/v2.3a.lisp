;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1991,1992,1993,1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "Apple"
;;;    Module:   "init;scripts:"
;;;   version:   April 1994

;; This file sets up the parameter settings to load Sparser
;; with the configuration and settings appropriate to Apple.
;;
;; Note the hard pathnames in setting up the call to load "everything"

(in-package :cl-user)

;;;--------------------
;;; define the package
;;;--------------------

(or (find-package :sparser)
    (make-package :sparser
                  :use #+:apple '(ccl common-lisp)
                       #+:unix  '(common-lisp)
                       ))


;;;-------------------------------------------------
;;; setup the parameters -- specialize the defaults
;;;-------------------------------------------------

(defparameter sparser::*apple* t)

(defparameter sparser::*loader-mode* :everything)

(defparameter sparser::*no-image* nil)

(defparameter sparser::*sparser-is-an-application?* t)

(defparameter sparser::*load-the-grammar* t)

(defparameter sparser::*include-model-facilities* t)

(defparameter *case-conversion* :no-conversion)

(defparameter sparser::*nothing-Mac-specific* nil)

(defparameter sparser::*connect-to-the-corpus* nil)

(defparameter sparser::*dont-load-verbose* nil) ;;/////////////////

;; When working with source this has to be nil, then change it
;; to T when the compilation has been done and the final
;; setup is being put in place.
;;(defparameter sparser::*insist-on-binaries* t)  ;;////////////////
(defparameter sparser::*insist-on-binaries* nil)  ;;////////////////


;; Extension on the binary (compiled) files
;; n.b. the periods are added when the filename is assembled
(defparameter sparser::*fasl-extension*
              #+:apple  "FASL"
              #+:unix   "mbin"
              )


(defparameter cl-user::*current-version*  "v2.3a")


;;;-------------
;;; do the load
;;;-------------

(unless (boundp 'cl-user::location-of-sparser-directory)
  ;; sometimes this file gets called from [scripts;compile-everything]
  (defparameter cl-user::location-of-sparser-directory
    (cond ((probe-file "Book:David:")  ;; M&D's powerbook
           "Book:David:Sparser:" )
          ((probe-file "ddm:stuff:")   ;; Br700
           "ddm:stuff:Sparser:" )
          ((probe-file "Sparser:written:")  ;; ddm's II
           "Sparser:" )
          (t (break "No location specified for the Sparser directory")))))

(let ((everything/source
       (concatenate 'string
                    cl-user::location-of-sparser-directory
                    #+:apple "code:s:init:everything"
                    #+:unix "init/everything" ))
      (everything/fasl
       (concatenate 'string
                    cl-user::location-of-sparser-directory
                    #+:apple "code:f:init:everything"
                    #+:unix "init/everything"
                    "."
                    sparser::*fasl-extension* )))

  #+:apple (setq *load-verbose* t)   ;;;  ////////// turn this off

  (if sparser::*insist-on-binaries*
    (load everything/fasl)
    (if (probe-file everything/fasl)
      (when (probe-file everything/source)
        ;; Have to check first, because the whole directory tree
        ;; for "s" will be missing after the instalation is finished.
        (let ((date-of-source (file-write-date everything/source))
              (date-of-fasl (file-write-date everything/fasl)))
          (if (> date-of-source
                 date-of-fasl)
            (load everything/source)
            (load everything/fasl))))
      (load everything/source))))

