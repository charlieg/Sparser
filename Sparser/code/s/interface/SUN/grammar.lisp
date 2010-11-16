;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "grammar"
;;;    Module:   "interface;SUN:"
;;;   Version:   December 1994

;; initiated 12/14/94

(in-package :sparser)


#| A routine attached to colons that looks to its left to see if the
   words between it an the newline are capitalized, in which case it
   declares them to be a header and spans them with an edge.  |#

(define-completion-action (punctuation-named #\:)
                          'header-check
                          'check-for-capitalized-header-before-colon)

(defun check-for-capitalized-header-before-colon (colon
                                                  pos-before pos-after)
  (declare (ignore colon))
  (let ((next-pos-back (chart-position-before pos-before))
        next-word-back  accumulating-words )
    (loop
      (setq next-word-back (pos-terminal next-pos-back))
      
      (when (eq next-word-back *source-start*)
        (form-edge-over-implicit-header
         accumulating-words next-pos-back pos-after)
        (return))
      (cond
       ((eq (pos-capitalization next-pos-back) :all-caps)
        (push next-word-back accumulating-words)
        (when (eq (pos-preceding-whitespace next-pos-back) *newline*)
          (form-edge-over-implicit-header
           accumulating-words next-pos-back pos-after)
          (return))
        (setq next-pos-back (chart-position-before next-pos-back)))

       ((eq (pos-capitalization next-pos-back) :multi-token)
        ;; special case for "ISO-9001"
        (if (eq (pos-preceding-whitespace next-pos-back) *newline*)
          (then
            (push next-word-back accumulating-words)
            (form-edge-over-implicit-header
             accumulating-words next-pos-back pos-after)
            (return))
          (else ;; other purpose
            (return))))
       (t
        ;; some other purpose for the colon
        (return))))))


(define-category  colon-delimited-header
  :specializes nil
  :instantiates self
  :binds ((name :primitive word))
  :index (:key name))


(defun form-edge-over-implicit-header (word-list starts-at ends-at)
  (let* ((multi-word
          (make-word-from-reversed-list-of-words word-list))
         (obj (define-individual 'colon-delimited-header
                :name multi-word)))

    (make-chart-edge :starting-position starts-at
                     :ending-position ends-at
                     :category (category-named 'colon-delimited-header)
                     :referent obj
                     :rule :colon-completion-hook )))
  
