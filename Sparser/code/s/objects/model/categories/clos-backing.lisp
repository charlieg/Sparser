;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 2010-2011 David D. McDonald  -- all rights reserved
;;; $Id$
;;;
;;;     File:  "clos-backing"
;;;   Module:  "objects;model:categories:"
;;;  version:  0.0 June 2011

;; initated 11/9/10. Modified the storage scheme 11/11. Tweaking cases
;; through 12/6. 6/16/11 fixed case of clash with existing classes.

(in-package :sparser)

;;;---------------------------------
;;; stashing the classes on a table
;;;---------------------------------

;; Tried adding a slot to the referential-category defstruct
;; but something weird is happening with them (load shows lots
;; of redefines that don't seem sensible) so went the easy
;; route

(defvar *categories-to-classes* (make-hash-table))

(defmethod get-class ((c category))
  (gethash c *categories-to-classes*))

(defmethod get-class ((s symbol))
  (let ((c (category-named s)))
    (unless c (error "No category named ~a" s))
    (get-class c)))

(defun store-class-for-category (c class)
  (setf (gethash c *categories-to-classes*) class))


;;;-------------
;;; entry point
;;;-------------

(defun setup-backing-clos-class (c source)
  ;; Called from the bottom of decode-category-parameter-list when
  ;; we have created everything we can about the category. Also called
  ;; from find-or-make-category-object for other cases, notably
  ;; form categories like 'modal'. 
  (push-debug `(,c))
  ;(break "got here: ~a" c)
  (case source
    (:minimal)
    (:define-category)
    ((or :referential :form)
     (let* ((class-name (backing-class-name-for-cateory c))
            ;; 1. Class goes in the sparser package so as not to conflict
            (supercat (when (cat-lattice-position c) ;;unless (eq source :form)
                        (lp-super-category (cat-lattice-position c))))
            (superc-name ;; presume there's just one
             (when supercat (backing-superclass-for-category supercat)))
            (variables (cat-slots c))
            (slot-expressions 
             (when variables (backing-class-slots-for-category variables)))
            (form
             `(defclass ,class-name ,(if superc-name `(,superc-name) nil)
                ,slot-expressions)))
       (push-debug `(,form))
       (let ((class (eval form)))
         (store-class-for-category c class)
         c)))
    (otherwise
     (push-debug `(,c ,source))
     (break "New backing-CLOS class source: ~a~%~a" source c))))

(defun backing-class-name-for-cateory (c)
  ;; :sparser package uses :common-lisp, so there's the possibility
  ;; of clashing with the name of a function, so we have to avoid
  ;; that by using a made-up name in such cases (eg. 'time).
  (let* ((c-name (cat-symbol c)) ;; in the category package
         (c-pname (symbol-name c-name))
         (class-name (intern c-pname (find-package :sparser)))
         (existing-class (find-class class-name nil))
         (names-a-function (fboundp class-name)))
    (when (or existing-class names-a-function)
      ;; We aren't allowed to redefine classes that already exist
      ;; Even our own classes that come out of defstruct. 
      ;; For functions (the word "when") we have a comparable problem
      (setq class-name (intern (string-append c-pname "-cclass")
                               (find-package :sparser))))
    (when (eq class-name 'individual)
      ;; Can't makes classes for symbols that name Sparser structs.
      ;; It would amount to redefining them and clobber everything
      (setq class-name (intern "individual-class" (find-package :sparser))))
    class-name))


(defun backing-superclass-for-category (superc)
  ;; stub something if there's not already a class?
  (let* ((superc-name (backing-class-name-for-cateory superc))
         (super-class (get-class superc)))
    (unless super-class
      (break "The CLOS class for ~a doesn't exist yet." superc-name))
    superc-name))

(defun backing-class-slots-for-category (variables)
  (let ( forms )
    (dolist (v variables)
      (let* ((slot-name (intern (symbol-name (var-name v))
				(find-package :sparser)))
	     (v/r (var-value-restriction v))
	     (type-constraint
	      (when v/r (backing-type-for-variable-restriction v/r))))
	(push (if v/r
               `(,slot-name :type ,type-constraint)
	       `(,slot-name))
	      forms)))
    (nreverse forms)))

(defun backing-type-for-variable-restriction (v/r)
  (typecase v/r
    (cons
     (case (car v/r)
       (:primitive
	(typecase (second v/r)
	  (symbol
	   (case (second v/r)
	     (word 'word)
	     (list 'list)
	     (integer 'integer)
	     (fixnum 'fixnum)
	     (number 'number)
	     (pathname 'pathname)
	     (cons 'cons)
	     (polyword 'polyword)
	     (cfr 'cfr)
	     (category 'category)
	     (segment 'segment)
	     (otherwise (push-debug `(,v/r))
			(break "Another v/r primitive symbol: ~a" (second v/r)))))
	  (cons
	   (let ((tag (car (second v/r)))
		 (values (cdr (second v/r))))
	     (unless (symbolp tag) 
	       (push-debug `(,v/r)) (error "V/R shouldn't go this deep"))
	     (case tag
	       (:or
		(let ((r (mapcar #'backing-type-for-variable-restriction values)))
		  `(:or ,@r)))
	       (otherwise
		(push-debug `(,v/r))
		(break "New key in deep cons-based value restriction:~%  ~a" v/r)))))
	  (otherwise
	   (push-debug `(,v/r))
	   (break "New type of cons-based value restriction:~%  ~a" v/r))))
       (:or
	(let ((r (mapcar #'backing-type-for-variable-restriction (cdr v/r))))
	  `(:or ,@r)))
       (otherwise
	(push-debug `(,v/r))
	(break "New form for cons-based value restriction:~%  ~a" v/r))))
    (referential-category
     (backing-class-name-for-cateory v/r))
    (symbol
     v/r)
    (otherwise
     (push-debug `(,v/r))
     (break "New type for v/r: ~a~%  ~a" (type-of v/r) v/r))))
 
	     



