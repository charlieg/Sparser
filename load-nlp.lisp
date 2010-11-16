;;; -*- Mode: Lisp; Syntax: Common-lisp; -*-
;;; $Id$
;;; Copyright (c) 2010 David D. McDonald
;;;
;;;   File:   load-nlp-poirot
;;;  Module:  /nlp/
;;; Version:  October 2010

;; Intiated 10/26/10 to load shared utilities, Mumble, Sparser,
;; and some KB ripped out of the Poirot ontology
;; Edited 11/16/10, added asdf items to simplify installation &
;; loading process -- charlieg

;;--- Load asdf
;;--- NOTE: you should modify the paths in this section to match
;;--- the location where you installed Sparser

(load "~/Sparser/util/asdf.lisp")

(setf asdf:*central-registry*
      '(*default-pathname-defaults*
        #p"~/Sparser/util/"   ;; ddm-util
        #p"~/Sparser/Poirot/" ;; poirot-after-mumble
        #p"~/Sparser/lisp/sfl/" ;; :sfl
        ))

(in-package :cl-user)

;;--- Directory structure

(defparameter *nlp-home*
  (make-pathname :directory (pathname-directory *load-truename*)))
;; (setq *nlp-home* "/Users/ddm/ws/nlp/")


;; ASDF setup
(require 'asdf)
#-asdf ;; otherwise use the copy in /nlp/util
(load (merge-pathname (make-pathname :directory "util")
		      "asdf.lisp"
		      *nlp-home*))


(let ((paths `((:relative ;; :up ;; nlp's parent
			  "lisp"
			  "sfl")
	       ;(:relative "ltml" "model")
	       ;(:relative "ltml" "src" "lisp")
	       )))
  (dolist (p paths)
    (pushnew (merge-pathnames (make-pathname :directory p) 
			      *nlp-home*)
	     asdf:*central-registry*)))

(pushnew (merge-pathnames (make-pathname :directory "util")
			  *nlp-home*)
	 asdf:*central-registry*)
  

;;--- Loading

;; 1st SFL so we can use the class-making shortcut
(asdf:operate 'asdf:load-op :sfl)

(asdf:operate 'asdf:load-op :ddm-util)

;; 2d Mumble
(load (concatenate 'string (namestring *nlp-home*) "Mumble/loader.lisp"))

;; 3d the bits of the Poirot NLP interface that are in :mumble
;(asdf:operate 'asdf:load-op :poirot-after-mumble)
;; just /nlp/Poirot/realization-mapping.lisp, with ltml-specific methods for
;; has-realization? and realization-for.  These need conversion to a neutral
;; package or just mining for their good stuff. 


(unless (boundp '*sparser-script-setting*)
  (defvar *sparser-script-setting* :fire))

;; 4th a choice of specific version of Sparser tuned for Poirot use
(load (concatenate 'string (namestring *nlp-home*) 
		   "Sparser/code/s/init/scripts/"
		   (ecase *sparser-script-setting*
		     (:poirot "poirot")
		     (:fire "fire")
		     (:checkpoint "checkpoint-ops"))
		   ".lisp"))
#|

;;(asdf:operate 'asdf:load-op :interprettrace)

;; Has to be loaded later because it references poirot classes in its methods
   poirot references will have to be expunged
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
|#




