;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 2010 David D. McDonald  -- all rights reserved
;;; $Id:$
;;;
;;;     File:  "interface"
;;;   Module:  "/interface/mumble/"
;;;  version:  0.0 December 2010

;; initiated 11/12/10. Elaborated through ..12/9

(in-package :sparser)

;; N.b. there's a check that the mumble code is loaded (package define)
;; in the grammar loader that bring this code in. 

;;;-------------------------
;;; is there a realization?
;;;-------------------------

;(defmethod mumble::has-realization? ((i individual))
;  (

(defmethod mumble::has-realization? ((i psi))
  (let ((lp (psi-lp i)))
    (lp-realizations i)))


;;;-------------
;;; what is it?
;;;-------------

(defmethod mumble::realization-for ((i individual))
  ;; Need to get the rnodes off the psi and onto permanent aspects
  ;; of their lattice points that can be found from an individual.
  (cond
    ((indiv-rnodes i) 
     (mumble::convert-to-derivation-tree (car (indiv-rnodes i)) i))
;    ((binds-a-word? i)
;     (break "binds-a-word?"))
    (t (push-debug `(,i))
       (break "No realization technique for ~a" i))))

(defmethod mumble::realization-for ((i psi))
  (let* ((rnodes (lp-realizations (psi-lp i)))
	 ;; arbitrarily use the first one.
	 ;; Generally speaking this is a choice-point
	 (rnode (car rnodes)))
    (unless rnode
      (push-debug `(,i))
      (error "No realization node recovered for ~a" i))
    (mumble::convert-to-derivation-tree rnode i)))


;;;---------
;;; helpers
;;;---------

(defmethod binds-a-word? ((i individual))
  (or (binds i 'name)
      (binds i 'word)))

(defmethod bound-word ((i individual))
  (let* ((binding/s (binds-a-word? i))
	 ;; in principle there could be more than one
	 (binding (typecase binding/s
		    (cons (car binding/s))
		    (binding binding/s)
		    (otherwise
		     (error "New type: ~a~%~a" 
			    (type-of binding/s) binding/s)))))
    (binding-value binding)))
    

    



