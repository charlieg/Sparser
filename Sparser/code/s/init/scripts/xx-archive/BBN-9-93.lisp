;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1991,1992,1993,1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "BBN"
;;;    Module:   "init;scripts:"
;;;   version:   0.1 April 1994

;; This file sets up the parameter settings to load Sparser
;; with the configuration and settings appropriate to BBN.
;;
;; Note the hard pathname in setting up the call to load "everything"

;; 0.1 (4/6) added probef's to simplify use on multiple systems

(in-package :cl-user)

#|  Directory layouts:

    On the Mac
       Sparser:code:s
                    f

    On a unix system
       ~sparser/s
                c
|#

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

(defparameter sparser::*bbn* t)

(defparameter sparser::*loader-mode* :just-the-all-edges-parser)

(defparameter sparser::*no-image* t)

(defparameter sparser::*Sparser-is-an-application?* nil)

(defparameter sparser::*load-the-grammar* nil)

(defparameter sparser::*include-model-facilities* nil)

(defparameter *case-conversion* :no-conversion)

(defparameter sparser::*nothing-Mac-specific* t)

(defparameter sparser::*connect-to-the-corpus* nil)

(defparameter sparser::*dont-load-verbose* t)

;; When working with source this has to be nil. Change it
;; to T when the compilation has been done and the final
;; setup is being put in place.
;;
(defparameter sparser::*insist-on-binaries* nil)
;; (defparameter sparser::*insist-on-binaries* t)


;; Extension on the binary (compiled) files
;; n.b. the periods are added when the filename is assembled
(defparameter sparser::*fasl-extension*
              #+:apple  "FASL"
              #+:unix   "mbin"
              )


;;;-------------
;;; do the load
;;;-------------

(unless (boundp 'cl-user::location-of-Sparser-directory)
  ;; sometimes this file gets called from [scripts;compile-everything]
  (defparameter cl-user::location-of-Sparser-directory
    (cond ((probe-file "Book:David:")  ;; M&D's powerbook
           (unless (boundp 'sparser::*known-machine*)
             (defparameter sparser::*known-machine* :book))
           "Book:David:Sparser:" )

          ((probe-file "ddm:stuff:")   ;; Br700
           (unless (boundp 'sparser::*known-machine*)
             (defparameter sparser::*known-machine* :br-700))
           "ddm:stuff:Sparser:" )

          ((probe-file "Sparser:writing:")  ;; ddm's 8100
           (unless (boundp 'sparser::*known-machine*)
             (defparameter sparser::*known-machine* :ddm-8100))
           "Sparser:" )

          (t (break "No location specified for the Sparser directory")))))


;; #+:unix  "/usr/users/guest/sparser/"


(let ((everything/source
       (concatenate 'string
                    cl-user::location-of-Sparser-directory
                    #+:apple "code:s:init:everything"
                    #+:unix "init/everything" ))
      (everything/fasl
       (concatenate 'string
                    cl-user::location-of-Sparser-directory
                    #+:apple "code:f:init:everything"
                    #+:unix "init/everything"
                    "."
                    sparser::*fasl-extension* )))

  #+:apple (setq *load-verbose* t)

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

