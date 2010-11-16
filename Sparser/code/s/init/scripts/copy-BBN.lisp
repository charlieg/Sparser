;;; -*- Mode:Lisp; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP)
;;; copyright (c) 1997  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "copy BBN"
;;;   module:  "init;scripts:"
;;;  version:  August 1997

;;; This file will copy all the files referenced in a designated load to a new
;;; 'target' location. It is intended to be launched from toplevel, and to be
;;; modified ad-hoc whenever a different script (load-definer) and target is
;;; needed. Note all the hard pathnames

;; cloned from [copy everything] 8/17/97.

(in-package :cl-user)

;;;--------------------
;;; define the package
;;;--------------------

(unless (find-package :sparser)
  (make-package :sparser
                :use #+:apple '(ccl common-lisp)
                     #+:unix  '(common-lisp)
                ))

(in-package :sparser)

;;;----------------------
;;; setup the parameters
;;;----------------------


;;--- parameters that make LLoad copy rather than load

(defparameter *copy-file*  t
  "flag read by lload to shunt it to the right routines")

(defparameter *copy-to-unix-format?* t
  "Does what it says -- adjusts the filenames that are made by LLoad.")


;;--- parameters to override any switch settings in the load script that
;;    would stop the process prematurely.

(defparameter *sparser-is-an-application?* nil)
(defparameter *load-the-grammar* t)
(defparameter *delayed-loading-of-the-grammar* nil)



;;;-------------
;;; do the copy
;;;-------------

;;--- parameters to determine where we're copying to and what load script
;;    we're using to determine what files we copy.


;;------------ Specialize this one ------------
(defparameter *target-root-for-copy* 
  '("Moby" "xx-archive"      ;; local for testing
    "BBN-8/20/97"
    "Sparser" "code" "s" )
  #+ignore
  '("Sparser for BBN"        ;; Zip drive for delivery
    "Sparser" "code" "s" )
  )


(defparameter sparser::*Sparser-has-been-compiled* nil)
;; otherwise we wouldn't be doing this step.


;;------------ and this one ------------
(load  #+:apple "Sparser:code:s:init:scripts:BBN")




;; Do these by hand, since they are loaded with "load" rather than "lload"
;; and won't have been seen.

(copy-source-to-new-root "init;everything")

(copy-source-to-new-root "init;Lisp:kind-of-lisp")
(copy-source-to-new-root "init;Lisp:grammar-module")
(copy-source-to-new-root "init;Lisp:ddef-logical")
(copy-source-to-new-root "init;Lisp:lload")

(copy-source-to-new-root "init;scripts:BBN loader")
(copy-source-to-new-root "init;scripts:BBN")
(copy-source-to-new-root "init;scripts:compile BBN")

(copy-source-to-new-root "version;loaders:grammar")
(copy-source-to-new-root "version;loaders:grammar modules")
(copy-source-to-new-root "version;loaders:lisp-switch-settings")
(copy-source-to-new-root "version;loaders:logicals")
(copy-source-to-new-root "version;loaders:master-loader" :do-not-copy-contents t)
(copy-source-to-new-root "version;loaders:stubs")

(copy-source-to-new-root "version;salutation")
(copy-source-to-new-root "version;updating")

(copy-source-to-new-root "config;launch")
(copy-source-to-new-root "config;load")

(copy-source-to-new-root "grammar-configurations;bbn")

:finished-copying

