;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1994,1995  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "Apple Loader"      ;; "Load Sparser" when used at toplevel
;;;    Module:   "init;scripts:"
;;;   version:   July 1995

;; Last substantive changes 9/94 at "Sparser:" or "init;" level, 
;; adapted to new locations 7/6/95

(in-package :cl-user)

;; All this file does is set one parameter and initiate the loading process. 
;; You have to change the file namestrings below to match where you have 
;; put the Sparser directory. The namestrings have to start with the 
;; desktop volume -- in the example the volume is a disk partition named
;; "Sparser"


(setq *features*
      (push :apple-doc *features*))


;;--- package for Apple interface

(make-package :apple-interface
              :nicknames '(:apple))

;;--- Sparser's package
(make-package :sparser
              :use '(ccl common-lisp))


;;----------------- specialize these hard filenames -------------------

(defparameter cl-user::location-of-root-directory  ;; flush for delivery /////////////
              "Sparser:")


(defparameter cl-user::location-of-sparser-directory
              "Sparser:"

  "The location of the Sparser directory as an explicit filename
   with no logicals or wildcards. Note the final colon.")


(defparameter sparser::*Apple-documents-directory*
              "Corpora:Apple documents:"

   "The location of a standard set of test documents" )



;;----------------- specialize this too

(defparameter sparser::*monitor-size* :20-inch)  ;; 14-inch 



;;------ do the load

(load (concatenate 'string
                   cl-user::location-of-sparser-directory
                   "code:"
                   "s"  ;; "f" ;; //////////////////////////////////
                   ":init:scripts:v2.3a")) ;;.fasl

