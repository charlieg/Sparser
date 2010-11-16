;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:APPLE-INTERFACE -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "offline dis analysis"
;;;   Module:  "interface;Apple:"
;;;  Version:  1.0  August 24, 1994

;; Change Log
;;  11/21 Sharpened the call that makes verb-terms from the pos data

(in-package :apple)


(defun render.dis-data-into-Sparser-information ()
  (let ((*trace-.dis-interface* t))
    (process-lingsoft-multitokens)
    (post-run-analysis/part-of-speech)
    (alphabetize-pos-buckets)
    (install-unambiguous-verbs-as-such)
    (sparser::declare-all-existing-individuals-permanent)))


;;;------------------------------------------------------
;;; routines to apply after a run of the *.dis interface
;;;------------------------------------------------------

(defun words-in-run ()
  "Goes through the total set of words currently defined and
   creates a list of those that have data on them indicating
   that they were defined by means of a .dis run."
  (let ( word-list )
    (maphash #'(lambda (word count)
                 (push word word-list)
                 (unless (eq word :punctuation)
                   (unless (sparser::get-tag-for :word-count word)
                     ;; there can be reasons to run this routine
                     ;; several times, and we don't want multiple
                     ;; instances of the property
                     (sparser::push-onto-plist
                      word count :word-count))))
             *words-in-.dis-run*)
    word-list ))


(defun distribute-words-in-run-by-type ()
  ;; divides the 'word's defined by a run into words and polywords.
  (let ( words  polywords )
    (dolist (item (words-in-run))
      (typecase item
        (sparser::word (push item words))
        (sparser::polyword (push item polywords))
        (symbol
         (unless (eq item :punctuation)
           (break "Unexpected symbol in word table:~%  ~A" item)))
        (otherwise
         (break "Unexpected type of item in word table:~%  ~A"
                item))))
    (values words polywords)))


