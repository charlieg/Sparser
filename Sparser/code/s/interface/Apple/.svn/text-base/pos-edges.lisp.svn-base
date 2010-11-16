;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:APPLE-INTERFACE -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "pos edges"              "part of speech edges"
;;;   Module:  "interface;Apple:"
;;;  Version:  1.0 June 1994

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

(defun appreciate-analysis-of-new-word (word lsa)
  (when lsa
    ;; there is at least one case of the feature description being
    ;; omitted, which has the effect of this parameter being ni
    (let ((part-of-speech (lsa-pos lsa)))
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
            (push word *possible-closed-class-words-found*)))))))


(defun install-segmentation-data-for-pos (word part-of-speech)
  (ecase part-of-speech
    (lingsoft::n )
    (lingsoft::v
     (sparser::assign-brackets-as-a-main-verb word))
    (lingsoft::a )
    (lingsoft::adv )
    (lingsoft::pcp1   ;; "ing"
     (sparser::assign-brackets-as-a-main-verb word))
    (lingsoft::pcp2  ;; ed
     (sparser::assign-brackets-as-a-main-verb word)))
  (sparser::push-onto-plist word part-of-speech :dis-pos)
  ;(sparser::put-property-on-word :dis-pos part-of-speech word)
  part-of-speech )


(defun multiple-analyses-of-word (word)
  (let ((analyses *analyses-of-current-word*))
    (single-analysis-of-word word (car analyses))
    (dolist (lsa (cdr analyses))
      (additional-instance-of-known-word word lsa))))
    

(defun additional-instance-of-known-word (word current-analysis)
  (let ((old-pos (sparser::property-of-word :dis-pos word)))
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

