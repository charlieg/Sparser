;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:  "mine sequences"
;;;    Module:  "analyzers;DM&P:"
;;;   version:  November 1994

;; split out from [analyzers;DM&P:scan] 7/2194 v2.3.  Being tweeked
;; continually ... 8/19.  Added check for literals in Hack-long-segment
;; and introduced use of silent name words to handle them. 10/31 revised
;; that check.   11/14 fixed bug in big dispatch

(in-package :sparser)

;;;--------
;;; driver
;;;--------

(defun mine-treetops (starts-at ends-at segment
                      &optional prefix-category )
  (if prefix-category
    (ecase (cat-symbol prefix-category)
      (category::np
       (mine-treetops-as-head/classifiers starts-at ends-at segment))

      (category::verb
       (break "shouldn't have gotten here -- call should go to Mine-vg"))
      (category::modal
       (break "shouldn't have gotten here -- call should go to Mine-vg"))

      (category::adjp
       (mine-treetops-as-head/classifiers starts-at ends-at segment))

      (category::possessive ;;//// specialize the dispatch ??
       (mine-treetops-as-head/classifiers starts-at ends-at segment))
      )

    (mine-treetops/indeterminate-relationship
     starts-at ends-at segment)))



;;;-------------
;;; verb groups
;;;-------------

(defun mine-vg (segment prefix-edge starts-at ends-at)
  ;; called from Scan-treetops/prefixed when there is a prefix edge
  ;; and its form is one of the possibilities that's mapped to 'verb'
  ;; by Determinant-segment-prefix
  (declare (ignore starts-at))
  (let* ((form (edge-form prefix-edge))
         (action (ecase (cat-symbol form)
                   (category::verb+s   :check-aux+s )
                   (category::verb+ed  :check-aux+ed )
                   (category::verb+ing :check-aux+ing )
                   (category::verb     :post-head )
                   (category::infinitive  :post-head )
                   (category::modal    :any-aux/verb )
                   (category::adverb   :any-aux/verb )
                   (category::vg       :break )   ;; "do" ///??
                   )))

    (ecase action
      (:check-aux+s   ;(break "mine verb, only with legit. +s aux")
       (mine-treetops-as-vg-head (pos-edge-ends-at prefix-edge)
                                 ends-at segment))
      (:check-aux+ed   ;(break "mine verb, only with legit. +ed aux")
       (mine-treetops-as-vg-head (pos-edge-ends-at prefix-edge)
                                 ends-at segment))
      (:check-aux+ing   ;(break "mine verb, only with legit. +ing aux")
       (mine-treetops-as-vg-head (pos-edge-ends-at prefix-edge)
                                 ends-at segment))
      (:post-head   ;(break "adverbs only")
       (mine-treetops-as-vg-head (pos-edge-ends-at prefix-edge)
                                 ends-at segment))
      (:any-aux/verb
       (mine-treetops-as-vg-head (pos-edge-ends-at prefix-edge)
                                 ends-at segment))
      (:break
       (break "mine verb: prefix edge has form 'vg'. Check this out")))))




(defun mine-treetops-as-VG-head (starts-at ends-at segment)
  (let* ((length (number-of-terminals-between starts-at ends-at)))
    (if (> length 1)
      (mine-after-prefix-of-multi-term-vg starts-at ends-at segment)

      (let* ((verb (pos-terminal starts-at))
             (verb-term (mine-verb/edge verb starts-at ends-at segment)))
        (list verb-term)))))


