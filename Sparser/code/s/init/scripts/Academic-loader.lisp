;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1994-1996  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "Academic version"
;;;    Module:   "init;scripts:"
;;;   version:   June 1996

(in-package :cl-user)

;; All this file does is set one parameter and initiate the loading process. 
;; You have to change the file namestrings below to match where you have 
;; put the Sparser directory. The namestrings have to start with the 
;; desktop volume -- in the example the volume is a disk partition named
;; "Sparser"


;;--- setup Sparser's package

(unless (find-package :sparser)
  (make-package :sparser
                :use '(ccl common-lisp)))


;;----------------- specialize these hard filenames -------------------

(defparameter cl-user::location-of-sparser-directory
              "Sparser:"  ;; <-- change this to fit your situation

  "The location of the Sparser directory as an explicit filename
   with no logicals or wildcards. Note the final colon.")


(defparameter sparser::*Apple-documents-directory*
              "Corpora:Apple documents:"  ;; <-- change this or set it to Nil

   "The location of a standard set of test documents" )



;;---------- set these as appropriate to your situation ---------

(defparameter cl-user::*end-user-owns-a-copy-of-mcl* t)

(defparameter sparser::*monitor-size* :20-inch)  ;; :14-inch  :8-inch



;;------ do the load

(load (concatenate 'string
                   cl-user::location-of-sparser-directory
                   "code:"
                   "s"  ;; "f" ;; //////////////////////////////////
                   ":init:scripts:v2.3ag")) ;;.fasl

