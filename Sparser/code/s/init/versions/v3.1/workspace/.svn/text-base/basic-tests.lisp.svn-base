;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1991,1992,1993  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "basic tests"
;;;   Module:  "init;versions:<current version>:workspace"
;;;  version:  December 1992

;; initialized 10/30, basic threading cases initiated 11/12,
;; corpora setup 11/25, inner timing loops 1/14

(in-package :sparser)

;;;------------------------------------------
;;; basic threading of the parsing algorithm
;;;------------------------------------------

; (p "")


;;;--------------------
;;; timing inner loops
;;;--------------------

;(test_max-testing-speed)
;; clocks the loop and counters that are used in the other tests.
;; Sometimes the loop is too fast and we get a "can't divide by zero" error

;(def-logical-pathname "Eastern;" "corpus;DJNS format:banruptcy:Eastern:")
;(load "Eastern;string to call")     -> Eastern-as-string

;(defparameter *test-string* Eastern-as-string)
;(p *test-string*)

;(test_aref/one-buffer)
;; clocks the inner loop of the character buffer -- how fast
;; can we walk through one buffer's worth 

;(test_Next-char/whole-article)
;; uses actual Next-char code and does as many 

;;;--------------- ////////////// old stuff - may not be in sync ///////

;;----------- brute force "getting through" large corpora

;(batch-run '|Tipster test articles|)
;(batch-run '|2 product announcements|)
;(batch-run '|London Stock Exchange|)
;(batch-run '|WSJ ERN articles|)
;(f "ERN;4/3/91 DowVision dump")   ;; file is 62k !!
;(batch-run '|1st 15 of Who's News test|)


;;--------- Who's News
;(length (setq files (files-in-directory "Dec 2;")))
;(first (setq files (nthcdr 61 files)))
;(f (setq *current-article* (pop files)))
;(f *current-article*)
;
;(preempt-all-fns-that-stop-execution 'abort-article/batch)
;(batch-run '|typed|)
;(batch-run '|WSJ batch #1|)
;(batch-run '|1st December batch|)
;(restore-original-break-error-&-cerror-definitions)



;;----------- basic CFR functionality
; (p "was named senior vice president")
; (setq *initial-region* :text-body)
; (defparameter *test-string* "was named senior vice president")
; (establish-psp-test-grammar)


;;---------- word frequency

;(load "grammar;tests:frequency strings")  ;; *boeing*

(when *load-the-grammar*
  (defun wfs (string)
    (word-frequency-setting)
    (initialize-word-frequency-data)
    (let ((*initial-region* :text-body))
      (analyze-text-from-string string))
    (readout-frequency-table))
  )


;;------------ Paragraphs 
;(establish-document-source-type :WSJ/DJNW/sissor)
;(setup-context-for-this-run)
#| (p "AN        900712-0091.
HL           MCorp to Sell a Texas Bank
DD        07/12/90
TX           DALLAS -- MCorp, a bank holding company, said it
          definitively agreed to sell its Waco, Texas, bank to a")
|#

