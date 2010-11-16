;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:APPLE-INTERFACE -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "lingsoft features"
;;;   Module:  "interface;Apple:"
;;;  Version:  1.0 August 1994

;; n.b. This file is a repackaging of routines in the first release.


;;;-------------------
;;; Lingsoft features
;;;-------------------

(in-package :lingsoft)  ;; so that the symbols for the features will
                        ;; be in this package rather than 'apple'

(defparameter apple-interface::*part-of-speech-features*
              '( n v a adv
                 pcp1   ;; "ing"
                 pcp2   ;; "ed"
                 )
                 ;; ignoring: det wh prep pron cc cs
                 ;;   or generally any pos feature that would only
                 ;;   apply to a closed-class/function word that
                 ;;   should already be in the core vocabulary

  "a list of symbols that can appear in the dis.out file that name
   a word's part of speech. Any given word should receive only one
   of these.  Not every p.o.s. feature is included, just those that
   label open-class words." )




;;;-------------------------------------------------
;;; getting around complications in the data format
;;;-------------------------------------------------

#| Some of the features include colons, e.g. "<DEC:er>" on "computer".
   Since they are being 'read' from the file as symbols, these get 
   interpreted as indicating packages.

   We have three choices.  Change the algorithm to not use symbols, or
   to use them after some laundering.  To have the file filtered before
   it reaches this point so that these problematic features aren't
   included (..unfortunately we can't break into Lingsoft's black box
   and change their orthographic conventions).  Or to employ a foul hack
   and define all the 'packages' that their predefined, fixed set of
   features is going to require.  For the nonce I'll do that since it's
   markedly easier. 

   Note that if an unlisted (un-'exported') case occurs we'll get a
   Lisp error to the effect that the symbol is not external in the
   package.
|#
(eval-when (:execute :load-toplevel :compile-toplevel)
  (unless (find-package "<DER")
    (make-package "<DER")))

(in-package "<DER")

(export 'al> )  ;; <DEC:al>
(export 'ed> )  ;; <DEC:ed>
(export 'er> )  ;; <DER:er>
(export 'ic> )  ;; <DEC:ic>
(export 'ly> )  ;; <DEC:ly>
(export 'or> )  ;; <DEC:or>
(export 'ate> )   ;; <DEC:ate>
(export 'ble> )   ;; <DEC:ble>
(export 'bly> )   ;; <DEC:bly>
(export 'ing> )   ;; <DEC:ing>
(export 'ive> )   ;; <DEC:ive>
(export 'able> )  ;; <DEC:able>
(export 'ness> )  ;; <DEC:ness>
(export 'bility> )  ;; <DEC:bility>



;;;------------------------------------------------------------------
(in-package :apple-interface)

#| A comparable problem is Lingsoft's use of the occasional 'comma'.
   When using 'read' and interpreting features as symbols this
   will cause a "Comma not inside backquote" error.

   The simplest way around this seems to be to modify the readtable
   during the time this reading is being done.  
|#

(defparameter *readtable/comma-is-constituent* nil
  "Set to a copy of the standard Common Lisp readtable to be changed
   to fit the needs of the .dis interface.")


(defun de-fang-comma ()
  (let ((standard-cl-table (copy-readtable nil)))
        ;; guarenteed to get the real thing

    (setq *readtable/comma-is-constituent* standard-cl-table)

    ;; change comma to have the reader syntax of lowercase a
    (set-syntax-from-char
     #\,                               #\a
     *readtable/comma-is-constituent*  standard-cl-table)))

