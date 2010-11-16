;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; $Id$
;;;
;;;     File: "comlex"
;;;   Module: "grammar;rules:words:one-offs:"
;;;  Version:  August 2010

;; initiated 8/16/10

(in-package :sparser)

;;;--------
;;; Comlex
;;;--------

#| Given the full Comlex file from the LDC, read it in and stash
 its contents into tables by the POS type that Comlex assigned.
 See read-comlex-hash-words below.
|#

(defvar *comlex-words* (make-hash-table))
(defvar *comlex-nouns* (make-hash-table))
(defvar *comlex-verbs* (make-hash-table))
(defvar *comlex-adjectives* (make-hash-table))
(defvar *comlex-adverbs* (make-hash-table))
(defvar *comlex-advparts* (make-hash-table))
(defvar *comlex-prepositions* (make-hash-table))
(defvar *comlex-cardinals* (make-hash-table))
(defvar *comlex-ordinals* (make-hash-table))
(defvar *comlex-titles* (make-hash-table))
(defvar *comlex-scopes* (make-hash-table))
(defvar *comlex-pronouns* (make-hash-table))
(defvar *comlex-coordinate-conjunctions* (make-hash-table))
(defvar *comlex-subodinate-conjunctions* (make-hash-table))
(defvar *comlex-quantifiers* (make-hash-table))
(defvar *comlex-determiners* (make-hash-table))
(defvar *comlex-auxilaries* (make-hash-table))
(defvar *comlex-non-words* (make-hash-table))
#|
all-words 35060
nouns 21932
verbs 5665
adjectives 8193
adverbs 3120
advparts 21
prepositions 185
cardinals 105
ordinals 99
titles 19
scopes 3
pronouns 45
coordinate-conjunctions 5
subodinate-conjunctions 49
quantifiers 14
determiners 22
auxilaries 28
non-words 26
|#
(defparameter *comlex-hash-tables*
  `((,*comlex-words* all-words)
    (,*comlex-nouns* nouns)
    (,*comlex-verbs* verbs) 
    (,*comlex-adjectives* adjectives)
    (,*comlex-adverbs* adverbs)
    (,*comlex-advparts* advparts)
    (,*comlex-prepositions* prepositions)
    (,*comlex-cardinals* cardinals)
    (,*comlex-ordinals* ordinals)
    (,*comlex-titles* titles)
    (,*comlex-scopes* scopes)
    (,*comlex-pronouns* pronouns)
    (,*comlex-coordinate-conjunctions* coordinate-conjunctions)
    (,*comlex-subodinate-conjunctions* subodinate-conjunctions)
    (,*comlex-quantifiers* quantifiers)
    (,*comlex-determiners* determiners)
    (,*comlex-auxilaries* auxilaries)
    (,*comlex-non-words* non-words)))


(defun comlex-noun-verb-ambiguous-words () ;; 2,879
  (loop for key being the hash-key in *comlex-verbs*
     when (gethash key *comlex-nouns*)
       collect key))

(defun comlex-noun-adjective-ambiguous-words () ;; 1,008
  (loop for key being the hash-key in *comlex-adjectives*
     when (gethash key *comlex-nouns*)
       collect key))

(defun comlex-verb-adjective-ambiguous-words () ;; 275
  (loop for key being the hash-key in *comlex-adjectives*
     when (gethash key *comlex-verbs*)
       collect key))



(defun get-orth (entry) ;; adapted from comlex-util.lisp
  (getf (cdr entry) :ORTH))

;(time (read-comlex-hash-words "/Users/ddm/Library/ ddm/comlex_synt_3.1/COMLEX-SYNTAX-3.1"))
(defun read-comlex-hash-words (full-filename)
  (with-open-file (stream full-filename
			  :direction :input
			  :if-does-not-exist :error)
    (do ((entry (read stream nil :eof)
		(read stream nil :eof)))
	((eq entry :eof))
      (let* ((pos (car entry))
	     (string (get-orth entry))
	     (symbol (intern string (find-package :sparser))))
	(setf (gethash symbol *comlex-words*) entry)
	(case pos
	  (NOUN (setf (gethash symbol *comlex-nouns*) entry))
	  (VERB (setf (gethash symbol *comlex-verbs*) entry))
	  (ADJECTIVE (setf (gethash symbol *comlex-adjectives*) entry))
	  (ADVERB (setf (gethash symbol *comlex-adverbs*) entry))
	  (ADVPART (setf (gethash symbol *comlex-advparts*) entry))
	  (PREP (setf (gethash symbol *comlex-prepositions*) entry))
	  (CARDINAL (setf (gethash symbol *comlex-cardinals*) entry))
	  (ORDINAL (setf (gethash symbol *comlex-ordinals*) entry))
	  (TITLE (setf (gethash symbol *comlex-titles*) entry))
	  (SCOPE (setf (gethash symbol *comlex-scopes*) entry))
	  (PRONOUN (setf (gethash symbol *comlex-pronouns*) entry))
	  (CCONJ (setf (gethash symbol *comlex-coordinate-conjunctions*) entry))
	  (SCONJ (setf (gethash symbol *comlex-subodinate-conjunctions*) entry))
	  (QUANT (setf (gethash symbol *comlex-quantifiers*) entry))
	  (DET (setf (gethash symbol *comlex-determiners*) entry))
	  (AUX (setf (gethash symbol *comlex-auxilaries*) entry))
	  (WORD (setf (gethash symbol *comlex-non-words*) entry))
	  (otherwise
	   (push-debug `(,pos ,symbol ,entry))
	   (break "Unexpected part of speech: ~a" pos)))))
    *comlex-words*))

