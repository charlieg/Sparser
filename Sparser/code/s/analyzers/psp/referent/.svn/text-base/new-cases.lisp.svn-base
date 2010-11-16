;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993-1998 David D. McDonald  -- all rights reserved
;;;
;;;      File:  "new cases"
;;;    Module:  "analyzers;psp:referent:"
;;;   Version:  1.0 February 1998

;; broken out from cases 8/24/93 v2.3.  (3/10/94) fixed typo. Added error
;; msg to Ref/head 6/14.  (7/15) patched in mixin-category  (7/19) rearranged
;; break in Ref/binding ...and again 9/12.
;; 0.1 (4/19/95) defanged Ref/subtype until the proper subtyping regime is done
;; 1.0 (2/26/98) Started rewriting everything to work with lattice points.

(in-package :sparser)

;;;------
;;; head
;;;------

(defun ref/head (category-or-edge left-referent right-referent)
  (let ((head
         (etypecase category-or-edge
           ((or referential-category category mixin-category)
            (break "Ref/head: this is an instance of a category value")
            category-or-edge)
           (symbol
            (ecase category-or-edge
              (left-referent left-referent)
              (right-referent right-referent)))
           (individual (break "Ref/head: this is an instance of an individual value")
            category-or-edge))))
    
    (unless head
      (break "Bug in the grammar?  Decoding the head expression:~
              ~%    ~A~
              ~%for the rule ~A~
              ~%resulted in Nil." category-or-edge
             *rule-being-interpreted*))
 
    (let ((psi (find-or-make-psi head)))
      (break "look at psi")
      (annotate-realization psi *rule-being-interpreted*)
      
      psi )))



;;;------------------------
;;; instantiate individual
;;;------------------------

(defun ref/instantiate-individual
       (rule-field left-referent right-referent right-edge)
  (declare (ignore right-edge))
  
  (let* ((head
          (case (second rule-field)
            (left-referent left-referent)
            (right-referent right-referent)
            (otherwise (second rule-field)))))
    
    (if (individual-p head)
      ;; Individual-hood (vs. denoting a category or a partially-
      ;; saturated category) is not always dictated by an explicit
      ;; reference action, but can happen implicitly through composition
      ;; with certain kinds of specifiers.  
      ;;   This implies that there are cases when the referent action
      ;; may call for instantiating an individual for its head-line's
      ;; category but there'll already be one (which we just return).
      head
      (else
        (unless (referential-category-p head)
          (error "Expected the referent for the head:~%     ~A~
                  ~%  to be a category." head))
        (make/individual head nil)))))



(defun ref/instantiate-individual-with-binding
       (rule-field left-referent right-referent right-edge)
  (declare (ignore right-edge))
  
  (let* ((head
          (case (second rule-field)
            (left-referent left-referent)
            (right-referent right-referent)
            (otherwise (second rule-field))))
         (binding-exp/s (cddr rule-field))
         binding-instructions  variable  value  individual )
    
    (dolist (pair binding-exp/s)
      (setq variable (car pair)
            value (case (cdr pair)
                    (left-referent left-referent)
                    (right-referent right-referent)
                    (otherwise (cdr pair))))
      (kpush (kcons variable
                    (kcons value
                           nil))
             binding-instructions))
    
    ;; two cases, as above.
    (if (individual-p head)
      (then
        (setq individual head)
        (dolist (instr binding-instructions)
          (bind-variable (car instr)  ;; variable
                         (cadr instr) ;; value
                         individual)))
      (else
        (setq individual
              (find-or-make/individual head
                                       binding-instructions))))
    ;;/// deallocate the binding-instruction
    
    individual ))


;;;-----------------------------------------------------------
;;; specializing the type of the referent individual/category
;;;-----------------------------------------------------------

(defun ref/subtype (category left-referent right-referent)
  ;; first check what we're adding this to, and if it is a category
  ;; rather than an individual make the corresponding individual
  ;; //// ought to do a check against the taxonomic hierarchy
  ;; first, but we're putting off all that for a boost in generic
  ;; functionality.
    
  (when (symbolp category)
    (let ((edge-designator category))
      (setq category (ecase edge-designator
                       (left-referent left-referent)
                       (right-referent right-referent)))))

  (unless *referent*
    (break "Subtype called without a head specified -- check rule:~
            ~%  ~A" *rule-being-interpreted*))
  
  (let ((individual
         (etypecase *referent*
           
           (referential-category )
            #|(let ((indiv (make-throw-away-individual *referent*)))
                (setq *referent* indiv)
                indiv) |#

           (mixin-category )
           
           (individual  *referent*)
            #|(let ((new-indiv (make-throw-away-individual
                              (first (indiv-type *referent*)))))
              ;; now copy over the properties
              (when (rest (indiv-type *referent*))
                (dolist (c (rest (indiv-type *referent*)))
                  (add-category-to-individual new-indiv c)))
              (setf (indiv-binds new-indiv)
                    (indiv-binds *referent*))
              (setf (indiv-bound-in new-indiv)
                    (indiv-bound-in *referent*))
              
              (setq *referent* new-indiv)
              new-indiv ) |#
           )))

    (when individual
      ;; interim hack because of subtyping a mixin like "could" by NEG
      (add-category-to-individual individual category))
    
    individual ))





;;;--------------------------------------------------------------
;;; binding another variable in the referent individual/category
;;;--------------------------------------------------------------

(defun ref/binding (binding-exp
                    left-referent right-referent right-edge
                    &optional value-datum )
  (declare (ignore right-edge))
  
  (let ((variable (if value-datum  ;;///nasty patch over inconsistency
                    binding-exp    ;; in packaging by rdata vs. others
                    (car binding-exp)))
        (value-symbol (if value-datum
                        value-datum
                        (cdr binding-exp)))
        (body *referent*)
        value )

    (break "Ref/binding  body = ~a" body)
        
    ;(when (referential-category-p body)
    ;  (setq body (def-individual/no-indexing body))
    ;  (setq *referent* body))

    (unless value-symbol
      (break "Threading bug -- no value for the value symbol ~A~
              ~%in the binding expression: ~A" value-symbol binding-exp))
    
    (setq value (if value-datum
                  (symbol-value value-symbol)
                  (ecase value-symbol
                    (right-referent  right-referent)
                    (left-referent   left-referent))))
    
    (if value
      ;; This does all the work: allocates the binding object
      ;; and cross indexes it against the two individuals
      (bind-variable variable value body)

      (unless (or *do-domain-modeling-and-population*
                  *ignore-capitalization*)
        (break "The referent passed in via ~A~%to be bound to ~A is Nil,~
                ~%but you aren't allowed to bind a variable to nil."
               value-symbol variable))
      )))

