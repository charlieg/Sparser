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
  "Moby:ddm:projects:SUN:glossary:sun-glossary.ascii")

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


;;;--------------------------------------
;;; newline routine for the sun glossary
;;;--------------------------------------

(defun Use-sun-glossary-NL-fsa ()
  (setf (symbol-function 'newline-fsa)
        (symbol-function 'Sun-glossary-nl-fsa))
  (setq *newline-fsa-in-use* 'sun-glossary-nl-fsa))


(defun Sun-glossary-nl-fsa (pos-being-filled)
  (increment-line-count) ;; the nl that called us
  (fill-whitespace pos-being-filled *newline* :display-word t)
  
  (let ((token (next-terminal)))
    (if (eq token *newline*)
      (then
        (increment-line-count)
        (fill-whitespace pos-being-filled *newline* :display-word t)

        ;(mark-position-as-generic-boundary pos-being-filled)

        (sun-gloss-nl-two-in-a-row pos-being-filled))
      (else
        ;; no ][ introduce unless there is at least one blank line
        ;; between text segments.
        (update-nl-state/act pos-being-filled)
        token ))))

;(use-sun-glossary-NL-fsa)



(defparameter *sun-sm*
  ;; a trivial definition just because the pause synchronizer
  ;; expects to get a sm
  (define-section-marker "sun-def"
    :implicitly-closes "sun-def"))

 
(defvar *snl-two-in-a-row* nil)
(defvar *snl-three-in-a-row* nil)
(defvar *snl-text-has-started?* nil)
(defvar *next-word-is-a-single-letter* nil)
(defvar *pos-of-letter* nil)
(defvar *pos-starting-term-being-defined* nil)
(defvar *pos-starting-definition* nil)
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
        *PNF-interrupted-before-def-text-ops* nil)
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

;; original before 1/9
#|(defun Initialize-sun-nl-state ()
  (setq *snl-two-in-a-row* nil
        *snl-three-in-a-row* nil
        *snl-text-has-started?* nil
        *next-word-is-a-single-letter* nil
        *pos-of-letter* nil
        *pos-starting-term-being-defined* nil
        *pos-starting-definition* nil
        *pos-term-just-finished-defining* nil
        *just-restarted-sgloss* nil
        )) |#

(define-per-run-init-form '(initialize-sun-nl-state))


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
        (update-nl-state/act pos-being-filled)
        token ))))

(defun Sun-gloss-nl-three-in-a-row (pos-being-filled)
  (setq *snl-three-in-a-row* t)
  (let ((token (next-terminal)))
    (if (eq token *newline*)
      (then
        (increment-line-count)
        (fill-whitespace pos-being-filled *newline* :display-word t)
        (break "4 newlines in a row"))
      (else
        (mark-position-as-generic-boundary pos-being-filled token)
        (update-nl-state/act pos-being-filled)
        token ))))


(defun Update-nl-state/act (next-pos-to-be-filled)
  ;; called after the first token has been see after one or more
  ;; newlines have been seen
  (cond (*snl-three-in-a-row*
         (setq *snl-three-in-a-row* nil)
         (setq *pos-possible-next-letter* next-pos-to-be-filled))

        (*snl-two-in-a-row*
         (setq *snl-two-in-a-row* nil)
         (if *snl-text-has-started?*
           (cond
            (*pos-possible-next-letter*
             ;; have to check whether this really is a transition to
             ;; the next letter of the alphabet or a spurious case
             ;; of three rather than two lines between definitions.
             (if (= 1 (length (word-pname
                               (pos-terminal *pos-possible-next-letter*))))
               (then
                 ;; copied from *pos-of-letter* case 
                 ;(format t "~&--- starting ~A~%"
                 ;        (pos-terminal *pos-of-letter*))
                 (setq *pos-starting-term-being-defined*
                       next-pos-to-be-filled)
                 (when *pos-of-letter* ;; hook
                   (setq *pos-of-letter* nil)))
               (else
                 (setq *pos-starting-term-being-defined*
                       *pos-possible-next-letter*)
                 (finished-item-defined next-pos-to-be-filled)))
             (setq *pos-possible-next-letter* nil))

            (*pos-of-letter*
             (next-letter-of-the-alphabet next-pos-to-be-filled))

            (*pos-starting-definition*
             (starting-def-text next-pos-to-be-filled))

            (*pos-starting-term-being-defined*
             (finished-item-defined next-pos-to-be-filled))
             

            (t (break "new state for two in a row")))
             
           (else
             (setq *next-word-is-a-single-letter* t
                   *snl-text-has-started?* t)
             (setq *pos-of-letter* next-pos-to-be-filled))))

        ;; just one nl, so this is contiguous text, presumably
        ;; within a definition
        (t
         (when *PNF-interrupted-before-def-text-ops*
           (break "*pos-starting-definition* flag up after one NL")
           (when *pnf-has-control*
             (break "we under PNF again"))
           (starting-def-text
            *PNF-interrupted-before-def-text-ops*)
           (setq *PNF-interrupted-before-def-text-ops* nil))
         )))


(defun Finished-item-defined (next-pos)
  ;(format t "~&SUN nl-fsa: defining the term \"~A\"~%"
  ;        (string-of-words-between
  ;         *pos-starting-term-being-defined*
  ;         next-pos))
  (setq *most-recent-sentence-start* next-pos)
  (setq *pos-starting-definition* next-pos))



(defun Starting-def-text (next-pos)
  (if *pnf-has-control*
    (then
      (break "NL:  PNF needs to finish")
      (setq *pos-starting-term-being-defined* next-pos)
      (setq *PNF-interrupted-before-def-text-ops* next-pos)
      (throw :position-scan-terminates-PNF :end-the-scan))
    (else
      (span-region-with-section-marker-edge
       *sun-sm* *pos-starting-term-being-defined* *pos-starting-definition*)
      
      ;(format t "~%SUN nl-fsa: finished a definition~%")
      (setq *pos-term-just-finished-defining*
            *pos-starting-term-being-defined*)
      
      (synchronize/should-we-pause?
       *sun-sm* (top-edge-starting-at *pos-starting-term-being-defined*))
      
      (setq *pos-starting-definition* nil)
      (setq *pos-starting-term-being-defined* next-pos))))



(defun Next-letter-of-the-alphabet (next-pos)
  ;(format t "~&--- starting ~A~%"
  ;        (pos-terminal *pos-of-letter*))
  (setq *pos-starting-term-being-defined*
        next-pos)
  (setq *pos-of-letter* nil))


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

