;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$
;;;
;;;      File:   "poirot"
;;;    Module:   "init;scripts:"
;;;   version:   August 2009

;; Created 8/27/09, adapting from several scripts, notably checkpoint-ops.

(in-package :cl-user)

;;;------------------------
;;; Locate the base system
;;;------------------------

(unless (boundp 'location-of-sparser-directory)
  (defparameter location-of-sparser-directory
    (cond
      ((member :allegro *features*)
       (namestring
	(merge-pathnames
	 (make-pathname :directory 
			'(:relative :
			  :up ;; scripts
			  :up ;; init
			  :up ;; s
			  :up ;; code
			  ))
	 (make-pathname :directory (pathname-directory *load-truename*)))))
      (t
       (break "Not running under Allegro Common Lisp. ~
              ~%Can't construct relative pathname to location of Sparser~
              ~%You'll have to set the value of ~
              ~%        cl-user::location-of-sparser-directory~
              ~%by hand in a wrapper to this file.")))))


;;;---------------------------------------------------
;;; Set Sparser switches (others take default values) 
;;;---------------------------------------------------

(unless (find-package :sparser)
  (make-package :sparser
		:use #+:apple '(ccl common-lisp)
		#-:apple  '(common-lisp)
		))

(defparameter sparser::*poirot-interface* t
  "Special application flag read in everything")

(defparameter sparser::*grammar-configuration* "poirot")

(defparameter *return-value* nil)

(defparameter sparser::*external-referents* t)


;;;-------------------
;;; envoke the loader
;;;-------------------

(load (concatenate 'string 
        location-of-sparser-directory
	#+apple "code:s:init:everything"
	#+unix  "code/s/init/everything.lisp"
	#+mswindows "code\\s\\init\\everything.lisp"
	))

 