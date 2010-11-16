;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1991-1997  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "BBN"
;;;    Module:   "init;scripts:"
;;;   version:   0.2 August 1997

;; This file sets up the parameter settings to load Sparser
;; with the configuration and settings appropriate to BBN.
;; It should be called from "BBN loader" (or equivalently when
;; installed "<toplevel>load-sparser"), which will handle the
;; hard pathnames that are needed. 

;; Both the compilation pass and all subsequent loading passes go 
;; through this file. 

;; 0.1 (4/6/93) added probef's to simplify use on multiple systems
;; 0.2 (8/13/97) adjusted the settings to fit current reality; re-
;;      introduced the +unix checks.  8/19 tweeked them again to fit
;;      the redesign of the toplevel "load Sparser" file. 8/24 fixed
;;      some location changes. 

(in-package :cl-user)


;;;-----------------------
;;; check for the package
;;;-----------------------

(unless (find-package :sparser)
  ;; defining it lets me launch this directly while debugging under
  ;; Sparser rather than in the 'for unix' copy.
  (make-package :sparser
              :use #+:apple '(ccl common-lisp)
                   #+:unix  '(lisp)))


;;;-------------------------------------------------
;;; setup the parameters -- specialize the defaults
;;;-------------------------------------------------

(defparameter sparser::*bbn* t)

(defparameter sparser::*loader-mode* :everything)

(defparameter sparser::*no-image* t)

(defparameter sparser::*sparser-is-an-application?* nil)

(defparameter sparser::*load-the-grammar* t)

(defparameter sparser::*include-model-facilities* nil)

(defparameter sparser::*connect-to-the-corpus* nil)


(unless (boundp 'sparser::*Sparser-has-been-compiled*)
  (defparameter sparser::*Sparser-has-been-compiled* nil))

(defparameter sparser::*dont-load-verbose*
              sparser::*Sparser-has-been-compiled*)

(defparameter sparser::*insist-on-binaries*
              sparser::*Sparser-has-been-compiled*)


;; When debugging an extension and working with native Mac files
;; this should be nil. Once the files have been copied out in
;; unix format, it should be changed to t, or else allow a location-
;; specific higher binding of it to do the work.  8/24 this situation
;; corresponds to the value of the compiled flag when running the
;; BBN configuration
(unless (boundp 'cl-user::*unix-file-system-inside-mac*)
  (defparameter cl-user::*unix-file-system-inside-mac*
                sparser::*Sparser-has-been-compiled*))


(defparameter cl-user::*unix-file-system* #+apple nil
                                          #+unix t )

(defparameter cl-user::*mac-file-system* #+apple t
                                          #+unix nil )


(defparameter sparser::*case-conversion* :no-conversion)

(defparameter sparser::*nothing-Mac-specific* t)


;; Extension on the binary (compiled) files
;; n.b. the periods are added when the filename is assembled
(unless (boundp 'sparser::*fasl-extension*)
  (defparameter sparser::*fasl-extension*
    #+:apple  "FASL"
    #+:unix   "mbin"
    ))


;;;-------------
;;; do the load
;;;-------------

(unless (boundp 'cl-user::location-of-sparser-directory)
  ;; default for development at 14B
  (defparameter cl-user::location-of-sparser-directory "Sparser:"))

(let ((everything/source
       (concatenate 'string
                    cl-user::location-of-sparser-directory
                    #+:apple "code:s:init:everything"
                    #+:unix "code/s/init/everything" ))
      (everything/fasl
       (concatenate 'string
                    cl-user::location-of-sparser-directory
                    #+:apple "code:f:init:everything"
                    #+:unix "code/f/init/everything"
                    "."
                    sparser::*fasl-extension* )))

  #+:apple (setq *load-verbose* t)

  (if sparser::*insist-on-binaries*
    (load everything/fasl)
    (if (probe-file everything/fasl)
      (if (probe-file everything/source)
        ;; Have to check first, because the whole directory tree
        ;; for "s" will be missing after the instalation is finished.
        (let ((date-of-source (file-write-date everything/source))
              (date-of-fasl (file-write-date everything/fasl)))
          (if (> date-of-source
                 date-of-fasl)
            (load everything/source)
            (load everything/fasl)))
        (load everything/fasl))
      (load everything/source))))

