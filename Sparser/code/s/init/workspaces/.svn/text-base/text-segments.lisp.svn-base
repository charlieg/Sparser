;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1995  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "text segments"
;;;   Module:  "init;workspaces:"
;;;  version:  January 1995

;; broken out from [init;versions:v2.3a:workspace:in progress] 1/30/95

(in-package :sparser)


;; 12/31/93, 1/3/94
(defun b ()
  (use-stack-sensitive-Newline-FSA)
  (initialize-NL-position-stack)
  (pp
"HL        AIRLINES (AIR)
       *  BANKRUPTCIES (BCY)
TX           There's just no pleasing some people; ask Eastern
          Airlines.
             Its promotion promising 100% refunds to dissatisfied
          full-fare passengers has spawned some creative complaining."))
;;
;; for testing NL routines that deduce indentation and paragraphing,
;; See Draw-paragraphing-conclusions


;; 12/30/93
(defun s ()
  (setup-for-typed/no-headers)
  (f "tipster;JV corpus:0368.372"))
;; a known text with sgml and simple indentation with double spacing
;;   dies instantly with wrong number of args w/in Start-document-start-section




#|(define-document-stream 'test1
    :file-list '( "feb0;WSJ002.TXT" )
    :style-name 'Dow-Jones-New-Service/1990-91 )  |#
;; 12/28/93 -- trivial test of running document streams.
;;   Stubs on accessing time from the AN, and on interning a real
;;   article with a switch to a known article object once the AN
;;   information becomes available. 
;; (setq ds *)
;; (analyze-document-stream ds)
;; Stubs return nil in Find-djns-assession-number-in-region
;;  and Redo-current-article-as-djns


;(p "<SO>     Copyright (c) 1990 Kyodo News Service  </SO>")
; 11/6/93  calls beyond eos
; 11/24  needs a company out of "Kyodo News Service" in order for the
;   analysis to go through.


(defun sg ()  ;; for testing Tipster SGML
  (f "tipster tests;0368.372") )


(defun t1 ()  ;;for testing SGML tags
  (p "<s>\"Clearly, we were shot in the back . . . as we battled 
to protect the taxpayers,\" said William Black, acting 
district counsel for the San Francisco region of 
thrift regulators. </s>"))

(defun t2 ()
  (p "
<so> WALL STREET JOURNAL (J) </so>
"))


(defun wsj1 ()
  (f "Who's News DCI;891102-0192"))
(defun wsj2 ()
  (f "Who's News DCI;891102-0193"))

