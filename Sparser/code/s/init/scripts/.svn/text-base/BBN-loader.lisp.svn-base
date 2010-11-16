;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; copyright (c) 1997  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "load Sparser"
;;;    Module:   "Sparser;"
;;;   version:   August 1997

(in-package :cl-user)

;; This file bootstraps the loading of the Sparser System from a directory
;; of files.  To use it, modify the hard pathname that it contain. Follow
;; the instructions below to adapt the other pathname strings, and then
;; load this file, as modified, from a running Lisp image.

;; 0.1 (8/24) Removed redundant reference to *unix-file-system-inside-mac* 
;;      Modified the hard pathnames to be sensitive to the OS flag (apple vs. unix)
;;      (re. slashes vs. colons).

;;--- Sparser's package
(make-package :sparser
              :use #+:apple '(ccl common-lisp)
                   #+:unix  '(lisp))



;; 1st. Make this full pathname have the right prefix according to
;; where you have put the Sparser directory.  

(defparameter cl-user::location-of-sparser-directory
  #+apple "Sparser:"  ;; note the colon
  #+unix "/net/kadmos/u12/rag/sparser/Sparser/"  
  )


;; 2d. Compile the system. Adapt the constructed pathname just
;; below.  Subsitute slashes for the colons if running under
;; unix.  Note that you are loading a file in the "s" (for source)
;; directory of Sparser's code. 


;; This flag has the obvious meaning, and it controls a number
;; of parameter values within the system.  Set it to "t" once
;; you have made the compilation run

(defparameter sparser::*Sparser-has-been-compiled* nil)  ;; t


(load (concatenate 'string
        cl-user::location-of-sparser-directory
        #+apple "code:s:"
        #+unix  "code/s/"
        #+apple "init:scripts:compile-BBN" 
        #+unix  "init/scripts/compile-BBN"
        ))


;; 3d. The compilation process will have populated the "f" directory
;; of Sparser's code. The files in that directory will also have
;; extensions: they will be either of the two choices shown as they
;; are stipulated by a parameter in the code rather than by a
;; default in the compiler.  
;;
;; The "s" directory tree is now superfluous. You are to delete it
;; as soon as you have used this alternative to load Sparser
;; successfully.  This is a condition of your license.
;;
;; Comment out the call above that loads the compile script.
;; Uncomment the call below that loads the "f" (for fasl) loading
;; script that has been tailored to your Sparser license. Use
;; this alternative from here on out every time you want to load
;; Sparser.  Don't forget to convert the file delimiters if 
;; necessary. 

;(load (concatenate 'string
;        cl-user::location-of-sparser-directory
;        #+apple "code:f:"
;        #+unix  "code/f/"
;        #+apple "init:scripts:BBN"
;        #+unix  "init/scripts/BBN"
;        #+apple ".fasl"     ;; default for MCL
;        #+unix  ".mbin"     ;; usually default for Lucid
;        ))


;; This call should also be uncommented and exposed to run
;; as part of a compiled load. It establishes the Sparser-
;; internal switch setting appropriate to your license
;(sparser::segmenter-settings/bbn)

