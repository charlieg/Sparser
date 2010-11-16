;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; extensions copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$
;;;
;;;     File:  "ad-hoc-annotation"
;;;   Module:  "grammar/model/sl/poirot/"
;;;  version:  December 2009

;; initiated 10/23/09. Continued initial development through 12/1

(in-package :sparser)

;;;----------------------------------------
;;; realization data for composite objects
;;;----------------------------------------
;; c.f. the lexical rdata in model/sl/poirot/special-forms.lisp
;; This edge-decoding can't happen until the whole system is loaded,
;; so it's safe to refer to stuff in that late-loading code.
;; Though we should look into moving it around for some uniformity
;; when possible

(when (find-package :core-omar)

  (co:defobject realization-data ()
    ((backpointer))) ;; to the Poirot object

  (co:defobject phrasal-rdata (realization-data)
    ((rpath) ;; just one for now. 
     ;; Try to move it over to lattice-points and some such 
     ;; for the ltml ontology / Omar the very moment that
     ;; the basics settle down. 
     ))

  (defmethod assign-rdata ((i ltml::LTML-class) (data rpath))
    (let ((concept (ltml:getOwlClass (ltml::concept-name i)))) ;; does the error checking
      (assign-rdata concept data)))

  (defmethod assign-rdata ((c ltml::OwlClass) (data rpath))
    (let ((pd (make-instance 'phrasal-rdata 
			      :backpointer c
			      :rpath data)))
      (setf (gethash c *poirot-to-rdata*) pd)))

)

;;;----------------
;;; decoding edges
;;;----------------

(defun rpath-from-edge (e)
  (let* ((referent (edge-referent e))
	 (category (determine-lattice-point-equivalent referent))
	 (rpath (make-instance 'rpath :category category))
	 (nodes (rnode-path-from-edge e)))
    (setf (ordered-list-of-rnodes rpath) (nreverse nodes))
    (assign-rdata referent rpath)
    rpath))

(defun rnode-path-from-edge (e &optional parent-referent)
  (let* ((referent (edge-referent e))
	 (type-name (type-of referent)) ;; n.b. symbol could be in ltml package
	 (rule (edge-rule e)))
    ;; This is probably the fixed-point for the recursion. If this were done with 
    ;; the annotation machinery it would be bottom-up. Working with an edge
    ;; we have to go top-down.
    (cond 
      ((form-rule? rule) 
       (rnode-from-form-rule rule e referent))
      ((unary-rule? rule)
       (rnode-from-unary-rule rule e (or parent-referent
					 referent)))
      ((binary-rule? rule)
       (push-debug `(,e)) (break "stub: binary rule: ~a" rule))
      (t (push-debug `(,e))
	 (break "stub")))))

#|  For each rule we want to record
 (a) the type of the argument being bound (e.g. 'number', ts@UnitOfTime)
 (b) the rule (in a form that we can invert to use in the generator)
 (c) the variable being bound (property set)
|#

(defun rnode-from-unary-rule (rule edge parent-referent)
  (let ((object (edge-referent edge))
	(schema (cfr-schema rule)))
    (unless schema
      (push-debug `(,object ,rule ,edge ,parent-referent))
      (error "Hoped for a schema on this unary rule but there ~
              isn't one.~%~a" rule))
    (let* ((relation (schr-relation schema)) ;; e.g. :common-noun
	   (descriptors (schr-descriptors schema))
	   (head? (memq :head-edge descriptors)))
      (unless head?
	(push-debug `(,schema ,object ,rule ,edge ,parent-referent))
	(break "New case of schema description: ~a" descriptors))
      (push-debug `(,object ,parent-referent))
      (let* ((rule-descriptor `(:head ,relation ,schema))
	     (binding (determine-binding-object object parent-referent))
	     (rnode (make-instance 'rnode 
				  :lattice-point object
				  :rule-used rule-descriptor
				  :variable-bound binding)))
	`(,rnode)))))    

(defun rnode-from-form-rule (rule edge parent-referent)
  (let* ((completion-field (cfr-completion rule))
	 (edge-keyword (car completion-field)))
    (push-debug `(,edge-keyword ,completion-field ,rule ,edge))
    (unless (keywordp edge-keyword) (break "wrong assumption"))
    (multiple-value-bind (edge-added ;; by the form-rule
			  edge-to-do) ;; the one this is building on
	    (ecase edge-keyword
	      (:right-edge ;; so the form-rule adds the left-edge
	       (values (edge-left-daughter edge) (edge-right-daughter edge)))
	      (:left-edge
	       (values (edge-right-daughter edge) (edge-left-daughter edge))))
      (let* ((object (edge-referent edge-added))
	     (lp (determine-lattice-point-equivalent object))
	     ;(rule-used (edge-rule edge-added))
	     (binding (determine-binding-object object parent-referent)))
	(let ((rnode (make-instance 'rnode 
				    :lattice-point lp
				    :rule-used rule
				    :variable-bound binding))
	      (rest-of-path (rnode-path-from-edge edge-to-do parent-referent)))
	  (cons rnode rest-of-path))))))


;;--- hacks for identifying the property/variable

(defgeneric determine-binding-object (object parent)
  (:documentation "The question is what field does the object fill in
 the parent. Since we are freely mixing Krisp and SFL, the returned
 value could be a variable or a property. We use this in the generation
 direction as the basis of decomposing the parent into its elements
 and assigning their realizations."))

(defmethod determine-binding-object ((object individual)
				     (parent ltml:ts@Duration))
  ;; judicious hack to get on with things. If we shadowed the Krisp
  ;; individuals with their SFL equivalents then it would be simpler.
  ;; but have to cross the representation line somewhere.
  (let ((category (car (indiv-type object))))
    ;; The right thing to do is to walk through the restrictions
    ;; on the parent and look for a match on the restricting type.
    ;; In this particular case we get a restricion of top@Quantity,
    ;; which -ought- to subsume Number, but doesn't happen to.
    (case (cat-symbol category)
      (category::number (ltml:lookup 'ltml::top@quantity))
      (otherwise
       (push-debug `(,category ,object ,parent))
       (error "Unexpected category: ~a" category)))))

(defmethod determine-binding-object ((object ltml:ts@UnitOfTime)
				     (parent ltml:ts@Duration))
  ;; even grosser hack, but I'm in a hurry to get to the other side right now
  (ltml:lookup 'ltml:top@measuredIn))

(defmethod determine-binding-object ((object individual)
				     (parent ltml:ts@Date))
  ;; similar hack
  (ltml:lookup 'ltml:ts@referenceDay))

(defmethod determine-binding-object ((object ltml:ts@MonthOfTheYear)
				     (parent ltml:ts@Date))
  ;; and another hack
  (ltml:lookup 'ltml:ts@month))


(defgeneric extract-value-of-variable (object variable)
  (:documentation "The variable can be used to access a particular value
 from the object, presumably in an application-specific way."))

(defmethod extract-value-of-variable ((object ltml:LTML-class) 
				       (variable ltml:OwlProperty))
  (ltml:get-property-value object variable))




;;--- connection to lp (or stand-in for the moment)

(defmethod determine-lattice-point-equivalent ((object individual))
  (car (indiv-type object))) ;; a referential-category

(defmethod determine-lattice-point-equivalent ((object ltml::LTML-class))
  (ltml:getOwlClass (ltml::concept-name object)))