(defun mine-after-prefix-of-multi-term-vg (starts-at ends-at segment)
  ;; This should see it as indetermant relationship between
  ;; them. ////////something like a check for adverbs and then
  ;; a treatment of verb-modifiers by analogy to classifiers is needed
  (let* ((length (number-of-treetops-between starts-at ends-at))
         edge
         (p-minus1 (if (setq edge (left-multiword-treetop ends-at))
                     (pos-edge-starts-at edge)
                     (chart-position-before ends-at)))

         (p-minus2 (when (>= length 2)
                     (if (setq edge (left-multiword-treetop p-minus1))
                       (pos-edge-starts-at edge)
                       (chart-position-before p-minus1))))

         (p-minus3 (when (>= length 3)
                     (if (setq edge (left-multiword-treetop p-minus2))
                       (pos-edge-starts-at edge)
                       (chart-position-before p-minus2))))

         (p-minus4 (when (>= length 4)
                     (if (setq edge (left-multiword-treetop p-minus3))
                       (pos-edge-starts-at edge)
                       (chart-position-before p-minus3))))

         (p-minus5 (when (>= length 5)
                     (if (setq edge (left-multiword-treetop p-minus4))
                       (pos-edge-starts-at edge)
                       (chart-position-before p-minus4))))

         (p-minus6 (when (>= length 6)
                     (if (setq edge (left-multiword-treetop p-minus5))
                       (pos-edge-starts-at edge)
                       (chart-position-before p-minus5)))))

    (when (> length 6)
      (break "add another case here"))

    (let ((term-minus6
           (when p-minus6
             (mine-unmarked-term/edge (pos-terminal p-minus6)
                                      p-minus6 p-minus5 )))
          (term-minus5
           (when p-minus5
             (mine-unmarked-term/edge (pos-terminal p-minus5)
                                      p-minus5 p-minus4 )))
          (term-minus4
           (when p-minus4
             (mine-unmarked-term/edge (pos-terminal p-minus4)
                                      p-minus4 p-minus3 )))

          (term-minus3
           (when p-minus3
             (mine-unmarked-term/edge (pos-terminal p-minus3)
                                      p-minus3 p-minus2 )))

          (term-minus2
           (when p-minus2
             (mine-unmarked-term/edge (pos-terminal p-minus2)
                                      p-minus2 p-minus1 )))

          (verb-term
           (mine-verb/edge (pos-terminal p-minus1)
                           (chart-position-before ends-at)
                           ends-at segment)))

      (cond ((and term-minus2 term-minus3 term-minus4 term-minus5 term-minus6)
             (list term-minus6 term-minus5 term-minus4 term-minus3 term-minus2 verb-term))
            ((and term-minus2 term-minus3 term-minus4 term-minus5)
             (list term-minus5 term-minus4 term-minus3 term-minus2 verb-term))
            ((and term-minus2 term-minus3 term-minus4)
             (list term-minus4 term-minus3 term-minus2 verb-term))
            ((and term-minus2 term-minus3)
             (list term-minus3 term-minus2 verb-term))
            (term-minus2
             (list term-minus2 verb-term))
            (t (list verb-term))))))


;;--- subroutine of Mine-verb/edge

