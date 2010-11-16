;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992,1993,1994,1995  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "new words"
;;;   Module:  "objects;chart:words:lookup:"
;;;  Version:  4.3 January 1995

;; 4.0 (9/28/92 v2.3) accomodates changes to tokenizer
;; 4.1 (7/16/93) updated field name
;; 4.2 (1/27/94) added Unknown-word?
;;     (12/12) added simplest case of make-word routine
;; 4.3 (1/9/95) added hook for introducing brackets

(in-package :sparser)


(defun unknown-word? (word)
  (null (word-rules word)))


;;;-----------------------------------------
;;; Cases for What-to-do-with-unknown-words
;;;-----------------------------------------

(defun make-word/all-properties (character-type)

  ;; Called from Find-word as one of the  possible values for the function
  ;; Establish-unknown-word
  ;;   In the *word-lookup-buffer* is the lowercase version of the word,
  ;; and we can calculate where in the character buffer the original
  ;; mixed case version is and use it if the capitalization seems important.

  (let* ((symbol (make-word-symbol))  ;;reads out the lookup buffer
         (word (make-word :symbol symbol
                          :pname  (symbol-name symbol))))

    (ecase character-type
      (:number (establish-properties-of-new-digit-sequence   word))
      (:alphabetical
       (setf (word-capitalization word)
             *capitalization-of-current-token*)

       (let ((morph-keyword (calculate-morphology-of-word/in-buffer)))
         (setf (word-morphology word) morph-keyword)
         (when *introduce-brackets-for-unknown-words-from-their-suffixes*
           (when morph-keyword
             (introduce-morph-brackets-from-unknown-word
              word morph-keyword))))))

    (catalog/word word symbol)
    word ))

;(what-to-do-with-unknown-words :capitalization-digits-&-morphology)





(defun make-word/capitalization-&-digits (character-type)
  ;; just like the all-properties version except that it does not
  ;; consider morphology
  (let* ((symbol (make-word-symbol))  ;;reads out the lookup buffer
         (word (make-word :symbol symbol
                          :pname  (symbol-name symbol))))

    (ecase character-type
      (:number (establish-properties-of-new-digit-sequence   word))
      (:alphabetical 
       (setf (word-capitalization word)
             *capitalization-of-current-token*)))

    (catalog/word word symbol)
    word ))

;(what-to-do-with-unknown-words :capitalization-&-digits)



(defun make-word/no-properties (character-type)
  ;; just sets up the word, doesn't calculate any of its properties
  (declare (ignore character-type))
  (let* ((symbol (make-word-symbol))
         (word (make-word :symbol symbol
                          :pname  (symbol-name symbol))))

    (catalog/word word symbol)
    word ))

;(what-to-do-with-unknown-words :make-word/no-properties)




;;;--------------------
;;; spaces and digits
;;;--------------------

(defun establish-properties-of-new-number-of-spaces (word)
  (setf (word-morphology word) :space)
  (setf (unit-plist      word)
        `(:number-of-spaces ,(length (word-pname word))))
  word )


(defun establish-properties-of-new-digit-sequence (word)
  (setf (word-morphology word) :digit)
  (setf (unit-plist      word)
        `(:numerical-value ,(parse-integer (word-pname word))))
  word )

(defun word-consists-of-only-digits (word)
  (eq (word-morphology word) :digit))


;;;------------------------------------------------
;;;  lowercase / capitalized version equivalences
;;;------------------------------------------------

(defun establish-equivalence-to-known-lowercase-word (word)
  (modify-word-buffer-to-lowercase (capitalized word))
  (let ((symbol-for-lowercase-equivalent
         (lookup-word-symbol)))
    (when symbol-for-lowercase-equivalent
      (let ((known-lowercase-word
             (symbol-value symbol-for-lowercase-equivalent)))
        (when known-lowercase-word
          (setf (word-rule-set word) known-lowercase-word)
          known-lowercase-word )))))


(defun modify-word-buffer-to-lowercase (type-of-capitalization)
  (ecase type-of-capitalization
    (:initial-letter-capitalized
     (downcase-first-letter/word-buffer))
    (:all-caps
     (downcase-entire-word/word-buffer))
    (:mixed-case
     (downcase-uppercase-letters/word-buffer))
    (:single-capitalized-letter
     (downcase-first-letter/word-buffer))))


(defun downcase-first-letter/word-buffer ()
  (setf (elt *word-lookup-buffer* 0)
        (lowercase-equivalent-letter (elt *word-lookup-buffer* 0))))

(defun downcase-entire-word/word-buffer ()
  (dotimes (i (fill-pointer *word-lookup-buffer*))
    (downcase-letter/word-buffer i)))

(defun downcase-uppercase-letters/word-buffer ( &aux letter )
  (dotimes (i (fill-pointer *word-lookup-buffer*))
    (setq letter (elt *word-lookup-buffer* i))
    (when (capital-letter letter)
      (downcase-letter/word-buffer i))))


(defun downcase-letter/word-buffer (index)
  (setf (elt *word-lookup-buffer* index)
        (lowercase-equivalent-letter
         (elt *word-lookup-buffer* index))))

