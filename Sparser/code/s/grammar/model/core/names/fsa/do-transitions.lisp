;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993,1994  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "do transitions"
;;;   Module:  "model;core:names:fsa:"
;;;  version:  0.1 February 1994

;; -.3 (12/17/93) added a catch to handle the fact that the capitalization of
;;      headers will catch them up in the initial scan.  (12/22) fixed a ramification
;;      of all that. 
;; -.2 (12/30) extended fsa driver to filter out literals from multiple edges
;;      over words.
;; -.1 (1/6/94) adding cut-off switch to avoid running the network, etc.
;; 0.0 (1/27/94 v2.3) broken out from [classify]
;; 0.1 (2/24) fixed what is passed as the daughters to a name edge

(in-package :sparser)


;;;----------------------
;;; debugging parameters
;;;----------------------

(defparameter *break-on-pattern-outside-coverage?* t)

(define-pnf-state :pattern-is-outside-coverage)

(define-category name/unknown-pattern)

;; or stop arbitrarily if we're avoiding all these calculations
(defparameter *end-PNF-early* nil)


;;;------------------------------------------------------------
;;; Organizing the analysis and classification of multi-word,
;;;             multi-edge capitalized sequences
;;;------------------------------------------------------------


(defun c&R-multi-word-span (starting-position ending-position)

  ;; run a version of the parser over the delimited span (respecting 
  ;;its end-point) and then see if that got anything.  Called from
  ;; Classify-and-record-name whenever the span involves more than
  ;; one word and there isn't a single span over them. 

  (let ((premature-termination?
         ;; in the course of the parse we can encounter words like Header
         ;; labels that are definitive name-terminators. We don't know that
         ;; they are until their fsas run and establish it (consider the
         ;; ambiguity of "an" vs. "AN"), which we don't know until this
         ;; parse. The throw is from the action routine of the fsa.
         (catch :early-termination-of-pnf-parse
           (parse-from-within-pnf starting-position ending-position))))

    (when premature-termination?
      (setq ending-position premature-termination?
            ;; we have to set this global because it's what is returned
            ;; by PNF as the official ending point of the fsa
            *PNF-end-of-span* ending-position))

    (unless (eq starting-position ending-position)
      ;; which can happen with premature terminations, this 'unless'
      ;; has the effect of returning 'nil' for the c&r stage, which
      ;; will abort the PNF and declare that there was no name here.

      (let ((edge (span-covered-by-one-edge? starting-position
                                             ending-position)))
        (if edge
          (c&r-single-spanning-edge edge)

          (if *end-PNF-early*
            (make-chart-edge :starting-position starting-position
                             :ending-position ending-position
                             :category category::name
                             :form category::np
                             :referent nil
                             :rule :stopped-PNF-early)

            (classify-&-record-span starting-position
                                    ending-position)))))))




(defun classify-&-record-span (starting-position ending-position)

  ;; the span has had its word actions run by the embedded parsing
  ;; and consists of more than one span.  Now we run the transition
  ;; net over that sequence of words and edges. If the net accepts
  ;; the sequence it will return a final state, and we use that
  ;; to establish a referent and construct the edge over the whole
  ;; capitalized sequence. 

  (initialize-PN-classification-engine)
  (let ((result
         (catch :transition-net-aborts-the-sequence
           (classification-fsa *PNF-start*
                               starting-position ending-position))))
    (etypecase result
      (pnf-state
       (do-referent-and-edge result
                             starting-position ending-position))
      (position
       ;; from here, we fall through to return this value, the position,
       ;; to PNF, which takes any non-nil value to indicate success,
       ;; in that it should return *pnf-end-of-span* as the value
       ;; of the fsa overall.
       ;(break)
       (if (further-to-the-right ending-position result)
         ;; then we can just imagine that we had started at this
         ;; position and keep going.
         (if (eq ending-position (chart-position-after result))
           ;; the remaining tail is just one word long, so we
           ;; should pass it to the processing that's tailored for
           ;; that case.
           (c&r-single-word result ending-position)
           (classify-&-record-span result ending-position))

         (else
           ;; we're at the end of the span, so we just return,
           ;; indicating (by setting this global) that the fsas
           ;; are done up to this point. ///Not strictly true -- look
           ;; at more cases than just "Including President Bush"
           (setq *pnf-end-of-span* result)
           result ))))))



