;;; -*- Mode: Lisp; Syntax: Common-lisp; -*-
;;; $Id$
;;; Copyright (c) 2010 David D. McDonald
;;;
;;;   File:   load-nlp-poirot
;;;  Module:  /nlp/
;;; Version:  December 2010

;; Intiated 10/26/10 to load shared utilities, Mumble, Sparser,
;; and some KB ripped out of the Poirot ontology
;; Edited 11/16/10, added asdf items to simplify installation &
;; loading process -- charlieg
;; 12/9/10 ddm: some reorg to get the Sparser package defined earlier

;;--- Load asdf
;;--- NOTE: you should modify the paths in this section to match
;;--- the location where you installed Sparser

(in-package :cl-user)

;;--- ASDF setup

(require :asdf)
(unless (find-package :asdf)
  (load "~/Sparser/util/asdf.lisp")) ;; N.b. this one's pretty old

;; This assumes you have not other files on your registry already,
;; e.g. from an init file. Adjust it if you do. 
(setf asdf:*central-registry*
      '(*default-pathname-defaults*
        #p"~/Sparser/util/"   ;; ddm-util
        #p"~/Sparser/lisp/sfl/" 
    	#p"~/Sparser/Mumble/derivation-trees/" ;; mumble after sparser
        ))


;;--- Directory structure

(defparameter *nlp-home*
  (make-pathname :directory (pathname-directory *load-truename*)))
;; (setq *nlp-home* "/Users/ddm/ws/nlp/")


;;--- Predefine :sparser so it can be referred to early

(unless (find-package :sparser)
  (make-package :sparser
                :use '(common-lisp #+apple ccl)))
  

;;--- Loading

;; Load SFL so we can use the class-making shortcut
;; /// If that turns out to be all we use then lift that to util
(asdf:operate 'asdf:load-op :sfl)

;; Utilities used everywhere (though not integrated into Sparser yet 12/22/10)
(asdf:operate 'asdf:load-op :ddm-util)

;; Mumble
(load (concatenate 'string (namestring *nlp-home*) "Mumble/loader.lisp"))

;; Sparser 
(unless (boundp '*sparser-script-setting*)
  (defvar *sparser-script-setting* :fire))
(load (concatenate 'string 
		   (namestring *nlp-home*) 
		   "Sparser/code/s/init/scripts/"
		   (case *sparser-script-setting*
		     (:fire "fire")
		     (:checkpoint "checkpoint-ops"))
		   ;; Need formulation that could go to 'everything'
		   ".lisp"))

;; Mumble derivation tree using Sparser types
(asdf:operate 'asdf:load-op :mumble-after-sparser)





