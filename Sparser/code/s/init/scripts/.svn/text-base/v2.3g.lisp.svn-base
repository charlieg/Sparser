;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1995  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "v2.3g"                 "g" for "grammar"
;;;    Module:   "init;scripts:"
;;;   version:   April 1995

;; This file sets up the parameter settings to load Sparser
;; with the configuration and settings appropriate to including
;; public grammar in what is otherwise an 'everything' load.
;;
;;   The intended use is as a binary Application with public
;; launch configuration and (some) public grammar
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


;;;-----------------------------------------------
;;; Specialize the parameters set by [everything]
;;;-----------------------------------------------

(defparameter sparser::*public-grammar* t)

(defparameter sparser::*loader-mode* :everything)

(defparameter sparser::*no-image* nil)

(defparameter sparser::*sparser-is-an-application?* t)

(defparameter sparser::*load-the-grammar* t)

(defparameter sparser::*include-model-facilities* t)

(defparameter sparser::*load-dossiers-into-image* nil)

(defparameter sparser::*case-conversion* :no-conversion)

(defparameter sparser::*nothing-Mac-specific* nil)

(defparameter sparser::*connect-to-the-corpus* nil)

(defparameter sparser::*dont-load-verbose* nil)

(defparameter sparser::*insist-on-binaries* nil)



(defparameter cl-user::*current-version*  "v2.3g")


;;;----------------------------------
;;; Gate the components of the Menus
;;;----------------------------------

(defparameter sparser::*spm/include-grammar-modules* t)
(defparameter sparser::*spm/include-backup* t)
(defparameter sparser::*spm/include-citations* t)
(defparameter sparser::*spm/include-define-rule* t)

(defparameter sparser::*pref-include/analysis-dm&p* nil)




;; Extension on the binary (compiled) files
;; n.b. the periods are added when the filename is assembled
(defparameter sparser::*fasl-extension*
              #+:apple  "FASL"
              #+:unix   "mbin"
              )



;;;-------------
;;; do the load
;;;-------------

(defparameter cl-user::location-of-root-directory nil)

(unless (boundp 'cl-user::location-of-sparser-directory)
  ;; sometimes this file gets called from [scripts;compile-everything]
  (defparameter cl-user::location-of-sparser-directory
    (cond ((probe-file "Book:David:")  ;; M&D's powerbook
           "Book:David:Sparser:" )
          ((probe-file "ddm:stuff:")   ;; Br700
           "ddm:stuff:Sparser:" )
          ((probe-file "Sparser:writing:")  ;; ddm's II, the 900
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

