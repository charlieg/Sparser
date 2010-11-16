;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:APPLE-INTERFACE -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "pos edges"              "part of speech edges"
;;;   Module:  "interface;Apple:"
;;;  Version:  1.1 August 1994

;; 7/14 fixed code that was having part of speech data noted redundantly.
;; 7/19 added flag to control whether part of speech data was acted on immediately
;; or only noted an acted on later.

;;;-------------------
;;; Lingsoft features
;;;-------------------

(in-package :lingsoft)  ;; so that the symbols for the features will
                        ;; be in this package rather than 'apple'

(defparameter apple-interface::*part-of-speech-features*
              '( n v a adv
                 pcp1   ;; "ing"
                 pcp2   ;; "ed"
                 )
                 ;; ignoring: det wh prep pron cc cs
                 ;;   or generally any pos feature that would only
                 ;;   apply to a closed-class/function word that
                 ;;   should already be in the core vocabulary

  "a list of symbols that can appear in the dis.out file that name
   a word's part of speech. Any given word should receive only one
   of these.  Not every p.o.s. feature is included, just those that
   label open-class words." )



;;;-------------------------------------------------
;;; acting on the features marked with a given word
;;;-------------------------------------------------
(in-package :apple)

(defun install-segmentation-data-if-pos-warrants ()
  (let ((word *current-word*))
    (when word  ;; the first call of the run is vacuous
      (when (not (eq word :punctuation))
        (if (cdr *analyses-of-current-word*)
          (multiple-analyses-of-word word)
          (single-analysis-of-word word))))))




(defun single-analysis-of-word (word
                                &optional (analysis *current-analysis*))
  (if (sparser::known-word? word)
    (additional-instance-of-known-word word analysis)
    (appreciate-analysis-of-new-word word analysis)))

(defun multiple-analyses-of-word (word)
  (let ((analyses *analyses-of-current-word*))
    (single-analysis-of-word word (car analyses))
    (dolist (lsa (cdr analyses))
      (additional-instance-of-known-word word lsa))))


