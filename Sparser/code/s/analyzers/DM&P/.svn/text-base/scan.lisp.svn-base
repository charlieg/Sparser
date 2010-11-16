;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:  "scan"
;;;    Module:  "analyzers;DM&P:"
;;;   version:  July 1994

;; initiated 3/28/94 v2.3. 5/23 fleshing out.  7/11,12,13,14 cont. fleshing out more cases

(in-package :sparser)

;;;-------------------
;;; all unknown words
;;;-------------------

(defun scan-words-and-mine (starts-at ends-at)
  ;; called from dm/Analyze-segment when the coverage shows there
  ;; are no edges within the scanned segment after it has been
  ;; parsed at the segment level.
  ;;   This is the case where absolutely nothing is known

  (let* ((s (define-segment starts-at ends-at))
         (pos-before-head (chart-position-before ends-at))
         (word (pos-terminal pos-before-head)))

    (if (eq starts-at pos-before-head)   ;; it's one word long
      (mine-one-word s word starts-at ends-at)

      ;; more than one word -- we assume it's an NP since it has
      ;; no known items in its prefix (that would have gone to a
      ;; different driver)
      (let* ((head (mine-head pos-before-head ends-at s))
             (classifier (mine-classifier pos-before-head head s))
             (end-minus-2 (chart-position-before pos-before-head)))

        (if (eq starts-at end-minus-2)
          (span-mined-segment s starts-at ends-at
                              `(,classifier ,head))
          (break "greater than two term segment of unknown words:~
                  ~%   ~A" s))))))


(defun mine-one-word (s word starts-at ends-at)
  (let ((marked-form
         (cond ((noun/verb-ambiguous? word)
                category::noun/verb-ambiguous )
               ((verb? word)
                ;; /// this ignores specific morphology
                category::verb )
               (t nil))))
    (bind-variable 'form (or marked-form category::segment) s)

    (let ((item
           (if marked-form
             (ecase (cat-symbol marked-form)
               (category::verb
                (mine-as-a-verb starts-at ends-at s))
               (category::noun/verb-ambiguous
                (mine-as-noun/verb starts-at ends-at s)))
             (mine-head starts-at ends-at s))))
      
      ;; 'mining' the word will introduce an edge as a side-effect
      ;; but we want a uniform edge reflecting the segment's status
      ;; qua segment, so we pass this on to another routine to
      ;; have that extra edge made
      (span-mined-segment s starts-at ends-at (list item)
                          :label marked-form
                          :form marked-form))))



(defun mine-rest-of-segment (s head
                               start-pos ;; first pos w/ unknown
                               end-pos   ;; pos before head / known tail
                               daughters seg-starts-at seg-ends-at)
  ;; the segment had some analyzable elements at its start, and
  ;; its head has been handled, but there are some unknown terms
  ;; between them.
  (let ((length (number-of-terminals-between start-pos end-pos)))
    (if (= length 1)
      (let ((classifier (mine-classifier end-pos head s)))
        (push classifier daughters)
        (span-mined-segment s seg-starts-at seg-ends-at
                            (nreverse (push head daughters))))

      (let ((additional-daughters
             (collect-pre-classifiers
              s start-pos (chart-position-before end-pos))))
        (setq daughters (append daughters additional-daughters))

        (let ((classifier
               (mine-classifier end-pos head s)))
          (push classifier daughters)
          (span-mined-segment s seg-starts-at seg-ends-at
                              (nreverse (push head daughters))))))))


(defun collect-pre-classifiers (s start-pos end-pos)
  ;; the words between these positions are probably all unknown words.
  ;; Certainly the first one is, otherwise we wouldn't have gotten here
  (let ((position start-pos)
        daughters  edge  word  next-position )
    (loop
      (setq next-position (chart-position-after position))
      (if (setq edge (nontrivial-terminal-edge-at position))
        (push (dm&p-analyzable-record-of-edge edge)
              daughters)
        (if (known-word? (setq word (pos-terminal position)))
          (push word daughters)
          (push (mine-pre-classifier s word position next-position)
                daughters)))
      (when (eq next-position end-pos)
        (return))
      (setq position next-position))

    ;; the caller does the nreverse
    daughters ))



;;;------------
;;; some edges
;;;------------

(defun scan-treetops-and-mine (starts-at ends-at)
  ;; called from dm/Analyze-segment when the coverage is either
  ;; discontinuous edges or some-adjacent-edges

  (let* ((s (define-segment starts-at ends-at))
         (prefix (edge-starting-at starts-at))) ;; ignoring possibility of multiples
    (if prefix
      (scan-treetops/prefixed s prefix starts-at ends-at)
      (scan-treetops/from-right s starts-at ends-at))))


(defun scan-treetops/prefixed (s prefix starts-at ends-at)
  (let* ((form (edge-form prefix))
         (category
          (cond ((eq form category::possessive)
                 category::np )
                ((and (one-word-long? prefix)
                      (determiner? (pos-terminal starts-at)))
                 category::np )
                (form form)
                (t nil))))
    (let ((items (mine-treetops-from-right (pos-edge-ends-at prefix)
                                           ends-at s)))
      ;; call parser ??
      ;; make edge if one doesn't form by itself (via parse)
      (span-mined-segment s starts-at ends-at items
                          :label category
                          :form category))))


(defun scan-treetops/from-right (s starts-at ends-at)
  ;; the segment doesn't have a prefix, so we probably can't know
  ;; its syntactic category
  (let ((items (mine-treetops-from-right starts-at ends-at s)))
    (break)))


(defun mine-treetops-from-right (starts-at ends-at segment)
  ;; generic subroutine that could be given a suffix or a whole
  ;; segment, and which could have no edges or a bunch of them.
  ;; Returns the treetop items (denotations) it finds.
  ;;   Assumes a classifier/head analysis makes sense.

  (let* ((length (number-of-terminals-between
                  starts-at ends-at))
         ;; has to be a least one word
         (pos-before-head (chart-position-before ends-at))
         (head (mine-head/edge? pos-before-head ends-at segment)))

    (when (> length 2)
      (break "region of more than two words to mine:~
              ~%  ~A" (string-of-words-between starts-at ends-at)))

    (if (= length 2)
      ;; the second word is taken as a classifier
      (let* ((classifier (mine-classifier/edge
                          (chart-position-before pos-before-head)
                          pos-before-head head segment)))
        (list classifier head))

      ;; return the one item we've found
      (list head))))



#|  general walk
             (position starts-at)
             daughters  edge  word )
        (loop
          (if (setq edge (nontrivial-terminal-edge-at position))
            (push (dm&p-analyzable-record-of-edge edge)
                  daughters)
            (if (known-word? (setq word (pos-terminal position)))
              (push word daughters)
              (else
                ;; it's unknown (or we have to extend the base grammar)
                ;; and we start mining at this point
                (return))))
          (setq position (chart-position-after position))
          (when (eq position pos-before-head)
            ;; check outside this loop again
            (return)))

        (if (eq position pos-before-head)
          ;; it was known items throughout
          (span-mined-segment s starts-at ends-at
                              (nreverse (push head daughters)))

          ;; there are some items still to mine
          (mine-rest-of-segment s head position pos-before-head
                                daughters starts-at ends-at))
      |#



;;;-------------------
;;; one spanning edge
;;;-------------------

(defun mine-under-edge-covering-whole-segment (starts-at ends-at)
  ;; called from dm/Analyze-segment when the coverage is 'one-edge-
  ;; -over-entire-segment.
  (let* ((edge (edge-between starts-at ends-at))
         (category (edge-category edge))
         (form (edge-form edge)))

    (cond (;; respan some cases
           (or (eq form category::verb)
               (eq form category::noun/verb-ambiguous)
               (eq form category::proper-name)
               (eq form category::proper-noun)
               (eq form category::apple-key))
           (let ((s (define-segment starts-at ends-at))
                 (verb-term (edge-referent edge)))
             (bind-variable 'head verb-term s)
             (span-mined-segment s
                                 starts-at ends-at
                                 (edge-referent edge)
                                 :label form
                                 :form form)))

          (;; don't mine things twice
           (eq category (category-named 'unknown-term))
           ;; but do give them a good segment-level label
           (span-mined-segment (define-segment starts-at ends-at)
                               starts-at ends-at
                               (list (edge-referent edge))))

          (;; some literals will have information about their morphology
           ;; that should be kept
           (and (word-p category)
                form )
           (span-mined-segment (define-segment starts-at ends-at)
                               starts-at ends-at
                               (list (edge-referent edge))
                               :form form))

          (;; capitalization isn't interesting, so redo it as
           ;; a word to be mined
           (eq category category::capitalized-word)
           (mine-one-word (define-segment starts-at ends-at)
                          (pos-terminal starts-at)
                          starts-at ends-at))
      

          (;; an item that could be a treetop
           (or (eq form category::adverb)
               ))

          (;; no further analysis of section markers
           (eq form (category-named 'section-marker)))
          (t
           (break "new case")))))




;;;-------------------------------
;;; dealing with individual words
;;;-------------------------------

(defun mine-as-a-verb (pos-before pos-after segment)
  ;; the one word between these positions has been identified as
  ;; a verb
  (let ((word (pos-terminal pos-before)))
    (tr :mining-verb word)
    (multiple-value-bind (verb its-edge)
                         (define-individual-for-unknown-term
                           word pos-before pos-after
                           :category  category::verb
                           :form category::verb)
      (declare (ignore its-edge))
      (bind-variable 'head verb segment)
      verb )))


(defun mine-as-noun/verb (pos-before pos-after segment)
  ;; not clear exactly what to do before start doing type-cascades
  (let ((word (pos-terminal pos-before)))
    (tr :mining-noun/verb word)
    (multiple-value-bind (verb its-edge)
                         (define-individual-for-unknown-term
                           word pos-before pos-after
                           :form category::noun/verb-ambiguous)
      (declare (ignore its-edge))
      (bind-variable 'head verb segment)
      verb )))


(defun mine-head (pos-before pos-after segment)
  ;; add the word to the model and make a rule and edge for it,
  ;; mark the edge as the head of an np,
  ;; associate the new individual with this segment

  (let ((word (pos-terminal pos-before)))
    (tr :mining-head word)
    (multiple-value-bind (head its-edge)
                         (define-individual-for-unknown-term
                           word pos-before pos-after)
      (setf (edge-form its-edge) category::np-head)
      (bind-variable 'head head segment)
      head )))


(defun mine-head/edge? (pos-before pos-after segment)
  ;; if there's an edge over this word, use it assuming it
  ;; isn't trivial. 
  (if (ev-top-node (pos-starts-here pos-before))
    (let ((edges
           (only-nontrivial-edges 
            (all-preterminals-at pos-before))))
      (if edges
        (if (cdr edges)
          (break "more than one edge was nontrivial:~
                  ~%~A" edges)
          (note-instance (car edges) 'head segment))
        (mine-head pos-before pos-after segment)))
    (mine-head pos-before pos-after segment)))



(defun mine-classifier (pos-after head segment)
  (let* ((pos-before (chart-position-before pos-after))
         (word (pos-terminal pos-before)))
    (tr :mining-classifier word)
    (multiple-value-bind (classifier its-edge)
                         (define-individual-for-unknown-term 
                           word pos-before pos-after)
      (setf (edge-form its-edge) category::classifier)
      (bind-variable 'classifier classifier segment)
      (bind-variable 'classifies head classifier)
      classifier )))


(defun mine-classifier/edge (pos-before pos-after
                             head segment)
  (if (ev-top-node (pos-starts-here pos-before))
    (let ((edges
           (only-nontrivial-edges 
            (all-preterminals-at pos-before))))
      (if edges
        (then
          (when (cdr edges)
            (break "more than one edge was nontrivial:~
                    ~%~A" edges))
          (note-instance (car edges) 'classifier segment))
        (mine-classifier pos-after head segment)))
    (mine-classifier pos-after head segment)))




(defun mine-pre-classifier (segment word pos-before pos-after)
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
  ;(unless (eq (edge-category edge) category::unknown-term)
  ;  (break "Threading? 'noting' an edge that isn't an unknown ~
  ;          term:~%~A" edge))
  (let ((unit (edge-referent edge)))
    (tr :noting-instance unit name-of-variable)
    (bind-variable name-of-variable unit segment)
    unit))



;;;------------------------------------------------------------
;;; noting known edges for later analysis of segment structure
;;;------------------------------------------------------------

(defun dm&p-Analyzable-record-of-edge (edge)
  (let ((label (edge-category edge)))
    (etypecase label
      (word label)  ;; e.g. "the", "a"
      (category
       (break "Stub: what's an analyzable record for a vanila category?"))
      ((or referential-category mixin-category)
       (edge-referent edge)))))



;;;---------------
;;; vetting edges
;;;---------------

(defun only-nontrivial-edges (list-of-edges)
  (let ( vetted-edges  label )
    (dolist (edge list-of-edges)
      (setq label (edge-category edge))

      ;; no literals
      (unless (word-p label)
        ;; no morph edges
        (unless (eq label category::capitalized-word)
          (push edge vetted-edges))))

    (nreverse vetted-edges)))


(defun nontrivial-terminal-edge-at (p)
  ;; C&S -- later we'll merge these
  (let ((edges (only-nontrivial-edges (all-preterminals-at p))))
    (when edges
      (if (cdr edges)
        (unless (edges-all-chain p :start)
          (break "more than one edge was nontrivial:~
                  ~%~A" edges))
        (car edges)))))

