;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1997-2003  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "Magi loader"
;;;    Module:   "init;"
;;;   version:   May 2003

;; initiated 11/29/97. Revised to put in slap dash lspec interface 7/26/98.
;; Adjusted 2/15/99 to incorporate Mumble loading in lieu of Ravel. 3/13
;; turned off *load-the-corpus*. 6/12 added Stravinsky loader. 9/4 Made the
;; pre-defined locations more thorough so it would be easier to move between
;; machines. 1/3/00 Moved the Magi workspace so it would load here as the
;; last thing that happened. 6/24 added binding for *edges-from-referent-categories*.
;; 2/22/01 Moved the definition of the magi-workspace up to the front so it
;; could get exposed (edited) right away to aid in debugging stuff that blows
;; up during the course of a load. 6/10/03 Switched path constants over to the
;; G4 upstairs.

(in-package :cl-user)

;;---- Utility

(defmacro def-string (&rest strings)
  `(concatenate 'string ,@strings))

(export 'def-string (find-package :cl-user))


;;;---------------------------
;;; Platform-specific globals
;;;---------------------------

;; !!! n.b. The hard-coded location of Mumble also has to be changed.
;; See NLG;Mumble-86:defsystem-definition.lisp

(unless (boundp 'nlg-directory)
  (defparameter nlg-directory  ;; for multiple evaluation
    "G4:Users:ddm:nlp:NLG:"
    ;;"g3:mine:NLG:" ;; note the final colon
    ;; "Moby:NLG:"
    ))

(unless (boundp 'mumble-directory)
  (defparameter mumble-directory
    (def-string nlg-directory
      "Mumble-86:Mumble-86:")))


(unless (boundp 'location-of-sparser-directory)
  (defparameter location-of-sparser-directory
    #+apple "G4:Users:ddm:nlp:Sparser:"  ;;"g3:mine:Sparser:"
    #+unix "/net/kadmos/u12/rag/sparser/Sparser/"  
    ))


(unless (boundp '*location-of-Stravinsky-directory*)
  (defparameter *location-of-Stravinsky-directory*
    "G4:Users:ddm:nlp:NLG:Stra:"
    ;;"g3:mine:NLG:Stra:"
    ;; "moby:NLG:Stra:"
    ))


(defparameter magi-workspace 
  (def-string cl-user::NLG-directory "workspace:Magi"))
(ed magi-workspace)

;;;-----------------
;;; loading Sparser
;;;-----------------

;;--- Sparser's package

(make-package :sparser
              :use #+:apple '(ccl common-lisp)
                   #+:unix  '(lisp))

;;---- specializations to how Sparser is loaded

(defparameter sparser::*lattice-points* t)
(defparameter sparser::*no-image* t)
(defparameter sparser::*edges-from-referent-categories* t)

(defparameter sparser::*connect-to-the-corpus* nil)
;; expediency while g3 isn't all loaded up

;;--- do it

(load (def-string
        cl-user::location-of-sparser-directory
        "code:s:init:everything"))

(ed (def-string
      cl-user::location-of-sparser-directory
      "code:s:grammar:model:dossiers:loader"))

(sparser::lload "lisp;exports")


;;;----------------
;;; loading Mumble
;;;----------------

;(load "Moby:NLG:Sage:Spokesman:load everything")
;(ed "Moby:NLG:Sage:Spokesman:Ravel:resource-object-types.lisp")

(load (def-string nlg-directory "load NLG"))


(load (def-string nlg-directory "Stra:load Stravinsky"))



;;;------------------
;;; load Magi proper
;;;------------------

#|(load (def-string
        cl-user::location-of-sparser-directory
        "Magi:"
        "loader"))|#



;;;--------------------
;;; load the workspace
;;;--------------------

(load magi-workspace)

