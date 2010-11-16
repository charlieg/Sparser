;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1996  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "v2.3ag"                 "ag" for "academic grammar"
;;;    Module:   "init;scripts:"
;;;   version:   June 1996

;; This file sets up the parameter settings to load Sparser
;; with the configuration and settings appropriate to including
;; the data files of Sparser's grammar that are released to academic
;; sites into what is otherwise an 'everything' load.
;;
;; The intended use is as a binary Application of Sparser's engine
;; with a source distribution of the designated parts of the grammar
;; that is loaded on top of the application once it has been launched.
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


;;;-------------------------------
;;; Specialize the parameters set 
;;;-------------------------------

(defparameter sparser::*academic-grammar* t)
  ;; Establishes what grammar configuration file to use.


;;--- The boundp checks are for the case when this script is being run by a
;;    meta script such as copying or compiling.

(unless (boundp 'sparser::*sparser-is-an-application?*)
  (defparameter sparser::*sparser-is-an-application?* t))
  ;; Indicates that the run-on-launch file will be at the top of the
  ;; file structure rather than deep within it.  It also indicates
  ;; that Sparser is being shipped as a standalone application, and
  ;; as a result tells the application-saving routine to leave out
  ;; the compiler unless it is overruled by the flag cl-user::*end-user-
  ;; owns-a-copy-of-mcl*.


(unless (boundp 'sparser::*load-the-grammar*)
  (defparameter sparser::*load-the-grammar* nil))
  ;; Blocks the inclusion of the grammar from the initial construction
  ;; of the binary engine so that the grammar can be modified while working
  ;; with a fixed version of the engine.

(unless (boundp 'sparser::*delayed-loading-of-the-grammar*)
  (defparameter sparser::*delayed-loading-of-the-grammar* t))
  ;; Used by the launch config when the initial, engine-only image is
  ;; launched. It signals that the grammar was deliberatly omitted from
  ;; that first image, as opposed to the case where the grammar was never
  ;; supposed to be included.

(unless (boundp 'sparser::*load-dossiers-into-image*)
  (defparameter sparser::*load-dossiers-into-image* nil))
  ;; Similarly blocks the loading of dossiers of lexical items and model-level
  ;; individuals (instances of the categories). They will be loaded from the
  ;; config file once an image including the grammar is launched.


(defparameter sparser::*connect-to-the-corpus*  nil)
  ;; The assumption is that the image that's being created may have been made
  ;; on one machine for use on another, in which case we take it for granted
  ;; that the corpus is in a different place on that second machine.  Having
  ;; this flag set to nil delays any attempt to hook up to a corpus until
  ;; the image is launched.



(defparameter sparser::*insist-on-binaries* nil)  ;;<<<<<<<<<<<<<<<<<<<<<



(defparameter cl-user::*current-version*  "v2.7")
  ;; This records the version number (which is not very informative anymore)
  ;; and dictates what version subdirectory will be used for the various
  ;; configuration and load files.


;;;----------------------------------
;;; Gate the components of the Menus
;;;----------------------------------

(defparameter sparser::*spm/include-grammar-modules* t)
(defparameter sparser::*spm/include-backup* t)
(defparameter sparser::*spm/include-citations* t)
(defparameter sparser::*spm/include-define-rule* t)





;; Extension on the binary (compiled) files
;; n.b. the periods are added when the filename is assembled
(defparameter sparser::*fasl-extension*
              #+:apple  "FASL"
              #+:unix   "mbin"
              )



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

