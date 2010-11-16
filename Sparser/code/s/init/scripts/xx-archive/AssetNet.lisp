;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(USER LISP) -*-
;;; copyright (c) 1991,1992  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "AssetNet"
;;;    Module:   "init;scripts:"
;;;   version:   January 1992

;; This file sets up the parameter settings to load the code
;; and grammar for the AssetNet application.
;;
;; Note the hard pathname in the call that loads "everything"

(in-package :user)

#|  Directory layouts:

    On the Mac
       Sparser:DEC:init
                       (with version's directories collapsed in)
                   s
                   f

    On the DecStation
       ~sparser/s
                c
                init
|#

;;;--------------------
;;; define the package
;;;--------------------

(or (find-package :sparser)
    (make-package :sparser
                  :nicknames '(:CTI-source :cs) ;; former spellings
                  :use #+:apple '(ccl lisp)
                       #+:unix  '(lisp)
                       ))

;; n.b. a spelling change is gradually being promulgated, and
;; the old spelling of the main package will remain until it
;; has completed.
(or (boundp 'sparser::*CTI-source-package*)
    (defconstant sparser::*CTI-source-package*
                   (find-package :sparser)))


;;;----------------------
;;; setup the parameters
;;;----------------------

(defparameter sparser::*load-the-grammar* t)

(defparameter sparser::*suborn-non-unix-file-characters* t)

(defparameter *case-conversion* :no-conversion)

(defparameter sparser::*nothing-Mac-specific* t)

(defparameter sparser::*load-AssetNet-interface* t)

(defparameter *unix-file-system-inside-mac* t)
(defparameter *unix-file-system* nil)


;; This script is also used when there is a compile directory
;; tree. To get things right there we have to have bindings for
;; the parameters used to construct those versions of the file
;; names

;; find the source in
(defparameter sparser::*source-root*
              ;; #+:apple  "moby:Sparser:code:s:"
              #+:apple  "moby:Sparser:DEC:s:"
              #+:unix   "usr:users:guest:sparser:s:"
              )
;; find the binaries in
(defparameter sparser::*root-for-binaries*
              ;; #+:apple  "moby:Sparser:code:f:"
              #+:apple  "moby:Sparser:DEC:c:"
              #+:unix   "usr:users:guest:sparser:c:"
              )

;; use this extension on the binary files
;; n.b. the periods are added when the filename is assembled
(defparameter sparser::*fasl-extension*
              #+:apple  "FASL"
              #+:unix   "mbin"
              )


;;;-------------
;;; do the load
;;;-------------

(load  ;; #+:apple "Moby:Sparser:code:init:everything"
       #+:apple "Moby:Sparser:DEC:init:everything"
       #+:unix "/usr/users/guest/sparser/init/everything"
       )

