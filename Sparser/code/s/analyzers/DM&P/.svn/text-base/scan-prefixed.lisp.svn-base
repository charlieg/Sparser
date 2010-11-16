;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:  "scan prefixed"
;;;    Module:  "analyzers;DM&P:"
;;;   version:  September 1994

;; split out from [scan1] 8/3/94 v2.3   Tweeking ...9/1.  Added 'infinitive' to
;; Determinant-... 10/24

(in-package :sparser)

;;;-------------
;;; entry point
;;;-------------

(defun scan-treetops-and-mine (starts-at ends-at)
  ;; called from dm/Analyze-segment when the coverage is either
  ;; discontinuous edges or some-adjacent-edges
  (let* ((s (define-segment starts-at ends-at))
         (prefix (edge-starting-at starts-at))) ;; ignoring possibility of multiples
    (if prefix
      (scan-treetops/prefixed s prefix starts-at ends-at)
      (if (function-word? (pos-terminal starts-at))
        ;; those won't show up as edges in the standard grammar
        (scan-treetops/fn-word-prefixed s starts-at ends-at)
        (scan-treetops/no-prefix s starts-at ends-at)))))



;;;----------------------
;;; categorizing routine
;;;----------------------

(defun determinant-segment-prefix (prefix-edge starts-at)
  ;; returns the most useful category description of the segment
  ;; given this edge which is its prefix.  Choices are coordinated
  ;; with the policy for labeling segments in Span-mined-segment.
  (let ((form (edge-form prefix-edge)))

    (cond ((and (one-word-long? prefix-edge)
                (determiner? (pos-terminal starts-at)))
           category::np )

          ((eq form category::content-word)
           nil )

          (form
           (ecase (cat-symbol form)
             (category::noun        category::np)
             (category::possessive  category::np)
             (category::NP          category::np)  ;; "the one..."
             (category::adjp        category::np)
             (category::adjective   category::np)
             (category::proper-noun category::np)

             (category::verb+s   category::verb)
             (category::verb+ed  category::verb)
             (category::verb+ing category::verb)
             (category::verb     category::verb)
             (category::infinitive  category::verb)
             (category::modal    category::verb)
             (category::adverb   category::verb)
             (category::vg       category::verb)   ;; "do" ///??
             ))

          ((eq (edge-category prefix-edge)
               category::number)
           category::np )

          (t nil))))


(defun determinant-segment-prefix/word (word)
  (when (determiner? word)
    category::np ))



;;;---------------------
;;; cases dispatched to
;;;---------------------

(defun scan-treetops/fn-word-prefixed (s starts-at ends-at)
  (let* ((fn-word (pos-terminal starts-at))
         (informative-category (determinant-segment-prefix/word fn-word)))
    (if informative-category
      (do-prefixed-segment s informative-category
                           starts-at (chart-position-after starts-at) ends-at)
      (if *break-on-pattern-outside-coverage?*
        (break "Function word \"~A\" starts segment but isn't determinant"
               (word-pname fn-word))
        (do-prefixed-segment s informative-category
                             starts-at (chart-position-after starts-at)
                             ends-at)))))


(defun scan-treetops/prefixed (s prefix-edge starts-at ends-at)
  (let ((informative-category (determinant-segment-prefix
                               prefix-edge starts-at)))
    (tr :scan-treetops/prefixed prefix-edge)

    (if informative-category
      (if (eq informative-category category::verb)
        (mine-vg s prefix-edge starts-at ends-at)
        (do-prefixed-segment s informative-category
                             starts-at (pos-edge-ends-at prefix-edge) ends-at))
      (else
        ;; there's an edge starting at the first word, but it doesn't
        ;; have a syntactically useful label. Most likely we have
        ;; another instance of a recently defined term
        (let ((prefix-category (edge-category prefix-edge)))

          (cond ((eq (edge-form prefix-edge) category::content-word)
                 (tr :prefix-is-content-word)
                 (scan-treetops/mined-term/s s starts-at ends-at))

                ((polyword-p prefix-category)
                 (tr :prefix-is-polyword)
                 (scan-treetops/mined-term/s s starts-at ends-at))

                (t ;(break
                   ; "New case: the segment \"~A\"~
                   ;  ~%has a prefix edge with the category ~A"
                   ; (string-of-words-between starts-at ends-at)
                   ; prefix-category)
                   (scan-treetops/mined-term/s s starts-at ends-at))))))))




(defun do-prefixed-segment (s informative-category
                            prefix-start body-start ends-at)
  (tr :prefix-is-informative informative-category)
  (let ((items (mine-treetops
                body-start ends-at s
                informative-category)))
    ;; //call parser now that there's something to work with ??
    ;; make edge if one doesn't form by itself (via parse)
    (categorize-segment s items informative-category)
    (span-mined-segment s prefix-start ends-at items
                        :label informative-category
                        :form informative-category)))


(defun scan-treetops/mined-term/s (s starts-at ends-at)
  ;; we don't have any interesting syntactic information about
  ;; this segment unless we can determine it by inference from
  ;; prior instances of this sequence of edges.
  (let ((terms (mine-treetops starts-at ends-at s)))
    (categorize-segment s terms)
    (span-mined-segment s starts-at ends-at terms)))




(defun scan-treetops/no-prefix (s starts-at ends-at)
  ;; the segment doesn't have a prefix, so we probably can't know
  ;; its syntactic category, but it does have some terms we've already
  ;; seen
  (tr :scan-treetops/from-right)
  (let ((terms (mine-treetops starts-at ends-at s)))
    (categorize-segment s terms)
    (span-mined-segment s starts-at ends-at terms)))

