;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:APPLE-INTERFACE -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "online dis analysis"
;;;   Module:  "interface;Apple:"
;;;  Version:  1.1  August 15, 1994

;; Changelong
;;  1.1 is a bug fixing release along with a repackaging -- some of
;; what was originally in this file was moved to [lingsoft features].
;; There are also small changes to coordinate this online tallying
;; with the offline work in [offline dis analysis]

;;;-------------------------------------------------
;;; acting on the features marked with a given word
;;;-------------------------------------------------
(in-package :apple)

(defun install-segmentation-data-if-pos-warrants ()
  ;; called from Finish-current-word. All of the interpretation to be
  ;; done is set up from this call.
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
        (let ((old-stem (sparser::property-of-word :ls-stem word))
              (old-multiple-stems
               (sparser::property-of-word :multiple-stems word)))
          (if old-multiple-stems
            (unless (member stem old-multiple-stems)
              (sparser::push-onto-plist word
                                        (cons stem old-multiple-stems)
                                        :multiple-stems))
            (if old-stem
              (unless (eq stem old-stem)
                (sparser::push-onto-plist word
                                          (list stem old-stem)
                                          :multiple-stems))
              (sparser::push-onto-plist word stem :ls-stem))))))))
    

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

