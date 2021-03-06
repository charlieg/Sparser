;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1995  David D. McDonald  -- all rights reserved
;;; Copyright (c) 2006-2007 BBNT Solutions LLC. All Rights Reserved
;;; $Id: fpm.lisp 207 2009-06-18 20:59:16Z cgreenba $
;;;
;;;     File:  "dm&p"
;;;   Module:  "init;workspaces:"
;;;  version:  January 1995

;; broken out from [init;versions:v2.3a:workspace:in progress] 1/30/95
;; 11/06 onwards - used as staging ground for situation report message
;; processing.

(in-package :sparser)

;;;--------------------------
;;; traces / switch settings
;;;--------------------------

;(setq *do-domain-modeling-and-population* t)
;(setq *do-domain-modeling-and-population* nil)
;(setq *trace-DM&P* t)
;(setq *trace-DM&P* nil)
;(debris-analysis-setting)
;(DM&P-setting)
;(top-edges-setting/ddm)
; (lp# N) ;; lattice-point accessor

(sit-rep-setting)

;; only-tokenize-on-whitespace-or-punctuation
;; Print-discourse-history

;(setq *break-on-pattern-outside-coverage?* t)
;(setq *break-on-pattern-outside-coverage?* nil)
;(ed "objects;traces:DM&P") <<< wrap ed in an expander

;*switch-setting*
;*current-analysis-mode*

;//// make a custom version
;(switch-settings)
;(setq *annotate-realizations* nil)


;;;--------------
;;; test / to-do
;;;--------------

;; 1/11/94
(defun p/br (s)
  (pp s)
  (display-bracketed-segments))

;; (p/br "(J), page b1")
;;   the comma should stand by itself. Consider timing problem
;;   with processing of the parenthesis


;; 12/30/93
(defun fw (p)
  (setup-for-DJNS/1990-91)
  (f p))

;(fw "feb0;WSJ021.TXT")
;;  waiting on paragraph operations.
;;  Dies on "NL After Mr. Kennedy", where the preposition needs to
;;   be appreciated as such. 

(defun sr-3a ()  ;; (sr-3a)
  (p/br "primary mission of brigade: 197th inf boe (m)(s) deploys to saudi 
arabia to conduct sustained combat operations."))

(defun sr-4a ()  ;; (sr-4a)
  (p/br "dcus. patches continuing to be sewn on. issued only to advon and 
ship personnel; balance to be shipped forward to issue at forward staging 
base. boe still in bous."))

(defun sr-7 ()   ;; (sr-7)
  (p/br "training comments: will train from forward staging base from 
22 - 30 aug 90. plan has been established. working class v shortages. 
request dedicated mcoft beginning today through 30 aug 90. team from 
29th inf req on site to orchestrate m16a2  zero for 3,700 new weapons. "))


;;;------------
;;; test cases
;;;------------

(defun fire ()
;; Fire ravages London cinema
;; London -- 
  (pp "Fire swept through a private theater in central London
yesterday, killing at least seven people and injuring more 
than 20, fire officials said.  A Fire Brigade spokesman said
about 50 firefighters were at the four-story building, where
the cinema club occupied the top floor.  After three hours
the fire was under control, but not out.  It was not known
how many people were in the building at the time of the fire.  
The cinema was a small private club showing pornographic files,
according to initial reports."))  ;; (Reuters)
