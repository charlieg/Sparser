;;; -*- Package: co; Mode: LISP; Syntax: Common-lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;; ASSUMING THAT ALL FORMULAE ARE IN CONJUNCTIVE NORMAL FORM !!!

;; Determine whether some complex vr R1 is less restrictive than (or equivalent to)
;; some other complex vr R2.

;; Return
;;   LESS-RESTRICTIVE if R1 is strictly less restrictive than R2
;;   EQUIVALENT if R1 and R2 are equally restrictive
;;   MORE-RESTRICTIVE is R1 is strictly more restrictive than R2
;;   NOT-COMPARABLE otherwise

(defun compare-simple-term (r1 r2 &aux concept1 concept2 comp-fn)
  ;; could be concept form, SATISFIES, set or negation
  ;; SATISFIES can only be compared with other SATISFIES; furthermore, the
  ;; predicates must be comparable (i.e., there must be a comparison function
  ;; for the ordered pair defined by the two predicates -- see DEFINE-COMPARISON-FUNCTIONS
  ;; and DEFINE-COMPARISON-FUNCTION)
  (flet ((negationp (form) (and (listp form) (member (car form) '(:not))))
	 (satisfiesp (form) (and (listp form) (member (car form) '(:satisfies SATISFIES))))
	 #+ignore
	 (conceptp (form) (or (symbolp form) (and (listp form)
						  (member (car form) '(a an)))))
	 (concept-from-form (form)
	   (concept (if (listp form) (concept-name-of-concept-form form) form))))
    (cond ((satisfiesp r1)
	   (if (and (satisfiesp r2)
		    (setq comp-fn (find-comparison-function (second r1) (second r2))))
	       (funcall comp-fn (cddr r1) (cddr r2))
	       'NOT-COMPARABLE))
	  ((satisfiesp r2) 'NOT-COMPARABLE)
	  ((negationp r1)
	   (cond ((negationp r2) (compare-simple-term (second r2) (second r1)))
		 (t 'NOT-COMPARABLE)))
	  ((negationp r2)
	   'NOT-COMPARABLE)
	  ((or (not (setq concept1 (concept-from-form r1)))
	       (not (setq concept2 (concept-from-form r2))))
	   'NOT-COMPARABLE)
	  ((eq concept1 concept2)
	   'EQUIVALENT)
	  ((subsumes-p concept1 concept2) 'LESS-RESTRICTIVE)
	  ((subsumes-p concept2 concept1) 'MORE-RESTRICTIVE)
	  (t 'NOT-COMPARABLE))))





(defun compare-or (r1 r2)
  ;; True if each disjunct of R2 is more restrictive than, or equivalent to,
  ;; some disjunct of R1.
  ;; Equivalence requires some special handling here.
  ;; Disjuncts must be concept forms or negations of concept forms. 
  (do ((equivalences nil) (more nil)
       (r2-disjuncts (copy-list (cdr r2)))
       r1-disjunct
       (r1-disjuncts (cdr r1) (cdr r1-disjuncts)))
      ((null r1-disjuncts)
       (cond ((null r2-disjuncts)
	      (if (equal (nreverse equivalences) (cdr r1)) 'EQUIVALENT 'LESS-RESTRICTIVE))
	     ((equal (nreverse more) (cdr r1))
	      'MORE-RESTRICTIVE)
	     (t
	      'NOT-COMPARABLE)))
    (if (null r2-disjuncts)
	(return 'LESS-RESTRICTIVE)
	(setq r1-disjunct (car r1-disjuncts)
	      r2-disjuncts (delete-if
			     #'(lambda (restriction)
				 (case (compare-simple-term r1-disjunct restriction)
				   (EQUIVALENT
				     (push r1-disjunct equivalences)
				     (push r1-disjunct more)
				     t)
				   (MORE-RESTRICTIVE
				     (push r1-disjunct more)
				     nil)
				   (NOT-COMPARABLE nil)
				   (LESS-RESTRICTIVE t)))
			     r2-disjuncts)))))




(defun compare-and (r1 r2)
  ;; True if each conjunct of R1 is less restrictive than, or equivalent to,
  ;; some conjunct or R2.
  ;; Equivalence requires some special handling here.
  ;; Conjuncts must be disjunctions since the forms are in conjunctive normal form.
  (do ((equivalences nil) (more nil)
       (r1-conjuncts (copy-list (cdr r1)))
       r2-conjunct
       (r2-conjuncts (cdr r2) (cdr r2-conjuncts)))
      ((null r2-conjuncts)
       (cond ((null r1-conjuncts)
	      (if (equal (nreverse equivalences) (cdr r2)) 'EQUIVALENT 'LESS-RESTRICTIVE))
	     ((equal (nreverse more) (cdr r2))
	      'MORE-RESTRICTIVE)
	     (t
	      'NOT-COMPARABLE)))
    (if (null r1-conjuncts)
	(return 'LESS-RESTRICTIVE)
	(setq r2-conjunct (car r2-conjuncts)
	      r1-conjuncts (delete-if
			     #'(lambda (restriction)
				 (case (compare-or restriction r2-conjunct)
				   (EQUIVALENT
				     (push r2-conjunct equivalences)
				     (push r2-conjunct more)
				     t)
				   (MORE-RESTRICTIVE
				     (push r2-conjunct more)
				     nil)
				   (NOT-COMPARABLE nil)
				   (LESS-RESTRICTIVE t)))
			     r1-conjuncts)))))


(defun compare-slots-1 (r1 r2 &optional (normalize t))
  (when normalize
    (setq r1 (cnf r1)
	  r2 (cnf r2)))
  (compare-and r1 r2))


(defmacro =r (r1 r2 &optional (normalizep t))
  `(compare-slots-1 ',r1 ',r2 ,normalizep))


  
(defun reduce-disjunction (disjunction)
  ;; Remove any disjunct which is more restrictive than, or equivalent to,
  ;; some other disjunct.
  (do* ((disjuncts (cdr disjunction) (cdr disjuncts))
	(disj1 (car disjuncts) (car disjuncts))
	(new-disjuncts nil))
       ((null disjuncts) `(:or ,@new-disjuncts))
    (do* ((remaining-disjuncts (cdr disjuncts) (cdr remaining-disjuncts))
	  (disj2 (car remaining-disjuncts) (car remaining-disjuncts)))
	 ((null remaining-disjuncts) (push disj1 new-disjuncts))
      (case (compare-simple-term disj2 disj1)
	((EQUIVALENT LESS-RESTRICTIVE)
	  ;; current disjunct is more restrictive than some other one --
	  ;; toss it and continue outer loop
	  (return nil))
	(MORE-RESTRICTIVE
	  ;; some other disjunct is more restrictive than this one --
	  ;; remove the other one from any further consideration
	  (delete disj2 disjunction :test 'eq))))))

(defun reduce-conjunction (conjunction)
  ;; Remove any conjunct which is less restrictive than, or equivalent to,
  ;; some other conjunct.
  (do* ((conjuncts (cdr conjunction) (cdr conjuncts))
	(conj1 (car conjuncts) (car conjuncts))
	(new-conjuncts nil))
       ((null conjuncts) `(:and ,@new-conjuncts))
    (do* ((remaining-conjuncts (cdr conjuncts) (cdr remaining-conjuncts))
	  (conj2 (car remaining-conjuncts) (car remaining-conjuncts)))
	 ((null remaining-conjuncts) (push conj1 new-conjuncts))
      (case (compare-or conj1 conj2)
	((EQUIVALENT LESS-RESTRICTIVE)
	 ;; current conjunct is less restrictive than some other one --
	 ;; toss it and continue outer loop
	 (return nil))
	(MORE-RESTRICTIVE
	  ;; some other conjunct is less restrictive than this one --
	  ;; remove the other one from any further consideration
	  (delete conj2 conjunction :test 'eq))))))

(defun reduced-cnf (cnf &optional in-cnf-p)
  (when (and (listp cnf)
	     (member (car cnf) *concept-form-keyword-list*))
    (unless in-cnf-p
      (setq cnf (cnf cnf)))
    (reduce-conjunction `(:and ,@(mapcar #'reduce-disjunction (cdr cnf))))))
