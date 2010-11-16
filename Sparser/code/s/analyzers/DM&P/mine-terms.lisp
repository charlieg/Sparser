;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:  "mine terms"
;;;    Module:  "analyzers;DM&P:"
;;;   version:  August 1994

;; split out from [analyzers;DM&P:mine] 8/3/94 v2.3.  Being tweeked
;; continually ... 

(in-package :sparser)

;;;--------------------------------
;;; cases for single unknown words
;;;--------------------------------

(defun mine-unmarked-term (word pos-before pos-after)
  ;; there is no prefix or other internal data to allow the form category
  ;; or syntactic function of this word to be deduced, so we put the
  ;; weakest possible label on it.  Since the relationship of this word
  ;; to the segment it is part is also vague we leave it to the caller.
  (let ((unkt
         (define-individual-for-unknown-term/span
           word pos-before pos-after
           :category category::unknown-term)))
    unkt ))

(defun mine-unmarked-term/edge (word pos-before pos-after)
  (if (ev-top-node (pos-starts-here pos-before))
    (let ((edges (only-nontrivial-edges 
                  (all-preterminals-at pos-before))))
      (if edges
        (if (cdr edges)
          (break "more than one edge was nontrivial:~
                  ~%~A" edges)
          (edge-referent (first edges)))
        (mine-unmarked-term word pos-before pos-after)))
    (mine-unmarked-term word pos-before pos-after)))


(defun mine-unmarked-term/pw (pw-edge)
  ;; just like an unmarked word, except that we have the edge over
  ;; a polyword here rather than a word.
  (unless (edge-p pw-edge)
    (break "Threading bug: expected 'pw' argument to be an edge"))
  (unless (polyword-p (edge-category pw-edge))
    (break "Threading bug: expected the label on the 'pw' argument ~
            to be a polyword."))
  (multiple-value-bind (unkt edge)
                       (define-individual-for-unknown-term/span
                         (edge-category pw-edge)
                         (pos-edge-starts-at pw-edge)
                         (pos-edge-ends-at pw-edge)
                         :category category::unknown-term)
    (values unkt edge)))
  


(defun mine-as-a-verb (word pos-before pos-after segment)
  ;; the one word between these positions has been identified as
  ;; a verb
  (tr :mining-verb word)
  (let ((verb (define-individual-for-unknown-term/span
                word pos-before pos-after
                :category  category::verb
                :form category::verb)))
    (bind-variable 'head verb segment)
    verb ))

(defun mine-verb/edge (word pos-before pos-after segment)
  (if (ev-top-node (pos-starts-here pos-before))
    (let ((edges (only-nontrivial-edges 
                  (all-preterminals-at pos-before))))
      (if edges
        (if (cdr edges)
          (break "more than one edge was nontrivial:~
                  ~%~A" edges)
          (let ((edge (car edges)))
            (note-instance edge 'head segment)
            (adjust-rule-to-verb edge)
            (edge-referent edge)))
        (mine-as-a-verb word pos-before pos-after segment)))
    (mine-as-a-verb word pos-before pos-after segment)))




(defun mine-head (pos-before pos-after segment)
  ;; add the word to the model and make a rule and edge for it,
  ;; mark the edge as the head of an np,
  ;; associate the new individual with this segment
  (let ((word (pos-terminal pos-before)))
    (tr :mining-head word)
    (let ((head
           (define-individual-for-unknown-term/span
             word pos-before pos-after
             :form category::noun )))
      (bind-variable 'head head segment)
      head )))


(defun mine-head/edge? (pos-before pos-after segment)
  ;; if there's an edge over this word, use it assuming it
  ;; isn't trivial.  It there are several words between
  ;; the positions then we were passed a treetop, and we
  ;; accept the edge without checking
  (if (adjacent-positions pos-before pos-after) ;; one word
    (then
      (if (ev-top-node (pos-starts-here pos-before))
        (let ((edges (only-nontrivial-edges 
                      (all-preterminals-at pos-before))))
          (if edges
            (if (cdr edges)
              (break "more than one edge was nontrivial:~
                      ~%~A" edges)
              (note-instance (car edges) 'head segment))
            (mine-head pos-before pos-after segment)))
        (mine-head pos-before pos-after segment)))
    (else
      ;; several words
      (let ((edge (ev-top-node (pos-starts-here pos-before))))
        (unless (edge-p edge)
          (break "Threading bug: expected there to be a edge ~
                  between p~A and p~A" (pos-token-index pos-before)
                 (pos-token-index pos-after)))
        (note-instance edge 'head segment)))))
        




(defun mine-classifier (pos-after head segment)
  (let* ((pos-before (chart-position-before pos-after))
         (word (pos-terminal pos-before)))
    (tr :mining-classifier word)
    (let ((classifier
           (define-individual-for-unknown-term/span
             word pos-before pos-after)))
      (bind-variable 'classifier classifier segment)
      (bind-variable 'classifies head classifier)
      classifier )))


(defun mine-classifier/edge (pos-before pos-after
                             head segment)
  (if (adjacent-positions pos-before pos-after) ;; one word
    (then
      (if (ev-top-node (pos-starts-here pos-before))
        (let ((edges
               (only-nontrivial-edges 
                (all-preterminals-at pos-before))))
          (if edges
            (then
              (when (cdr edges)
                (break "more than one edge was nontrivial:~
                        ~%~A" edges))
              (bind-variable 'classifies head
                             (edge-referent (car edges)))
              (note-instance (car edges) 'classifier segment))
            (mine-classifier pos-after head segment)))
        (mine-classifier pos-after head segment)))
    (else
      (let ((edge (ev-top-node (pos-starts-here pos-before))))
        (unless (edge-p edge)
          (break "Threading bug: expected there to be a edge ~
                  between p~A and p~A" (pos-token-index pos-before)
                 (pos-token-index pos-after)))
        (when (polyword-p (edge-category edge))
          ;; hasn't yet been seen as a term
          (multiple-value-bind (term new-edge)
                               (mine-unmarked-term/pw edge)
            (declare (ignore term))
            (setq edge new-edge)))

        (bind-variable 'classifies head (edge-referent edge))
        (note-instance edge 'classifier segment)))))
      




;;/// dubious 8/3
(defun mine-pre-classifier (segment word pos-before pos-after)
  (break "vet this")
  (multiple-value-bind (pre-classifier its-edge)
                       (define-individual-for-unknown-term 
                         word pos-before pos-after)

    ;; this should suffice 'till we learn more about these
    (setf (edge-form its-edge) category::classifier)

    (bind-variable 'pre-classifier pre-classifier segment)
    pre-classifier ))





;;;--------------------------------
;;; later instances of known words
;;;--------------------------------

(defun note-instance (edge name-of-variable segment)
  ;; this should be an instance of a content term, not one
  ;; of the close-class (pre-defined) terms
  (let ((unit (edge-referent edge)))
    (tr :noting-instance unit name-of-variable)
    (bind-variable name-of-variable unit segment)
    unit))

