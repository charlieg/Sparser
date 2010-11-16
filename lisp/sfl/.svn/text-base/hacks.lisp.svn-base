;;; -*- Package: co; Base: 10; Syntax: Common-lisp -*-
(in-package :co)

;;;
;;;			   BBN Technologies
;;;		    A Division of BBN Corporation
;;;			      Copyright
;;;			 All Rights Reserved
;;;				 1999
;;;

;;; THIS FILE CONTAINS A VARIED COLLECTION OF VERY GENERAL SIMPLE MACROS, SUBSTS
;;; AND FUNCTIONS.

(proclaim '(inline coerce-list laste nsubst-or-delete))

(defmacro putprop (symbol value indicator)
  `(setf (get ,symbol ,indicator) ,value))

(defmacro ncons (x)
  `(list ,x))

(defun coerce-list (x)
  (if (listp x) x (list x)))


(defun laste (list)
  (car (last list)))

(defun nsubst-or-delete (new old ll)
  (if (listp ll)
      (if (member new ll)
	  (delete old ll)
	  (nsubst new old ll))
      (if (eql ll old)
	  new
	ll)))

(defun flat-listp (l)
  (loop for e in l
      unless (atom e) return nil
      finally (return t)))

(defun flat-listp (l)
  (loop for e in l
      for l1 on l
      ;;do (print (list e l1 l))
      unless (atom e) return nil
      when (atom (cdr l1)) return t
      finally (return t)))

#+ignore
(defun nsubst-or-delete-from-flat (new old ll)
  (if (listp ll)
      (if (flat-listp ll)
	  (nsubst-or-delete new old ll)
	  (loop for e in ll
		when  (symbolp e)
		  when (eql e old)
		    when (member new all) do nil
		    else collect new into all
		  else collect e into all
		else collect (nsubst-or-delete-from-flat new old e) into all
		finally (return all)))
      (if (eql ll old)
	  new
	ll)))

(defun nsubst-or-delete-from-flat (new old ll)
   (if (listp ll)
       (if (flat-listp ll)
	  (nsubst-or-delete new old ll)
	  (loop for e in ll
		when  (symbolp e)
		  when (eql e old)
		    when (member new all) do (progn)
		    else collect new into all
		  else collect e into all
		else collect (nsubst-or-delete-from-flat new old e) into all
		finally (return all)))
       (if (eql ll old)
	  new
	ll)))

(defun nsubst-atom-or-list (new old l1)
  (if (listp l1)
      (nsubst new old l1)
    (if (eql l1 old)
	new
      l1)))

(defun member-tree (obj tree)
  (cond ((atom tree)
	 (eq obj tree))
	((listp tree)
	 (or (member-tree obj (car tree))
	     (member-tree obj (cdr tree))))))

(proclaim '(inline associated-with assoc-with))

(defun associated-with (key alist)
  (cadr (assoc key alist)))

(defun assoc-with (key alist)
  (cdr (assoc key alist)))

(proclaim '(inline add-on maybe-add-on intersect-p))

(defun add-on (e listx)
  (append listx (list e)))

(defun funcall-maybe-list (function list)
  (if (listp list)
      (mapcar function list)
    (funcall function list)))

(eval-when (compile load eval)
  (export '(funcall-maybe-list add-on) (find-package :co)))

(defun maybe-add-on (e list)
  (if (member e list)
      list
      (add-on e list)))

(defun intersect-p (set1 set2)
  (loop for el in set1 
	when (member el set2 :test #'eq) return t))

;;;This acts like push except that the new element is added to the end, rather than
;;;the beginning of the list.

(defmacro nadd-on (item list)
  `(setq ,list (nconc ,list (list ,item))))

;;; Add it to the end of the list (destructively).
;;; Like pushnew.

(defmacro maybe-nadd-on (item list)
    `(progn (or (member ,item ,list)
	        (setf ,list (nconc ,list (list ,item))))
	    ,list))

(defvar *vowels* '(#\A #\E #\I #\O #\U))
(defun articalize (symbol)
  (if (member (char  (string symbol) 0) *vowels*)
      `(an ,symbol)
      `(a ,symbol)))

(proclaim '(inline filter-out non-intersection member-or-equal subset))
(defun filter-out (small-list big-list)
  ;;filters out the members of small-list from big list
  (loop for e in big-list
	unless (member e small-list)
	collect e))

(defun non-intersection (list1 list2)
  (nconc (filter-out list1 list2)(filter-out list2 list1)))

(defun ndelete-dupes (lst)
  "DESTRUCTIVELY remove duplicates from input list."
  (loop for tail1 on lst
	while (cdr tail1)
	for x = (car tail1)
	when x
	do (loop with x = (car tail1)
		 for tail2 on (cdr tail1)
		 when (eq x (car tail2))
		 do (rplaca tail2 nil))
	finally (return (delete nil lst))))

(defun remove-items-of-type-from-list (lst type)
  (loop for e in lst
	unless (typep e type)
	  collect e))

(defun set-equivalence (s1 s2)
  (and (= (length s1) (length s2))
       (loop for e in s1
	     unless (member e s2)
	     return nil
	     finally (return t))))

(defun member-or-equal (a l)
  (if (listp l)
      (member a l)
      (eql a l)))

(defun subset (s1 s2)
  (or (null s1)
      (if (atom s1)
	  (member s1 s2)
	  (null (filter-out s2 s1)))))

(defmacro eval-or-nil (form)
  `(or (null ,form)
       (eval ,form)))

(proclaim '(inline round-two-places inside-bounds))
(defun round-two-places (n)
  (/ (round (* n 100)) 100.0))

(defun inside-bounds (n kmin kmax)
  (min kmax (max kmin n)))

;;; Will return divisor if exact unless number is zero
(proclaim '(inline *max *= *<= *< *>= *> min* =* mod+ null0 >* >=* <* <=* =*))

(defun mod+ (number divisor)
  (if (zerop number)
      0
      (let ((m (mod number divisor)))
	(if (= m 0)
	    divisor
	    m))))

(defun null0 (n)
  (or (null n) (zerop n)))

(defun >* (n1 n2)
  (cond ((null0 n1) nil)
	((null0 n2) t) 
	(t (> n1 n2))))

(defun >=* (n1 n2)
  (cond ((null0 n1) (null0 n2))
	((null0 n2) t)
	(t (>= n1 n2))))

(defun <* (n1 n2)
  (cond ((null0 n1) n2)
	((null0 n2) nil)
	(t (< n1 n2))))

(defun <=* (n1 n2)
  (cond ((null0 n1) t)
	((null0 n2) nil)
	(t (<= n1 n2))))

(defun =* (n1 n2)
  (cond ((null0 n1) (null0 n2))
	((null0 n2) nil)
	(t (= n1 n2))))

(defun min* (values)
  (if (member nil values)
      nil
      (apply #'min values)))

;;;These assume nil is maximum

(defun *> (n1 n2)
  (cond ((null n1) n2)
	((null n2) nil)
	(t (> n1 n2))))

(defun *>= (n1 n2)
  (cond ((null n1) t)
	((null n2) nil)
	(t (>= n1 n2))))

(defun *< (n1 n2)
  (cond ((null n1) nil)
	((null n2) t)
	(t (< n1 n2))))

(defun *<= (n1 n2)
  (cond ((null n1) (null n2))
	((null n2) t)
	(t (<= n1 n2))))

(defun *= (n1 n2)
  (cond ((null n1) (null n2))
	((null n2) nil)
	(t (= n1 n2))))

(defun *max (values)
  (if (member nil values)
      nil
      (apply #'max values)))

(defun match-name (name instances)
  (loop for instance in instances
	when (eql (name instance) name)
	  return instance))

(defun extend-symbol-name (&rest symbols)
  (flet ((name (object)
	   (typecase object
	     (symbol (symbol-name object))
	     (string object)
	     (fixnum (princ-to-string object))
	     (t (error "extend-symbol-name: ~a is of type ~a"
		       object (type-of object))))))
    (intern (apply 'concatenate 'string (mapcar 'name symbols))
	    (symbol-package (car symbols)))))

(eval-when (compile load eval)
  (export '(extend-symbol-name) (find-package :co)))

;;; ********************************************************************************
;;; MAKE-ID will generate a numbered ID from a string or a symbol
;;; with "string" as input it will return  "string-n"
;;; with 'symbol as input it will return 'symbol-n
;;; numbering starts at 1

(defun generate-id (string)
  (let ((count 0))
    #'(lambda ()
	(setq count (1+ count))
	(concatenate 'string string "-" (format nil "~a" count)))))

#+allegro
(defun make-id (string-or-symbol &optional package)
  (if (stringp string-or-symbol)
      (let ((symbol (find-symbol string-or-symbol package)))
	(if symbol
	    (progn
	      (unless (excl::closurep (eval symbol))
		(set symbol (generate-id string-or-symbol)))
	      (funcall (eval symbol)))
	  (multiple-value-bind (symbol keyword)
	      (intern string-or-symbol package)
	    keyword
	    (unless (excl::closurep symbol)
	      (set symbol (generate-id string-or-symbol)))
	    (funcall (eval symbol)))))
    (progn
      (unless (and 
	       (boundp string-or-symbol) 
	       (excl::closurep (eval string-or-symbol)))
	(set string-or-symbol (generate-id (symbol-name string-or-symbol))))
      (intern (funcall (eval string-or-symbol)) package))))

#+ignore
(defun make-id (string &optional (symbol nil symbol-p))
  (if symbol-p
      (progn
	(unless (and (boundp symbol) symbol)
	  (set symbol (generate-id string)))
	(funcall (eval symbol)))
    (multiple-value-bind (symbol keyword)
	(intern string)
      (unless keyword
	(set symbol (generate-id string)))
      (funcall (eval symbol)))))

(eval-when (eval compile load)
  (export '(make-id) :co))

;;; ********************************************************************************

(defgeneric relevant-instance (object name))

(defun collect-instances-from-names (names controlling-instance)
  (loop for name in names
	collect (relevant-instance controlling-instance name)))

(proclaim '(inline obj random-list-item))

(defun obj (name)
  (get name :object))

(defmacro o. (name)
  `(obj ',name))

(eval-when (compile load eval)
  (export '(obj o.) (find-package :co)))

(defun random-list-item (li)
  (nth (random (- (length li) 1)) li))

(eval-when (compile load eval)
  (export '(random-list-item) (find-package :co)))

(defmacro push-alist (key item alist)
  `(let ((bucket (assoc ,key ,alist)))
     (cond (bucket
	    (rplacd bucket (cons ,item (cdr bucket))))
	   (t
	    (push (list ,key ,item) ,alist)))))

;;; Makes defclass more reasonable

(defmacro defobject (name supers slots &rest options)
  "Like DEFCLASS but automatically defines initarg and accessor
   for each slot.  Slots have the form (name value . options)."
  `(defclass ,name
	  ,supers
	,(map 'list #'(lambda (s)
			(let ((name (first s))
			      (value (second s)))
			  `(,name :initform ,value
			    :initarg ,(intern (string name) :keyword)
			    :accessor ,name ., (cddr s))))
	      slots)
	. ,options))

(defun make-instance* (CLASS-NAME &rest ARGS)
  (apply #'make-instance CLASS-NAME ARGS))

;; ********************************************************************************
;; pretty-string stuff yanked from glenn's sproket code
;; ********************************************************************************

(defvar *delimeters* '(#\space #\(  #\< #\[ #\return #\' #\: #\*))
(defvar *no-space-out-before-chars* '(#\- #\>))
(defvar *dont-spacify-till-next-delimeter* '(#\' #\: #\* #\())

(defun char-equal-member (char mlist)
  (loop for c in mlist
	when (char-equal c char)
	  return t))

(defun pretty-code-string (form &optional (length 20))
  (declare (ignore length))
  (let ((stream (make-string-output-stream)))
    (pprint form stream)
    (string-capitalize (get-output-stream-string stream))))

(defun pretty-string (string &optional (max-char 20) (spacify t))
  (let ((len (length string)))
    (if (> len 2)
	(let ((new-string (string-downcase string)))
	  (setf (aref new-string 0) (char-upcase (aref new-string 0)))
	  (loop with line-char = 0 and max-max = (+ 4 max-char)
		and dont-spacify-dashes = nil and seen-blank-p = nil
		for i from 0 to (- len 2)
		for char = (aref new-string i)
		do (incf line-char)
		when (and seen-blank-p
			  (> line-char max-max))
		  ;;This word extends past max-max -- insert return at previous space.
		  do (setf (aref new-string seen-blank-p) #\return)
		  and do (setq line-char (- i seen-blank-p)
			       seen-blank-p nil)
		when (char-equal-member char *dont-spacify-till-next-delimeter*)
		  do (setq dont-spacify-dashes i)
		when (and spacify
			  (null dont-spacify-dashes)	;Replace dashes with spaces.
			  (char-equal char #\-)	
			  (not (char-equal-member (aref new-string (+ i 1))
						  *no-space-out-before-chars*)))
		  do (setf (aref new-string i) #\space)
		  and do (setq char #\space)
		when (char-equal-member char *delimeters*)
		  ;;When hit a delimeter turn on spacify dashes and capitalize the next word.
		  do (when (and dont-spacify-dashes
				(< dont-spacify-dashes i))
		       (setq dont-spacify-dashes nil))
		  and do (setf (aref new-string (+ 1 i))
			       (char-upcase (aref new-string (+ i 1))))
		  and when (char-equal char #\return)
			do (setq line-char 0 seen-blank-p nil)
		      else
			when (char-equal char #\space)	;lines can break on blanks.
			  do (setq seen-blank-p i)
			  and when (> line-char max-char)
				do (setf (aref new-string i) #\return)
				and do (setq max-char line-char
					     max-max (+ 2 line-char)
					     line-char 0
					     seen-blank-p nil)
		finally (return new-string)))
	string)))

;;; ********************************************************************************

;;; The following code has been lifted from ...cooket/support/hacks.lisp

(defun flatlength (list)
  (if (listp list)
      (apply #'+ (mapcar #'flatlength list))
    1))

(defun alpha-sort (ll)
  (sort ll #'string-lessp))

(defun collect-names-from-instances (instances)
  (loop for instance in instances
      collect (name instance)))

(defun sort-names-and-return-instances (list)
  (collect-instances-from-names
   (alpha-sort (collect-names-from-instances list))
   (car list)))

;;;************************************************************************
;;; 
;;;************************************************************NLC-02/17/94
;;; classes that don't have concepts defined for them were originally
;;; known in SFL as other-mixins -- they are now known as superclasses
;;; the migration to the new naming is not complete -- both old and new
;;; functions/macros will work for now
;;; the *DEFINED-CONCEPT-OTHER-MIXINS* variable name will not change


(defvar *DEFINED-CONCEPT-OTHER-MIXINS* nil)

(defun merge-defined-concept-other-mixins (NEW-OTHER-MIXINS)
  (loop for TOM in NEW-OTHER-MIXINS
      unless (member TOM *DEFINED-CONCEPT-OTHER-MIXINS*)
      do (push TOM *DEFINED-CONCEPT-OTHER-MIXINS*)))

(defun merge-defined-concept-superclasses (NEW-OTHER-MIXINS)
  (loop for TOM in NEW-OTHER-MIXINS
      unless (member TOM *DEFINED-CONCEPT-OTHER-MIXINS*)
      do (push TOM *DEFINED-CONCEPT-OTHER-MIXINS*)))

(defun defined-concept-other-mixins ()
  *DEFINED-CONCEPT-OTHER-MIXINS*)

(defun defined-concept-superclasses ()
  *DEFINED-CONCEPT-OTHER-MIXINS*)

(defmacro define-other-mixin (NAME)
  `(pushnew ',NAME *DEFINED-CONCEPT-OTHER-MIXINS*))

(defmacro define-superclass (NAME)
  `(pushnew ',NAME *DEFINED-CONCEPT-OTHER-MIXINS*))

(eval-when (compile load eval)
  (export '(define-other-mixin define-superclass) (find-package :co)))

;;;************************************************************************
;;; 
;;;************************************************************NLC-05/16/94
(define-superclass instance-recording-mixin)

(define-superclass basic-agent)

(define-superclass named-object-mixin)

(define-superclass object-with-sets-mixin)

(define-superclass basic-procedure)

(define-superclass basic-predicate)

(define-superclass basic-primitive)

(define-superclass basic-goal)

(define-superclass basic-scenario)

(define-superclass conflicts-with-mixin)


;;;************************************************************************
;;; 
;;;************************************************************NLC-01/27/98
(defmacro format-nil (STR &rest ARGS)
  `(format nil ,STR ,@ARGS))

(eval-when (compile load eval)
  (export '(format-nil) (find-package :co)))
