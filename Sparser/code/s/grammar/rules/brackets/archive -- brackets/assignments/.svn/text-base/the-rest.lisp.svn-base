;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1991,1992,1993,1994  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "assignments"
;;;   Module:  "grammar;rules:brackets:"
;;;  Version:  January 1994

;; initiated 4/26/91, extended 4/28,10/2
;; Required assignments to the source start/end pulled 11/24
;; (12/17/92 v2.3) pulled the assignments on function words
;;  and moved them to there [words;] files.  1/11/94 added more cases

(in-package :sparser)


;;;--------------------
;;; (...), "..." <...>
;;;--------------------

(assign-bracket  open-paren  ].phrase )
(assign-bracket  open-paren  phrase.[ )
(assign-bracket  close-paren  ].phrase )
(assign-bracket  close-paren  phrase.[ )

(assign-bracket  open-angle-bracket  ].phrase )
(assign-bracket  open-angle-bracket  phrase.[ )
(assign-bracket  close-angle-bracket  ].phrase )
(assign-bracket  close-angle-bracket  phrase.[ )

(assign-bracket  double-quote  ].phrase )
(assign-bracket  double-quote  phrase.[ )


;;;----------------
;;;  ","  ";"  ":"
;;;----------------

(assign-bracket  comma  ].punctuation )
(assign-bracket  comma  punctuation.[ )

(assign-bracket  semi-colon  ].punctuation )
(assign-bracket  semi-colon  punctuation.[ )

(assign-bracket  colon  ].punctuation )
(assign-bracket  colon  punctuation.[ )


;;;---------------
;;; "."  "?"  "!"
;;;---------------

(assign-bracket  period  ].phrase )
(assign-bracket  period  phrase.[ )
(assign-bracket  period  phrase]. )

(assign-bracket  question-mark  ].phrase )
(assign-bracket  question-mark  phrase.[ )
(assign-bracket  question-mark  phrase]. )

(assign-bracket  exclamation-point  ].phrase )
(assign-bracket  exclamation-point  phrase.[ )
(assign-bracket  exclamation-point  phrase]. )


;;;---------
;;;  "'s"
;;;---------

(assign-bracket  apostrophe-s  ].phrase )
(assign-bracket  apostrophe-s  phrase]. )
(assign-bracket  apostrophe-s  phrase.[ )

