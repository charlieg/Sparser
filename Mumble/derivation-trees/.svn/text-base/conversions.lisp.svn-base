;;; -*- Mode: Lisp; Syntax: Common-lisp; -*-
;;; $Id$
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved

;; /Mumble/derivation-trees/conversions.lisp

;; Initated 10/6/09. First real code 10/23. Real code that runs 11/9 (sigh)
;; Modified through 11/27

(in-package :mumble)

(defgeneric convert-to-derivation-tree (class object)
  (:documentation "Takes an instance from the Sparser domain and converts it
 into an object in Mumble's domain suitable for passing to the 'say' method
 by using realization knowledge associated with the class."))

(defmethod convert-to-derivation-tree (dummy-class (e sparser::edge))
  (declare (ignore dummy-class))
  (convert-to-derivation-tree (sparser::rpath-from-edge e)
			      (sparser::edge-referent e)))

(defmethod convert-to-derivation-tree ((prd sparser::phrasal-rdata)
				       (i ltml::LTML-class))
  (let ((rpath (sparser::rpath prd)))
    (convert-to-derivation-tree rpath i)))

(defmethod convert-to-derivation-tree ((rpath sparser::rpath) (i ltml::LTML-class))
  (let ((ordered-rnodes (sparser::ordered-list-of-rnodes rpath))
	(dtn (make-instance 'derivation-tree-node
	        :referent i)))
    (setf (root *the-derivation-tree*) dtn)
    (setf (participants *the-derivation-tree*) `(,i))

    (dolist (rnode ordered-rnodes)
      ;; a path will be ordered from the head out to its complements and adjuncts
      ;; so if we trust that, we can just put things where the conventionally go
      ;; and not have to examine the path.
      (read-out-rnode rnode i dtn))
    dtn))


(defun read-out-rnode (rnode i dtn)
  (push-debug `(,rnode ,i ,dtn))
  (let* ((rule-descriptor (sparser::rule-used rnode))
	 (variable (sparser::variable-bound rnode))
	 (extracted-individual (sparser::extract-value-of-variable i variable)))
    (push-debug `(,rule-descriptor))
    (multiple-value-bind (resource argument/s features-source)
	(sparser::rule-descriptor-to-nlg-resource rule-descriptor)
      (push-debug `(,resource ,argument/s ,features-source))      
      (push-debug `(,i ,variable))
;      (break "resouce = ~a" resource) ;; look at whether we can do it before continuing
      ;; at this point it will go bad on the 2d rnode for that adjunction

      (typecase resource
	(phrase 
	 (unless (null (resource dtn))
	  (error "The resource derived from ~a~%is a phrase but we've already ~
                  fill that field in the dtn." rnode))
	 (setf (resource dtn) resource))
	(sparser::bidir-mapping ;; may be an easy way to cover lots of cases
	 (let ((mumble-resource ;; feels like there's an opportunity for recursion
		(sparser::mumble-resource resource)))
	   (typecase mumble-resource
	     (splicing-attachment-point
	      (make-adjunction-node mumble-resource extracted-individual dtn))
	     (otherwise
	      (error "New/unexpectd mumble-side resource in bidir-mapping")))))
	(otherwise
	 (error "Unexpected type of resource for ~a: ~a~%  ~a"
		rnode (type-of resource) resource)))

      (when argument/s ;; single-argument case. 
	(unless variable (break "There are arguments but no corresponding variable"))
	(unless (= 1 (length argument/s))
	  (break "Stub not ready to do multi-parameter resources. Needs design"))
	(make-complement-node (car argument/s) extracted-individual dtn)))
      dtn))



;;;------------------------
;;; mixed-package printers
;;;------------------------

(defun value-short-form (o)
  (typecase o
    (ltml:LTML-class (ltml:tag-to-symbol o))
    (fixnum o)
    (otherwise
     (push-debug o)
     (format t "~&unknown type for value-short-form: ~a~%  ~a"
	     (type-of o) o)
     "<printer bug>")))


