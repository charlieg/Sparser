;;; -*- Mode: Lisp; Syntax: COMMON-LISP; Package:MUMBLE; Base:10; -*-
;;; $Id$
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved

;;; /nlp/Poirot/resources.lisp

;; initiated 9/14/09
;; elaborated through 11/02/09

(in-package :mumble)

;;;---------------------
;;; lexicalized phrases
;;;---------------------

(defun make-one-word-lexicalized-phrase (keyword string)
  (let ((word (word-given-mapping-key keyword string)))
    (unless (eq keyword :preposition)
      (let* ((phrase (phrase-given-mapping-key keyword))
	     (parameters (parameters-to-phrase phrase))
	     (lp (make-instance 'saturated-lexicalized-phrase
				 :resource phrase)))
	(unless (= 1 (length parameters))
	  (error "Assumptions violated. The phrase ~a~
            ~%  has more than one parameter: ~a" phrase parameters))
	(let ((pvp (make-instance 'parameter-value-pair
				  :phrase-parameter (car parameters)
				  :value word)))
	  (setf (bound lp) `(,pvp))
	  lp)))))


(defun word-given-mapping-key (keyword string)
  (let* ((label-name
	  (case keyword
	    (:kind 'noun)
	    (:name 'noun)
	    (:indexical ;;/// need pronoun / adverbial distinction
	     ;; proper-noun (???) for, e.g., "Wednesday"
	     'adverb) ;; ??? for "today"
	    (:preposition 'preposition)
	    (otherwise
	     (error "unanticipated keyword: ~a" keyword))))
	 (label (mumble-value label-name 'word-label))
	 (exp `(define-word ,string (,label-name)))) ;;/// irregulars??
      (eval exp)))

(defun phrase-given-mapping-key (keyword)
  (let ((name (case keyword
		(:kind 'common-noun) ;; bare-np-head ?
		(:name 'proper-name)
		(:preposition nil)
		(:indexical 'Abstract-np) ;; singleton-np, possessive-np
		(otherwise
		 (error "unanticipated keyword: ~a" keyword)))))
    (phrase-named name)))


