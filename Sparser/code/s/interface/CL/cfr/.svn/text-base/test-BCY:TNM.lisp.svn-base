;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(interface-testing LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "test BCY"
;;;   Module:  "interface;PRW"
;;;  Version:   1.1  January 1991
;;;

;;1.1  (1/4, v1.7)  Pathname changes

(in-package :interface-testing)


(import '(CTI-source:Close-character-source-accidentally-left-open
          CTI-source:analyze-text-from-string
          CTI-source:Analyze-text-from-file
          CTI-source:Display-all-cfrs
          )
        (find-package :interface-testing))


;;;------------------------------------------------------------------
;;; shell that gets the setup for wsj/djns/sissor paragraphs correct
;;;------------------------------------------------------------------

(defun text-excerpt (string)
  (close-character-source-accidentally-left-open)
  (let ((cs::*initial-region* :text-body))
    (analyze-text-from-string string)))



;;;----------------
;;; whole articles
;;;----------------

(defun T013 ()  ;; Southmark vs. Evergreen battle over control
  (analyze-text-from-file "C&L;cfr:CFR test articles:9007100013"))
; (T013)

(defun T028 ()  ;; Conseco acquiring Lomas life insurance group
  (analyze-text-from-file "C&L;cfr:CFR test articles:9007110028"))
; (T028)

(defun T091 ()  ;; MCorp selling one of its banks
  (analyze-text-from-file "C&L;cfr:CFR test articles:9007120091"))
; (T091)


;;;-----------------------------------
;;; Bankruptcy -- specific paragraphs
;;;-----------------------------------

; (bcy1)
(defun bcy1 ()   ;; extracted from 900712-0091
  (text-excerpt "
             MCorp, which has been operating under federal
          bankruptcy-court protection since last year when federal
          regulators seized most of its banks, said "))


; (bcy2)
(defun bcy2 ()   ;; extracted from 900711-0028
  (text-excerpt "
             Conseco said the planned transaction is subject to
          approval by the bankruptcy court that has jurisdiction over
          Lomas's proceedings under Chapter 11 of the federal
          Bankruptcy Code, which protects the company from creditors'
          lawsuits while it forms a plan to repay debts, and by various
          states' insurance regulatory agencies."))


; (bcy3.1)
(defun bcy3.1 ()
  (text-excerpt "
             But when tax-law changes stalled syndication sales and a
          real-estate recession depressed asset values, Southmark's
          cash flow disappeared. Short of funds, it sought
          bankruptcy-law protection in July 1989. Meanwhile, its
          continued cash bind and its need to cut staff left it
          ill-prepared to aid its 335 public and private partnerships
          or advise the 145,000 people who invested $2 billion in the
          partnerships."))

; (bcy3.2)
(defun bcy3.2 ()
  (text-excerpt "
             The negotiations have an added urgency because of hearings
          scheduled this week on the confirmation of Southmark's
          proposed reorganization plan under Chapter 11 of the U.S.
          Bankruptcy Code. Southmark and its attorneys are scurrying to
          clear up any potential hurdles that could trip up the plan."))

; (bcy3.3)
(defun bcy3.3 ()
  (text-excerpt "
             Certainly, many of Southmark's partnership investors would
          like a change. Since Southmark initiated Chapter 11
          bankruptcy reorganization a year ago, it has stopped
          subsidizing distributions to partners and halted mortgage
          payments on some properties, putting them in danger of
          foreclosure. Auditors have questioned whether many of the
          partnerships can continue as going concerns."))



;;;-----------------------------------------
;;; tenders, mergers, and acquisition (TNM)
;;;-----------------------------------------

; (tnm1)
(defun tnm1 ()  ;;from 7/11, #28
  (text-excerpt "
             CARMEL, Ind. -- Conseco Inc. said it agreed to acquire the
          life insurance group of Lomas Financial Corp., a Dallas-based
          mortgage banking concern, in a transaction valued at $165
          million."))

; (tnm2)
(defun tnm2 ()  ;;from 7/11, #28
  (text-excerpt "
             Conseco, an insurance holding company, said it will
          acquire the group through Conseco Capital Partners Limited
          Partnership, which it created with institutional investors to
          acquire and operate life insurance companies."))

; (tnm3)
(defun tnm3 ()  ;;from 7/11, #28
  (text-excerpt "
             The proposed purchase would be the second acquisition made
          through Conseco Capital Partners. Late last month, the
          partnership acquired Great American Reserve Insurance Co.
          from Temple-Inland Inc., Diboll, Texas, for $143.5 million."))

; (tnm4)
(defun tnm4 ()  ;;from 7/12, #91
  (text-excerpt "
             DALLAS -- MCorp, a bank holding company, said it
          definitively agreed to sell its Waco, Texas, bank to a
          private investor group led by Gerald J. Ford, a Texas banker
          who also heads First Gibraltar Bank, the state's largest
          thrift. Terms weren't disclosed."))

; (tnm5)
(defun tnm5 ()  ;;from 7/12, #91
  (text-excerpt "
             MCorp, which has been operating under federal
          bankruptcy-court protection since last year when federal
          regulators seized most of its banks, said it expects to
          complete the sale of the Waco bank by year end. MCorp said
          the unit has assets of $333 million."))
