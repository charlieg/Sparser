;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "next-terminal/invisible"
;;;   Module:  "analyzers;sectionizing:"
;;;  Version:  June 1994

;; initiated 6/2/94 v2.3

(in-package :sparser)

;;;--------------------------
;;; routine to connect it up
;;;--------------------------

(defun allow-invisible-markup ()
  (establish-version-of-next-terminal-to-use
   :invisible-markup-checked-for
   'detect-and-process-invisible-markup))


;;;---------
;;; globals
;;;---------

(defvar *buffered-token* nil)

(define-per-run-init-form '(setq *buffered-token* nil))


;;;---------------
;;; next-terminal
;;;---------------

(defun detect-and-process-invisible-markup ()
  (if *buffered-token*
    (kpop *buffered-token*)

    (let ((word (next-token)))
      (if (eq word word::open-angle-bracket)
        (lookahead-for-invisible-markup)
        word ))))


(defun lookahead-for-invisible-markup ()
  ;; peek at the next characters, checking them against the
  ;; trie for invisible markup. If the sequence is found,
  ;; we return a keyword + section-marker pair to this point.
  ;; If this next alpabetic token is not invisible markup,
  ;; then we pretend all this never happened and return
  ;; the angle-bracket that triggered all this.  Since we
  ;; were just peeking, the next call to next-terminal will
  ;; get this token that we just found (or found some prefix of it)
  (multiple-value-bind (tag length)
                       (peek-at-next-chars/trie/invis-markup
                        (trie-network *invisible-markup-trie*) 1)
    (if tag
      (establish-hidden-markup-tag tag length)
      word::open-angle-bracket)))


(defun peek-at-next-chars/trie/invis-markup (trie-network
                                             number-of-chars-looked-at)
  ;; looks directly into the character buffer, circumventing the
  ;; usual machinery, which means we have to be prepared to
  ;; handle the buffer swap
  (let ((next-char (elt *character-buffer-in-use*
                        (+ *index-of-next-character*
                           number-of-chars-looked-at))))

    (when (eql next-char #\^d)
      (break "buffer swap")
      ;; swap buffers -- it's safe to do it here because we're
      ;; not looking ahead beyond where next-token will look if
      ;; we don't see what we're looking for
      (refill-character-buffer *character-buffer-in-use*)
      ;; n.b. after this swap the next-char index will have been
      ;; reset to its initialization value, -1
      (setq next-char (elt *character-buffer-in-use* 0)))

    (let ((continuation
           (char-continues-known-sequence? next-char trie-network)))
      (when continuation
        (unless (consp continuation)
          (break "Data bug: continuation isn't a list:~%~A" continuation))

        (if (keywordp (car continuation))
          (values continuation
                  number-of-chars-looked-at)
          (peek-at-next-chars/trie/invis-markup
           continuation (1+ number-of-chars-looked-at)))))))




(defun establish-hidden-markup-tag (tag-data length-of-tag)
  ;; We have just seen an open  angle-bracket followed by a tag
  ;; that we are to treat has 'hidden', in that it is not to
  ;; appear as a terminal in the chart. 
  (let ((keyword (car tag-data))
        (section-marker (cadr tag-data)))
    (ecase keyword
      (:initiate
       (establish-initiating-hidden-markup
        section-marker length-of-tag))
      (:terminate
       (establish-terminating-hidden-markup
        section-marker length-of-tag))
      (:annotation
       (establish-annotation-hidden-markup
        section-marker length-of-tag)))))


#| These are called from the marker-checking version of next-terminal
   so they are responsible, ultimately, for returning the next
   terminal that is to go into the chart.  |#


(defun establish-initiating-hidden-markup (sm length-of-tag)
  ;; the next word will fall under the scope of this tag,
  ;; so we put the marker on the 'starts-here' of the next
  ;; position since the word will be placed logically just after it.
  (let ((position (next-chart-position-to-fill)))
    (setf (ev-marker (pos-starts-here position)) sm)
    (let ((next-terminal
           (if (takes-internal-data sm)
             (scan-for-hidden-internal-markup-data sm position length-of-tag)
             (scan-for-tag-end-marker-and-continue length-of-tag))))
      next-terminal)))

(defun establish-terminating-hidden-markup (sm length-of-tag)
  ;; the last word under the scope of this marker was scanned
  ;; just a moment before, so we put this on the ends here
  ;; of the next position.
  (let ((position (next-chart-position-to-fill)))
    (setf (ev-marker (pos-ends-here position)) sm)
    (let ((next-terminal
           (if (takes-internal-data sm)
             (scan-for-hidden-internal-markup-data sm position length-of-tag)
             (scan-for-tag-end-marker-and-continue length-of-tag))))
      next-terminal)))

(defun establish-annotation-hidden-markup (sm length-of-tag)
  ;; the last word under the scope of this marker was scanned
  ;; just a moment before, so we put this on the ends here
  ;; of the next position.
  (let ((position (next-chart-position-to-fill))
        (operation (sm-initiation-action sm)))
    (multiple-value-bind (next-terminal features)
                         (if (takes-internal-data sm)
                           (scan-for-hidden-internal-markup-data
                            sm position length-of-tag)
                           (scan-for-tag-end-marker-and-continue
                            length-of-tag))
      (when operation
        (funcall operation position features))
      next-terminal)))



(defun scan-for-tag-end-marker-and-continue (length-of-tag)
  ;; we've peeked into the character buffer and recognized
  ;; a hidden markup tag. Now we peek once more for the
  ;; character that marks the end of the tag -- which should
  ;; be the very next character -- scarf it, and then make
  ;; another call to next-terminal to find the 'real' next
  ;; terminal to be added to the chart.
  (let ((next-char (elt *character-buffer-in-use*
                        (+ *index-of-next-character*
                           (1+ length-of-tag)))))

    (when (eql next-char #\^d)
      (break "buffer swap")
      ;; swap buffers -- it's safe to do it here because we're
      ;; not looking ahead beyond where next-token will look if
      ;; we don't see what we're looking for
      (refill-character-buffer *character-buffer-in-use*)
      ;; n.b. after this swap the next-char index will have been
      ;; reset to its initialization value, -1
      (setq next-char (elt *character-buffer-in-use* 0)))

    (unless (eql next-char #\> )
      (break "Threading: unexpected character after hidden markup ~
              string:~% \"~A\" " next-char))

    (setq *index-of-next-character*
          (1+ (+ *index-of-next-character* length-of-tag)))
    ;(break)
    (next-terminal)))




(defun scan-for-hidden-internal-markup-data (sm position length-of-tag)

  ;; we've scanned a tag by peeking into the character buffer, and
  ;; noticed that this tag can take internal markup between it
  ;; and the closing angle bracket.  Since we're now sure that
  ;; we have a tag we can shift to doing real consumption of tokens
  ;; from the stream until we reach that angle bracket.

  (declare (ignore position))

  ;; 1st reset the character index to point to just after the tag
  (setq *index-of-next-character*
        (1+ (+ *index-of-next-character* length-of-tag)))

  ;; We expect to see one or more markup tags, which will often
  ;; be polywords.  We check each token in sequence, and if it is
  ;; not by itself a markup label (i.e. the label is a word), then
  ;; we treat it as the beginning of a polyword and try to roll one
  ;; up from it and the tokens that follow until the next whitespace
  ;; or the angle bracket.
  (let ((markup-labels (cdr (sm-interior-markup sm)))
        word  pending-prefix  cfr  markup-found )
    (loop
      (setq word (next-token))
      (when (eq word word::close-angle-bracket)
        (when pending-prefix
          ;; we have to close it off
          (unless (member pending-prefix markup-labels :test #'eq)
            (error "unanticipated markup token: ~A~
                    ~%governing tag: ~A" pending-prefix sm))
          (push pending-prefix markup-found))
        (return))
      (cond (pending-prefix
             (if (whitespace word)
               ;; then the polyword should be over
               (then
                 (unless (member pending-prefix markup-labels :test #'eq)
                   (error "unanticipated markup token: ~A~
                           ~%governing tag: ~A" pending-prefix sm))
                 (push pending-prefix markup-found))
               (else
                 (setq cfr (multiply-labels pending-prefix word))
                 (unless cfr
                   (break "Expected ~A and ~A to combine~%as part of ~
                           a polyword representation of a interior ~
                           marker tag" pending-prefix word))
                 (setq pending-prefix
                       (cfr-category cfr)))))

            ((whitespace word))
            (t
             (if (member word markup-labels :test #'eq)
               (push pending-prefix markup-found)
               (setq pending-prefix word)))))

    (values (next-terminal)
            (nreverse markup-found))))

