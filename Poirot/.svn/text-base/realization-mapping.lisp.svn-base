;;; -*- Mode: Lisp; Syntax: COMMON-LISP; Package:MUMBLE; Base:10; -*-
;;; $Id$
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved

;;; /nlp/Poirot/realization-mapping.lisp

;; initiated 9/14/09. First code 9/18. Elaborated through 12/27/09

(in-package :mumble)

(defmethod has-realization? ((i ltml::LTML-class))
  (let ((class (ltml:getOwlClass (ltml::concept-name i))))
    (or (sparser::get-rdata class)
	(sparser::get-rdata i))))

(defmethod realization-for ((i ltml::LTML-class))
  "The realization of instances tend to be maximal projections: classes, nps."
  (let* ((class (ltml:getOwlClass (ltml::concept-name i)))
	 (rdata (or (sparser::get-rdata class)
		    (sparser::get-rdata i))))
    (unless rdata
      (error "No realization data on record for ~a" i))
    (typecase rdata
      (sparser::phrasal-rdata
       (convert-to-derivation-tree rdata i))
      (sparser::lexical-rdata
       (sparser::lexicalized-phrase rdata))
      (otherwise
       (push-debug `(,rdata ,i ,class))
       (error "Unknown type of rdata: ~a~%~a" (type-of rdata) rdata)))))

(defmethod realization-for ((c ltml:OwlClass))
  "Classes tend to have realizations as heads: lexicalized nouns or verbs,
   adjective phrases, etc."
  (look-for-lexicalized-phrase c)) ;; too simplistic probably

(defmethod realization-for ((n integer)) ;;/// What's the most-general number class
  ;; see general-purpose code for this from 2000 in /grammar/numbers.lisp 
  ;; that has to get the kinks worked out of it. For now just punt.
  (define-word/expr (format nil "~a" n) `(number)))



(defun look-for-lexicalized-phrase (item)
  (let ((rdata (sparser::get-rdata item)))
    (unless rdata
      (error "No realization data on record for ~a" item))
    (sparser::lexicalized-phrase rdata)))


#| No no. We want to look at the specific facts about the class that
     We've learned from looking at how it's been parsed. 
(defmethod realization-for ((c ltml:top@Object))
  (look-for-lexicalized-phrase c))
(defmethod realization-for ((c ltml:top@Quality))
  (look-for-lexicalized-phrase c))
(defmethod realization-for ((c ltml:top@Relation))
  (look-for-lexicalized-phrase c))
(defmethod realization-for ((c ltml:top@Relationship))
  (look-for-lexicalized-phrase c))
(defmethod realization-for ((c ltml:top@Action))
  (look-for-lexicalized-phrase c))
(defmethod realization-for ((c ltml:top@Event))
  (look-for-lexicalized-phrase c))
(defmethod realization-for ((c ltml:top@Situation))
  (look-for-lexicalized-phrase c))
|#

;;---



;;------ Sparser methods ------------

(in-package :sparser)

(defmethod get-rdata ((o ltml:OwlClass))
  (gethash o *poirot-to-rdata*))

(defmethod get-rdata ((i ltml::LTML-class))
  (gethash i *poirot-to-rdata*))



#|  I presume these were waiting for some specialization. What were your thoughts?
(defmethod get-rdata ((o ltml:top@Object))
  (gethash o *poirot-to-rdata*))
(defmethod get-rdata ((o ltml:top@Quality))
  (gethash o *poirot-to-rdata*))
(defmethod get-rdata ((o ltml:top@Relation))
  (gethash o *poirot-to-rdata*))
(defmethod get-rdata ((o ltml:top@Relationship))
  (gethash o *poirot-to-rdata*))
(defmethod get-rdata ((o ltml:top@Action))
  (gethash o *poirot-to-rdata*))
(defmethod get-rdata ((o ltml:top@Event))
  (gethash o *poirot-to-rdata*))
(defmethod get-rdata ((o ltml:top@Situation))
  (gethash o *poirot-to-rdata*))
|#
