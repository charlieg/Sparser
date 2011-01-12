;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(S2) -*-
;;; Copyright (c) 2006-2010 BBNT Solutions LLC. 
;;; Copyright (c) 2010 David D. McDonald
;;; $Id$
;;;
;;;     File: "treebank-reader"
;;;   Module: "grammar;rules:words:one-offs:"
;;;  Version:  August 2010

;;; Moved to words/one-offs 11/1/10

(in-package :sparser)

;;; (setq *readtable* *my-readtable*)
;;; (harness "/Users/ddm/ws/nlp/corpus/treebank/10s.txt")
;;; (set-macro-characters)


;; These solve a problem about populating the chart by hiding
;; the multi-type characters of the symbols from Sparser's tokenizer
;; The values have to be a single character type so that the tokenizer
;; will treat them as a single token rather than split them, which
;; leads to getting the wrong chart terminals and all sorts of subtle
;; bugs -- see extract-terminals-loop in sparser-interface

(defconstant *possessive-marker* (intern "POSSESSIVE" (find-package :sparser)))

(defconstant *LRB* 'lrb) ;; open & close parentheses
(defconstant *RRB* 'rrb)

(defconstant *open-quote* 'openQuote)
(defconstant *close-quote* 'closeQuote)

(export '(*possessive-marker*
          *LRB*
          *RRB*
          *open-quote*
          *close-quote*
          ))


;;;------
;;; util
;;;------

(defun take (n list)
  (loop repeat n
      collect (pop list)))


;;;-----------------------
;;; readtable for TB sexp
;;;-----------------------

(defparameter *my-readtable* (copy-readtable))

(defun period-reader (stream char)
  (declare (ignore stream char))
  'period)

(defun comma-reader (stream char)
  (declare (ignore stream char))
  'comma)

(defun backquote-reader (stream char)
  (declare (ignore char))
  (let ((c (peek-char nil stream)))
    (if (eql c #\`)
	(then 
	 (read-char stream)
	 (let ((d (peek-char nil stream)))
	   (if (eql d #\))
	       'open-quote
	     'open-quote-tag)))
      'open-quote)))

(defun quote-reader (stream char)
  (declare (ignore char))
  (let ((c (peek-char nil stream)))
    (if (eql c #\')
	(then (read-char stream) 'close-quote)
      'single-quote))) ;; appostrophe ??

(defun colon-reader (stream char)
  (declare (ignore char))
  (let ((c (peek-char nil stream)))
    (if (eql c #\space)
	'colon-tag
      'colon)))

(defun semicolon-reader (stream char)
  (declare (ignore stream char))
  'semicolon)

(defun sharpsign-reader (stream char)
  (declare (ignore char))
  (let ((c (peek-char nil stream)))
    (if (eql c #\space)
	'sharpsign-tag
      'sharpsign)))

(defparameter period 'period)
(defparameter comma 'comma)
(defparameter open-quote 'open-quote)
(defparameter open-quote-tag 'open-quote-tag)
(defparameter close-quote 'close-quote)
(defparameter single-quote 'single-quote)
(defparameter colon-tag 'colon-tag)
(defparameter colon 'colon)
(defparameter semicolon 'semicolon)
(defparameter sharpsign 'sharpsign)
(defparameter sharpsign-tag 'sharpsign-tag)


(defun set-macro-characters ()
  (set-macro-character #\. #'period-reader nil *my-readtable*)
  (set-macro-character #\, #'comma-reader nil *my-readtable*)
  (set-macro-character #\` #'backquote-reader nil *my-readtable*)
  (set-macro-character #\' #'quote-reader nil *my-readtable*)
  (set-macro-character #\: #'colon-reader nil *my-readtable*)
  (set-macro-character #\; #'semicolon-reader nil *my-readtable*)
  (set-macro-character #\# #'sharpsign-reader nil *my-readtable*))

(set-macro-characters)

(defvar *current-readtable* *readtable*)

(defun my-rt () (setq *readtable* *my-readtable*))

(defun old-rt () (setq *readtable* *current-readtable*))

(defmacro with-readtable-bound (&body body)
  `(progn
     (my-rt)
     ,@body
     (old-rt)))


;;;---------
;;; objects
;;;---------

(defstruct (immediate-constituent-pattern
	    (:conc-name "icp-")
	    (:print-function
	     (lambda (icp stream depth)
	       (declare (ignore depth))
	       (format stream "#<icp ~a => ~a>"
		       (icp-tag icp)
		       (icp-constituents icp)))))
  tag ;; symbol for now, rep. of the NT latter
  constituents
  freq
  count ;; ///
  over-terminals?
  )


;;;------------
;;; parameters
;;;------------

(defparameter *tb-notice-immediate-constituent-patterns* nil
  "This is the original purpose of this body of code, but it is expensive
 if all one is doing is working with the words.")

(defparameter *tb-notice-words* t)

(defparameter *merge-numbers* t)



;;;---------------------------------
;;; harness for going through files
;;;---------------------------------

(defun harness (full-filename)
  (time
   (with-open-file (stream full-filename
		    :direction :input
		    :if-does-not-exist :error)
     (with-readtable-bound *my-readtable*
       (clear-treebank-tables)
       (let ((eof? nil)
	     (sexp nil)
	     ;(count 0)
             )
	 (loop
           while (not eof?)
           do
           (setq sexp (read stream nil :eof))
           (if (eq sexp :eof) (setq eof? t))
           ;(format t " ~a" (incf count))	     
           (eval sexp)))))))

(defvar *output-stream* nil
  "Way too many call between I and O, so the output stream is
 stashed in this global.")
(defun harness-output (filename-in filename-out)
  (with-open-file (stream filename-out
			  :direction :output
			  :if-does-not-exist :create
			  :if-exists :overwrite)
    (setq *output-stream* stream) ;; pooh! need sparser to use
    (harness filename-in)         ;; full set of utilities
    (setq *output-stream* nil)))
  


(defun create-top-level-call (tag)
  (let ((form `(defmacro ,tag (&rest constituents)
		 ;;(funcall #constituent-reader constituents ',tag)
		 (constituent-reader constituents ',tag))))
    (eval form)))

(mapcar #'create-top-level-call
  '(S
    SINV
    SBAR
    SBARQ
    SQ
    FRAG
    UCP
    DATE
    NP
    PRN
    VP
    PP
    ADVP
    ADJP
    X
    INTJ))



;;;---------------------------
;;; reading parser or TB sexp
;;;---------------------------

(defun constituent-reader (constituents toplevel-tag)
  (dolist (c constituents)
    ;(format t "reader: c = ~a" c)
    (analyze-constituent c)))

(defparameter *what-to-do* :read-through)

(defun analyze-constituent (constituent)
  (case *what-to-do*
    (:read-through
     (constituent-walker constituent))
    (:otherwise
     (format t "Unknown value for *what-to-do*: ~a" *what-to-do*))))

(defun constituent-walker (c)
  (unless (symbolp (car c))
    (break "Constituent does not start with a symbol:~%~a" c))
  (let ((tag (car c))
	(rest (cdr c)))
    (notice-tag tag)
    (if (consp (car rest))
      (then
	(notice-nonterminal-tag tag rest)
	(when *tb-notice-immediate-constituent-patterns*
	  (notice-immediate-constituent-pattern tag rest))
	(constituent-reader rest tag))
      (let ((token (second c)))
       (unless token
	 (break "Expected a pname. c = ~a" c))
       (when (and (numberp token)
		  *merge-numbers*)
	 (setq token 'number))
       (when *tb-notice-words*
	 (notice-pos-tag tag token)
	 (notice-word token tag))))))


;;;-----------------
;;; data collection
;;;-----------------

(defun clear-treebank-tables ()
  (setq *nonterminal-tag-count* 0)
  (clrhash symbol-to-nonterminal-tag)
  (setq *constituent-patterns* 0)
  (clrhash *NT-tags-to-patterns*)
  (setq *pos-tag-count* 0)
  (clrhash symbol-to-pos-tags)
  (setq *tag-count* 0)
  (clrhash symbols-to-tags)
  (setq *word-count* 0)
  (setq *word-token-count* 0)
  (setq *sorted-icp* '())
  (setq *proper-nouns* '()
	*everything-else* '())
  (clrhash symbols-to-words)
  #+ccl(gc))


;;;--------------------------------
;;; immediate constituent patterns
;;;--------------------------------

;;(clear-pattern-counts)
;;  Clearing the index table frees the objects for gc so we don't
;;  have to include this operatin in clear-treebank-tables
;;  /// In other modes these objects will be permanent and the
;;      table read in from data

(defvar *constituent-patterns* 0) ;; count of unique instances

(defparameter *NT-tags-to-patterns* (make-hash-table :test #'equal))

(defun notice-immediate-constituent-pattern (tag constituents)
  (let ((constituent-tags (toplevel-tags constituents))
	(tag-table (gethash tag *NT-tags-to-patterns*)))
    (if tag-table
      (let ((icp (gethash constituent-tags tag-table)))
	(if icp
	  (incf (icp-freq icp))
	  (else
	    ;;(format t "~&~a added ~a" tag constituent-tags)
	    (setf (gethash constituent-tags tag-table)
		  (define-constituent-pattern tag constituent-tags)))))
      (let ((tag-table (make-hash-table :test #'equal)))
	(setf (gethash constituent-tags tag-table) 
	      (define-constituent-pattern tag constituent-tags))
	;;(format t "~&-- ~a added ~a" tag constituent-tags)
	(setf (gethash tag *NT-tags-to-patterns*) tag-table)))
    constituent-tags))


(defvar *sorted-icp* '())

(defun order-icp-by-frequency ()
  (let ((icps '()))
    (maphash #'(lambda (tag table)
		 (declare (ignore tag))
		 (maphash #'(lambda (constituents icp-object)
			      (declare (ignore constituents))
			      (push icp-object icps))
			  table))
	     *NT-tags-to-patterns*)
    (length (setq *sorted-icp*
	      (sort icps #'> :key #'icp-freq)))))


(defun incident-count ()
  (let ((count 0))
    (maphash #'(lambda (tag table)
		 (declare (ignore tag))
		 (maphash #'(lambda (constituents icp)
			      (declare (ignore constituents))
			      (setq count (+ count
					     (icp-freq icp))))
			  table))
	     *NT-tags-to-patterns*)

    count))


(defun icp-by-percentage (percent)
  (let* ((total (incident-count))
	 (target (round (* total percent)))
	 (accumulated 0)
	 (icp-count 0))
    (loop
      until (>= accumulated target)
	for icp in *sorted-icp*
	do
	  (incf icp-count)
	  (setq accumulated
	    (+ accumulated
	       (icp-freq icp))))
    icp-count))
  



(defun write-icp (full-filename)
  (order-icp-by-frequency)
  (with-open-file (s full-filename
		   :direction :output
		   :if-exists :supersede
		   :if-does-not-exist :create)
    (let ((count 0))
      (dolist (icp *sorted-icp*)
	(format s "~%~a/~a  ~a"
		(incf count)
		(icp-freq icp)
		icp)))))


(defun clear-pattern-counts ()
  (maphash #'(lambda (non-terminal pattern-table)
	       (declare (ignore non-terminal))
	       (maphash #'(lambda (constituent-list icp)
			    (declare (ignore constituent-list))
			    (setf (icp-freq icp) 0))
			pattern-table))
	   *NT-tags-to-patterns*))


(defun get-icp (nt constituents)
  (let ((icp-table (gethash nt *NT-tags-to-patterns*)))
    (when icp-table
      (gethash constituents icp-table))))


(defmacro def-constituent-pattern (tag immediate-constituents)
  `(define-constituent-pattern ',tag ',immediate-constituents))


(defun define-constituent-pattern (tag immediate-constituents)
  (let ((icp (make-immediate-constituent-pattern
	      :tag tag 
	      :constituents immediate-constituents
	      :freq 1))) ;; gets stored in the *NT-tags-to-patterns*
    ;; table, which is an index by non-terminal
    (incf *constituent-patterns*)
    icp))



(defun sort-cp (tag)
  (unless (gethash tag *NT-tags-to-patterns*)
    (break "~a is not a know non-terminal with constituents" tag))
  (let ((icp-list '()))
    (maphash #'(lambda (key icp) 
		 (declare (ignore key))
		 (push icp icp-list))
	     (gethash tag *NT-tags-to-patterns*))
    (sort icp-list #'> :key #'icp-freq)))

;;/// wip through the list and fill the 'count' field of the icp
;; according to where the icp falls

(defun write-icp (tag full-filename)
  (let ((sorted (sort-cp tag)))
    (with-open-file (stream full-filename
		     :direction :output
		     :if-exists :overwrite
		     :if-does-not-exist :create)
      (dolist (icp sorted)
	(format stream "~&~a  ~a" (icp-freq icp) icp)))))




;;;----------
;;; POS tags
;;;----------

(defun toplevel-tags (constituents)
   (let ((list '()))
     (dolist (c constituents)
       (push (get-tag c) list))
     (nreverse list)))

(defun get-tag (sexp)
  (unless (symbolp (car sexp))
    (break "Threading bug: sexp doesn't start with a symbol:~
          ~%~a" sexp))
  (car sexp))

(defun ic-patterns-for (tag)
  (let ((table (gethash tag *NT-tags-to-patterns*)))
    (if (null table)
      (format t "~a has no entries in the immediate-constituent table." tag)
      (let ((patterns '()))
	(maphash #'(lambda (key value) (declare (ignore value))
		     (push key patterns))
		 table)
	patterns))))



(defvar *nonterminal-tag-count* 0)

(defparameter symbol-to-nonterminal-tag (make-hash-table))

(defun notice-nonterminal-tag (tag immediate-constituents)
  (unless (gethash tag symbol-to-nonterminal-tag)
    (setf (gethash tag symbol-to-nonterminal-tag) immediate-constituents)
    (incf *nonterminal-tag-count*)))

(defun non-terminal-tags ()
  (let ((list '()))
    (maphash #'(lambda (key value)
		 (declare (ignore value))
		 (push key list)) 
	     symbol-to-nonterminal-tag)
    list))

(defun read-terminal-tags-from-file (full-filename)
  (with-open-file (stream full-filename
		    :direction :input
		    :if-does-not-exist :error)
    (let ((eof? nil))
      (break "stub"))))

(defparameter *pos-tags* 
  '(CLOSE-QUOTE COLON-TAG COMMA
    DT CD EX FW IN JJ JJR JJS LS
    MD NN NNP NNPS NNS POS
    OPEN-QUOTE-TAG PDT PERIOD 
    PRP PRP$ RB RBR RBS RP
    SHARPSIGN-TAG SYM TO UH
    VB VBD VBG VBN VBP VBZ
    WDT WP WP$ WRB))


(defvar *pos-tag-count* 0)

(defparameter symbol-to-pos-tags (make-hash-table))

(defun notice-pos-tag (tag-symbol word-symbol)
  "Collects all instances of a given POS tag on a table indexed
   by the tag symbol. Doesn't do any lumping of tags, 'words' are
   still just lowercase symbols."
  (let ((entry (gethash tag-symbol symbol-to-pos-tags)))
    (cond 
      (entry (unless (memq word-symbol entry)
	       (rplacd entry (cons word-symbol (cdr entry)))))
      (t 
       (setf (gethash tag-symbol symbol-to-pos-tags) `(,word-symbol))
       (incf *pos-tag-count*)))))


(defun pos-tags ()
  (let ((list '()))
    (maphash #'(lambda (key value)
		 (declare (ignore value))
		 (push key list))
	     symbol-to-pos-tags)
    list))


(defvar *tag-count* 0)

(defparameter symbols-to-tags (make-hash-table ))

(defun notice-tag (symbol)
  (unless (gethash symbol symbols-to-tags)
    (setf (gethash symbol symbols-to-tags) symbol)
    (incf *tag-count*)))



;;;-------------------------------------------------
;;; words -- represented in TB as lowercase symbols
;;;-------------------------------------------------

(defvar *word-count* 0) ;; unique pnames

(defvar *word-token-count* 0)

(defparameter symbols-to-words (make-hash-table))

(defun notice-word (raw-symbol tag)
  "Called with every word, so this is where we increment the token
 count. We create or update an entry in the symbols-to-words table
 for each unique spelling form. The entry is an alist by POS tag
 that records the number of times the form has been seen with that
 particular tag."
  (incf *word-token-count*)
  (let* ((symbol (canonicalize-treebank-symbol raw-symbol))
	 (entry (gethash symbol symbols-to-words)))
    (if entry
      (let ((tag-entry (assoc tag entry :test #'eq)))
	(if tag-entry
	  (rplacd tag-entry (1+ (cdr tag-entry)))
	  (setf (gethash symbol symbols-to-words) 
	    (cons `(,tag . 1) entry))))
      (else
       (setf (gethash symbol symbols-to-words) 
	     `( (,tag . 1) ))
       (incf *word-count*)))
    (when *output-stream*
      (write-tb-word-to-stream raw-symbol tag))))

(defun pos-info (w)
  (gethash w symbols-to-words))


(defun canonicalize-treebank-symbol (symbol)
  ;; Nominally, the treebank just contains lowercase words. But in point of
  ;; fact there a few Capitalized versions of a word (e.g. one instance of 
  ;; "Differences" against 67 instances of "differences") and even the
  ;; occasional all-caps. This smashes everything to all lowercase.
  (let ((pname (symbol-name symbol)))
    (intern (string-downcase pname) (find-package :sparser))))

(defun normalize-tb-word (word count &optional note-pos?)
  ;; Copied from normalized-count method in frequency.lisp
  ;; Just simple division with no smoothing or reduction of scale
  (let ((ratio (/ count *word-token-count*)))
    (values
     (format nil "~,8F" ratio)
     ratio)))

(defun word-table-to-list (&optional (table symbols-to-words))
  (let ( list )
    (maphash #'(lambda (k v) (push k list)) table)
    list))

;;--- sorting routines

(defun sort-word-pos-by-frequency (alist)
  ;; highest to lowest
  (sort alist #'> :key #'cdr))

(defun sort-words-by-pos-frequency ()
  (maphash
   #'(lambda (key value)
       (let ((sorted (sort-word-pos-by-frequency value)))
	 (setf (gethash key symbols-to-words) sorted)))
   symbols-to-words))

(defun word-total-token-count (w)
  (let ((total 0))
    (dolist (pair (pos-info w))
      (setq total (+ (cdr pair) total)))
    total))

(defun sort-words-alphabetically (list-of-symbols)
  (sort (copy-list list-of-symbols) #'string-lessp :key #'symbol-name))

(defun sort-words-by-token-count (&optional (table symbols-to-words))
  (let* ((words (word-table-to-list table))
	 (entries (mapcar #'(lambda (w) 
			      (cons (define-word/expr (symbol-name w))
				    (word-total-token-count w)))
			  words)))
    ;; use routine from the standard frequency code
    (sort-frequency-list entries)))



;;--- Studying the "frequency mass" -- how many of which words
;;      does it take to account for a certain percentage of 
;;      the corpus


#|
sparser> (nth 34643 sorted-by-count)
(#<word "the"> . 95954)
sparser> (nth 34644 sorted-by-count)
(#<word comma> . 97446)
|#

(defvar *distribution-by-tenths* nil)
;; (length (setq sorted-by-count (nreverse (sort-words-by-token-count))))
;;
(defun tb-count-distribution-on-corpus (sorted-word-count-pairs)
  (let* ((total-length *word-token-count*)
	 (tenth-count (round (/ total-length 10)))
	 (entries `((0 . nil)))
	 (count 0)
	 (words-in-increment nil)
	 (accumulated-count 0)
	 (threshold tenth-count))
    (do* ((pair (car sorted-word-count-pairs) (car rest))
	  (rest (cdr sorted-word-count-pairs) (cdr rest))
	  (word (car pair) (car pair))
	  (increment (cdr pair) (cdr pair)))
	 ((null pair))
      (push word words-in-increment)
      (incf accumulated-count increment)
      (when (<= threshold accumulated-count)
	(incf count)
	(push `(,count . ,words-in-increment)
	      entries)
;	(format t "~&tenth #~a, ~a words at count ~a" 
;		count (length words-in-increment) threshold)
	(setq words-in-increment nil
	      threshold (+ tenth-count threshold))))
    ;; last tenth
    (push `(,(incf count) . ,words-in-increment) entries)
    (setq *distribution-by-tenths* (nreverse entries))
    :done))

(defun readout-tenths-distribution ()
  (dolist (entry *distribution-by-tenths*)
    (format t "~&~a  ~a words" (car entry) (length (cdr entry)))))
	 


#|  This pattern wouldn't even get to the break 
    What's wrong with it?
      (loop for pair in sorted-word-count-pairs
	   for increment in (cdr pair)
	   for word in (car pair)
	   do (progn
		(push word words-needed)
		(incf accumulated-count increment)
		(break "~a ~a" word increment)
		(when (<= tenth-count accumulated-count)
		  (return))))
  |#
	   



;;--- distribution pulling out the proper nouns

(defvar *proper-nouns* '())

(defvar *everything-else* '())

(defun proper-vs-common (&optional (word-table symbols-to-words))
  (let ((other '()) (always-proper '()))
    (maphash 
     #'(lambda (word pos-pairs)
	 (let ((other? nil))
	   (dolist (pair pos-pairs)
	     ;;(when (not (proper-noun? pos-pairs) - better factoring?
	     (when (not (or (eq (car pair) 'NNP)
			    (eq (car pair) 'NNPS)))
	       (setq other? (car pair))))
	   (if other?
	       (push word other)
	     (push word always-proper))))
     word-table)
    (setq *proper-nouns* always-proper
	  *everything-else* other)
    (values (length always-proper)
	    (length other))))


;;--- distribution of words by the POS entries they have

(defun study-word-pos ()
  (let ((singles '())(doubles '())(more '()))
    (maphash
     #'(lambda (key value)
	 (cond
	  ((= (length value) 1)
	   (push key singles))
	  ((= (length value) 2)
	   (push key doubles))
	  (t
	   (push key more))))
     symbols-to-words)
    (format t "~a singles, ~a doubles, ~a rest" 
	    (length singles) (length doubles) (length more))))


;;--- orphan?
(defvar *word-list* '())




;;;--------------------------------------
;;; Writing out the data in various ways
;;;--------------------------------------

(defun write-words (list-of-words full-filename) ;; sort the list before calling
  ;; This is a variant on write-tb-word-frequency-entry that would
  ;; feed a different reader
  (with-open-file (s full-filename
		   :direction :output
		   :if-exists :supersede
		   :if-does-not-exist :create)
    (let ((count 0))
      (dolist (word list-of-words)
	(format s "~&(defword ~a/~a  \"~a\"  ~a)" 
		(incf count)
		( ) ;;//// frequency of word
		(string-downcase (symbol-name word))
		(pos-info word))))))



(defun write-words-by-pos (full-filename)
  ;; Write out all the words organized by POS
  (with-open-file (s full-filename
		   :direction :output
		   :if-exists :supersede
		   :if-does-not-exist :create)
    (dolist (tag-symbol *pos-tags*)
      (let ((entry (gethash tag-symbol symbol-to-pos-tags)))
	(when entry
	  (write-pos-entry tag-symbol entry s))))))

(defun write-pos-entry (tag-symbol entry stream) (break "stub"))


;;--- Writing the words out in def-word format for merging
;;       frequency information.

(defun write-words-with-frequency-data (full-filename)
  (let* ((words (word-table-to-list)) ;; parameter goes into here
	 (sorted (sort-words-alphabetically words)))
    (with-open-file (stream full-filename
		       :direction :output
		       :if-exists :supersede
		       :if-does-not-exist :create)
      (loop for word in sorted
	   do (write-tb-word-frequency-entry word stream)))))

(defun write-tb-word-frequency-entry (symbol stream)
  ;; Mimics the form in frequency.lisp over this one "document"
  (let* ((count (word-total-token-count symbol)) 
	 ;;//// ignoring different POS
	 (normalized (normalize-tb-word symbol count)))
    (format stream "(def-word ~s  (treebank ~a ~a))~%" 
	    (symbol-name symbol) normalized count)))


;;--- Saving the treebank text to a separate file as plain text
;; /// Add variant to write out in NLTK format with the pos data
(write-tb-word-to-stream raw-symbol tag)


