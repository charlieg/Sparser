;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994,1995  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "dispatch"
;;;   Module:  "drivers;DA:"
;;;  Version:  May 1995

;; initiated 10/27/94 v2.3.  Moved it and gave it some flesh 5/5/95

(in-package :sparser)

;;;-------------------------
;;; interface to the driver 
;;;-------------------------

(defun look-for-and-execute-any-DA-pattern (tt
                                            pos-before pos-after)

  ;; Called from Walk-pending-treetops-for-debris-analysis.
  ;; Look up any patterns associated linked to the labeling
  ;; on this treetop. If there is any and if it matches the
  ;; current context in the chart, then execute its rule.

  (tr :DA-dispatch pos-before tt)
  (let ((1st-vertex (trie-for-1st-item tt)))
    (if 1st-vertex
      (then
        (tr :starts-da-pattern-with 1st-vertex)
        (execute-da-trie 1st-vertex
                         tt pos-before pos-after))

      (let ((arc (is-an-item-anywhere-in-a-trie tt)))
        (if arc
          (then
            (tr :starts-da-pattern/middle-out)
            (execute-trie-middle-out arc tt
                                     pos-before pos-after))
          
          (else
            (tr :no-da-pattern-started-by tt)
            nil ))))))




(defun execute-da-trie (1st-vertex
                        tt pos-before pos-after)

  ;; called from Look-for-and-execute-any-DA-pattern to set up the
  ;; state and handle the return values from the search.

  (initialize-da-search)
  (initialize-da-action-globals tt pos-before pos-after)

  ;;    If the rule succeeds, we return //pos//.  If it fails, 
  ;; return nil -- This becomes the value of *da-dispatch-position*
  ;; which is how we communicate with the Walk where it is to
  ;; look next. Its default is the pos-after.

  (let ((result
         (catch :da-pattern-matched
           (catch :no-da-pattern-matched
             (check-for-extension-from-vertex 1st-vertex tt)))))

    (if result
      (etypecase result
        (edge *left-boundary/treetop-actions*)  ;; restart from the beginning       
        (symbol
         (ecase result
           (:trie-exhausted
            (tr :da-pattern-not-matched)
            nil )
           (:pattern-matched
            ;; This is the default value of Execute-da-action-function,
            ;; returned when the function itself returns nil.
            ;; If there's known side-effect of the DA action that would
            ;; change the treetops of the chart, then we can get into
            ;; a loop if we start back at the beginning of the chart,
            ;; so best to err on the safe side.
            pos-after ))))

      (else
        ;; /// ? trap other pathways
        nil ))))




(defun execute-trie-middle-out (arc
                                tt pos-before pos-after)

  ;; calle from Look-for-and-execute-any-DA-pattern

  (initialize-da-search)
  (initialize-da-action-globals tt pos-before pos-after :middle-out)
  (let ((result
         (catch :da-pattern-matched
           (catch :no-da-pattern-matched
             (check-middle-out-from-arc tt arc pos-before pos-after)))))

    (if result
      (etypecase result
        (edge *left-boundary/treetop-actions*)  ;; restart from the beginning       
        (symbol
         (ecase result
           (:trie-exhausted
            (tr :da-pattern-not-matched)
            nil )
           (:pattern-matched
            ;; This is the default value of Execute-da-action-function,
            ;; returned when the function itself returns nil.
            ;; If there's known side-effect of the DA action that would
            ;; change the treetops of the chart, then we can get into
            ;; a loop if we start back at the beginning of the chart,
            ;; so best to err on the safe side.
            pos-after ))))

      (else
        ;; /// ? trap other pathways
        nil ))))

