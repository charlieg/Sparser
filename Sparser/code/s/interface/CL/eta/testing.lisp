;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(interface-testing LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "testing"
;;;   Module:  "interface;PRW"
;;;  Version:   1.2  September 1990
;;;

(in-package :interface-testing)

;; Changelog:
;;   1.1  Minor changes to make the file more usable as a workspace.
;;        Added delete expressions for all the association expressions.
;;        Added tprw4 to test running the analyzer from an open stream.
;;        Added trpw3 to test turning off paragraph detection by binding
;;        the global flag
;;   1.2  Incorporated the new deletion routine as a variant


(import '(;; from the prw;eta: files
          CTI-source:Define-association-with-topic
          CTI-source:Define-association-with-topics
          CTI-source:Define-topic-associations
          CTI-source:Delete-association-with-topic
          CTI-source:Delete-association-of-evidence-with-topic
          CTI-source:Delete-all-ETAs
          CTI-source:Display-all-etas

          ;; from the analysis engine
          CTI-source:Analyze-text-from-string
          CTI-source:Analyze-text-from-file
          CTI-source:Analyze-text-from-open-file
          CTI-source:*display-word-stream*
          CTI-source:Close-character-source-accidentally-left-open
          CTI-source:Terminate-chart-level-process
          CTI-source:*announce-paragaph-starts*
          )
        (find-package :interface-testing))


;;;--------
;;; basics
;;;--------

; (tprw1)
(defun tprw1 ()
  "A self-contained test.  The evidence-topic associations are
   made as part and then deleted within the routine.  Also exercises
  the global flag that controls whether the text of the article under
  analysis is printed to the lisplistener as it is scanned.  Only a
  single line of text is analyzed, with no embedded newlines.  Only
  a word and a polyword are defined as evidence, not any nonterminal
  categories."
  (make-test-associations-for-tprw1)
  (terpri)
  (let ((*display-word-stream* nil))
    (analyze-text-from-string
     "Boeing Co. said the U.S. government has suspended the sale"))
  (delete-test-associations-for-tprw1))


(defun Make-test-associations-for-tprw1 ()
  (define-association-with-topic "said" 'report)
  (define-association-with-topic "U.S." 'United-States))

(defun Delete-test-associations-for-tprw1 ()
  ;; uses both forms of the deletion routine
  (delete-association-with-topic "said" 'report)
  (delete-association-of-evidence-with-topic "U.S." 'United-States))



;;;-----------------------
;;; operation from files
;;;-----------------------
;; n.b. the logical "prw;" has a default definition in the analysis
;; engine as "CTI-code;interface:prw:"


; (tprw2)
(defun tprw2 ()
  "Runs over the first file in the bankruptcy set"
  (close-character-source-accidentally-left-open)
  (associations-for-tprw2)
  (analyze-text-from-file "prw;eta:test files:bcy1 djns/sissor")
  (delete-associations-for-tprw2))



(defun Associations-for-tprw2 ()
  ;; this hits early in the article
  (define-topic-associations 'bankruptcy
    '("bankruptcy-court"
      "Eastern"))
  ;; this hits quite late in the article
  (define-association-with-topic "frequent-flier" 'late-test)
  )


(defun Delete-associations-for-tprw2 ()
  (delete-association-of-evidence-with-topic "bankruptcy-court"
                                             'bankruptcy)
  (delete-association-of-evidence-with-topic "Eastern"
                                             'bankruptcy)
  (delete-association-of-evidence-with-topic "frequent-flier"
                                             'late-test)
  )

;;;------------
;;; paragraphs
;;;------------

; (tprw3)
(defun tprw3 ()
  "Identical to tprw2 except that the flag that enables the
   announcement of paragraph starts is bound to Nil."
  (let ((*announce-paragaph-starts* nil))
    (tprw2)))

;;;-----------------------------------
;;; operation from already open files
;;;-----------------------------------

; (tprw4)
(defun tprw4 ()
  "Tests the option of runing the Analysis engine from an already open
   character stream.  Exercises whatever rules and evidence associations
   are currently defined."
  (let ((file-stream
         (open "prw;eta:test files:bcy1 djns/sissor"
               :direction :input)))
    (analyze-text-from-open-file file-stream)
    (close file-stream)))