(defun do-referent-and-edge (final-state
                             starting-position ending-position)

  (multiple-value-bind (category basis-of-judgement)
                       (categorize-pn-results final-state)
    (unless category
      (setq category category::name
            basis-of-judgement :insufficient-internal-evidence))
    
    ;; now we have to establish the referent
    (let ((referent
           (establish-referent-of-pn
            final-state
            category
            basis-of-judgement
            (setq *items-in-PN-sequence*
                  (nreverse *items-in-PN-sequence*)))))
      
      (let ((edge
             (edge-over-proper-name
              starting-position
              ending-position
              category
              referent
              (if (pnf-state-p basis-of-judgement)  ;; "rule"
                `(:pnf-fsa ,final-state)
                `(:classification-tree ,basis-of-judgement))
              (successive-treetops :from starting-position
                                   :to ending-position)
              )))
        
        edge ))))


;;---- data structures

(defvar *items-in-PN-sequence* nil
  "holds the actual sequence toplevel items -- edges or words -- as
   they are encountered by the fsa")


;;;-------------------------------------------------------------
;;; General state machine for classifying capitalized sequences
;;;                     as proper names
;;;-------------------------------------------------------------

(defun classification-fsa (state position final-position)

  (when (eq position final-position)
    (return-from Classification-fsa state))

  (let* ((ev (pos-starts-here position))
         (edge/s (ev-top-node ev))
         (word (pos-terminal position)))

    (if (eq edge/s :multiple-initial-edges)
      (sort-out-multiple-edge-&-resume-classification-fsa
       word state position final-position)
      (classification-fsa/continued
       edge/s word state position final-position))))


(defun classification-fsa/continued (edge word state
                                     position final-position)
  (let ( item  item-type  item-is-an-edge? )
    (setq item-type
          (cond (edge
                 (setq item-is-an-edge? t
                       item (edge-referent edge))
                 (edge-category edge))
                ((null (word-capitalization word))
                 ;; quick test for punctuation
                 (setq item word)
                 word )
                (t (setq item word)
                   *unknown-word*)))

    (push (kcons item-type item)
          *items-in-PN-sequence*)

    (let ((transition (pnf-transition? state item-type))
          next-state  action )

      (unless transition
        (if *break-on-pattern-outside-coverage?*
          (break "Gap in the transition net for proper names:~
                  ~%No rule for the state ~A and the item type ~A"
                 state item-type)
          (return-from Classification-fsa/continued
            (pnf-state-named :pattern-is-outside-coverage))))

      (setq next-state (car transition)
            action (cadr transition))

      (when action
        (eval action))

      ;; check for some exceptions. ///If this this list gets
      ;; too long move the information to some uniform place.
      ;; If the exception decides that we have to abort, it
      ;; will throw a position up to Classify-&-record, 
      ;; otherwise we'll just fall through this and continue
      ;; on to the next transition
      (case (pnf-state-symbol next-state)
        (:exception-check-for-titles
         (pnf/check-titles edge))
        (:exception-check-for-titles/prior-word
         (pnf/check-titles/prior-word position edge)))

      (classification-fsa next-state
                          (if item-is-an-edge?
                            (pos-edge-ends-at edge)
                            (chart-position-after position))
                          final-position))))



(defun pnf/Check-titles (title-edge)
  ;; We've just noticed a title in the midst of a capitalized
  ;; sequence. It's probably a term of address: "President Mugabe",
  ;; so we want to rework the pnf processing so that the title
  ;; is left out as a separate constituent.
  (throw :transition-net-aborts-the-sequence
         (pos-edge-ends-at title-edge)))


(defun pnf/Check-titles/prior-word (title-starts-at title-edge)
  ;;   In this case there is one, unknown, word in front of the
  ;; title. The question is whether this is a name or just a word
  ;; that's been capitalized because, e.g. it starts the sentence.

  (let ((1st-in-para? (first-item-in-its-paragraph
                       (chart-position-before title-starts-at))))
    (if 1st-in-para?
      ;; then we can ignore that 1st word before the title and
      ;; throw out to just after the title
      (throw :transition-net-aborts-the-sequence
             (pos-edge-ends-at title-edge))
      (break "stub"))))



;;;-------------
;;; subroutines
;;;-------------

(defun sort-out-multiple-edge-&-resume-classification-fsa
       (word state position final-position)
  ;; there is more than one edge over the terminal at this position.
  ;; We go through the vector and see if there's some applicable criteria
  ;; for selecting just one of the edges and continuing as normal.

  (let ((edges (edges-between position (chart-position-after position)))
        residue  preferred-edge )
    (dolist (edge edges) ;; get rid of any literal (there would just be one)
      (unless (eq :literal-in-a-rule
                  (edge-rule edge))
        (kpush edge residue)))

    (if (null (cdr residue))  ;; there's just one left
      (then
        (setq preferred-edge (kpop residue))
        (classification-fsa/continued
         preferred-edge
         word state position final-position))
      (else
        (break "Multiple edges over the word ~A~
                ~%even discounting a literal")))))

