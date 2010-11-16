;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved
;;; $Id$
;;;
;;;      File:  "special-forms"
;;;    Module:  "grammar/model/sl/poirot/"
;;;   version:  September 2009

;; The forms that are used in the realization statements on classes
;; and individuals in Poirot. 
;; initiated 8/31/09. Elaborated through 11/2.

(in-package :sparser)

;;;-------------------------------------------------------------------
;;; Associating realization specifications (etc.) with Poirot objects
;;;-------------------------------------------------------------------

(co:defobject lexical-rdata (realization-data)
   ((parsing-rule) ;; Sparser's
    (lexicalized-phrase))) ;; Mumble's


;; Need comparable classes for relations and their ETF, and probably
;; for bigger things if they exist.

(defvar *poirot-to-rdata* (make-hash-table) ;; What size?
  "From Classes or Individuals (etc.) in Poirot to their
 realization-data object. Defining use is in Mumble and
 the method realization-for.")

(defgeneric get-rdata (object)
  (:documentation "Returns something that can be handled by
 mumble::realize."))

(defmethod get-rdata ((qualified-symbol symbol))
  (let ((object (ltml::lookup qualified-symbol)))
    (unless object :
      (error "There is no Poirot object named ~a" qualified-symbol))
    (get-rdata object)))

;; The object-level methods like get-rdata are in
;; nlp/Poirot/realization-mapping because its classes aren't defined
;; at this point in the load.



;;;---------------------------------------
;;; driver from realization-specification 
;;;---------------------------------------

(defun vivify-object-realization-spec-pair (pair)
  (let* ((object (car pair))
	 (spec (cdr pair))
	 (keyword (first spec))
;	 (method (intern (symbol-name keyword) (find-package :sparser)))
	 (string (if (stringp (second spec)) (second spec) (third spec)))
	 (category-name (when (= 3 (length spec)) (second spec))))
    (unless (stringp string)
      (error "Word argument not a string in realization:~
            ~%      ~a" pair))
    (unless category-name
      (setq category-name (intern string (find-package :sparser))))
    (let ((*external-referents* t)) ;; see /init/everything
      (cond
	((memq keyword '(:kind :name :indexical :preposition))
	 ;; Word-level 
	 (let ((word (define-word/expr string))
	       (category (find-or-make-category category-name :referential))
	       (entry (make-instance 'lexical-rdata :backpointer object)))
	   (setf (gethash object *poirot-to-rdata*) entry)
	   (create-word-level-parsing-rule keyword word category object entry)
	   (when (find-package :mumble)
	     (let ((lp (eval `(mumble::make-one-word-lexicalized-phrase 
			       ,keyword ,string))))
	       (when lp 
		 ;; won't be one for prepositions
		 (setf (lexicalized-phrase entry) lp))))
	   entry))
	(t
	 (error "Shouldn't have gotten here"))))))

(defun create-word-level-parsing-rule (keyword word category referent entry)
  (let ((word-class 
	 (case keyword
	   (:kind :common-noun)
	   (:name :proper-noun) ;; I thought this should be proper-name like in Mumble/grammar/phrases.lisp?
	   (:indexical :standalone-word)
	   (:preposition :preposition)
	   (otherwise
	    (error "unanticipated keyword: ~a" keyword)))))
    (let ((rule
	   (head-word-rule-construction-dispatch 
	    `(,word-class . ,word) category referent)))
      (setf (parsing-rule entry) rule))))

