;;; -*- Package: co; Mode: LISP; Syntax: Common-lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;;;THIS FILE DEFINES FUNCTIONS THAT COMPARE ONE NUMBER RESTRICTION WITH ANOHTER AND
;;;RETURN ONE OF FOUR VALUES: MORE-RESTRICTIVE, LESS-RESTRICTIVE, EQUIVALENT OR
;;;NOT-COMPARABLE.

;;; The code for the define-comparison-function macro is in EXTENDED-VALUE-RESTRICTIONS.LISP


(define-comparison-functions <
  (< (args1 args2)
     (let ((upper-bound-1 (car args1))
	   (upper-bound-2 (car args2)))
       (cond ((or (not (numberp upper-bound-1)) (not (numberp upper-bound-1)))
	      'NOT-COMPARABLE)
	     ((= upper-bound-1 upper-bound-2) 'EQUIVALENT)
	     ((< upper-bound-1 upper-bound-2) 'MORE-RESTRICTIVE)
	     (t 'LESS-RESTRICTIVE))))
  (<= (args1 args2)
     (let ((upper-bound-1 (car args1))
	   (upper-bound-2 (car args2)))
       (cond ((or (not (numberp upper-bound-1)) (not (numberp upper-bound-1)))
	      'NOT-COMPARABLE)
	     ((<= upper-bound-1 upper-bound-2) 'MORE-RESTRICTIVE)
	     (t 'LESS-RESTRICTIVE))))
  (= (&rest ignore)
     (declare (ignore ignore))
     'LESS-RESTRICTIVE))


(define-comparison-functions <=
  (<= (args1 args2)
     (let ((upper-bound-1 (car args1))
	   (upper-bound-2 (car args2)))
       (cond ((or (not (numberp upper-bound-1)) (not (numberp upper-bound-1)))
	      'NOT-COMPARABLE)
	     ((= upper-bound-1 upper-bound-2) 'EQUIVALENT)
	     ((< upper-bound-1 upper-bound-2) 'MORE-RESTRICTIVE)
	     (t 'LESS-RESTRICTIVE))))
  (< (args1 args2)
     (let ((upper-bound-1 (car args1))
	   (upper-bound-2 (car args2)))
       (cond ((or (not (numberp upper-bound-1)) (not (numberp upper-bound-1)))
	      'NOT-COMPARABLE)
	     ((< upper-bound-1 upper-bound-2) 'MORE-RESTRICTIVE)
	     (t 'LESS-RESTRICTIVE))))
  (= (&rest ignore)
     (declare (ignore ignore))
     'LESS-RESTRICTIVE))


(define-comparison-functions >
  (> (args1 args2)
     (let ((lower-bound-1 (car args1))
	   (lower-bound-2 (car args2)))
       (cond ((or (not (numberp lower-bound-1)) (not (numberp lower-bound-1)))
	      'NOT-COMPARABLE)
	     ((= lower-bound-1 lower-bound-2) 'EQUIVALENT)
	     ((> lower-bound-1 lower-bound-2) 'MORE-RESTRICTIVE)
	     (t 'LESS-RESTRICTIVE))))
  (>= (args1 args2)
     (let ((lower-bound-1 (car args1))
	   (lower-bound-2 (car args2)))
       (cond ((or (not (numberp lower-bound-1)) (not (numberp lower-bound-1)))
	      'NOT-COMPARABLE)
	     ((>= lower-bound-1 lower-bound-2) 'MORE-RESTRICTIVE)
	     (t 'LESS-RESTRICTIVE))))
  (= (&rest ignore)
     (declare (ignore ignore))
     'LESS-RESTRICTIVE))


(define-comparison-functions >=
  (>= (args1 args2)
     (let ((lower-bound-1 (car args1))
	   (lower-bound-2 (car args2)))
       (cond ((or (not (numberp lower-bound-1)) (not (numberp lower-bound-1)))
	      'NOT-COMPARABLE)
	     ((= lower-bound-1 lower-bound-2) 'EQUIVALENT)
	     ((> lower-bound-1 lower-bound-2) 'MORE-RESTRICTIVE)
	     (t 'LESS-RESTRICTIVE))))
  (> (args1 args2)
     (let ((lower-bound-1 (car args1))
	   (lower-bound-2 (car args2)))
       (cond ((or (not (numberp lower-bound-1)) (not (numberp lower-bound-1)))
	      'NOT-COMPARABLE)
	     ((> lower-bound-1 lower-bound-2) 'MORE-RESTRICTIVE)
	     (t 'LESS-RESTRICTIVE))))
  (= (&rest ignore)
     (declare (ignore ignore))
     'LESS-RESTRICTIVE))

(define-comparison-functions =
  (= (args1 args2)
     (cond ((equal (car args1) (car args2)) 'EQUIVALENT)
	   (t 'NOT-COMPARABLE)))
  ((< <= > >=) (&rest ignore)
   (declare (ignore ignore))
   'MORE-RESTRICTIVE))









