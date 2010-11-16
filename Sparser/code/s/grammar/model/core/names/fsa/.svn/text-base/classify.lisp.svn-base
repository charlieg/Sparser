;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993,1994  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "classify"
;;;   Module:  "model;core:names:fsa:"
;;;  version:  0.7 March 1994

;; initiated 5/15/93 v2.3 to fit PNF paper
;; 0.1 (6/10) tweeked judgement over single words
;; 0.2 (6/18) and again -- they need sequence intermediaries for consistency
;;      with all other names
;; 0.3 (6/30) changed the treatment of single word cap.seq. so that it
;;      didn't presume that it was a name.
;;     (10/22) added case there for proper-adjectives  (10/28) filled stub for
;;      two edges over a single capitalized word
;; 0.4 (12/7) added case to handle "AN" ambiguity and stubbed the case of
;;      single unclassified capitalized words
;; 0.5 (1/27/94) broke out the pnf transition driver to [do transitions]
;; 0.6 (3/15) switched where single-edge routine looked to appreciate that an
;;      edge is a literal
;; 0.7 (3/28) tweeked the fields of the edge made by Span-as-capitalized-word

(in-package :sparser)

;;;--------
;;; driver
;;;--------

(defun classify-and-record-name (starting-position
                                 ending-position)

  ;; called from PNF's driver, PNF, after the sequence has been delimited.
  ;; The delimiting can introduce edges around some punctuation, so
  ;; we have to look for that case. Otherwise any edges over known
  ;; words will be introduced here.
  ;;    Returns an edge to indicate that it has a successful analysis
  ;; or Nil if it doesn't think the delimited span holds a name.

  (if (eq ending-position (chart-position-after starting-position))
    (c&r-single-word starting-position ending-position)
    (else
      (let ((edge (span-covered-by-one-edge?
                   starting-position ending-position)))
        (if edge
          (c&r-single-spanning-edge edge)
          (c&r-multi-word-span starting-position ending-position))))))



;;;------------------------------------------------------
;;; one edge already over the whole span from delimiting
;;;------------------------------------------------------

(defun c&R-single-spanning-edge (edge)
  ;; there is more than one word in the delimited span but one of
  ;; the routines run then covered the whole span with an edge,
  ;; e.g. for an abbreviation ("Inc.") or an initial.
  edge )



;;;---------------------------------------
;;; special case of a one-word 'sequence'
;;;---------------------------------------

