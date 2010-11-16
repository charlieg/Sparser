;;; -*- Mode: Lisp; Syntax: Common-lisp; -*-
;;; $Id$
;;; Copyright (c) 2009-2010 BBNT Solutions LLC. All Rights Reserved
;;;
;;;   File:   load-nlp-poirot
;;;  Module:  /nlp/Poirot/
;;; Version:  February 2010

;; 2/4/10 Modified the poirot default to be runtime rather than offline to reflect
;;  where I'm doing most of the work today.

(in-package :cl-user)

;;--- Directory structure
#| 
On my machine, nlp is a sister to poirot, both are daughters of ws.
This file is an daughter of nlp/Poirot, so to load poirot we got
up and then down again. We have to modify this when we do imports
into the Poirot repository. ddm 8/27/09
|#

(defparameter *poirot-nlp-home*
  (make-pathname :directory (pathname-directory *load-truename*)))
 
(defparameter *nlp-home*
  (merge-pathnames (make-pathname :directory 
				  '(:relative
				    :up ;; Poirot
				    ))
		  *poirot-nlp-home*))

(defparameter *poirot-home*
  (merge-pathnames (make-pathname :directory
				  '(:relative
				    :up ;; ws
				    "poirot"))
		   *nlp-home*))

;; ASDF setup
(require 'asdf)
#-asdf ;; otherwise use the copy in /nlp/util
#| (load (merge-pathname (make-pathname :directory "util")
		      "asdf.lisp"
		      *nlp-home*))
DOESN'T WORK: "merge-pathname" is an undefined function (should be
  "merge-pathnames"), and would produce: #P"/util/asdf.lisp"
|# 

(load (merge-pathnames (make-pathname
			:directory '(:relative "util" "asdf.lisp"))
		       *nlp-home*))

#|
(let ((paths `((:relative "extlib" "sfl")
	       (:relative "ltml" "model")
	       (:relative "ltml" "src" "lisp")
	       )))
  (dolist (p paths)
    (pushnew (merge-pathnames (make-pathname :directory p) 
			      *poirot-home*)
	     asdf:*central-registry*)))

(pushnew (merge-pathnames (make-pathname :directory "util")
			  *nlp-home*)
	 asdf:*central-registry*)
DOESN'T WORK: would produce: #P"/util/"

(pushnew (merge-pathnames (make-pathname
			  :directory '(:relative "util"))
			  *nlp-home*)
	 asdf:*central-registry*)
|#

;;--- Loading

;; 1st SFL so we can use the class-making shortcut
(asdf:operate 'asdf:load-op :sfl)

(asdf:operate 'asdf:load-op :ddm-util)

;; 2d Mumble
(load (concatenate 'string (namestring *nlp-home*) "Mumble/loader.lisp"))

;; 3d the bits of the Poirot NLP interface that are in :mumble
(asdf:operate 'asdf:load-op :poirot-after-mumble)

(unless (boundp '*sparser-script-setting*)
  (defvar *sparser-script-setting* :poirot))

;; 4th a choice of specific version of Sparser tuned for Poirot use
(load (concatenate 'string (namestring *nlp-home*) 
		   "Sparser/code/s/init/scripts/"
		   (ecase *sparser-script-setting*
		     (:poirot "poirot")
		     (:fire "fire")
		     (:checkpoint "checkpoint-ops"))
		   ".lisp"))

;; Poirot itself
(unless (boundp '*poirot-load*)
  (defvar *poirot-load* :mdis))
(case *poirot-load* 
  (:medivac (asdf:operate 'asdf:load-op :service-defs))
  (:xplain  (asdf:operate 'asdf:load-op :interprettrace))
  (:mdis (asdf:operate 'asdf:load-op :mdis-runtime-code)) ;; mdis-offline-code
  (otherwise (asdf:operate 'asdf:load-op :mdis-runtime-code)))


;;(asdf:operate 'asdf:load-op :interprettrace)

;; Has to be loaded later because it references poirot classes in its methods
(sparser::gload "poirot;time")
(sparser::gload "poirot;ad-hoc-annotation")
(asdf:operate 'asdf:load-op :mumble-after-poirot) ;; in /nlp/Poirot/

(in-package :sparser)
;; Expand the realizations in the Poirot objects
(progn  ;; in the sparser package
  (setq *trace-realization-definition* t)
    ;; provide some feedback
  (setq *expand-realizations-when-enqueued* t)
    ;; for modifying/elaborating realization definitions after the
    ;; initial load
  (expand-realizations)) ;; runs the realization forms that were
                         ;; stored when Poirot was loaded

(load (concatenate 'string (namestring cl-user::*nlp-home*) "Mumble/load-after-sparser.lisp"))

