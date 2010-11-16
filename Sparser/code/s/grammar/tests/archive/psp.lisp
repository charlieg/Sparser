;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1992  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "psp"
;;;   Module:  "grammar;tests:"
;;;  version:  0.0 October 1992

;; initiated 10/5/92 v2.3,  added meta-point fns 10/16

(in-package :sparser)

(defun grammar-tests ()) ;; for meta-point

(defun setup-only (string)
  (establish-character-source/string string)
  (initialize-tokenizer-state)
  (initialize-chart-state)
  (per-article-initializations)
  )

#|

(Establish-kind-of-chart-processing-to-do :new-toplevel-protocol)
(top-edges-setting)
(debris-analysis-setting)

(setq *demo-output* *standard-output*)
(setq *demo-output* nil)  ;; next time after it will make a window


(p "")

;*left-segment-boundary*
;*right-segment-boundary*

;(setq *use-Segment-edges-as-segment-defaults* t)
;(setq *use-Segment-edges-as-segment-defaults* nil)
;(setq *trace-network* t)
;(setq *trace-network* nil)
;(setq *trace-fsas* t)
;(setq *trace-fsas* nil)
;(setq *trace-check-edges* t)
;(setq *trace-check-edges* nil)
;(setq *parse-edges* t)
;(setq *parse-edges* nil)

;;---------------------------------------------------------
;; assuming numbers are loaded, these test the number fsa
;; and indirectly the threading of psp

;; predefined
(p "2")

;; new
(p "37")

;; compound -- exercises the branches of the fsa
(p "76.1")

;; the second time around you're exercising the polyword that
;; was built for the number the first time it was parsed.
(p "76.1")


;;-----------------------------
;; testing simple binary rules
(p "50%")
  ;; n.b. this won't form the percent edge until it reaches the
  ;; treetop level since the rightmost-edge criteria is so conservative



;;--------------
;; proper names

;(setq *break-on-pattern-outside-coverage?* t)
;(setq *break-on-pattern-outside-coverage?* nil)


|#

;;;--------------------
;;; canonical articles
;;;--------------------

(defun belmoral ()
  (pp "BELMORAL MINES Ltd. (Toronto) -- J. Gordon Strasser, acting president 
and chief executive officer of this gold mining company, was confirmed in 
the posts, succeeding Kenneth Dalton, who retired as chairman and chief 
executive officer, and Clive Brown, who retired as president.  Messrs. Dalton
and Brown remain directors.  A new chairman wasn't named."))

(defun yoshi ()
  (pp "Yoshinoya D & C Co. will develop a Japanese food restaurant chain in 
Hong Kong, the Tokyo-based company said Wednesday.  Yoshinoya will set up a 
joint venture there with Mitsubishi Corp., Mitsubishi Corp. (Hong Kong) Ltd. 
and Hop Hing Holdings Ltd., a Hong Kong-based food producer, said the food 
chain operator, which specializes in \"gyudon\" boiled beef on rice.  Hong Kong 
will be Yoshinoya's third overseas market following 11 outlets in Taiwan and 
44 restaurants in the United States, company officials said.  The joint 
venture, whose corporate name has not yet been decided, will be capitalized 
at 10 million Hong Kong dollars, of which 70% will be provided by Hop Hing, 
15% by Yoshinoya and 7.5% each by Mitsubishi and its Hong Kong unit, they 
said.  Under a franchise contract with Yoshinoya, the new gyudon company 
plans to open 12 outlets in Hong Kong and Macau and achieve annual sales of 
one billion Yen in three years, the officials said."))