(defun appreciate-analysis-of-new-word (word lsa)
  (when lsa
    ;; there is at least one case of the feature description being
    ;; omitted, which has the effect of this parameter being ni
    (let ((part-of-speech (lsa-pos lsa))
          (stem (lsa-stem lsa)))

      (if part-of-speech
        (install-segmentation-data-for-pos word part-of-speech)
        
        ;; we're only interested in open-class words, see above
        (unless (eq (sparser::word-capitalization word) :digits)
          (when *trace-.dis-interface*
            (format t "~&>>> Unlisted function word?  \"~A\"~
                       ~%analysis: ~A~%" (sparser::word-pname word)
                    (lsa-features lsa)))
          (unless (member word *possible-closed-class-words-found*
                          :test #'eq)
            (push word *possible-closed-class-words-found*))))

      (when stem
        (sparser::push-onto-plist word stem :ls-stem)))))
    

(defun additional-instance-of-known-word (word current-analysis)
  (let ((old-pos (sparser::property-of-word :dis-pos word))
        (current-stem (lsa-stem current-analysis))
        (old-multiple-stems
         (sparser::get-tag-for :ls-multiple-stems word))
        (old-stem (sparser::get-tag-for :ls-stem word)))

    (cond (old-multiple-stems
           (unless (member current-stem old-multiple-stems :test #'eq)
             (sparser::push-onto-plist
               word (cons current-stem old-multiple-stems)
               :ls-multiple-stems)))
          ((eq old-stem (lsa-stem current-analysis)))
          (t 
           (sparser::push-onto-plist word `(,old-stem
                                            ,current-stem)
                                     :ls-multiple-stems)))
    (if old-pos
      (unless (eq old-pos (lsa-pos current-analysis))
        (appreciate-word-with-multiple-pos word current-analysis))
      (else
        ;; it's probably a close-class word in the core vocabulary
        (unless (sparser::word-rules word)
          (unless (member word *possible-closed-class-words-found*
                          :test #'eq)
            (break "New case of known word")))))))



(defun appreciate-word-with-multiple-pos (word new-analysis)
  (let ((new-pos (lsa-pos new-analysis))
        (established-pos
         (or (sparser::property-of-word :dis-multiple-pos word)
             (list (sparser::property-of-word :dis-pos word)))))
    (when new-pos
      ;; some analyses will employ pos that we're ignoring, so they
      ;; won't have a value for that field
      (unless (member new-pos established-pos :test #'eq)
        (install-segmentation-data-for-pos word new-pos)
        (sparser::put-property-on-word :dis-multiple-pos
                                       (cons new-pos established-pos)
                                       word)))))



(defparameter *act-on-.dis-pos-data-online* nil
  "Controls whether the part of speech data from .dis files is
   used to create Sparser information at the time it is first
   noticed, word by word as the file is read.")



(defun install-segmentation-data-for-pos (word part-of-speech)

  ;; Taking note of the pos on general principles or for
  ;; acting on later
  (unless (or (sparser::property-of-word :dis-pos word)
              (sparser::property-of-word :dis-multiple-pos word))
    (sparser::push-onto-plist word part-of-speech :dis-pos))

  ;; In some cases making something for Sparser to use
  (when *act-on-.dis-pos-data-online*
    (ecase part-of-speech
      (lingsoft::n )
      (lingsoft::v
       (sparser::assign-brackets-as-a-main-verb word))
      (lingsoft::a )
      (lingsoft::adv )
      (lingsoft::pcp1   ;; "ing"
       (sparser::assign-brackets-as-a-main-verb word))
      (lingsoft::pcp2  ;; ed
       (sparser::assign-brackets-as-a-main-verb word))))

  part-of-speech )



;;;-------------------------------
;;; routines to apply after a run
;;;-------------------------------

(defun words-in-run ()
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
  (let ((words (distribute-words-in-run-by-type)))
    (sparser::alphabetize-word-list words)))


(defvar *nouns* nil)
(defvar *verbs* nil)
(defvar *verbs/ing* nil)
(defvar *verbs/ed* nil)
(defvar *adjectives* nil)
(defvar *adverbs* nil)
(defvar *noun/verb* nil)
(defvar *noun/adj* nil)
(defvar *verb/adjective* nil)
(defvar *adj/ed* nil)  ;; e.g. "left"
(defvar *adj/adv* nil)
(defvar *noun/verb/adj* nil)
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
        *verb/adjective* nil
        *adj/adv* nil
        *noun/verb/adj* nil
        *function-words* nil
        *residue* nil ))



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
             (length *adj/adv*)))
  (format t "~&  noun/verb ~A" (length *noun/verb*))
  (format t "~&  verb/adj ~A" (length *verb/adjective*))
  (format t "~&  adj/past-participle  ~A" (length *adj/ed*))
  (format t "~&  noun/adj ~A" (length *noun/adj*))
  (format t "~&  adj/adv ~A" (length *adj/adv*))
  (format t "~&  n/v/a ~A" (length *noun/verb/adj*))

  (format t "~&~%~A words in the residue:~%" (length *residue*))
  *residue* )



(defun distribute-multiple-analysis-to-buckets (word list-of-features)
  (let ((n (member 'ls::n list-of-features))
        (v (member 'ls::v list-of-features))
        (a (member 'ls::a list-of-features))
        (adv (member 'ls::adv list-of-features))
        (pcp1 (member 'ls::pcp1 list-of-features))
        (pcp2 (member 'ls::pcp2 list-of-features)))

    (ecase (length list-of-features)
      (3 (cond ((and n v pcp2)  ;; "set"
                (push word *noun/verb*))
               ((and a n v)
                (push word *noun/verb/adj*))
               (t (break "New 3 feature combination"))))
      (2 (cond ((and n v)
                (push word *noun/verb*))
               ((and v a)
                (push word *verb/adjective*))
               ((and v pcp2)
                ;; be more discriminating than this?
                (push word *verbs/ing*))
               ((and a pcp2)
                (push word *adj/ed*))
               ((and n a)
                (push word *noun/adj*))
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
      (sparser::define-individual-for-term/verb word stem))

    (dolist (word *verbs/ed*)
      (setq stem (cadr (member :ls-stem (sparser::unit-plist word)
                               :test #'eq)))
      (unless stem
        (break "No stem recorded for ~A" word))
      (sparser::define-individual-for-term/verb word stem))))



;;;---------------------------------------------------
;;; processing the idioms collected during a .dis run
;;;---------------------------------------------------

(defun process-lingsoft-multitokens ()
  (dolist (string *idioms-found*)
    (process-multitokens string)))

(defun process-multitokens (string)
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
    (format t "~&>> ~A~%" pw)
    (when (sparser::word-p pw)
      (sparser::delete/word pw)
      (setq pw (sparser::define-polyword string))
      (format t "~&  --- redefined: ~A~%" pw))
    pw ))

(defun process-lingsoft-idiom (string substrings)
  ;(break)
  )

(defun process-multitoken-with-period (string substrings)
  ;(break)
  )




;;;-------------------------------------------------
;;; getting around complications in the data format
;;;-------------------------------------------------

#| Some of the features include colons, e.g. "<DEC:er>" on "computer".
   Since they are being 'read' from the file as symbols, these get 
   interpreted as indicating packages.

   We have three choices.  Change the algorithm to not use symbols, or
   to use them after some laundering.  To have the file filtered before
   it reaches this point so that these problematic features aren't
   included (..unfortunately we can't break into Lingsoft's black box
   and change their orthographic conventions).  Or to employ a foul hack
   and define all the 'packages' that their predefined, fixed set of
   features is going to require.  For the nonce I'll do that since it's
   markedly easier. 

   Note that if an unlisted (un-'exported') case occurs we'll get a
   Lisp error to the effect that the symbol is not external in the
   package.
|#
(eval-when (:execute :load-toplevel :compile-toplevel)
  (unless (find-package "<DER")
    (make-package "<DER")))

(in-package "<DER")

(export 'al> )  ;; <DEC:al>
(export 'ed> )  ;; <DEC:ed>
(export 'er> )  ;; <DER:er>
(export 'ic> )  ;; <DEC:ic>
(export 'ly> )  ;; <DEC:ly>
(export 'or> )  ;; <DEC:or>
(export 'ate> )   ;; <DEC:ate>
(export 'ble> )   ;; <DEC:ble>
(export 'bly> )   ;; <DEC:bly>
(export 'ing> )   ;; <DEC:ing>
(export 'ive> )   ;; <DEC:ive>
(export 'able> )  ;; <DEC:able>
(export 'ness> )  ;; <DEC:ness>
(export 'bility> )  ;; <DEC:bility>



(in-package :apple-interface)

#| A comparable problem is Lingsoft's use of the occasional 'comma'.
   When using 'read' and interpreting features as symbols this
   will cause a "Comma not inside backquote" error.

   The simplest way around this seems to be to modify the readtable
   during the time this reading is being done.  
|#

(defparameter *readtable/comma-is-constituent* nil
  "Set to a copy of the standard Common Lisp readtable to be changed
   to fit the needs of the .dis interface.")


(defun de-fang-comma ()
  (let ((standard-cl-table (copy-readtable nil)))
        ;; guarenteed to get the real thing

    (setq *readtable/comma-is-constituent* standard-cl-table)

    ;; change comma to have the reader syntax of lowercase a
    (set-syntax-from-char
     #\,                               #\a
     *readtable/comma-is-constituent*  standard-cl-table)))

