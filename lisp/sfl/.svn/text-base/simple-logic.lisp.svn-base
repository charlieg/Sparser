;;; -*- Mode: LISP; Package: co; Syntax: Common-lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;; The truth table stuff WILL NOT WORK with SATISFIES or SET expressions

(defun unknown-logical-expression (expr)
  (error "Illegal logical expression ~a" expr))

(defun expr-vars-1 (expr)
  (declare (special *vars*))
  (cond ((symbolp expr)
	 (pushnew expr *vars*))
	((listp expr)
	 (if (member (first expr) '(a an) :test 'eq)
	     (pushnew (second expr) *vars*)
	     (mapc #'expr-vars-1 (cdr expr))))
	(t
	 (unknown-logical-expression expr))))

(defmacro symbol-logvalue (symbol)
  `(get ,symbol :log-offset))


(defun expr-vars (expr)
  (declare (special *vars*))
  (expr-vars-1 expr)
  (do* ((vars *vars* (cdr vars))
	(log 1 (ash log 1)))
       ((null vars))
    (setf (symbol-logvalue (first vars)) log)))

(defun symbol-lookup (sym)
  (declare (special *pseudo-set*))
  (not (zerop (logand (symbol-logvalue sym) *pseudo-set*))))

(defun ttable-internal (expr)
  ;; generate one line in truth table
  ;; assume symbols in EXPR have been "bound" to T or NIL
  (cond ((symbolp expr)
	 (symbol-lookup expr))
	((listp expr)
	 (case (first expr)
	   ((a an)
	    (symbol-lookup (second expr)))
	   (:not
	    (not (ttable-internal (second expr))))
	   ((=>* :=>)
	    (not (and (ttable-internal (second expr)) (not (ttable-internal (third expr))))))
	   ((iff* :iff)
	    (eq (ttable-internal (second expr)) (ttable-internal (third expr))))
	   (:and
	    (do ((subexpr (cdr expr) (cdr subexpr)))
		((null subexpr) t)
	      (unless (ttable-internal (first subexpr))
		(return nil))))
	   (:or
	    (do ((subexpr (cdr expr) (cdr subexpr)))
		((null subexpr) nil)
	      (when (ttable-internal (first subexpr))
		(return t))))
	   (otherwise
	     (unknown-logical-expression expr))))
	(t
	 (unknown-logical-expression expr))))

(defun ttable (expr)
  ;; Build a truth-table list for EXPR.
  ;; Each entry is a set of variable truths (implemented as a number interpreted as
  ;; a bit-array) and the corresponding expression truth
  (let ((*vars* nil) (ttable nil))
    (declare (special *vars*))
    (expr-vars expr)
    (do ((limit (expt 2 (length *vars*)))
	 (*pseudo-set* 0 (1+ *pseudo-set*)))
	((= *pseudo-set* limit) ttable)
      (declare (special *pseudo-set*))
      (push (cons *pseudo-set* (ttable-internal expr)) ttable))))

(defun expr-eql (expr1 expr2)
  (loop for (nil . truth-value1) in (ttable expr1)
	for (nil . truth-value2) in (ttable expr2)
	when (not (eql truth-value1 truth-value2))
	  return nil
	finally (return t)))




;; RUP normal form generators


(defun cnf (exp)
  `(:and ,@(mapcar #'(lambda (disjuncts) `(:or ,@disjuncts)) (conj-normal exp))))

(defun dnf (exp)
  `(:or ,@(mapcar #'(lambda (conjuncts) `(:and ,@conjuncts)) (disj-normal exp))))

(defun conj-normal (exp)
  "Reduces a logical expression to its conjunctive normal form."
  (cond
    ((symbolp exp) `((,exp)))
    ((listp exp)
     (case (first exp)
       ((a an satisfies :satisfies) `((,exp)))
       ((=>* :=>)  (distribute (neg-conj-normal (second exp)) (conj-normal (third exp))))
       (:or  (do* ((res (conj-normal (second exp))
			      (distribute (conj-normal (first disjuncts)) res))
			 (disjuncts (cddr exp) (cdr disjuncts)))
			((null disjuncts) res)))
       (:and (mapcan #'conj-normal (cdr exp)))
       (:not (neg-conj-normal (second exp)))
       ((iff* :iff) (nconc (conj-normal `(:=> ,(second exp) ,(third exp)))
			   (conj-normal `(:=> ,(third exp) ,(second exp)))))
       (otherwise `((,exp)))))
    (t (unknown-logical-expression exp))))

(defun neg-conj-normal (exp)
  "Negates an expression and reduces it to conjunctive normal form."
  (cond
    ((symbolp exp) `(((:NOT ,exp))))
    ((listp exp)
     (case (first exp)
       ((a an satisfies  :satisfies) `(((:NOT ,exp))))
       ((=>* :=>)  (nconc (conj-normal (second exp)) (neg-conj-normal (third exp))))
       (:and (do* ((res (neg-conj-normal (second exp))
			       (distribute (neg-conj-normal (first conjuncts)) res))
			  (conjuncts (cddr exp) (cdr conjuncts)))
			 ((null conjuncts) res)))
       (:or (mapcan #'neg-conj-normal (cdr exp)))
       (:not (conj-normal (second exp)))
       ((iff* :iff) (nconc (conj-normal `(:=> ,(second exp) (:not ,(third exp))))
			   (conj-normal `(:=> ,(third exp) (:not ,(second exp))))))
       (otherwise `(((:NOT ,exp))))))
    (t (unknown-logical-expression exp))))


(defun disj-normal (exp)
  "Reduces a logical expression to its disjunctive normal form."
  (cond
    ((symbolp exp) `((,exp)))
    ((listp exp)
     (case (first exp)
       ((a an satisfies  :satisfies) `((,exp)))
       ((=>* :=>)  (nconc (neg-disj-normal (second exp)) (disj-normal (third exp))))
       (:and (do* ((res (disj-normal (second exp))
			       (distribute (disj-normal (first conjuncts)) res))
			  (conjuncts (cddr exp) (cdr conjuncts)))
			 ((null conjuncts) res)))
       (:or (mapcan #'disj-normal (cdr exp)))
       (:not (neg-disj-normal (second exp)))
       ((iff* :iff) (nconc (disj-normal `(:=> ,(second exp) ,(third exp)))
			   (disj-normal `(:=> ,(third exp) ,(second exp)))))
       (otherwise `((,exp)))))
    (t (unknown-logical-expression exp))))

(defun neg-disj-normal (exp)
  "Negates an expression and reduces it to disjunctive normal form."
  (cond
    ((symbolp exp) `(((:NOT ,exp))))
    ((listp exp)
     (case (first exp)
       ((a an satisfies  :satisfies) `(((:NOT ,exp))))
       ((=>* :=>) (distribute (disj-normal (second exp)) (neg-disj-normal (third exp))))
       (:or (do* ((res (neg-disj-normal (second exp))
			     (distribute (neg-disj-normal (first disjuncts)) res))
			(disjuncts (cddr exp) (cdr disjuncts)))
		       ((null disjuncts) res)))
       (and* (mapcan #'neg-disj-normal (cdr exp)))
       (not* (disj-normal (second exp)))
       ((:iff iff*) (nconc (disj-normal `(:=> ,(second exp) (:not ,(third exp))))
			   (disj-normal `(:=> ,(third exp) (:not ,(second exp))))))
       (otherwise `(((:NOT ,exp))))))
    (t (unknown-logical-expression exp))))



(defun distribute (exp1 exp2)
  "Given two conjunctive normal forms, generate a new cnf which is
  (equaivalent to) the disjunction of the two.
  Or given two disjunctive normal forms, generate a new dnf which is
  (equivalent to) the conjunction of the two."
  (mapcan #'(lambda (sub1) (mapcar #'(lambda (sub2) (append sub1 sub2)) exp2)) exp1))
