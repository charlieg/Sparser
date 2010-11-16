;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1995  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "SUN"
;;;   Module:  "init;workspaces:"
;;;  version:  February 1995

;; initiated 1/5.  Added stuff for glossary 1/6.  Elaborating 1/16.
;; Tweeked settings 2/2

(in-package :sparser)

;;;----------
;;; settings
;;;----------

;*switch-setting*
;(Top-edges-setting/ddm)
(dm&p-setting)
(setq *introduce-brackets-for-unknown-words-from-their-suffixes* t)
;(establish-pnf-routine :scan/ignore-boundaries)  ;; kills "U.S."
(establish-pnf-routine :scan/ignore-boundaries/initials-ok
                       'pnf/scan/ignore-boundaries/initials-ok)
(setq *dm&p-forest-protocol* 'no-forest-level-operations)
;(setq *dm&p-forest-protocol* 'parse-forest-and-do-treetops)

(setq *independent-aux-subview-to-use* (wb-subview-named :independent-contents))
;(launch-subview-as-independent-window)


;(setq *do-new-head-term-forest-patterns* t)
(setq *do-new-head-term-forest-patterns* nil)


;;;-------
;;; files
;;;-------

(unless (boundp '*location-of-Sun-corpus*)
  (defparameter *location-of-Sun-corpus*
                "Sparser:corpus:Sun:srdb:"))

(defparameter s6371 (concatenate 'string
                       *location-of-Sun-corpus*
                       "6371"))
;(analyze-text-from-file s6371)


(defparameter *sgloss*
  "Moby:ddm:projects:SUN:glossary:sun-glossary.hacked")

(defun sgloss ()
  (let ((*current-style* (document-style-named 'SUN-glossary)))
    (analyze-text-from-file *sgloss*)))

;(ed *sgloss*)



;;;-------
;;; style
;;;-------

(define-document-style  SUN-glossary
  :init-fn setup-for-SUN-glossary )

(defun Setup-for-SUN-glossary ()
  (setq *ignore-capitalization* nil)
  (use-sun-glossary-NL-fsa))


;;;-----------------
;;; section markers
;;;-----------------

(defparameter *dictionary-entry*
  ;; trivial definition, but it gives the pause synchronizer
  ;; a hook and provides hard boundaries in the text for
  ;; defining sentence-start and partitioning segments.
  (define-section-marker "dictionary-entry"
    :implicitly-closes "dictionary-entry"))

(defparameter *letter-of-the-alphabet*
  ;; ditto
  (define-section-marker "letter-of-the-alphabet"
    ;; :implicitly-closes "letter-of-the-alphabet"
    ;; if we include such a pointer back to the last letter, we will
    ;; presently (2/95) blow up the Edges View because the distance
    ;; is so great the relevant positions will have recycled edges
    ))


;;;--------------------------------------
;;; newline routine for the sun glossary
;;;--------------------------------------

;;--- state variables

(defvar *just-started-the-text* nil)
(defvar *snl-two-in-a-row* nil)
(defvar *snl-three-in-a-row* nil)
(defvar *snl-text-has-started?* nil)
(defvar *next-word-is-a-single-letter* nil)
(defvar *pos-of-letter* nil)
(defvar *pos-starting-term-being-defined* nil)
(defvar *pos-starting-definition* nil)
(defvar *NL-action-waiting-on-next-NLs* nil)
(defvar *pos-possible-next-letter* nil)

(defvar *pos-term-just-finished-defining* nil
  "This is updated when we finish the body of text defining some term,
   i.e. when we see the nl pattern that indicates that we've reached
   the position of the next term to be defined, we set this to the
   position of the previous one.")

(defvar *just-restarted-sgloss* nil
  "set by Restart-sgloss")

(defvar *PNF-interrupted-before-def-text-ops* nil)


(defun Initialize-sun-nl-state ()
  (setq *snl-two-in-a-row* nil
        *snl-three-in-a-row* nil
        *pos-possible-next-letter* nil
        *NL-action-waiting-on-next-NLs* t
        *PNF-interrupted-before-def-text-ops* nil)
  (setq *just-started-the-text* t)

  (if *just-restarted-sgloss*
    (setq *snl-text-has-started?* t
          *next-word-is-a-single-letter* nil
          *pos-of-letter* nil
          *pos-starting-term-being-defined* (position# 1)
          *pos-starting-definition* nil
          *pos-term-just-finished-defining* nil
          *just-restarted-sgloss* nil
          )
    (setq *snl-text-has-started?* nil
          *next-word-is-a-single-letter* nil
          *pos-of-letter* nil
          *pos-starting-term-being-defined* nil
          *pos-starting-definition* nil
          *pos-term-just-finished-defining* nil
          *just-restarted-sgloss* nil
          )))

(define-per-run-init-form '(initialize-sun-nl-state))


;;--- fsa 

(defun Use-sun-glossary-NL-fsa ()
  (setf (symbol-function 'newline-fsa)
        (symbol-function 'Sun-glossary-nl-fsa))
  (setq *newline-fsa-in-use* 'sun-glossary-nl-fsa))


(defun Sun-glossary-nl-fsa (pos-being-filled)
  (increment-line-count) ;; the nl that called us
  (fill-whitespace pos-being-filled *newline* :display-word t)
  (setq *NL-action-waiting-on-next-NLs* nil)
  ;(format t "[[nil]] ")
  
  (let ((token (next-terminal)))
    (if (eq token *newline*)
      (then
        (increment-line-count)
        (fill-whitespace pos-being-filled *newline* :display-word t)
        (sun-gloss-nl-two-in-a-row pos-being-filled))
      (else
        ;; No ][ is introduced unless there is at least one blank line
        ;; between text segments.  This is presumably a case of a NL
        ;; within the text of a definition.
        (update-nl-state/one-nl pos-being-filled)
        token ))))

;(use-sun-glossary-NL-fsa)


(defun Sun-gloss-nl-two-in-a-row (pos-being-filled)
  (setq *snl-two-in-a-row* t)
  (let ((token (next-terminal)))
    (if (eq token *newline*)
      (then
        (increment-line-count)
        (fill-whitespace pos-being-filled *newline* :display-word t)
        (sun-gloss-nl-three-in-a-row pos-being-filled))
      (else
        (mark-position-as-generic-boundary pos-being-filled token)
        (update-nl-state pos-being-filled token)
        token ))))

(defun Sun-gloss-nl-three-in-a-row (pos-being-filled)
  (setq  *snl-two-in-a-row* nil
         *snl-three-in-a-row* t)
  (let ((token (next-terminal)))
    (if (eq token *newline*)
      (then
        (increment-line-count)
        (fill-whitespace pos-being-filled *newline* :display-word t)
        (break "New case: 4 newlines in a row"))
      (else
        (mark-position-as-generic-boundary pos-being-filled token)
        (update-nl-state pos-being-filled token)
        token ))))



;;--- Actions

(defun Update-nl-state (next-pos token)
  (cond
   (*just-started-the-text*
    ;; There are only two NLs before the first letter ('A') since
    ;; there is no text just finished to have a NL after it.
    (setq *just-started-the-text* nil)
    (setq *pos-possible-next-letter* next-pos))
   
   (*snl-three-in-a-row*
    ;; If we aren't just starting the text, we'll end up here when
    ;; the token we're pulling in the letter that marks the next
    ;; segment of the glossary.
    (setq *snl-three-in-a-row* nil)
    (setq *pos-possible-next-letter* next-pos))
   

   (*pos-possible-next-letter*
    ;; This is seen at the next multiple-NL event after
    ;; three NL's in a row have been seen.  We're at the
    ;; start of some next section-type.
    ;;    Have to check whether this really is a transition
    ;; to the next letter of the alphabet or a spurious case
    ;; of three rather than two lines between definitions.
    (if (= 1 (length (word-pname
                      (pos-terminal *pos-possible-next-letter*))))
      (next-letter-of-the-alphabet next-pos token)
      (else
        ;; Having concluded that it's spurious, we should
        ;; not presume that we know anything and just fall
        ;; through to check the other cases
        (cond
         (*pos-starting-definition*
          ;; The 3 NLs preceded a head term. Finish off the ongoing
          ;; definition text and then do the routine for processing
          ;; a head term.
          (finished-text-of-definition *pos-possible-next-letter*)
          (finished-entry-title next-pos token)
          ;; set up the state for the next case
          (setq *pos-starting-definition* next-pos)
          (setq *pos-starting-term-being-defined* nil)
          (setq *pos-possible-next-letter* nil))

         (t (break "New case of the situation at three-NL-in-~
                    a-row that don't mark a single letter")))))

    (if *snl-two-in-a-row*
      (setq *snl-two-in-a-row* nil)
      (break "Hit in 'possible-next-letter' but didn't have ~
              two NL's following the letter")))
   
   
   (*pos-starting-term-being-defined*
    ;; Initially set by the next-letter routine, and then
    ;; in alternation with the definition text.
    ;;   The next-pos is now the start of the text body
    (finished-entry-title next-pos token))


   (*pos-starting-definition*
    (finished-text-of-definition next-pos))
   

   (t (break "Multiple newlines but no relevant state"))))




(defun Update-nl-state/one-nl (next-pos)
  ;; called from Sun-glossary-nl-fsa as a hook for any
  ;; pathological cases
  (declare (ignore next-pos))
  (when *PNF-interrupted-before-def-text-ops*
    (break "*pos-starting-definition* flag up after one NL")
    (when *pnf-has-control*
      (break "we're under PNF again"))
    (starting-def-text *PNF-interrupted-before-def-text-ops*)
    (setq *PNF-interrupted-before-def-text-ops* nil)))




;;;------------------------------------
;;; subroutines to Update-nl-state/act
;;;------------------------------------

(defun Finished-entry-title (beginning-of-body &optional token)
  ;; We've just seen the two NLs that follow the name of the term
  ;; about to be defined by the text that follows at this position.
  
  (if *PNF-has-control*
    (then
      ;; A complication in this scheme (as compared with this
      ;; same setup in Next-letter-of-the-alphabet) is that since
      ;; an entry title can be many words long, it can contain
      ;; a capitalized sequence that ends before the entry title
      ;; does. Then, because the *pos-starting-term-being-defined*
      ;; flag is up, Adjudicate-after-pnf would call this routine
      ;; prematurely, i.e. before the NLs that terminate the
      ;; entry are seen.  To preempt this possibility, at the same
      ;; time as we turn on our flag, we turn on a flag that won't
      ;; be dropped until those NLs are seen, and we make the
      ;; Adjudicate-call sensitive to that flag.
      (sort-out-result-of-newline-analysis beginning-of-body token)
      (rest-of-Scan-next-position beginning-of-body)
      (throw :position-scan-terminates-PNF :end-the-scan))

    (else
      (cleanup-dictionary-term-debris-if-any
       *pos-starting-term-being-defined* beginning-of-body)
      
      (span-region-with-section-marker-edge
       *dictionary-entry* *pos-starting-term-being-defined* beginning-of-body)
      
      ;; set up the state for the next case
      (setq *pos-starting-definition* beginning-of-body)
      (setq *pos-starting-term-being-defined* nil))))





(defun Finished-text-of-definition (after-text-end)
  ;; We've just gotten the two NLs after the text of a definition.
  ;; *pos-starting-definition* points to the position at the
  ;; beginning of this section, and just before that is a section
  ;; marker edge over the term this text defines.

  (when *PNF-has-control*
    (break "Stub: PNF is running and has to be terminated"))

  (block synchronization-at-end-of-def-text
    (let ((sm-edge-over-term
           (left-treetop-at  *pos-starting-definition*)))
      (unless (edge-p sm-edge-over-term)
        (break "Assumption violation: treetop just before the ~
                text of a dictionary definition~%isn't an edge: ~
                ~A" sm-edge-over-term)
        (return-from synchronization-at-end-of-def-text))
      (unless (section-marker-p (edge-referent sm-edge-over-term))
        (break "Assumption violation: edge prior to text of ~
                a dictionary definition~%doesn't have a section ~
                marker as its referent.~% edge = ~A"
               sm-edge-over-term)
        (return-from synchronization-at-end-of-def-text))

      (synchronize/should-we-pause?
       (edge-referent sm-edge-over-term)
       sm-edge-over-term)))

  ;; set up the state for the next case
  (setq *pos-starting-definition* nil)
  (setq *pos-starting-term-being-defined* after-text-end)
  (setq *NL-action-waiting-on-next-NLs* t)
  ;(format t "[[t]] ")
  )

  




(defun Next-letter-of-the-alphabet (pos-after-letter
                                    &optional token)

  ;; We've just seen the NLs following the letter and are in the
  ;; process of getting the next token, which will be the first
  ;; word in an entry-title.  Since the letter is capitalized,
  ;; we will be in the middle of PNF's scan and have to get out
  ;; that before we can get on with the processing that should
  ;; go on here.   To get out of PNF we'll make a Throw, which
  ;; screws up the normal procedure that would return from the
  ;; NL routine and place the token we've just found and plunk it
  ;; into the chart. Because of the Throw we've got to do that
  ;; ourselves explicitly by making the call that we would have
  ;; returned into.
  ;;   As a result of all this, we're going to go through this
  ;; routine twice for each letter. The first call is from
  ;; Update-nl-state, the second from Adjudicate-after-pnf.

  (if *PNF-has-control*
    (then
      ;(format t "~&--- starting ~A~%"
      ;        (pos-terminal *pos-possible-next-letter*))
      (sort-out-result-of-newline-analysis pos-after-letter token)
      (rest-of-Scan-next-position pos-after-letter)
      ;(break "about to throw")
      (throw :position-scan-terminates-PNF :end-the-scan))

    (else
      (span-region-with-section-marker-edge
       ;; triggers all the action associated with the sm
       *letter-of-the-alphabet* *pos-possible-next-letter* pos-after-letter)

      ;; The position passed in is the pos before the start of the
      ;; label on a definition, so we set up that state to be seen
      ;; when the next pair of NLs come in and we call Update-nl-state.
      (setq *pos-starting-term-being-defined* pos-after-letter)

      ;; Clear our flag
      (setq *pos-possible-next-letter* nil)

      ;; Get back into the main line
      (adjudicate-after-pnf1 pos-after-letter))))




;;;----------------------------------------
;;; Special handling for the term segments
;;;----------------------------------------

(defun Cleanup-dictionary-term-debris-if-any (start-pos end-pos)
  ;; Called from Finished-entry-title.  Since we're operating from
  ;; within the NL routine, we won't yet have finished the segment
  ;; though we will have introduced the heavy NL-boundary brackets
  ;; that would finish it if we didn't do it now.

  (let ((coverage (coverage-over-region start-pos end-pos)))
    ;(format t "Term: \"~A\"~
    ;         ~%      coverage: ~A~%~%"
    ;        (string-of-words-between start-pos end-pos) coverage)
    (ecase coverage
      (:one-edge-over-entire-segment )
      (:discontinuous-edges 
       (finish-dictionary-term-and-make-it-one-span coverage start-pos end-pos))
      (:some-adjacent-edges
       (finish-dictionary-term-and-make-it-one-span coverage start-pos end-pos))
      (:null-span )
      (:no-edges
       (finish-dictionary-term-no-edges coverage start-pos end-pos)))

    ;; Now we want the mainline segment-tracking state variables
    ;; to appreciate that we've finished with this segment and
    ;; are ready for the next one (initiated by the NL's [ bracket
    ;; just after this dictionary term)
    (no-further-action-on-segment)
    (setq *bracket-opening-segment* nil)
    ))




(defun Finish-dictionary-term-no-edges (coverage start-pos end-pos)
  ;; Since there are no edges within the term, all of its words
  ;; must be new and the whole thing is one segment. We also don't
  ;; do any parsing since there is nothing that would combine.
  (offline-dm&p start-pos end-pos coverage))


(defun Finish-dictionary-term-and-make-it-one-span (coverage start-pos end-pos)
  ;; There are some edges between the start of the term and its end.
  ;; That means its possible that one (or more?) of them is at the
  ;; segment level, meaning that the right fringe of the term has
  ;; to be folded up, and then it and the existing segment combined
  ;; at the forest level as it were.
  (let ((edge-at-left-end (right-treetop-at start-pos)))
    ;(break "edge at left end = ~A" edge-at-left-end)
    (etypecase edge-at-left-end
      (word
       ;; If there wasn't a segment edge at the left end, then
       ;; there won't be one further in, and we should just treat this
       ;; as all one segment and get it hacked.
       (offline-parse-and-dm&p-segment start-pos end-pos coverage))
      (symbol
       (unless (eq edge-at-left-end :multiple-initial-edges)
         (break "Unexpected symbol returned as treetop:~%~A"
                edge-at-left-end))
       (offline-parse-and-dm&p-segment start-pos end-pos coverage))
      (edge
       (if (segment-level-edge? edge-at-left-end)
         (then
           (offline-dm&p (pos-edge-ends-at edge-at-left-end) end-pos)
           (apply-forest-patterns-within-dictionary-term
            start-pos end-pos))

         (offline-parse-and-dm&p-segment start-pos end-pos
                                         coverage))))))


(defun Offline-parse-and-dm&p-segment (start-pos end-pos &optional coverage)
  ;; There only one case where a parse is needed, otherwise we drop
  ;; through to the offline dm&p routine.
  (unless coverage
    (setq coverage (coverage-over-region start-pos end-pos)))
  (ecase coverage
    (:null-span (break "How can a dictionary term be a null span?"))
    (:one-edge-over-entire-segment
     (forest-&-offline-dm&p start-pos end-pos coverage))
    (:no-edges
     (forest-&-offline-dm&p start-pos end-pos coverage))
    (:discontinuous-edges
     (forest-&-offline-dm&p start-pos end-pos coverage))

    (:some-adjacent-edges
     (when *do-new-head-term-forest-patterns*
       (break "Stub: something in a dictionary term to parse")))))



(defun Forest-&-Offline-dm&p (start-pos end-pos
                              &optional coverage )
  ;; Apply dm&p to the region, and if the result isn't a single edge
  ;; run it through the dictionary-term forest patterns.
  (unless coverage
    (setq coverage (coverage-over-region start-pos end-pos)))
  (offline-dm&p start-pos end-pos coverage)
  (let ((new-coverage (coverage-over-region start-pos end-pos)))
    (case new-coverage
      (:one-edge-over-entire-segment )
      (:some-adjacent-edges
       (apply-forest-patterns-within-dictionary-term start-pos end-pos))
      (otherwise
       (break "Unreasonable coverage over dictionary term after ~
               dm&p applied to it")))))



(defun Offline-dm&p (start-pos end-pos  &optional coverage )
  (unless coverage
    (setq coverage (coverage-over-region start-pos end-pos)))
  (dm/Dispatch-on-segment-coverage/unthreaded
   coverage start-pos end-pos))



(defun Apply-forest-patterns-within-dictionary-term (start-pos end-pos)
  (let ((tt-list (treetops-between start-pos end-pos)))
    (case (length tt-list)
      (1 (break "Threading bug: shouldn't be running forest patterns ~
                 when the~%dictionary term consists of a single treetop"))
      (2
       (apply #'forest-patterns-within-dictionary-term1 tt-list))
      (otherwise
       (break "Stub: more than two treetop edges within dictionary ~
               term")))))


(defparameter *do-new-head-term-forest-patterns* nil)

(defun Forest-patterns-within-dictionary-term1 (first-edge second-edge)
  ;; hack, hack, hack.  Doing only one pattern, the one in the
  ;; very first head term.  All the others are ignored.
  (let ((first-form (edge-form first-edge)))
    (when first-form
      (case (cat-symbol first-form)
        (category::verb+ed
         (case (cat-symbol (edge-category second-edge))
           (category::one-word-segment
            (pw-ify-dictionary-term/+ed-&-one-word
             first-edge second-edge))
           (category::two-word-segment
            (pw-ify-dictionary-term/+ed-&-one-word
             first-edge second-edge))
           (otherwise
            (when *do-new-head-term-forest-patterns*
              (break "Stub: new case for category of second edge: ~A"
                     (edge-category second-edge))))))
        (otherwise
         (when *do-new-head-term-forest-patterns*
           (break "Stub: new case for form of first edge: ~A"
                  (edge-form first-edge))))))))

#|  not needed if sm-spanning call doesn't care about daughters (?)
(defun Hack-edge-over-dictionary-term (first-edge second-edge)
  ;; We're not going to work out the right thing to do, we'll
  ;; just cover the whole thing with a generic edge so that the
  ;; follow on routine can span that with the section marker.
  ) |#



;;--- Specific cases of forest patterns

(defun PW-ify-dictionary-term/+ed-&-one-word (+ed-segment-edge
                                              head-segment-edge)
  ;; We've got a dictionary term that parsed up into two segments,
  ;; and those segments fit the pattern of a gerundive classifier
  ;; (result of whis-deletion) and its head.  We construct the
  ;; appropriate pair term, and then we make a polyword out of the
  ;; whole string with the pt as its referent. 
  ;;   When we return from this, we've finished the call to
  ;; Cleanup-dictionary-term-debris-if-any and are ready to
  ;; adjust the segment state variables.

  (let* ((real-+ed-edge (edge-left-daughter +ed-segment-edge))
         (real-head-edge (edge-left-daughter head-segment-edge)))

    (when (eq real-+ed-edge :multiple-initial-edges)
      (setq real-+ed-edge (single-best-edge-over-word
                           (pos-edge-starts-at +ed-segment-edge))))
    (when (eq real-head-edge :multiple-initial-edges)
      (setq real-head-edge (single-best-edge-over-word
                           (pos-edge-starts-at head-segment-edge))))

    (let ((+ed-referent (edge-referent real-+ed-edge))
          (head-referent (edge-referent real-head-edge)))
      
      (let ((pt (define-individual 'pair-term
                  :head head-referent
                  :other +ed-referent)))
        (let ((cfr
               (define-cfr (label-for-pair-term
                            (edge-category real-+ed-edge)
                            (edge-category real-head-edge))
                 (list
                  (define-polyword
                    (string-of-words-between
                     (pos-edge-starts-at +ed-segment-edge)
                     (pos-edge-ends-at head-segment-edge))))
                 :form category::np
                 :referent nil ;;//// pt won't survive cleanup
                 )))  ;;but right now the cfr will

          (make-default-binary-edge 
           +ed-segment-edge head-segment-edge cfr))))))





;;----------------------------------------------

(defun Restart-sgloss ()
  (if *pos-term-just-finished-defining*
    (let ((filepos (pos-character-index
                    *pos-term-just-finished-defining*)))

      (when *filepos-at-beginning-of-source*
        (setq filepos (+ filepos *filepos-at-beginning-of-source*)))

      (setq *just-restarted-sgloss* t)
      (analyze-text-from-file/at-filepos *sgloss*
                                         (1- filepos)))

    "Too early to restart: no definition has been finished yet"))

