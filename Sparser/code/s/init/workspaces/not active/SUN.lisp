;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1995  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "SUN"
;;;   Module:  "init;workspaces:"
;;;  version:  January 1995

;; initiated 1/5.  Added stuff for glossary 1/6.  Elaborating 1/16

(in-package :sparser)

;;;----------
;;; settings
;;;----------

;*switch-setting*
;(Top-edges-setting/ddm)
;(dm&p-setting)
;(setq *introduce-brackets-for-unknown-words-from-their-suffixes* t)
;(setg *dm&p-forest-protocol* 'no-forest-level-operations)
;(setq *dm&p-forest-protocol* 'parse-forest-and-do-treetops)

(use-blank-line-nl-fsa)


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
  (use-sun-glossary-NL-fsa)
  (analyze-text-from-file *sgloss*))


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

        (mark-position-as-generic-boundary pos-being-filled)

        (sun-gloss-nl-two-in-a-row pos-being-filled))
      (else
        (update-nl-state/act pos-being-filled)
        token ))))

;(use-sun-glossary-NL-fsa)


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


(defun Initialize-sun-nl-state ()
  (setq *snl-two-in-a-row* nil
        *snl-three-in-a-row* nil
        *pos-possible-next-letter* nil)
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
             (break)
             (setq *pos-possible-next-letter* nil))

            (*pos-of-letter*
             (format t "~&--- starting ~A~%"
                     (pos-terminal *pos-of-letter*))
             (setq *pos-starting-term-being-defined*
                   next-pos-to-be-filled)
             (setq *pos-of-letter* nil))

            (*pos-starting-definition*
             (span-region-with-section-marker-edge
              *sun-sm*
              *pos-starting-term-being-defined* *pos-starting-definition*)

             (format t "~%SUN nl-fsa: finished a definition~%")
             (setq *pos-term-just-finished-defining*
                   *pos-starting-term-being-defined*)

             (synchronize/should-we-pause?
              *sun-sm* (top-edge-starting-at 
                        *pos-starting-term-being-defined*))

             (setq *pos-starting-definition* nil)
             (setq *pos-starting-term-being-defined*
                   next-pos-to-be-filled))

            (*pos-starting-term-being-defined*
             (format t "~&SUN nl-fsa: defining the term \"~A\"~%"
                     (string-of-words-between
                      *pos-starting-term-being-defined*
                      next-pos-to-be-filled))

             (setq *most-recent-sentence-start* next-pos-to-be-filled)
             (setq *pos-starting-definition* next-pos-to-be-filled))

            (t (break "new state for two in a row")))
             
           (else
             (setq *next-word-is-a-single-letter* t
                   *snl-text-has-started?* t)
             (setq *pos-of-letter* next-pos-to-be-filled))))

        ;; just one nl, so this is contiguous text, presumably
        ;; within a definition
        (t )))

(defparameter *sun-sm*
  ;; a trivial definition just because the pause synchronizer
  ;; expects to get a sm
  (define-section-marker "sun-def"
    :implicitly-closes "sun-def"))
    
    


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



;; original version before adjustments for restart
#|(defun Update-nl-state/act (next-pos-to-be-filled)
  ;; called after the first token has been see after one or more
  ;; newlines have been seen
  (cond (*snl-three-in-a-row*
         (break "three nl in a row"))

        (*snl-two-in-a-row*
         (setq *snl-two-in-a-row* nil)
         (if *snl-text-has-started?*
           (cond
            (*pos-of-letter*
             (format t "~%--- starting ~A~%"
                     (pos-terminal *pos-of-letter*))
             (setq *pos-starting-term-being-defined*
                   next-pos-to-be-filled)
             (setq *pos-of-letter* nil))

            (*pos-starting-definition*
             (format t "~%finished a definition~%")
             (setq *pos-term-just-finished-defining*
                   *pos-starting-term-being-defined*)
             (synchronize/should-we-pause?
              *sun-sm* *pos-starting-term-being-defined*)
             (setq *pos-starting-definition* nil)
             (setq *pos-starting-term-being-defined*
                   next-pos-to-be-filled))

            (*pos-starting-term-being-defined*
             (format t "~%defining the term \"~A\""
                     (string-of-words-between
                      *pos-starting-term-being-defined*
                      next-pos-to-be-filled))
             (setq *pos-starting-definition* next-pos-to-be-filled)
             ;;(setq *pos-starting-term-being-defined* nil)
             )

            (t (break "new state for two in a row")))
             
           (else
             (setq *next-word-is-a-single-letter* t
                   *snl-text-has-started?* t)
             (setq *pos-of-letter* next-pos-to-be-filled))))

        (t 
         (when *just-restarted-sgloss*
           (setq *pos-starting-term-being-defined* (position# 1))
           (setq *pos-starting-definition*
                 next-pos-to-be-filled)
           (setq *pos-term-just-finished-defining* nil)
           )))) |#
