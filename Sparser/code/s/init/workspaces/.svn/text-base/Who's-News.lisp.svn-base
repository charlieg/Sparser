;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1995-2005  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "Who's News"
;;;   Module:  "init;workspaces:"
;;;  version:  January 1995

;; broken out from [init;versions:v2.3a:workspace:in progress] 1/30/95
;; 3/14/05 renamed to Vinken/markup to distinguish it from the simpler
;; cases w/o markup

(in-package :sparser)

;;;------------------
;;; pending problems
;;;------------------

;; 3/21/94 -- titles re. "chief executive" vs. "chief executive officer"
;;  needs either a new analysis not based on polywords or polywords
;;  need to allow multiple rules:
#|(defparameter *polyword-routine*
                :multiple-completions
                ;; :single-completions
                )  |#


;;;---------------------------
;;; switches / trace settings
;;;---------------------------

;; for getting through 9/17/92
;(setq *break-on-pattern-outside-coverage?* t)
;(setq *break-on-pattern-outside-coverage?* nil)

;; for "President Bush ... the president"
;(setq *ignore-out-of-pattern-dereferencing* t)
;(setq *ignore-out-of-pattern-dereferencing* nil)




;;;-------
;;; cases
;;;-------

(defun vinken/markup ()
  (setup-for-dci/1989-wsj)
  (pp "<DOC>
<DOCNO>  891102-0193. </DOCNO>
<DD> = 891102 </DD>
<AN> 891102-0193. </AN>
<HL> Who's News:
@  Economist Newspaper Ltd. </HL>
<DD> 11/02/89 </DD>
<SO> WALL STREET JOURNAL (J) </SO>
<CO> WNEWS </CO>
<DATELINE> ECONOMIST NEWSPAPER Ltd. (London)  </DATELINE>
<TXT>
<p>
<s> Pierre Vinken, 61 years old, will join the board as a nonexecutive director Nov. 29. </s>
<s> Mr. Vinken is chairman of Elsevier N.V., the Dutch publishing group. </s>
</p>
</TXT>
</DOC>"))


(defun dci ()
  (setup-for-dci/1989-wsj)
  (f "Sparser:corpus:WSJ:DCI format:166-193.word"))
