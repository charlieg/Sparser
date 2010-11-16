;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "next-terminal"
;;;    Module:   "interface;SUN:"
;;;   Version:   December 1994

;; initiated 12/12/94. Added capitalization 12/14

(in-package :sparser)

#|  useful when the threading is impossible to deduce from word output
(trace scan-next-position
         next-terminal/hide-pos-tags
         nt/hpt-Look-for-slash
         nt/hpt-Checkout-slash-context
         nt/hpt-Continue-multi-with-slash
         nt/hpt-Note-tag-and-return-terminal
         nt/hpt-find/make-multi-token
         next-token )   |#


(defparameter *nt/hpt-accumulating-multi-tokens* nil)

(defparameter *nt/hpt-pending-space* nil)

(defparameter *nt/hpt-capitalization-of-first-token* nil)


(defun initialize-nt/hpt ()
  (setq *nt/hpt-accumulating-multi-tokens* nil
        *nt/hpt-pending-space* nil
        *nt/hpt-capitalization-of-first-token* nil))

(define-per-run-init-form '(initialize-nt/hpt))



(defun next-terminal/hide-pos-tags ()
  ;; Called from Add-terminal-to-chart. Returns the word that is to go into
  ;; the chart and puts the tag that follows it into the 'marker' field of 
  ;; the edge vector starting at the position before the word.
  ;;    If the unit that is tagged is several of Sparser's words long,
  ;; then a word object is defined for the whole sequence using a special
  ;; routine written just for that purpose that circumvents many of the
  ;; usual operations. 

  (setq *number-of-characters-to-subtract* 0)

  (if *nt/hpt-pending-space*
    (prog1
      *nt/hpt-pending-space*
      (setq *length-of-the-token* 1
            *capitalization-of-current-token* :spaces)
      (setq *nt/hpt-pending-space* nil))

    (let ((token (next-token)))
      (cond
       ((eq token *source-start*)
        token )
       ((eq token *end-of-source*)
        ;(format t "~&------- eos ----------~%")
        token )
       ((eq token *newline*)
        token ) ;;(next-terminal/hide-pos-tags))
       (t
        (push token *nt/hpt-accumulating-multi-tokens*)
        (setq *nt/hpt-capitalization-of-first-token*
              *capitalization-of-current-token*)
        (nt/hpt-look-for-slash))))))



(defun nt/hpt-Look-for-slash ()
  (let ((token (next-token)))
    (if (eq token word::forward-slash)
      (nt/hpt-checkout-slash-context)
      (else
        (push token *nt/hpt-accumulating-multi-tokens*)
        (nt/hpt-look-for-slash)))))


