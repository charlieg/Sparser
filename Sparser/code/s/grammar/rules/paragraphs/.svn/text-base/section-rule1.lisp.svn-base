;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1991,1992,1993,1994  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "section rule"
;;;   Module:  "grammar;rules:paragraphs:"
;;;  Version:   1.4 May 1994

;; initiated 8/90
;; 1.1 (10/26/91 v2.0) completely overhauled.
;;     (10/28) put in temporary hack for w::paragraph-start
;;     (7/13/92 v2.2) Inserted traces on *trace-paragraphs*
;; 1.2 (1/4/93 v2.3) made adjustments now that they're actually being used
;; 1.3 (1/13/94) added a global pointing to the section marker, and a flag
;;      to the start routine so it will call finish-para when there's no
;;      section-marker involved.
;; 1.4 (5/9/94) hooking it in to the different calling patter from sgml tags

(in-package :sparser)


;;;----------------------------------------
;;; define the word and the section marker
;;;----------------------------------------

;; This is used in the FSA to point to the item it's supposed
;;   to return as the section marker.
;;
(defparameter word::paragraph-start
  (define-section-marking-word "paragraph-start"))


(define-section-marker "paragraph-start"
  ;; When the start of a paragraph is seen, finish the current
  ;; paragraph and start the next one.

  :initiation-action  'start-new-paragraph
  :termination-action 'finish-ongoing-paragraph
  :implicitly-closes  "paragraph-start" )

(defparameter *paragraph-start* (section-marker-named "paragraph-start"))


;;;-----------------
;;; action routines
;;;-----------------

(defun start-new-paragraph (word
                            &optional position-before
                            call-finish? )

  ;; called as a section markerfrom either Establish-section-within-
  ;; document or by Draw-paragraphing-conclusions, in which case we'll
  ;; need to do the finishing action from here rather than the section
  ;; driver doing it.   Also called via the edge completed over a
  ;; paragraph, in which case the distribution of the information 
  ;; across the parameters is different -- in that case the "word"
  ;; is actually an edge, and the other two arguments are omitted

  (cond (call-finish?  ;; inline call from the NL-fsa
         (when *current-paragraph*
           (finish-ongoing-paragraph position-before)))
        (*current-section-type*
         (consider-finishing-section-from-paragraph position-before)))

  (let ((number (incf *number-of-paragraphs-so-far*))
        (new-para (allocate-paragraph)))

    (setf (paragraph-number new-para) number)
    (setf (paragraph-start new-para)
          (if word  ;; its omitted in a call from Draw...
            (etypecase word  ;; but not from Establish...
              (word position-before)
              ;; and from Complete (sgml) it's really an edge
              (edge (setq position-before (pos-edge-ends-at word))))
            position-before))
    (tr :paragraph-start new-para position-before)
    (setq *current-paragraph* new-para)))


(defun consider-finishing-section-from-paragraph (pos-before)
  (let ((sm *current-section-type*))
    (unless (section-marker-p sm)
      (break "Data mixup: Expected a section marker and got:~
              ~%~A" sm))
    (let ((sm-to-terminate? (sm-terminates-previous sm)))
      (when sm-to-terminate?
        (let ((termination-fn (sm-termination-action sm-to-terminate?)))
          (when termination-fn
            (funcall termination-fn pos-before)))))))


(defun finish-ongoing-paragraph (position-after
                                 &optional starting-edge)
  ;; When called via a NL routine (as a section marker) the
  ;; "position-after" is the position just before the word that
  ;; starts the next paragraph. If called from completing a
  ;; sgml tag, that argument is given as an edge redundantly
  ;; with the edge argument, and the position we're after is
  ;; the start of that edge since it will be what bounds the
  ;; text of the paragraph. 
  (when starting-edge
    (unless (edge-p position-after)
      (break "Change in protocol: expected a call from Complete to ~
              pass in an edge~%as the first argument but got~%~A"
             position-after))
    (setq position-after (pos-edge-starts-at position-after)))

  (let* ((p *current-paragraph*)
         (start-pos (paragraph-start p)))
    (tr :paragraph-finish p start-pos position-after)

    (if (eq position-after
            (chart-position-after start-pos))
      ;; which can happen when a newline criteria is used to
      ;; define paragraphs and a separate criteria is used to
      ;; define other section-types, like header labels or tags
      (then
        ;; remove this paragraph from existence, as it doesn't
        ;; encompass anything.
        (tr :flushing-empty-paragraph p start-pos position-after)
        (deallocate-paragraph p)
        (decf *number-of-paragraphs-so-far*))

      (else
        (setf (paragraph-end p) position-after)
        (update-workbench)
        (when *after-paragraph-actions*
          (dolist (function *after-paragraph-actions*)
            (tr :after-paragraph-action function p)
            (funcall function p)))
        p ))))



;;;-------------------------
;;; after-paragraph actions
;;;-------------------------

(defvar *after-paragraph-actions* nil)

(defun install-after-paragraph-action (fn-name)
  (push fn-name *after-paragraph-actions*))

(defun remove-after-paragraph-action (fn-name)
  (setq *after-paragraph-actions*
        (delete fn-name *after-paragraph-actions*
                :test #'eq)))

(defun list-after-paragraph-actions ()
  (pl *after-paragraph-actions*))

(defun clear-after-paragraph-actions ()
  (setq *after-paragraph-actions* nil))