(defparameter *treat-single-Capitalized-words-as-names*  nil
  "Read by C&R-single-word and set in the various switch setting 
   routines.")


(defun c&R-single-word (position next-position)

  ;; The sequence is just one word long. We introduce its edges,
  ;; and if there aren't any, distinguish between function words
  ;; (which we assume not to be names) and other. We then consult
  ;; a protocol flag as to whether we should assume by default that
  ;; it is a name (for which we introduce an edge as an uncharacterized
  ;; name) or just leave it as an unknown word that will perhaps
  ;; be enriched by a later context-sensitive rule.

  (let ((word (pos-terminal position))
        (status (pos-assessed? position)))

    (ecase status
      ;; has to have some status because we scanned it in order 
      ;; to reach this point
      (:word-fsas-done
       (install-terminal-edges word position next-position))
      (:boundaries-introduced
       (install-terminal-edges word position next-position))
      (:preterminals-installed ))

    (if (ev-top-node (pos-starts-here position))
      (then ;; there are some edges
        (sortout-edges-over-single-cap-word position next-position))
      (else
        ;; No edges.
        ;; The word is capitalized, so the question is whether it's a
        ;; function word (and then maybe we also check whether we're
        ;; function beginning of the sentence).  If it is, we return
        ;; function to the fsa driver that we're rejecting this one
        ;; as a name and the regular processing should get a crack at it.
        (if (function-word? word)
          nil
          (if (unknown-word? word)
            (if *treat-single-Capitalized-words-as-names*
              (do-single-word-name word position next-position)
              (span-as-capitalized-word word position next-position)
              )))))))


;;;---------------------
;;; single unknown word
;;;---------------------

(defun do-single-word-name (word position next-position)
  ;; we know that there's no individual with this name yet
  ;; because if there were we'd have a name-word edge instead
  ;; of this unknown word, so we go ahead and create the individual
  ;; (of type "uncategorized-name") that has this word as their name

  (let ((name (make-throw-away-individual category::uncategorized-name))
        (name-word (make-name-word-for-unknown-word-in-name word)))

    (let ((sequence (def-individual category::sequence
                      ;; This indexes the name-word to the sequence
                      :items (list name-word)
                      :number 1
                      :type category::name-word)))

      (bind-variable 'name/s sequence name)
      (index/uncategorized-name name (list name-word))

      (let ((edge (edge-over-proper-name
                   position next-position
                   category::name
                   name   ;; referent
                   :single-unknown-capitalized-word   ;; rule
                   nil))) ;; daughter edges
        edge ))))



(define-category capitalized-word)

(defun span-as-capitalized-word (word position next-position)
  ;; same idea as do-single-word-name, but the flag to interpret
  ;; otherwise unknown words as 'names' is down, so we just call
  ;; it a 'capitalized-word'
  ;;   N.b. this is a final call in PNF, so returning this edge
  ;; means that the fsa overall will be interpreted as 'succeeding'

  (make-chart-edge :starting-position position
                   :ending-position next-position
                   :category category::capitalized-word
                   :form nil
                   :rule :spelling-based-edge
                   :referent word
                   :left-daughter word
                   :right-daughter :single-term ))


;;;-------------------
;;; single known word
;;;-------------------

(defun sortout-edges-over-single-cap-word (position next-position)
  ;; subroutine for the case of C&R-single-word where there's
  ;; some analysis for it in the grammar. We have to decide whether
  ;; the edge over this word (or one of them) is something that
  ;; the Proper Name Facility should record as a name or not.
  ;; If it is, then the fsa has succeeded and we return the edge.
  ;; If it isn't we return nil and some other fsa or rule gets
  ;; a crack at it.

  (let ((ev (pos-starts-here position)))
    (if (= 1 (ev-number-of-edges ev))
      (let ((edge (ev-top-node ev)))
        (cond ((or (eq (edge-form edge) category::proper-noun)
                   (eq (edge-form edge) category::proper-adjective))
               (let ((new-edge (dereference-proper-noun edge)))
                 ;; Is this the name of someone/something?  If so,
                 ;; we should respan it with an edge with their
                 ;; category -- the "new-edge". If it isn't, then
                 ;; it's arguably not a "name" in the sense of being
                 ;; something that PNF was designed to look for
                 ;; (months fall into this category) and we should
                 ;; return nil.                      
                 (or new-edge
                     nil )))
              ;; else the edge might be over a function word that's
              ;; used as a literal in rules
              ((function-word? (pos-terminal position))
               nil )
              (t (other-single-cap-words edge))))

      (if (= 2 (ev-number-of-edges ev))
        ;; check if one of them is a literal and if so take the other.
        (let ((edges (edges-between position next-position))
              good-edge literal )
          (if (or (and (eq :literal-in-a-rule (edge-right-daughter (first edges)))
                       (setq good-edge (second edges)
                             literal (first edges)))
                  (and (eq :literal-in-a-rule (edge-right-daughter (second edges)))
                       (setq good-edge (first edges)
                             literal (second edges))))

            (if (or (eq (edge-form good-edge) category::proper-noun)
                    (eq (edge-form good-edge) category::proper-adjective))
              ;; copy of the code from above -- couldn't easily figure out
              ;; a good subroutine that would correctly feed "Cond"
              (let ((new-edge (dereference-proper-noun good-edge)))
                 (or new-edge
                     nil ))
              (else
                (two-edges/one-literal good-edge literal)))
            (else
              (break "New case for two edges over a single capitalized word~
                      ~%   Finish writing the code"))))
        (else
          (break "More than two edges over a single capitalized word~
                  ~%   Finish writing the code")
          :foo next-position )))))


(defun other-single-cap-words (edge)
  ;; its capitalized in a sequence one word long, and it isn't
  ;; a proper noun, a proper adjective, or a function word.
  ;; The substantive question is whether it's a hitherto unknown
  ;; proper name (e.g. "Ford"), but we can also identify some
  ;; established cases.
  ;;   We're a tail, so we have to indicate whether PNF succeeded
  ;; or not. 

  (case (cat-symbol (edge-category edge))
    (category::sgml-label
     ;; precludes other interpretations, though one can imagine
     ;; an ambiguity with an interesting unknown word -- we can leave
     ;; that case to imaginative Debris analysis
     nil )
    (otherwise
     ;; assume its a different kind of unknown word. // maybe look for
     ;; evidence that we're at the beginning of a sentence.
     nil )))



(defun two-edges/one-literal (non-literal literal)
  ;; One of the edges is just a literal in a rule, the other is
  ;; something else, where we've already covered the case that might
  ;; have been a proper noun or proper adjective.  
  ;;    The operant example to date is the ambiguity between "AN" the
  ;; tag in a header and "AN" the full-caps form of the indefinite
  ;; determiner.
  ;;   In any event, we're not going to accept this as a one word
  ;; hitherto unknown proper name, so we may as well let it all go through.
  (declare (ignore non-literal literal))
  nil )




(defun reduce-multiple-initial-edges (ev)
  ;; some routine has gotten an edge vector where it wanted an edge
  ;; and the reason is :multiple-initial-edges.  We go through the
  ;; edges and remove any literals.
  (let ((count (ev-number-of-edges ev))
        (vector (ev-edge-vector ev)))
    (ecase *edge-vector-type*
      (:kcons-list (break "Write this routine for kcons list version"))
      (:vector
       (if (= count 2)
         (let ( edge  good-edge )
           (dotimes  (i count)
             (setq edge (aref vector i))
             (unless (eq :literal-in-a-rule (edge-rule edge))
               (setq good-edge edge)))
           good-edge )
         (break "More than two edges need to be reduced"))))))

