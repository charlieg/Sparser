;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1990,1992,1993,1994.1995  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "word freq"
;;;   Module:  "analyzers;doc:"
;;;  Version:  0.2 February 1995

;; initiated 10/90
;; 3/21/92 Added capitalization information to the dummy words
;; (1/11/94 v2.3) modernized it all
;; 0.1 (6/12) switch'ified the runtime word-checking routine.
;; 0.2 (2/27/95) cleaned up loose ends.

(in-package :sparser)


;;;-----------------
;;; state variables
;;;-----------------

(defvar *words-in-run* 0
  "Bumped with the recording of each word.  Intended to accumulate
   across multiple articles.")

(defvar *word-types* 0
  "Bumped with the recording of each NEW word.")

(defvar *word-types-at-start-of-article* 0
  "Keeps track of how many new words appear in successive articles
   when running over document streams")

(defparameter *word-frequency-classification* nil
  "Set by Establish-word-frequency-classification. Names the 
   pattern of categories that the words will be sorted into.")

(defparameter *word-count-buckets* nil
  "An alist that reflect a sorting of the word-frequency
   hashtable's data by count.  The first element in each item
   is the frequency, the second is the word count at that
   frequency, and the rest is the list of words.")

(defparameter *word-count-buckets-most-freq-highest* nil
  "The same list ordered from most frequent word to least.")


;;;----------------
;;; initialization
;;;----------------

(defun initialize-word-frequency-data ()
  (setq *words-in-run* 0
        *word-types* 0
        *word-types-at-start-of-article* 0
        *sorted-word-entries* nil
        *word-count-buckets* nil
        *word-count-buckets-most-freq-highest* nil)
  (Reset/over-all))


;;;--------
;;; driver
;;;--------

(defun record-word-frequency (word position)
  ;; called as the body of Look-at-terminal
  (incf *words-in-run*)
  (let ((classification (classify-word-for-frequency word position)))
    (record-word-frequency/over-all word classification)))

(defun record-word-frequency/over-all (word classification)
  (let ((entry
         (if classification
           (frequency-table-entry/over-all classification)
           (frequency-table-entry/over-all word))))
    (if (eq entry :no-entry)
      (make-initial-word-frequency-entry/over-all (or classification
                                                      word))
      (increment-word-frequency-entry/over-all entry))))


;;;--------
;;; shells
;;;--------

;; (initialize-word-frequency-data)
;; (readout-frequency-table)

(defun p/wf (string)
  (initialize-word-frequency-data)
  (analyze-text-from-string string)
  (readout-frequency-table))


(defun f/wf (namestring)
  (initialize-word-frequency-data)
  (word-frequency-setting)
  (analyze-text-from-file namestring)
  (when (y-or-n-p "~%~%~%-------------------------------------~
                   ~% Readout the frequency data now ?")
    (readout-frequency-table)))


(defun wf/ds (document-stream)
  (establish-kind-of-chart-processing-to-do :just-do-terminals)
  (establish-version-of-look-at-terminal :record-word-frequency)
  (initialize-word-frequency-data)
  (define-after-analysis-action '(report-word-increment))
  (analyze-document-stream document-stream)
  (remove-after-analysis-action '(report-word-increment))
  (when (y-or-n-p "~%~%~%-------------------------------------~
                   ~% Readout the frequency data now ?")
    (readout-frequency-table)))


;;;------------------------------------
;;; the table for "over all" frequency
;;;------------------------------------

(defparameter *word-frequency-table*
              (make-hash-table :test #'eq
                               :size 1000
                               :rehash-size 500))


(defun frequency-table-entry/over-all (word)
  (gethash word *word-frequency-table*
           :no-entry  ;; the value returned if the word isn't in the table
           ))


(defun make-initial-word-frequency-entry/over-all (word)
  ;; called the first time a word is seen, i.e. when it isn't already
  ;; in the frequency table.
  (incf *word-types*)
  (setf (gethash word *word-frequency-table*)
        (cons 1
              (list (cons *current-article* 1)
                    ))))

(defun increment-word-frequency-entry/over-all (entry)
  (incf (first entry))
  (let ((subentry-for-current-article (cadr entry)))
    (incf (cdr subentry-for-current-article))
    subentry-for-current-article ))


(defun number-of-words-counted ()
  (hash-table-count *word-frequency-table*))

(defun reset/over-all ()
  (clrhash *word-frequency-table*))


;;;-----------------------
;;; reporting the results
;;;-----------------------

(defun report-word-increment ()
  (let* ((last-time *word-types-at-start-of-article*)
         (difference (- *word-types*
                        last-time)))
    (format t "~&  ~A words added~%" difference)
    (setq *word-types-at-start-of-article* *word-types*)))


(defvar *sorted-word-entries* nil)

(defun setup-word-frequency-data ()
  (let ((words-counted
         (readout-hashtable-into-a-list)))
    (setq *sorted-word-entries*
          (sort-frequency-list words-counted))
    (length *sorted-word-entries*)))


(defun readout-frequency-table ()
  (setup-word-frequency-data)
  (display-sorted-results *standard-output*
                          *sorted-word-entries*)
  '*sorted-word-entries*)


;;--- subroutines for reporting

(defun readout-hashtable-into-a-list ()
  (let ( accumulator )
    (maphash
     #'(lambda (word entry)
         (push (cons word (first entry))
               accumulator))
     *word-frequency-table*)
    accumulator))


(defun sort-frequency-list (list-of-entries)
  (sort list-of-entries
        #'(lambda (first second)
            (cond ((< (cdr first)
                      (cdr second))
                   t)  ;; the first goes earlier in the result
                  ((> (cdr first)
                      (cdr second))
                   nil)
                  ((string< (word-pname (car first))
                            (word-pname (car second)))
                   t)
                  ((string> (word-pname (car first))
                            (word-pname (car second)))
                   nil)))))


(defun word-frequency-profile (&optional
                               (list-of-entries *sorted-word-entries*))
  (declare (ignore stream))
  ;; Scans the global list of sorted (<word> . <count>) data and
  ;; sorts it into buckets.
  (let ((current-count 0)
        list-of-lists  accumulating-words  )
    (dolist (entry list-of-entries)
      (when (not (= current-count (cdr entry)))
        ;; close out the ongoing bucket and start a new one
        (if accumulating-words  ;; startup check
          (then
            (push `(,current-count
                    ,(length accumulating-words)
                    ,@accumulating-words )
                  list-of-lists)
            (setq accumulating-words nil
                  current-count (cdr entry)))
          (setq current-count 1)))
      (push (car entry) accumulating-words))

    ;; close out the last entry
    (push `(,current-count
            ,(length accumulating-words)
            ,@accumulating-words )
          list-of-lists)

    (setq *word-count-buckets* (nreverse list-of-lists))
    (length *word-count-buckets*)))



(defun display-word-frequency-profile (&optional
                                       (stream *standard-output*))
  (unless *word-count-buckets*
    (word-frequency-profile))
  (let ( frequency  count )
    (dolist (entry *word-count-buckets*)
      (setq frequency (first entry)
            count (second entry))
      (format stream "~&~A~4,2T~A~%" frequency count))))


(defun words-with-frequency# (n)
  ;; returns the whole entry, not just the word list
  (unless *word-count-buckets*
    (word-frequency-profile))
  (assoc n *word-count-buckets*))


(defun top-N-frequent-words (n &optional (stream *standard-output*))
  (unless *word-count-buckets*
    (word-frequency-profile))
  (unless *word-count-buckets-most-freq-highest*
    (setq *word-count-buckets-most-freq-highest*
          (reverse *word-count-buckets*)))
  (let ( entry )
    (dotimes (i n)
      (setq entry (nth i *word-count-buckets-most-freq-highest*))
      (format stream "~&~A~5,2T~A" (car entry) (cddr entry)))))





(defun display-sorted-results (&optional
                               (stream *standard-output*)
                               (list-of-entries *sorted-word-entries*))
  (format stream "~&~%~A words in a corpus of length ~A"
          (number-of-words-counted) *words-in-run*)
  (let ((frequency 0)
        (words-on-the-line 0))
    (dolist (entry list-of-entries)
      (when (not (= (cdr entry) frequency))
        ;; the frequency just changed
        (setq frequency (cdr entry)
              words-on-the-line 0)
        (format stream "~&~%Word with frequency ~A~%   " frequency))
      (princ-word (car entry) stream)
      (write-string "  " stream)
      (incf words-on-the-line)
      (when (= 5 words-on-the-line)
        (format stream "~%   ")
        (setq words-on-the-line 0)))
    (terpri stream)
    (terpri stream)))



;;;---------------
;;; alphabetizing
;;;---------------

(defun alphabetize-words (w1 w2)
  (let ((pname1 (word-pname w1))
        (pname2 (word-pname w2)))
    (string< pname1 pname2)))
         
(defun alphabetize-word-list (global-symbol)
  (let ((sorted-list
         (sort (symbol-value global-symbol)
               #'alphabetize-words)))
    (set global-symbol sorted-list)))




;;;---------------------------
;;; classifying unknown words
;;;---------------------------

(defun classify-word-for-frequency (word position)
  (declare (ignore word position))
  (break "No classifier has been picked for measuring word ~
          frequency.~%You have to make a call to~
          ~%  Establish-word-frequency-classification"))


(defun establish-word-frequency-classification (keyword function-name)
  (unless (fboundp function-name)
    (format t "~&~%Warning: the word frequency classification function~
            ~%  ~A  is not yet defined." function-name))
  (setf (symbol-function 'classify-word-for-frequency)
        (symbol-function function-name))
  (setq *word-frequency-classification* keyword))

#|
(establish-word-frequency-classification :standard 
                                         'standard-wf-classification)
(establish-word-frequency-classification :ignore-capitalization
                                         'wf-classification/ignore-caps)
|#


(defparameter *capitalized-word*
  (define-dummy-word/expr 'capitalized-word
    :capitalization :initial-letter-capitalized))

(defparameter *number-word*
  (define-dummy-word/expr 'number-word))

(defparameter *function-word*
  (define-dummy-word/expr 'function-word))

(defparameter *punctuation-word*
  (define-dummy-word/expr 'punctuation-word))



(defun standard-wf-classification (word position)
  (if (word-rules word)
    (standard-wf-classification/known word position)
    (ecase (pos-capitalization position)
      (:lower-case word)  ;;//morph. ?
      (:digits *number-word*)
      ((or :initial-letter-capitalized
           :all-caps
           :mixed-case
           :single-capitalized-letter)
       *capitalized-word*))))

(defun standard-wf-classification/known (word position)
  (if (member :function-word (word-plist word))
    *function-word*
    (ecase (pos-capitalization position)
      (:lower-case word) 
      (:punctuation
       *punctuation-word*)
      (:digits *number-word*)
      ((or :initial-letter-capitalized
           :all-caps
           :mixed-case
           :single-capitalized-letter)
       *capitalized-word*))))



(defun wf-classification/ignore-caps (word position)
  (if (word-rules word)
    (wf-classification/ignore-caps/known word position)
    (ecase (pos-capitalization position)
      (:lower-case word)
      (:digits *number-word*)
      ((or :initial-letter-capitalized
           :all-caps
           :mixed-case
           :single-capitalized-letter)
       word ))))

(defun wf-classification/ignore-caps/known (word position)
  (if (member :function-word (word-plist word))
    *function-word*
    (ecase (pos-capitalization position)
      (:lower-case word) 
      (:punctuation
       *punctuation-word*)
      (:digits *number-word*)
      ((or :initial-letter-capitalized
           :all-caps
           :mixed-case
           :single-capitalized-letter)
       word ))))

