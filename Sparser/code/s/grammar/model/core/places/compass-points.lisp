;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1995-1999  David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2007 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$
;;;
;;;     File:  "compass points"
;;;   Module:  "model;core:places:"
;;;  version:  0.2 September 2007

;; initiated in 1/9/95, 2/24 added string printer. 
;; 0.1 (11/27/99) reworked them using realizations and implicit indexing. 
;;      Note that the adjective forms are still old style and won't work.
;; 0.2 (9/5/07) Making it over in the same style as directions.

(in-package :sparser)


;;--- object

(define-category  compass-point
  :instantiates  self
  :specializes   direction
  :binds ((name :primitive word)))


;;--- def form

;; These words compose with "the" and take complements that make the
;; direction more precise ("of the corn field").

(defun define-compass-point (string &optional ward)
  (let* ((brackets (if ward
		     '( .[np np]. )
		     '( .[np )))
	 (word (or (word-named string) ;; take whatever the original brackets are
		   (define-function-word string 
		       :form 'noun
		       :brackets brackets)))
	 (i (define-individual 'compass-point :name word))
	 (noun-rule (define-cfr category::direction `(,word)
		      :form category::noun
		      :referent i))
	 ;; /////////// is this combination worth a tree family?
	 ;; // or at least a schema to associate with it?
	 (adj (define-adjective (concatenate 'string string "ern")))
	 (adj-rule
	  (unless ward
	    (define-cfr category::direction `(,adj)
	      :form category::adjective
	      :referent i)))
	 (rules `(,noun-rule ,adj-rule)))

    ;;//// need an idiom for stashing these rules on the plist
    ;; of the individual: (cadr (memq :rules (unit-plist cp)))
    (values i rules)))


;;--- printer

(defun string/Compass-point (cp)
  (let ((name (value-of 'name cp)))
    (if name
      (word-pname name)
      "[compass point w/o name]" )))