(defun adjust-rule-to-verb (edge)
  ;; This is the edge formed over some unknown term. We have
  ;; just learned that its word should be interpreted as a
  ;; verb, so we adjust the form of the rule that created the
  ;; edge so that next time it will start out the right way
  ;; and we change this instance as well (///) to facilitate
  ;; any later parsing within the analyzed segment
  (let ((cfr (edge-rule edge))
        (word (edge-left-daughter edge))
        adverb? )

    (unless (and (word-p word)
                 (null (cdr (cfr-rhs cfr))))
      (if *break-on-pattern-outside-coverage?*
        (break "Assumptions not supported:  Expected this edge to ~
                be an unknown-term~%with a word as its left daughter.~
                ~%Instead the daughter is ~A~%edge: ~A" word edge)
        (return-from Adjust-rule-to-verb)))

    (let ((form (if (word-morphology word)
                  (ecase (word-morphology word)
                    (:ends-in-s category::verb+s)
                    (:ends-in-ed category::verb+ed)
                    (:ends-in-ing category::verb+ing)
                    (:ends-in-ly
                     (setq adverb? t)
                     category::adverb))
                  category::verb)))

      (setf (edge-form edge) form)
      (setf (cfr-form cfr) form)
      (unless adverb?
        (assign-brackets-as-a-main-verb word)))))



;;;-----
;;; NPs
;;;-----

(defun mine-treetops-as-head/classifiers (starts-at ends-at segment)
  ;; generic subroutine that could be given a suffix or a whole
  ;; segment, and which could have no edges or a bunch of them
  ;; but would not have one edge over the entire region.
  ;;   Returns the treetop items (denotations) it finds.
  ;;   Assumes a classifier/head analysis makes sense.

  (let* ((length (number-of-treetops-between starts-at ends-at)))
          ;; has to be a least one

    (cond ((= length 1)
           (let* ((head (mine-head/edge? starts-at ends-at segment)))
             (list head)))

          ((= length 2)
           ;; the first of the two terms is taken as a classifier,
           ;; the second as a head
           (multiple-value-bind (classif-term pos-between)
                                (next-treetop/rightward starts-at)
             (declare (ignore classif-term))
             (let* ((head (mine-head/edge? pos-between ends-at segment))
                    (classifier (mine-classifier/edge
                                 starts-at pos-between head segment)))
               ;(format t "~%      head = ~A~
               ;           ~%   classif = ~A~%" head classifier)

               (consider-reifying/classifier+np-head
                classifier head segment starts-at pos-between)

               (list classifier head))))

          ((> length 2)
           (tr :length-of-long-segment 
               (number-of-treetops-between starts-at ends-at))
           (hack-long-segment/mining starts-at ends-at)))))



(defvar *seq* nil)

(defun hack-long-segment/mining (starts-at ends-at)

  ;; if we already had information about how the more than two terms
  ;; in this segment were related, it would already have been reflected
  ;; in parsed pair-terms and we wouldn't be here.  
  ;;    We have an object reified that will hold the whole compound
  ;; as a sequence. This gives us something to react to later when more
  ;; information about the internal grouping becomes available by inference.

  (let ((next-pos starts-at)
        tt  term  items )
    (loop
      (when (eq next-pos ends-at)
        (return))
      (setq tt (right-treetop-at/edge next-pos))
      ;;(format t "~&tt = ~A~%" tt)

      (setq term
            (etypecase tt
              (edge
               (if (polyword-p (edge-category tt))
                 (mine-unmarked-term/pw tt)
                 (edge-referent tt)))
              (word
               (mine-unmarked-term
                tt next-pos (chart-position-after next-pos)))))

      (when (edge-p tt)
        (unless (polyword-p (edge-category tt))
          (tr :term-from-long-segment-edge term tt)))

      (when (word-p term)
        (setq term
              (adjudicate-word-as-referent-in-long-segment term tt)))

      (push term items)

      (setq next-pos (etypecase tt
                       (word (chart-position-after next-pos))
                       (edge (pos-edge-ends-at tt)))))

    (let ((sequence (define-sequence (nreverse items))))
      (list
       (define-individual 'unanalyzed-compound
         :terms sequence) ))))



(defun mine-treetops/indeterminate-relationship (starts-at ends-at segment)
  ;; some/all of the treetops in this segment are unknown-term edges,
  ;; and we do not have enough information to make an informed judgement
  ;; about the relationships between them other than precedes/follows.
  (let* ((length (number-of-treetops-between starts-at ends-at)))
    (case length
      (1 ;;(break "called with just one word/term instead of several")
       (list (mine-unmarked-term (pos-terminal starts-at) starts-at ends-at)))
                           
      (2 (mine-treetops/indeterminate-relationship/2 starts-at ends-at segment))
      (otherwise
       (tr :length-of-long-segment length)
       (hack-long-segment/mining starts-at ends-at)))))


(defun mine-treetops/indeterminate-relationship/2 (starts-at ends-at segment)
  ;; analogous to Scan-two-word-segment/unknown except that we're
  ;; usually dealing with edges and consequently with known terms.
  (let* ((tt1 (right-treetop-at starts-at))
         pw1  midpoint  tt2  pw2  )

    (when (eq tt1 :multiple-initial-edges)
      (setq tt1 (single-best-edge-over-word starts-at)))

    (setq pw1 (when (polyword-p (edge-category tt1))
                tt1))

    (when (edge-p tt1)
      (when (edge-for-literal? tt1)
        (setq tt1 (edge-left-daughter tt1))))

    (setq midpoint (if (word-p tt1)
                     (chart-position-after starts-at)
                     (pos-edge-ends-at tt1)))

    (setq tt2 (right-treetop-at midpoint))
    (when (eq tt2 :multiple-initial-edges)
      (setq tt2 (single-best-edge-over-word midpoint)))

    (setq pw2 (when (polyword-p (edge-category tt2))
                tt2))

    (when (edge-p tt2)
      (when (edge-for-literal? tt2)
        (setq tt2 (edge-left-daughter tt2))))

    (tr :two-terms-indeterminate tt1 tt2)
          
    (when (eq tt2 :multiple-initial-edges)
      (break "Data error: A treetop shouldn't be :multiple-initial,~
              but the one over \"~A\" is" (pos-terminal midpoint)))

    (let
      ((terms
        (cond
         ((and pw1 pw2)
          (let ((term1 (mine-unmarked-term/pw pw1))
                (term2 (mine-unmarked-term/pw pw2)))
            (mine-treetops/new-terms/2 term1 term2 segment
                                       starts-at midpoint)))
         
         ((and pw1 (edge-p tt2))
          (let ((term1 (mine-unmarked-term/pw pw1)))
            (mine-treetops/one-new-&-one-established term1 tt2 segment
                                                     starts-at midpoint)))
         
         (pw1
          (let ((term1 (mine-unmarked-term/pw pw1))
                (term2 (mine-unmarked-term tt2 midpoint ends-at)))
            (mine-treetops/new-terms/2 term1 term2 segment
                                       starts-at midpoint)))
         
         ((and (edge-p tt1) pw2)
          (let ((term2 (mine-unmarked-term/pw pw2)))
            (mine-treetops/one-established-&-one-new tt1 term2 segment
                                                     starts-at midpoint)))
         
         (pw2
          (let ((term1 (mine-unmarked-term tt1 starts-at midpoint))
                (term2 (mine-unmarked-term/pw pw2)))
            (mine-treetops/new-terms/2 term1 term2 segment
                                       starts-at midpoint)))
         
         ((and (edge-p tt1) (edge-p tt2))
          (mine-treetops/established-terms/2 tt1 tt2 segment
                                             starts-at midpoint))
         
         ((edge-p tt1)
          (setq tt2 (mine-unmarked-term tt2 midpoint ends-at))
          (mine-treetops/one-established-&-one-new tt1 tt2 segment
                                                   starts-at midpoint))
         
         ((edge-p tt2)
          (setq tt1 (mine-unmarked-term tt1 starts-at midpoint))
          (mine-treetops/one-new-&-one-established tt1 tt2 segment
                                                   starts-at midpoint))
         
         (t ;; have to treat it as though it were two unknown
          ;; words since the edges that span these words are literals
          (let ((terms
                 (mine-two-unknown-word-sequence starts-at ends-at)))
            (mine-treetops/new-terms/2 (first terms) (second terms)
                                       segment starts-at midpoint))
          ))))
      terms )))




(defun mine-two-unknown-word-sequence (starts-at ends-at)
  (let* ((left (pos-terminal starts-at))
         (midpoint (chart-position-after starts-at))
         (right (pos-terminal midpoint)))

    (let* ((left-term (mine-unmarked-term left starts-at midpoint))
           (right-term (mine-unmarked-term right midpoint ends-at)))

      (list left-term right-term))))




(defun mine-treetops/new-terms/2 (term1 term2 segment
                                  starts-at midpoint)
  ;; neither term has been seen before, so this is identical to
  ;; Scan-two-unknown-term-segment except that the operations on this
  ;; thread are modularized differently. We do the relationships between
  ;; the elements here, but then just return the terms and leave the
  ;; categorization of the segment and its spanning to the caller
  (tr :mining-two-new)

  (bind-variable 'contains term1 segment)
  (bind-variable 'contains term2 segment)
  (bind-variable 'adjacent/precedes term2 term1)
  (bind-variable 'adjacent/follows term1 term2)
  
  (consider-reifying/adjacent-terms term1 term2 segment
                                          starts-at midpoint)
  (list term1 term2))



(defun mine-treetops/established-terms/2 (tt1 tt2 segment
                                          starts-at midpoint)
  ;; both terms have been seen before, so while we don't have any
  ;; explicit internal evidence about how they relate, maybe there
  ;; things that we already know about them that will let us
  ;; conclude something
  (tr :both-known)
  (let* ((left-term (edge-referent tt1))
         (right-term (edge-referent tt2))
         (terms (list left-term right-term)))

    (bind-variable 'contains left-term segment)
    (bind-variable 'contains right-term segment)
    (bind-variable 'adjacent/precedes right-term left-term)
    (bind-variable 'adjacent/follows left-term right-term)

    (consider-reifying/adjacent-terms left-term right-term segment
                                      starts-at midpoint)
    terms ))



(defun mine-treetops/one-established-&-one-new (edge1 term2 segment
                                                starts-at midpoint)
  ;; ///should be more clever since there's probably some inference
  ;; we can make online here
  (tr :mining-first-known-second-new)
  (let ((term1 (edge-referent edge1)))
    (bind-variable 'contains term1 segment)
    (bind-variable 'contains term2 segment)
    (bind-variable 'adjacent/precedes term2 term1)
    (bind-variable 'adjacent/follows term1 term2)

    (consider-reifying/adjacent-terms term1 term2 segment
                                      starts-at midpoint)
    (list term1 term2)))



(defun mine-treetops/one-new-&-one-established (term1 edge2 segment
                                          starts-at midpoint)
  ;; ///should be more clever since there's probably some inference
  ;; we can make online here
  (tr :mining-first-new-second-known)
  (let ((term2 (edge-referent edge2)))
    (bind-variable 'contains term1 segment)
    (bind-variable 'contains term2 segment)
    (bind-variable 'adjacent/precedes term2 term1)
    (bind-variable 'adjacent/follows term1 term2)

    (consider-reifying/adjacent-terms term1 term2 segment
                                      starts-at midpoint)    
    (list term1 term2)))





;;;------------------------
;;; checking out odd cases
;;;------------------------

(defun adjudicate-word-as-referent-in-long-segment (word edge)
  ;; Called from Hack-long-segment/mining when a word gets passed
  ;; through as the referent of an edge (i.e. a literal). We return
  ;; the term (which will go into a sequence) that it is to use
  ;; for the word or break with a complaint.
  ;;   If we're doing PNF then any word is legitimate as a term,
  ;; including punctuation and we make a silent Name-word for it.
  ;; Otherwise we have to complain at punctuation or function words.
  (declare (ignore edge))
  (if *PNF-has-control*
    (or (name-word-for-word word)
        (make-name-word-for/silent word))
    (cond
     ((function-word? word)
      (if *break-on-pattern-outside-coverage?*
        (then
          (break "A literal edge over the function word \"~A\"~
                  was mined by Hack-long-segment/mining in a context ~
                  other than a name."
                 (word-pname word))
          (or (name-word-for-word word)
              (make-name-word-for/silent word)))))

     ((punctuation? word)
      (if *break-on-pattern-outside-coverage?*
        (then
          (break "A literal edge over the punctuation \"~A\"~
                  was mined by Hack-long-segment/mining in a context ~
                  other than a name."
                 (word-pname word))
          (or (name-word-for-word word)
              (make-name-word-for/silent word)))))

      (t (define-individual-for-term word)))))

