;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:APPLE-INTERFACE -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "dis.out reader"
;;;   Module:  "interface;Apple:"
;;;  Version:  1.1  August 15, 1994

;; Changelog
;; 1.1 incorporates minor adjustments to accomodate the pos-run processing

(in-package :apple-interface)



;;;------------------
;;; trace parameters
;;;------------------

(defparameter *trace-.dis-interface* nil
  "Flag controlling occasional format statements that announce
   idioms, compounds and the like while the analysis of a file
   is progressing.")

(defparameter *trace-.dis-interface/track-words* nil
  "Flay controlling a trace of all the words as they are seen.")
  
 

;;;-----------------
;;; state variables
;;;-----------------

(defvar *word-count* nil
  "Counts the number of unique words in the input, ignoring
   punctuation and special characters")

(defvar *token-count* nil
  "Incremented with each token. Can be used to correlate a
   position in the .dis file with a position in the chart.")


(defvar *current-word* nil
  "Stores the word whose analyses are being collected")

(defvar *current-analysis* nil
  "Stores the ls-analysis object being filled")

(defvar *analyses-of-current-word* nil
  "A list of ls-analysis objects accumulating for the current word")


(defvar *words-in-.dis-run* (make-hash-table :test #'eq)
  "A hashtable of word objects.  Each word that is seen in the course of
   a run through a .engdis.out is accumulated here by Finish-Word.
   The words are the keys and the value is the number of instances of 
   the word in the run.")


(defvar *compound-nouns-found* nil
  "A list of strings flagged as compound nouns by the LS software.
   It is accumulated over the entire run.")

(defvar *idioms-found* nil
  "A list of strings flagged as idioms by the LS software.
   It is accumulated over the entire run.")

(defvar *possible-closed-class-words-found* nil
  "This accumulates every unknown word that does not have one of
   the parts of speech we have associated with content words.")


(defvar *stream-to-open-dis-file* nil
  "Set when the stream is opened by the driver. Provides convenient
   access for debugging")


;;;---------------------------
;;; collection data structure
;;;---------------------------

(defstruct (ls-analysis
            (:conc-name #:lsa-)
            (:print-function print-ls-analysis))
  word
  number
  stem
  pos
  features
  )

(defun print-ls-analysis (obj stream depth)
  (declare (ignore depth))
  (format stream "#<ls-analysis~A ~A ~A>"
          (lsa-number obj)
          (if (lsa-word obj)
            (sparser::word-pname (lsa-word obj))
            "unused")
          (or (lsa-pos obj)
              "")))

(defun initialize-ls-analysis-object (ls)
  (setf (lsa-word ls) nil)
  (setf (lsa-stem ls) nil)
  (setf (lsa-pos ls) nil)
  (setf (lsa-features ls) nil)
  ls )

(defparameter lsa1 (make-ls-analysis :number 1))
(defparameter lsa2 (make-ls-analysis :number 2))
(defparameter lsa3 (make-ls-analysis :number 3))
(defparameter lsa4 (make-ls-analysis :number 4))
(defparameter lsa5 (make-ls-analysis :number 5))
(defparameter lsa6 (make-ls-analysis :number 6))
(defparameter lsa7 (make-ls-analysis :number 7))
(defparameter lsa8 (make-ls-analysis :number 8))
(defparameter lsa9 (make-ls-analysis :number 9))
(defparameter lsa10 (make-ls-analysis :number 10))

(defvar *analyses-objects* nil
  "Holds a list of ls-analysis objects, defining the order
   in which they will be used.")


;;;-------------------------
;;; initialization routines
;;;-------------------------

(defun initialize-dis-assimilation-process ()
  (setq *word-count*  0
        *token-count* 0
        *compound-nouns-found* nil
        *idioms-found* nil
        *possible-closed-class-words-found* nil)
  (when *words-in-.dis-run*
    (clrhash *words-in-.dis-run*))
  (initialze-word-analysis-data))


(defun initialze-word-analysis-data ()
  (setq *analyses-objects*
        (list lsa1 lsa2 lsa3 lsa4 lsa5 lsa6 lsa7 lsa8 lsa9 lsa10))
  (dolist (ls *analyses-of-current-word*)
    (initialize-ls-analysis-object ls))
  (prog1
    *current-word*
    (setq *current-analysis* nil
          *analyses-of-current-word* nil
          *current-word* nil)))



;;;-------------------
;;; multi-file driver
;;;-------------------

(defun run-dis-over-book (document-stream-name)
  (let ((ds (sparser::document-stream-named document-stream-name))
        dis-name )
    (initialize-dis-assimilation-process)
    (dolist (gml-name (sparser::ds-file-list ds))
      (setq dis-name
            (concatenate
             'string (subseq gml-name
                             0 (position #\. gml-name :from-end t))
             ".engsyn.out"))
      (apple::assimilate-dis.out dis-name nil))))



;;;--------
;;; driver
;;;--------

(defun assimilate-dis.out (file-namestring
                           &optional (initialize? t))

  "Opens the file and 'read's items from it until it is exhausted.
   Each successive item is passed to Dispatch which governs all 
   later processing."

  (unless *readtable/comma-is-constituent*
    ;; should be included in the setup for the interface
    (de-fang-comma))

  (let ((eof (gensym))
        (*package* (find-package :lingsoft))
        (*readtable* *readtable/comma-is-constituent*)
        item )

    (when initialize?
      (initialize-dis-assimilation-process))

    (with-open-file (infile file-namestring
                     :direction :input)
      (setq *stream-to-open-dis-file* infile)
      (loop
        (setq item (read infile nil eof))
        (when (eq item eof)
          (return))
        (dispatch item infile)))

    (setq *stream-to-open-dis-file* nil)
    (format t "~%~%----------------------------------------~
               ~% ~A tokens~
               ~%  ~A words" *token-count* *word-count* )))



(defun dispatch (item stream)
  ;(format t "~&item = ~A~%" item)
  (etypecase item
    (string
     (if (eq (elt item 0) #\< )
       (start-next-word item stream)
       (start-ls-analysis item)))
    (symbol
     (accumulate-ls-feature item))))



;;;-----------------------
;;; processing word items
;;;-----------------------

(defun finish-current-word ()
  ;(format t "  ~A - ~A~%" *current-word*
  ;        ;; follows on trace of the word itself in Ass..&-setup-word
  ;        (when *current-analysis*
  ;          (lsa-pos *current-analysis*)))
  (let ((word *current-word*))
    (when word
      (let ((count (gethash word *words-in-.dis-run*)))
        (if count
          (setf (gethash word *words-in-.dis-run*) (1+ count))
          (setf (gethash word *words-in-.dis-run*) 1))))

    (install-segmentation-data-if-pos-warrants)))



(defun start-next-word (string stream)

  "Finishes the analysis of the prior word, looks up or creates
   the word corresponding to the just-read string, and sets up
   to assimilate its analysis."

  ;; data check against the file format
  (let ((next-char (read-char stream nil :eof)))
    (unless (eql next-char #\newline)
      ;; the LS convention is to have no spaces after these word-citation
      ;; lines, just the Newline. The feature lines end in a space.
      ;; This call checks for a weirdness.
      (setq string (repair-double-quote-token string next-char stream)))

    (finish-current-word)
    (initialze-word-analysis-data)

    ;; strip the "<" and ">" off the string for the word
    (let ((substring (subseq string 1
                                   (1- (length string)))))
      (case (elt substring 0)
        (#\$  (assimilate-punctuation (subseq substring 1)))
        (#\*  (look-for-token-separating-chars-and-assimilate 
               (subseq substring 1) t))
        (#\&  (assimilate-special-token substring))
        (otherwise
         ;(break)
         (look-for-token-separating-chars-and-assimilate
          substring nil))))))



;;;------------------------------------------------------------
;;; cases where LS has one token and Sparser will have several
;;;------------------------------------------------------------

(defun look-for-token-separating-chars-and-assimilate
       (string  &optional recursive-call? )
  (let ((revised-string string)
        pos  )

    (when (setq pos (position #\_  string :test #'eql :from-end t))
      (setq revised-string
            (strip-out-underbar string pos recursive-call?)))

    (when (setq pos (position #\=  string :test #'eql :from-end t))
      (setq revised-string
            (record-and-hack-interior-of-idiom
             string pos recursive-call?)))

    (when (setq pos (position #\-  string :test #'eql :from-end t))
      (setq revised-string
            (breakup-hyphenated-word string pos recursive-call?)))

    (when (setq pos (position #\.  string :test #'eql :from-end t))
      (setq revised-string
            (breakup-interior-period string pos recursive-call?)))
 ;(break)
    (assimilate-word-and-setup-for-analyses revised-string nil)))




(defun strip-out-underbar (string pos record-already-made?)
  (let ((end-of-string (1- (length string))))
    (cond ((= pos end-of-string)
           (subseq string 0 end-of-string)) ;; "you_"
          ((= pos 0)
           (if (eql #\' (char string 1))    ;; "_'re"
             (subseq string 2)
             (if (eql #\' (char string 2))  ;; "_n't"
               (subseq string 3)
               (break "not a contraction"))))
          (t  ;; "floppy_disk"
           (assimilate-nominal-compound
            string pos record-already-made?)))))

;(strip-out-underbar "you_" 3 nil)
;(strip-out-underbar "_'re" 0 nil)
;(strip-out-underbar "_n't" 0 nil)
;(strip-out-underbar "floppy_disk" 6 nil)
;(strip-out-underbar "floppy_master_disk" 13 nil)


(defun assimilate-nominal-compound (string pos record-already-made?)
  ;; there can (?) be several substrings joined by underbars in one
  ;; original string.  What we do is snip off the last substring as
  ;; the value we will eventually return. If there is more than one
  ;; token in the prefix, that will be noticed in the recusive call
  ;; by the very same check that got us here in the first place.
  ;; We'll know we're coming back to handle components of the
  ;; prefix by the flag 'record-already-made?', whose name indicates
  ;; that the compound only to be put on the list once.
  ;;    We're going to all this hassle because (in principle) there
  ;; could be other conventional characters in the substrings and
  ;; we want to be sure they're hacked right.

  (if record-already-made?
    (assim-nom-com/aux string pos)
    (else
      (push string *compound-nouns-found*)
      (when *trace-.dis-interface*
        (format t "~&>>> Nominal compound: ~A~%" string))
      (assim-nom-com/aux string pos))))

(defun assim-nom-com/aux (string pos)
  (let ((last-substring (subseq string (1+ pos))))
    ;; n.b. the incoming pos was taken from the end
    (look-for-token-separating-chars-and-assimilate 
      (subseq string 0 pos) t )
    last-substring ))
  


(defun record-and-hack-interior-of-idiom (string pos recursive-call?)
  (if recursive-call?
    (record-idiom/aux string pos)
    (else
      (push string *idioms-found*)
      (when *trace-.dis-interface*
        (format t "~&>>> Idiom: ~A~%" string))
      (record-idiom/aux string pos))))

(defun record-idiom/aux (string pos)
  ;; this is identical to Assim-nom-com/aux since all the
  ;; character-specific work is done in the caller
  (let ((last-substring (subseq string (1+ pos))))
    ;; n.b. the incoming pos was taken from the end
    (look-for-token-separating-chars-and-assimilate 
      (subseq string 0 pos) t )
    last-substring ))

;(record-and-hack-interior-of-idiom "aa=bb" 2 nil)
;(record-and-hack-interior-of-idiom "aa=bb=cc" 5 nil)



(defun breakup-hyphenated-word (string pos recursive-call?)
  (if recursive-call?
    (breakup-hyphenation/aux string pos)
    (else
      (push string *idioms-found*)
      (when *trace-.dis-interface*
        (format t "~&>>> Hyphenated word: ~A~%" string))
      (breakup-hyphenation/aux string pos))))

(defun breakup-hyphenation/aux (string pos)
  (let ((last-substring (subseq string (1+ pos))))
    ;; n.b. the incoming pos was taken from the end
    (look-for-token-separating-chars-and-assimilate 
      (subseq string 0 pos) t )
    last-substring ))

;(breakup-hyphenated-word "aa-bb" 2 nil)
;(breakup-hyphenated-word "aa-bb-cc" 5 nil)



(defun breakup-interior-period (string pos recursive-call?)
  (if recursive-call?
    (breakup-period/aux string pos)
    (else
      (push string *idioms-found*)
      (when *trace-.dis-interface*
        (format t "~&>>> Interior period: ~A~%" string))
      (breakup-period/aux string pos))))

(defun breakup-period/aux (string pos)
  (let ((last-substring (subseq string (1+ pos))))
    ;; n.b. the incoming pos was taken from the end
    (look-for-token-separating-chars-and-assimilate 
      (subseq string 0 pos) t )
    last-substring ))

;(breakup-interior-period "aa.bb" 2 nil)
;(breakup-interior-period "aa.bb.cc" 5 nil)


;;;-----------------------
;;; setting up for a word
;;;-----------------------

(defun assimilate-word-and-setup-for-analyses (pname
                                               capitalized?
                                               &aux caps-pname )
  (when (= 0 (length pname))
    (when *trace-.dis-interface*
      (format t "~&~%!! null pname, possibly the ~
                 result of a LingSoft glitch.~%~%"))
    (return-from
      Assimilate-word-and-setup-for-analyses nil))

  (when (or capitalized?
            (find #\* pname))
    (setq caps-pname
          (if (find #\* pname)
            (check-for-more-caps pname)
            (sparser::define-word/expr (string-capitalize pname)))))

  (let* ( new?
         (word
          (or (sparser::word-named pname)
              (else
                (setq new? t)
                (if capitalized?
                  (then
                    (sparser::define-word pname)
                    ;; n.b. with this ordering of the two cases,
                    ;; the *current-word* is going to be set to
                    ;; the capitalized word rather than to its
                    ;; (implicitly required by Sparser's tokenizer)
                    ;; lowercase equivalent
                    (sparser::define-word caps-pname))
                  (sparser::define-word pname))))))
    (when new?
      (incf *word-count*))
    (incf *token-count*)
    (when (null word)
      (break "glitch: 'word' is nil"))
    (when *trace-.dis-interface/track-words*
      (format t "~A " (sparser::word-pname word)))
    (setq *current-word* word)))



(defun check-for-more-caps (string)
  ;; The caller has determined that there is at least one "*" character
  ;; within the string.  We return a new string with each "*" removed
  ;; and each character following it given in uppercase.
  (let ((list-of-characters (coerce string 'list))
        new-string )
    (do* ((sublist list-of-characters (cdr sublist))
          (char (first sublist) (first sublist))
          (next-char (second sublist) (second sublist)))
         ((null sublist))
      (if (eql char #\*)
        (then
          (push (char-upcase next-char) new-string)
          (setq sublist (cdr sublist)))
        (push char new-string)))
    (coerce (nreverse new-string) 'string)))

;(check-for-more-caps "abcd")
;(check-for-more-caps "*abc")
;(check-for-more-caps "a*bc")
;(check-for-more-caps "a*b*c")


;;;--------------------------------
;;; punctuation and special tokens
;;;--------------------------------

(defun assimilate-punctuation (one-character-pname)
  (let ((punctuation-word (sparser::word-named one-character-pname)))
    (unless punctuation-word
      (unless (equal "HEAD" one-character-pname)
        (break "Threading (?) Why isn't there a punctuation word ~
                defined~%for the character \"~A\""
               one-character-pname)))
    (when *trace-.dis-interface/track-words*
      (if (equal "HEAD" one-character-pname) ;; trace
        (format t "HEAD")
        (format t "~A " (sparser::word-pname punctuation-word))))
    (setq *current-word* :punctuation)))


(defun assimilate-special-token (multi-token-string)
  ;; e.g. "&apple"
  (let ((polyword (sparser::polyword-named multi-token-string)))
    (unless polyword
      (break "New case of special character: ~A~
              ~%Define it and continue~%"
             multi-token-string)
      (setq polyword (sparser::polyword-named multi-token-string)))
    (when *trace-.dis-interface/track-words*
      (format t "~&polyword: ~A~%" (sparser::word-pname polyword)))
    (setq *current-word* polyword)))




;;;-------------------------------
;;; processing the analysis lines
;;;-------------------------------

(defun start-ls-analysis (pname)
  
  (let ((analysis (pop *analyses-objects*))
        (word (or (sparser::word-named pname)
                  (sparser::define-word pname))))
    (if analysis
      (setq *current-analysis* analysis)
      (break "Ran out of analysis objects for the current word"))
    (push analysis *analyses-of-current-word*)

    (unless (sparser::word-p *current-word*)
      (unless (sparser::polyword-p *current-word*)
        (break "Threading: *current-word* is set to ~A~
                ~%instead of a word" *current-word*)))

    (setf (lsa-word analysis) *current-word*)
    (setf (lsa-stem analysis) word)))



(defun accumulate-ls-feature (symbol)
  (unless (symbolp symbol)
    (break "Data: while accumulating features for ~A~
            ~%got an item that wasn't a symbol: ~A"
           *current-word* symbol))

  (push symbol (lsa-features *current-analysis*))
  (when (member symbol *part-of-speech-features* :test #'eq)
    (setf (lsa-pos *current-analysis*) symbol)))



;;;--------------------------------------------------------------
;;; compensating for C/Lisp mismatches in syntactic assumptions
;;;--------------------------------------------------------------
;; see the case in [pos edges] as well


(defparameter dis-stream nil) ;; for debugging

(defun repair-double-quote-token (string char-just-read stream)
  ;; we're here because the character after the word-naming item
  ;; was not a newline.  That 'unless' is basically a data check to track
  ;; the consistency of the convention that is being used in the
  ;; assembly of the .dis file, however it also picks up a case
  ;; that is forced on us by the fact that we're working through
  ;; the file with 'read' -- namely that a reference to a double-quote
  ;; punctuation character will be mis-read as an oddly formed
  ;; token: the punctuation token being flagged with the angle-bracket
  ;; followed by a dollar sign is terminated prematurely by the
  ;; very punctuation character it is flagging.  The next two
  ;; characters are the closing bracket and another double-quote
  ;; i.e.  "<$">"    We have to appreciate this explicitly and
  ;; make an explicit readch into the stream to get the > and "
  ;; by hand so that the rest of the stream will parse as intended
  ;; from then on. 
  (let ((next-char (peek-char nil stream)))
        ;;file can't end here, can it?

    ;; check for the case we're looking for, and if it's not
    ;; found, go to a general break that reflects the original
    ;; situation.
    (unless (and (eql char-just-read #\> )
                 (eql next-char #\"))
      (break "Data check: ostensive word: ~A~%is not immediately ~
              followed by a newline" string))

 ;(setq dis-stream stream)
 ;(break)
    ;; we've found the case we're expecting, so we reconstruct
    ;; the situation by doing some readch's and then return
    ;; the proper string that we would have gotten had some different
    ;; kind of reader been used. 
    (read-char stream) ;; flush the #\>
    (read-char stream) ;; flush the #\"
    "<$\">" ))