(defun nt/hpt-Checkout-slash-context ()
  ;; We've just seen a slash. The question is whether it indicates that
  ;; a tag follows, or whether it is internal to some multitoken.
  ;; In the tagged out file the whitespace has been canonicalized to
  ;; one space between tagged items, so we look for that.
  (let ((after-slash (next-token))
        (following (next-token)))
    (if (eq following word::one-space)
      (nt/hpt-note-tag-and-return-terminal after-slash)
      (else
        ;; this means that the slash and after-slash token are
        ;; part of a multi-token. We should expect another slash.
        ;(format t "~&Slash didn't terminate.~
        ;           ~%       after = ~A~
        ;           ~%   following = ~A~%" after-slash following)
        (push word::forward-slash *nt/hpt-accumulating-multi-tokens*)

        (cond 
         ((eq after-slash word::forward-slash) ;; two slashes in a row
          (nt/hpt-note-tag-and-return-terminal following))
         ((eq following word::dollar-sign)  ;; ".../prp$ "
          ;; // ? is the dollar sign part of the tag or not?
          (nt/hpt-note-tag-and-return-terminal after-slash))
         (t
          (push after-slash *nt/hpt-accumulating-multi-tokens*)
          (push following *nt/hpt-accumulating-multi-tokens*)

          ;; typically in this case we're in the middle of a file name,
          ;; otherwise consider it wierdness and break.
          (if (eq following word::forward-slash)
            (nt/hpt-continue-multi-with-slash)
            (break "Multi-token has wierd pattern"))))))))


(defun nt/hpt-Continue-multi-with-slash ()
  ;; We're accumulating a multi-token that has slashes in it, and we've
  ;; just come from nt/hpt-Checkout-slash-context where instead of seeing
  ;; a period (and terminating), we've seen a slash.
  ;;    Anticipating that we're in the middle of a Unix filename, we
  ;; use this special routine to parse up just the right amount of it.
  (let ((after-slash (next-token))
        (following (next-token)))
    (if (eq following word::one-space)
      (then 
        ;; get rid of the slash we put on with the last pass through here
        (pop *nt/hpt-accumulating-multi-tokens*)
        (nt/hpt-note-tag-and-return-terminal after-slash))
      (else
        ;(format t "~&Continuing multi-token with slashes~
        ;           ~%       after = ~A~
        ;           ~%   following = ~A~%" after-slash following)
        ;; this differs from nt/hpt-Checkout-slash-context in that
        ;; we're not also pushing on a slash
        (push after-slash *nt/hpt-accumulating-multi-tokens*)
        (push following *nt/hpt-accumulating-multi-tokens*)
        (cond ((or (eq following word::forward-slash)
                (eq following word::hyphen)
                (eq following word::under-bar)
                (eq after-slash word::open-angle-bracket)
                )
               (nt/hpt-continue-multi-with-slash))
              ((eq after-slash word::open-angle-bracket)
               (cont-after-slash-open-term))
              (t 
               (break "Multi-token with slashes continues with other ~
                       fillers")))))))


(defun cont-after-slash-open-term ()
  ;; assumes that the situation is .../aa/aa/<bb and we're looking
  ;; for a close bracket followed by a slash and the tag
  (let ((next (next-token)))
    (if (eq next word::close-angle-bracket)
      (then
        ;; try and get back in to sync
        (if (eq (next-token) word::forward-slash)
          (nt/hpt-continue-multi-with-slash)
          (else
            (break " '.../aa/aa/<bb>' situation didn't continue as ~
                    expected~%")
            (nt/hpt-continue-multi-with-slash))))
      (else
        (break " '.../aa/aa/<bb' situation didn't continue as ~
                expected~%")
        (nt/hpt-continue-multi-with-slash)))))



(defun nt/hpt-Note-tag-and-return-terminal (tag)
  (let ((position-to-be-filled
         (chart-position *number-of-next-position*)))  ;; token index

    ;; stash the tag
    (setf (ev-marker (pos-starts-here position-to-be-filled)) tag)

    ;; record its effect for use by the display routines
    (setq *number-of-characters-to-subtract*
          (1+ ;; the slash
           (length (word-pname tag))))


    ;; save the space for the next time through
    (setq *nt/hpt-pending-space* word::one-space)
          

    ;; check whether we need to construct the terminal before we return
    (if (cdr *nt/hpt-accumulating-multi-tokens*)
      (nt/hpt-find/make-multi-token)

      (let ((word (car *nt/hpt-accumulating-multi-tokens*)))

        ;; get the right values to be used by Bump&store
        (setq *length-of-the-token* (length (word-pname word)))
        (setq *capitalization-of-current-token*
          *nt/hpt-capitalization-of-first-token*)
        (when (eq *capitalization-of-current-token* :punctuation)
          (decf *number-of-characters-to-subtract*))

        ;; turn off the flag
        (setq *nt/hpt-accumulating-multi-tokens* nil)

        word ))))




(defun nt/hpt-find/make-multi-token ()
  (let ((word (make-word-from-reversed-list-of-words
               *nt/hpt-accumulating-multi-tokens*)))
    
    (setq *length-of-the-token* (length (word-pname word)))
    (setq *nt/hpt-accumulating-multi-tokens* nil)
    (setq *capitalization-of-current-token* :multi-token)
    
    word ))



;; /// move
(defun make-word-from-reversed-list-of-words (list)
  (let ((pname ""))
    (dolist (word list)
      (setq pname
            (concatenate 'string
                         (word-pname word) pname)))

    (let* ((symbol (intern pname *word-package*))
           (word (when (boundp symbol)
                   (symbol-value symbol))))

      (setq word (make-word :pname pname
                            :symbol symbol))
      (catalog/word word symbol)

      word )))

