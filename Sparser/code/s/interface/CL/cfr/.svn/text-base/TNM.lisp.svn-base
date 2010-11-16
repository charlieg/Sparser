;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(interface-testing LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "TNM"
;;;   Module:  "interface;PRW:rules:"
;;;  Version:   1.0   August 1990
;;;

(in-package :interface-testing)


(import '(CTI-source:Def-cfr
          CTI-source:Def-cfr/multiple-rhs
          )
        (find-package :interface-testing))


;;;----------------------
;;;  "state of the deal"
;;;----------------------

(def-cfr agreed-to ("agreed to"))  ;; (tnm2)

;; variation on that theme for "sell"
(def-cfr/multiple-rhs state-of-deal/equi-verb
                      (( "agreed to" )
                       ( "expects to" )
                       ( state-of-deal/equi-verb "complete the" )
                       ))

;;;---------
;;; acquire
;;;---------

(def-cfr/multiple-rhs acquisition
                      (( "acquire" )
                       ( agreed-to acquisition)  ;; (tnm1)
                       ( "will" "acquire" )      ;; (tnm2)
                       ( "to"   "acquire" )      ;; (tnm2)
                       ( "acquisition" )         ;; (tnm3)
                       ( "acquired" )            ;; (tnm3)
                       ))

(define-association-with-topic 'acquisition 'acquisition)


;;;------
;;; sell
;;;------

(def-cfr/multiple-rhs sell
                      (( "sell" )
                       ( "sale of" )
                       ( state-of-deal/equi-verb sell )
                       ))

(define-association-with-topic 'sell 'selling)


;;;---------------------------------
;;; value of financial transactions
;;;---------------------------------

(def-cfr/multiple-rhs transaction-value
                      (("in a transaction valued at")
                       ))

(define-association-with-topic "Terms weren't disclosed"
                               'deal-terms)

(define-association-with-topic 'transaction-value 'deal-terms)


