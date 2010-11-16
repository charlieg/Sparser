;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "NL routine"
;;;    Module:   "interface;SUN:"
;;;   Version:   December 1994

;; initiated 12/12/94

(in-package :sparser)


(defun use-Initial-Caps-&-colon-NL-fsa ()
  (setf (symbol-function 'Newline-FSA)
        (symbol-function 'Initial-Caps-&-colon-NL-fsa))
  (setq *NewLine-FSA-in-use* 'Initial-Caps-&-colon-NL-fsa))

;(use-Initial-Caps-&-colon-NL-fsa)

(defun initial-Caps-&-colon-NL-fsa (position-being-filled)
  ;; The text has an uncataloged set of headers that are indicated by
  ;; one or more capitalized words at the beginning of a line followed
  ;; by a colon.  ///sync with section hacking
  ;(break)
  ;;   We just saw a NL character. If the first two characters of the
  ;; next token are capitalized we'll declare that we've got one.
  ;; There should then be a confirmation by checking for a following 
  ;; colon, but we'll leave that off to start.

  (if (next-two-characters-are-capitalized?)
    (then
      (increment-line-count)
      (sftp/terminate-ongoing-sequence position-being-filled)
      *newline* )
    (else
      (unless *adjust-text-to-fixed-line-length*
        (increment-line-count))
      (if *adjust-text-to-fixed-line-length*
        *one-space*
        *newline*))))


(defun next-two-characters-are-capitalized? ()
  (let ((index-of-nl *index-of-next-character*))
    (when (capital-letter
           (elt *character-buffer-in-use* (+ 1 index-of-nl)))
      (when (capital-letter
             (elt *character-buffer-in-use* (+ 2 index-of-nl)))
        t ))))