(defun alphabetize-words-in-run ()
  ;(multiple-value-bind (words polywords)
  ;                     (distribute-words-in-run-by-type)
  ;; Not clear where to fold polywords into an alphabetic presentation
  (let ((words (distribute-words-in-run-by-type)))
    (sparser::alphabetize-list-of-words words)))


;;;------------------------------------------------------
;;; distributing words into buckets by Lingsoft pos data
;;;------------------------------------------------------

(defvar *nouns* nil)
(defvar *verbs* nil)
(defvar *verbs/ing* nil)
(defvar *verbs/ed* nil)
(defvar *adjectives* nil)
(defvar *adverbs* nil)
(defvar *noun/verb* nil)
(defvar *noun/adj* nil)
(defvar *noun/adv* nil)
(defvar *noun/pres-part* nil)
(defvar *verb/adjective* nil)
(defvar *verb/adv* nil)
(defvar *adj/ed* nil)  ;; e.g. "left"
(defvar *adj/adv* nil)
(defvar *noun/verb/adj* nil)
(defvar *adj/verb/past-part* nil)
(defvar *adj/adv/verb* nil)
(defvar *adj/adv/past-part* nil)
(defvar *adj/adv/verb/past-part* nil)
(defvar *function-words* nil)
(defvar *residue* nil)

(defun initialize-pos-analysis-buckets ()
  (setq *nouns* nil
        *verbs* nil
        *verbs/ing* nil
        *verbs/ed* nil
        *adjectives* nil
        *adj/ed* nil
        *adverbs* nil
        *noun/verb* nil
        *noun/adj* nil
        *noun/adv* nil
        *noun/pres-part* nil
        *verb/adjective* nil
        *verb/adv* nil
        *adj/adv* nil
        *noun/verb/adj* nil
        *adj/verb/past-part* nil
        *adj/adv/verb* nil
        *adj/adv/past-part* nil
        *adj/adv/verb/past-part* nil
        *function-words* nil
        *residue* nil ))


(defparameter *print-bucket-distribution-to-buffer* t
  "flag read in Alphabetize-pos-buckets.")

(defun alphabetize-pos-buckets ()
  (let ( buffer )
    (when *print-bucket-distribution-to-buffer*
      (setq buffer (fred)))

    (dolist (symbol '(*nouns* 
                      *verbs* *verbs/ing* *verbs/ed*
                      *adjectives* *adverbs*
                      *noun/verb* *noun/adj* *noun/adv* *noun/pres-part*
                      *verb/adjective* *verb/adv*
                      *adj/ed* *adj/adv*
                      *noun/verb/adj*
                      *adj/verb/past-part* *adj/adv/verb* *adj/adv/past-part*
                      *adj/adv/verb/past-part*
                      *function-words* *residue* ))
      
      (sparser::alphabetize-word-list symbol)

      (when *print-bucket-distribution-to-buffer*
        (format buffer "~%~%~%--------------------------------------------~
                        ~%  ~A~%~%" symbol)
        (sparser::pl (symbol-value symbol)
                     t  ;; include numbering ?
                     buffer)))))




(defun post-run-analysis/part-of-speech ( &optional
                                          (words-in-run
                                           (alphabetize-words-in-run)))
  (initialize-pos-analysis-buckets)
  (dolist (word words-in-run)
    (let ((multiple (sparser::get-tag-for :dis-multiple-pos word))
          (single (sparser::get-tag-for :dis-pos word)))
      (cond (multiple
             (distribute-multiple-analysis-to-buckets word multiple))
            (single
             (distribute-single-analysis-to-buckets word single))
            ((sparser::punctuation? word))
            ((sparser::function-word? word)
             (push word *function-words*))
            ((sparser::digit? word))
            ((sparser::digit-sequence? word))
            (t
             ;(break "Word without an analysis: ~A" word)
             (push word *residue*))
            )))

  (when *trace-.dis-interface*
    ;; this distributed layout makes this easier to reorder and
    ;; easier to extend without making a mistake
    (format t "~&~%nouns ~A" (length *nouns*))
    (format t "~&verbs ~A" (length *verbs*))
    (format t "~&verbs with 'ing' ~A" (length *verbs/ing*))
    (format t "~&verbs with 'ed' ~A" (length *verbs/ed*))
    (format t "~&adjectives ~A"  (length *adjectives*))
    (format t "~&adverbs: ~A" (length *adverbs*))
    (format t "~&function words ~A" (length *function-words*))
    (format t "~&ambiguous words ~A"
            (+ (length *noun/verb*) (length *verb/adjective*)
               (length *adj/ed*) (length *noun/adj*)
               (length *adj/adv*) (length *noun/adv*)
               (length *verb/adv*) ))
    (format t "~&  verb/adj ~A" (length *verb/adjective*))
    (format t "~&  verb/adv ~A" (length *verb/adv*))
    (format t "~&  adj/past-participle  ~A" (length *adj/ed*))
    (format t "~&  noun/verb ~A" (length *noun/verb*))
    (format t "~&  noun/adj ~A" (length *noun/adj*))
    (format t "~&  noun/adv ~A" (length *noun/adv*))
    (format t "~&  noun/pres-part ~A" (length *noun/pres-part*))
    (format t "~&  adj/adv ~A" (length *adj/adv*))
    (format t "~&  n/v/a ~A" (length *noun/verb/adj*))
    (format t "~&  adj/verb/past-part ~A" (length *adj/verb/past-part*))
    (format t "~&  adj/adv/verb ~A" (length *adj/adv/verb*))
    (format t "~&  adj/adv/past-part ~A" (length *adj/adv/past-part*))
    (format t "~&  adj/adv/verb/past-part ~A" (length *adj/adv/verb/past-part*))
    
    (format t "~&~%~A words in the residue:~%~A"
            (length *residue*) *residue* ))
  :done )



(defun distribute-multiple-analysis-to-buckets (word list-of-features)
  (let ((n (member 'ls::n list-of-features))
        (v (member 'ls::v list-of-features))
        (a (member 'ls::a list-of-features))
        (adv (member 'ls::adv list-of-features))
        (pcp1 (member 'ls::pcp1 list-of-features))
        (pcp2 (member 'ls::pcp2 list-of-features)))

    (when pcp1 (push word *verbs/ing*))
    (when pcp2 (push word *verbs/ed*))
    ;; these will cause some pos-ambiguous words to appear
    ;; in more than one bucket and so distort the counts, but
    ;; it's much more useful to get these analyzed as verbs
    ;; by Install-unambiguous-verbs-as-such than to have a
    ;; perfect count.

    (ecase (length list-of-features)
      (4 (cond ((and a adv v pcp2)
                (push word *adj/adv/verb/past-part*))))
      (3 (cond ((and n v pcp2)  ;; "set"
                (push word *noun/verb*))
               ((and a n v)
                (push word *noun/verb/adj*))
               ((and a v pcp2)
                (push word *adj/verb/past-part*))
               ((and a adv pcp2)
                (push word *adj/adv/past-part*))
               ((and a adv v)
                (push word *adj/adv/verb*))
               (t (break "New 3 feature combination"))))
      (2 (cond ((and n v)
                (push word *noun/verb*))
               ((and n a)
                (push word *noun/adj*))
               ((and n adv)
                (push word *noun/adv*))
               ((and n pcp1)
                (push word *noun/pres-part*))
               ((and v a)
                (push word *verb/adjective*))
               ((and v pcp2)
                ;; be more discriminating than this?
                (push word *verbs/ing*))
               ((and v adv)
                (push word *verb/adv*))               
               ((and a pcp2)
                (push word *adj/ed*))
               ((and a adv)
                (push word *adj/adv*))
               (t
                (break "New 2 feature combination")))))))


(defun distribute-single-analysis-to-buckets (word feature)
  (ecase feature
    (ls::n (push word *nouns*))
    (ls::v (push word *verbs*))
    (ls::pcp1 (push word *verbs/ing*))
    (ls::pcp2 (push word *verbs/ed*))
    (ls::a (push word *adjectives*))
    (ls::adv (push word *adverbs*))
    ))


;;--- Acting on all that data

(defun install-unambiguous-verbs-as-such ()
  (let ( stem )
    (dolist (word *verbs*)
      (setq stem (cadr (member :ls-stem (sparser::unit-plist word)
                               :test #'eq)))
      (unless stem
        (break "No stem recorded for ~A" word))
      (sparser::define-individual-for-term/verb word stem))

    (dolist (word *verbs/ing*)
      (setq stem (cadr (member :ls-stem (sparser::unit-plist word)
                               :test #'eq)))
      (unless stem
        (break "No stem recorded for ~A" word))
      (sparser::define-individual-for-term/verb
        word stem category::verb+ing))

    (dolist (word *verbs/ed*)
      (setq stem (cadr (member :ls-stem (sparser::unit-plist word)
                               :test #'eq)))
      (unless stem
        (break "No stem recorded for ~A" word))
      (sparser::define-individual-for-term/verb
        word stem category::verb+ed))))



;;;---------------------------------------------------
;;; processing the idioms collected during a .dis run
;;;---------------------------------------------------

(defun process-lingsoft-multitokens ()
  (dolist (string *idioms-found*)
    (process-multitoken string)))

(defun process-multitoken (string)
  ;; multi-tokens are words connected by punctuation that are interesting
  ;; to LingSoft for some reason or another. In any event, they get their
  ;; linguistic analysis as a whole and appear in folded input (i.e. source
  ;; with /syn markup) as single items though Sparser's tokenizer will
  ;; of course break them down into their component tokens.

  (let ((substrings (sparser::token-strings-in-string string)))
    (cond ((member "=" substrings :test #'equal)
           (process-lingsoft-idiom string substrings))
          ((member "-" substrings :test #'equal)
           (process-hyphenated-word string))
          ((member "." substrings :test #'equal)
           (process-multitoken-with-period string substrings))
          (t (break "Unanticipated case: the multi-token ~A~
                     has none of the known separators ('-', '=')"
                    string)))))


(defun process-hyphenated-word (string)
  (let ((pw (sparser::define-polyword string)))
    (when *trace-.dis-interface*
      (format t "~&>> ~A~%" pw))
    (when (sparser::word-p pw)
      ;;// something strange is happening in some of the cases when
      ;; the hyphenated word is first seen such that it is being
      ;; defined as the wrong kind of object.  This postprocessing
      ;; gets around the problem.
      (sparser::delete/word pw)
      (setq pw (sparser::define-polyword string))
      (when *trace-.dis-interface*
        (format t "~&  --- redefined: ~A~%" pw)))
    pw ))

(defun process-lingsoft-idiom (string substrings)
  (declare (ignore substrings))
  ;; these are word strings with '=' within them that LS analyzes
  ;; as a whole
  (let ((pw (sparser::define-polyword string)))
    (when *trace-.dis-interface*
      (format t "~&>> ~A~%" pw))
    (when (sparser::word-p pw)
      (sparser::delete/word pw)
      (setq pw (sparser::define-polyword string))
      (when *trace-.dis-interface*
        (format t "~&  --- redefined: ~A~%" pw)))
    pw ))

(defun process-multitoken-with-period (string substrings)
  ;(break) Waiting to see what's needed at runtime
  )