(defun report-comlex-list-lengths ()
  (loop for entry in *comlex-hash-tables*
        for table hash-table = (car entry)
        for name symbol = (cadr entry)
       do (format t "~&~a ~a" name (hash-table-count table))))


(defun extract-table-entries (table)
  (loop for key being the hash-key in table
       collect key))

(defun alphabetize-table-entries (table)
  (let ((symbols (extract-table-entries table)))
    (sort symbols #'alphabetize)))

;; (write-complex-table-entries *comlex-adverbs* "adverbs")
(defun write-complex-table-entries (table file-final-part)
  (let ((filename (string-append "/Users/ddm/ws/Vulcan/ws/frequencies/"
				 "comlex-" file-final-part ".txt")))
    (with-open-file (stream filename
			    :direction :output
			    :if-does-not-exist :create
			    :if-exists :overwrite)
      (format stream "~&;; Extracted from Comlex 3.1~%")
      (format stream "~&;; ~a ~a~%~%" (hash-table-count table)  file-final-part)
      (let ((word-symbols (alphabetize-table-entries table)))
	(write word-symbols :stream stream))
      :done)))


;;;-------------------
;;; Comlex word lists
;;;-------------------

#| Once the original file has been loaded and the word-lists written
 out, then we can work just from those files to have all the lemmas
 we want to have defined. Note that there's been no expansion of their
 morphological variants yet.
|#

(defvar *comlex-word-lists-loaded* nil
  "Provides a flag to gate operations that reference these lists")

(defun load-comlex ()
 (load "/Users/ddm/ws/Vulcan/ws/frequencies/comlex-function-words.lisp")
 (load "/Users/ddm/ws/Vulcan/ws/frequencies/comlex-adjectives.lisp")
 (load "/Users/ddm/ws/Vulcan/ws/frequencies/comlex-adverbs.lisp")
 (load "/Users/ddm/ws/Vulcan/ws/frequencies/comlex-nouns.lisp")
 (load "/Users/ddm/ws/Vulcan/ws/frequencies/comlex-verbs.lisp")
 (populate-comlex-adjectives)
 (populate-comlex-adverbs)
 (populate-comlex-nouns)
 (populate-comlex-verbs)
 (populate-comlex-function-words)
 (setq *comlex-word-lists-loaded* t))

(defmethod is-in-comlex? ((w word))
  (is-in-comlex? (word-pname w)))

(defmethod is-in-comlex? ((s string))
  (is-in-comlex? (intern s (find-package :sparser))))
		   
(defmethod is-in-comlex? ((s symbol))
  ;; interesting words will fit many parts of speech, 
  ;; which we could note here with a cond-every or some such.
  (or (gethash s *is-a-noun-in-comlex*)
      (gethash s *is-a-verb-in-comlex*)
      (gethash s *is-an-adjective-in-comlex*)
      (gethash s *is-an-adverb-in-comlex*)
      (gethash s *is-a-function-word-in-comlex*)))





