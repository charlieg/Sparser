;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "markup operations"
;;;    Module:   "interface;SUN:"
;;;   Version:   December 1994

;; initiated 12/13/94

(in-package :sparser)

;;;----------------------------------
;;; state established by the buttons
;;;----------------------------------

(defvar *current-smu-classification* nil
  "a keyword with the same name as the corresponding button")

(defvar *the-current-SUN-phrase-is-good* t
  "a boolean flag maintained by the 'ok' and 'mistaken' buttons
   and read in Mark-selected-SUN-phrase")

;; these go with the corresponding radio buttons
(defvar *phrase-is-SUN-or-Unix-vocabulary* nil)
(defvar *phrase-is-generic-comp-sci-vocabulary* nil)
(defvar *phrase-is-other-vocabulary* nil)


(defun initialize-smu-state ()
  (setq *current-smu-classification* nil
        *the-current-SUN-phrase-is-good* t
        *phrase-is-SUN-or-Unix-vocabulary* nil
        *phrase-is-generic-comp-sci-vocabulary* nil
        *phrase-is-other-vocabulary* nil)

  (ccl:set-dialog-item-text *smu/edge-decription* "")
  (ccl:dialog-item-disable *smu/next-phrase*)
  (ccl:dialog-item-disable *smu/mark-it*)
  (ccl:dialog-item-disable *smu/subtypes-button*))

(define-per-run-init-form '(initialize-smu-state))


;;;----------------------------------------
;;; drivers called from the action buttons
;;;----------------------------------------

(defun select-next-SUN-phrase (next-phrase-button)

  ;; This is the entry point for every annotation. It is activated
  ;; when all the actions over a lexical item have been finished.

  (declare (ignore next-phrase-button))

  ;; reset the buttons to operate on the next item
  (ccl:set-dialog-item-text *smu/edge-decription* "")
  (ccl:dialog-item-enable *smu/mark-it*)
  (ccl:dialog-item-enable *smu/subtypes-button*)
  (setq *parent-category-to-subtype-dialog* nil)

  ;; save out the results for the last item
  (when *smu/current-instance*
    (save-instance-for-later-restoration))

  ;; find the next item
  (find-next-consequental-edge))



;;;-------------------------------------------
;;; actions for the ok/mistaken radio buttons
;;;-------------------------------------------

(defun set-smu-mode/phrase-is-good (radio-button)
  (declare (ignore radio-button))
  (setq *the-current-SUN-phrase-is-good* t))

(defun set-smu-mode/phrase-is-bad (radio-button)
  (declare (ignore radio-button))
  (setq *the-current-SUN-phrase-is-good* nil))



;;;--------------------
;;; walking the forest
;;;--------------------

(defparameter *smu/current-start-pos* nil)

(define-per-run-init-form '(setq *smu/current-start-pos* nil))


(defvar *smu/current-phrase* nil)

(define-per-run-init-form '(setq *smu/current-phrase* nil))


(defvar *smu/current-instance* nil)

(define-per-run-init-form '(setq *smu/current-instance* nil))



(defun find-next-consequental-edge ()
  (unless *smu/current-start-pos*
    (setq *smu/current-start-pos* (chart-position 0)))
  (let ((edge
         ;; an edge may have been formed from a sequence of tags by
         ;; Record-phrase, or by it recognizing a pattern that was 
         ;; seen before and reified as a unary rule or polyword.
         (fnce *smu/current-start-pos*)))

    (when (eq edge *header-edge/entry-just-started*)
      ;; that's the first edge of the next entry, so we now
      ;; want to resume scanning
      (throw :continue-from-pause t))

    (select-edge-in-text-view (pos-edge-starts-at edge)
                              (pos-edge-ends-at edge)
                              edge)

    ;; update the walk's index
    (setq *smu/current-start-pos*
          (pos-edge-ends-at edge))

    (setq *smu/current-phrase* edge)

    ;; look for reasons not to go into the markup phase
    (cond ((smu/edge-is-self-marked edge))

          ((smu/edge-seen-earlier-this-phase edge)
           (ccl:dialog-item-disable *smu/mark-it*)
           (ccl:dialog-item-disable *smu/subtypes-button*)
           (ccl:dialog-item-enable *smu/next-phrase*))

          (t ;; don't disable the markup buttons and do disable
             ;; the next phrase button so there's nothing to do
             ;; but markup the current item
           (ccl:dialog-item-disable *smu/next-phrase*)))))



(defun fnce (start-here)
  ;; go-fer for Find-next-consequental-edge
  (let* ((start-pos start-here)
         tt )
    (loop
      (when (eq (pos-terminal start-pos) *end-of-source*)
        (return-from fnce :eos))
      (setq tt (ev-top-node (pos-starts-here start-pos)))
      (cond
       ((null tt)
        ;; there's no value for ev-top-node, so there's
        ;; no edge, so we just loop
        (setq start-pos (chart-position-after start-pos)))
       ((symbolp tt)
        (unless (eq tt :multiple-initial-edges)
          (break "Assumption violation: treetop is a symbol ~
                  that isn't :multiple-initial-edges~
                  ~%~A~%" tt))
        ;; it's either a word or a singleton edge
        (if (= 0 (ev-number-of-edges start-pos))
          ;; it's a word -- loop
          (setq start-pos (chart-position-after start-pos))
          (else
            (return-from fnce tt))))
       (tt
        (return-from fnce tt))
       (t
        (break "Threading bug: ran off the end of conditional"))))))


(defun smu/Edge-seen-earlier-this-phase (edge)
  ;; This acts as a predicate with side effects if the condition
  ;; it is looking for is true. The edge is usually a vanila, pos-triggered
  ;; edge.  Its possible, however, that we've already seen this
  ;; phrase during this ongoing labeling-phase on the current entry,
  ;; in which case we would find a stronger edge if we looked,
  ;; an edge that wouldn't form on its on until we move on to another
  ;; entry. 
  (let* ((starts-at (pos-edge-starts-at edge))
         (ends-at (pos-edge-ends-at edge))
         (1st-word (pos-terminal starts-at)))

    (when (word-rules 1st-word)
      ;; copied from Record-phrase
      (let* ((word-list (words-between starts-at ends-at))
             (new-edge
              (if (cdr word-list) ;; multiple words
                (smu/check-for-polyword 1st-word starts-at)
                (smu/check-for-unary-rule
                 1st-word starts-at ends-at))))

        (setq *smu/current-phrase* (or new-edge edge))
        (when new-edge
          (ccl:set-dialog-item-text *smu/edge-decription*
                                    (format nil "~A"
                                            (edge-referent new-edge))))
        new-edge ))))




;;;--------------------
;;; clicking 'Mark it'
;;;--------------------

(defun mark-selected-SUN-phrase (mark-it-button)
  (declare (ignore mark-it-button))
  ;; dispatch off the ok/mistaken button
  (if *the-current-SUN-phrase-is-good*
    (let ((classification
           (or *current-smu-classification*  ;; from subdialog
               (readout-smu-classification-buttons))))

      (when *current-smu-classification* ;; turn it off
        (setq *current-smu-classification* nil))

      (if (eq classification :other)
        (then
          ;; could trap here to something more interesting, like
          ;; a standard 2d string set of 'toplevel' categories,
          ;; but not for now
          (smu/classify-phrase classification))
        (smu/classify-phrase classification)))

    (mark-phrase-as-mistaken)))



;;;-----------------------
;;; markuping up mistakes
;;;-----------------------

(defparameter *number-of-mistakes-in-entry* 0)

(defun mark-phrase-as-mistaken ()
  (incf *number-of-mistakes-in-entry*)
  (ccl:dialog-item-enable *smu/next-phrase*)
  (ccl:dialog-item-disable *smu/mark-it*)
  (bring-up-mistake-dialog))


;;;-------------------------
;;; marking up good phrases
;;;-------------------------

(defun smu/Classify-phrase (keyword)
  ;; called from Mark-selected-SUN-phrase
  (let ((edge *smu/current-phrase*)
        (category (if (or (referential-category-p keyword)
                          (category-p keyword)
                          (mixin-category-p keyword))
                    keyword
                    (category-for-smu-classification keyword)))
        (semantic-field (readout-gross-semantic-field-buttons)))
    (unless category
      (break "no category for ~A" keyword))

    (let ((instance
           (smu/instantiate-category category edge)))

      (bind-variable 'semantic-field semantic-field instance)
      (setq *smu/current-instance* instance)
      (setf (edge-referent edge) instance)

      (write-cfr-for-smu-tag-derived-edge edge category instance)

      (add-subsuming-object-to-discourse-history edge)

      (if (or (eq keyword :proper-name)
              (eq keyword :file-name)
              (eq keyword :machine-type)
              (eq *parent-category-to-subtype-dialog*
                  category::proper-name))
        (then
          (ccl:dialog-item-enable *smu/next-phrase*)
          (ccl:dialog-item-disable *smu/mark-it*))
        (show-and-read-dialog-for-standard-features)))))


;;;--------------------------------------------------------
;;; markup subdialog for standard features like mass/count
;;;--------------------------------------------------------

(defvar *smu/pos-choice* nil)
(defvar *smu/features-choice* nil)

(defun initialize-smu-standard-features-subdialog ()
  (setq *smu/pos-choice* nil
        *smu/features-choice* nil))

(define-per-run-init-form '(initialize-smu-standard-features-subdialog))


(defun show-and-read-dialog-for-standard-features ()
  ;; called from smu/Classify-phrase
  ;;//could be clever and examine the phrase or its context and
  ;; try estimating the values of the features before launch/selection
  ;; and set the radio button accordingly.
  (ccl:dialog-item-disable *smu/mark-it*)
  (if *smu/standard-markup-subdialog*
    (ccl:window-select *smu/standard-markup-subdialog*)
    (launch-smu-standard-features-dialog)))


;;--- asyncronous alternative ways out of the subdialog

(defun readout-button-values-onto-current-phrase (ok-button)
  (declare (ignore ok-button))
  (let ((instance *smu/current-instance*)
        (pos (readout-smu-pos-radio-buttons))
        (feature (readout-smu-features-radio-buttons)))
    (bind-variable 'pos pos instance)
    (when (eq pos :noun)
      (bind-variable 'feature feature instance))

    (ccl:dialog-item-enable *smu/next-phrase*)
    (ccl:window-hide *smu/standard-markup-subdialog*)))


(defun smu/Return-to-classification-state (reconsider-button)
  (declare (ignore reconsider-button))
  (ccl:window-hide *smu/standard-markup-subdialog*)
  (ccl:dialog-item-enable *smu/mark-it*))



;;;--------------------------------------------
;;; edges that don't have to be marked by hand
;;;--------------------------------------------

(defun smu/Edge-is-self-marked (edge)
  ;; Called from Find-next-consequental-edge
  ;; Check whether this edge already has a referent. That would
  ;; mean that it was arrived at by some process other than grouping
  ;; the tags and shouldn't be marked.
  ;;    This routine is gating an Unless, so we return non-nil
  ;; if the edge is self-marked, and its our responsibility to
  ;; get the tableau in the right state for the next action.
  (when (edge-referent edge)
    (let ((referent (edge-referent edge)))
      (ccl:set-dialog-item-text *smu/edge-decription*
                                (format nil "~A" referent))
      (ccl:dialog-item-disable *smu/mark-it*)
      (ccl:dialog-item-disable *smu/subtypes-button*)
      (ccl:dialog-item-enable *smu/next-phrase*)
      t )))
