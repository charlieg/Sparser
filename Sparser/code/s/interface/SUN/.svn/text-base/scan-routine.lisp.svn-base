;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "scan routine"
;;;    Module:   "interface;SUN:"
;;;   Version:   December 1994

;; initiated 12/12/94

(in-package :sparser)

;;;--------
;;; driver
;;;--------

(defun scan-for-tag-patterns (word position)
  ;; called from Look-at-next-terminal/shell for ':just-do-terminals'
  (let ((marker
         (ev-marker (pos-starts-here position))))
    ;(format t "~&~A  ~A / ~A~%" position word marker)
    (if marker
      (update-pos-pattern-state marker position)
      (else
        ;; ss and eos won't have markers, and perhaps there will
        ;; be others (or there'll be mistakes by the tagger)
        ;; so we have to check the state variables here too.
        (sftp/terminate-ongoing-sequence position)))

    (complete word position (chart-position-after position))
    word ))


(defun update-pos-pattern-state (marker position)
  ;; a little more general than needed if all we're looking for are NPs
  (let ((category
         (cadr (member :typical-containing-category (word-plist marker)))))
    (if category
      (sftp/track-phrasal-sequence category position) 
      (else
        (break "new tag: ~A~%" marker)
        (sftp/terminate-ongoing-sequence position)))))
  

;;;-----------------
;;; state variables
;;;-----------------

(defvar *sftp/phrase-start* nil
  "When the first NP term (word) is scanned, this global is set to the 
   the position just before that term.")

(defvar *sftp/term-category* nil
  "Records the phrasal category that the tags on the pending sequence
   of terms indicate.")

(defun initialize-sftp-state ()
  (setq *sftp/phrase-start* nil
        *sftp/term-category* nil
        ))

(define-per-run-init-form '(initialize-sftp-state))


;;;--------------------------------
;;; managing tag-indicated phrases
;;;--------------------------------

(defun sftp/track-phrasal-sequence (category position)
  (if *sftp/term-category*
    ;; there's a phrase being accumulated.
    (if (eq category *sftp/term-category*)
      ;; it's the same kind as currently being accumulated
      ()    ;; no need to do anything
      (else
        ;; we have to end the ongoing phrase and maybe start a new one
        (sftp/terminate-ongoing-sequence position)
        (sftp/check-category-for-phrasal-status category position)))

    ;; nothing ongoing
    (sftp/check-category-for-phrasal-status category position)))


(defun sftp/check-category-for-phrasal-status (category position)
  (when (eq category :np)
    (sftp/start-phrasal-sequence category position)))

(defun sftp/start-phrasal-sequence (category position)
  (setq *sftp/phrase-start* position
        *sftp/term-category* category))
    
(defun sftp/terminate-ongoing-sequence (position)
  (when *sftp/phrase-start*
    (record-phrase *sftp/phrase-start* position))
  (initialize-sftp-state))


;;;---------------------------------
;;; entering phrases into the chart
;;;---------------------------------

(unless (category-named 'np)
  (define-category np))
    ;; n.b. this is a vanila non-terminal, not a form category


(defun record-phrase (starts-at ends-at)
  ;; We make an edge so that the next phase has something to notice.
  ;; Most of the time this sequence of words is new, but in other cases,
  ;; especially within the same article, we'll have seen them before
  ;; so we need to check for that case an introduce the correct edge.
  (let ((word-list
         (words-between starts-at ends-at))
        (1st-word (pos-terminal starts-at))
        edge )
    
    (when (word-rules 1st-word)
      ;; we've made a record involving this word, so we should
      ;; see if this is a pattern we annotated before and defined
      ;; a cfr for so it could be replicated rather than having
      ;; to do the annotation again
      (setq edge
            (if (cdr word-list) ;; multiple words
              (smu/check-for-polyword 1st-word starts-at)
              (smu/check-for-unary-rule
               1st-word starts-at ends-at))))
      
    (unless edge
      ;; if there is no already established edge, we just create
      ;; a default edge so that there's something to be seen
      ;; in the next phase and reacted to                                     
      (make-chart-edge :starting-position starts-at
                       :ending-position ends-at
                       :category (category-named 'np)
                       :rule-name :sun-scan))
    edge ))


(defun smu/Check-for-polyword (1st-word starts-at)
  ;; Called from Record-phrase. Returns the edge formed by the
  ;; finding a polyword here if there is one.
  (when (and (word-rules 1st-word)
             (rs-fsa (word-rules 1st-word)))
    (let* ((edge
            (do-polyword-fsa/in-place 1st-word starts-at)))
      (when edge
        ;; value is nil if there was no pw here
        edge ))))


(defun do-polyword-fsa/in-place (1st-word pos-before)
  ;; The words have already been scanned, otherwise it's about
  ;; the same as Polyword-fsa1
  (dpf/ip1 1st-word pos-before (chart-position-after pos-before)))

(defun dpf/ip1 (last-label first-position next-position)
  (let* ((next-word (pos-terminal next-position)))
    (let ((rule
           (if (word-p last-label)
             (multiply-words/case-from-position
              last-label next-word first-position next-position)
             (multiply-label-and-word/case-from-pos
              last-label next-word next-position))))
      (if rule
        (if (dotted-rule rule)
          (dpf/ip1 (cfr-category rule)
                   first-position
                   (chart-position-after next-position))
          (let ((edge (make-edge-over-long-span
                       first-position
                       (chart-position-after next-position)
                       (cfr-category rule)
                       :rule rule
                       :referent (cfr-referent rule))))
            edge ))
        nil))))




(defun smu/Check-for-unary-rule (word starts-at ends-at)
  ;; Called from Record-phrase. Checks whether the word has a
  ;; rewriting rule and instantiates it if there is. Returns the
  ;; edge that it makes. 
  (let* ((rs (word-rules word))
         (list-of-cfrs (rs-single-term-rewrites rs)))
    (when (cdr list-of-cfrs)
      (break "~%How did there get to be multiple rules over ~
              ~%~A~%" word))
    (when list-of-cfrs
      (let ((edge
             (install-preterminal-edge (car list-of-cfrs)
                                       word
                                       starts-at ends-at)))
        edge ))))

