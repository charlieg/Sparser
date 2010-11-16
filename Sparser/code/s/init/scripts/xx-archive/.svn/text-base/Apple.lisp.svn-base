;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1991,1992,1993,1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "Apple"
;;;    Module:   "init;scripts:"
;;;   version:   March 1994

;; This file sets up the parameter settings to load Sparser
;; with the configuration and settings appropriate to Apple.
;;
;; Note the hard pathname in setting up the call to load "everything"

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

(defparameter sparser::*bbn* t)

(defparameter sparser::*loader-mode* :just-the-all-edges-parser)

(defparameter sparser::*load-the-grammar* nil)

(defparameter sparser::*include-model-facilities* nil)

(defparameter *case-conversion* :no-conversion)

(defparameter sparser::*nothing-Mac-specific* t)

(defparameter sparser::*no-image* t)

;; When working with source this has to be nil, then change it
;; to T when the compilation has been done and the final
;; setup is being put in place.
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

(defparameter cl-user::location-of-Sparser-directory
  #+:apple "Sparser:"
  ;; #+:apple "Book:David:Sparser:"
  ;; #+:unix  "/usr/users/guest/sparser/"
  )

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

  (if (probe-file everything/fasl)
    (when (probe-file everything/source) ;; that tree could be omitted
      (let ((date-of-source (file-write-date everything/source))
            (date-of-fasl (file-write-date everything/fasl)))
        (if (> date-of-source
               date-of-fasl)
          (load everything/source)
          (load everything/fasl))))
    (load everything/source)))

