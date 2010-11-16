;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993-2000 David D. McDonald  -- all rights reserved
;;;
;;;      File:  "new cases"
;;;    Module:  "analyzers;psp:referent:"
;;;   Version:  1.2 December 2000

;; broken out from cases 8/24/93 v2.3.  (3/10/94) fixed typo. Added error
;; msg to Ref/head 6/14.  (7/15) patched in mixin-category  (7/19) rearranged
;; break in Ref/binding ...and again 9/12.
;; 0.1 (4/19/95) defanged Ref/subtype until the proper subtyping regime is done
;; 1.0 (2/26/98) Started rewriting everything to work with lattice points.
;;      Continued sporatically through 7/25.
;;     (3/25/00) Resumed through 6/18.
;; 1.1 (6/18) Added Opportunistic-binding-to-composite-head. Incorporated annotation
;;      into it 6/21. Occasional tweaks through 7/9.
;; 1.2 (12/26) Added optional arg. to ref/head so the annotation call could know
;;      it was coming in from a unary-rule.

(in-package :sparser)

;;;------
;;; head
;;;------

#| Head statements in a referent will always come first. They just
 serve to elevate the referent of one of the daughters to be the
 referent of the phrase were interpreting, or they could be newly
 introducing a referent where more structure is needed in the
 referent expression than just laying down a category or an 
 individual as the direct interpretation -- initial motivation 
 from "companies" 3/25/00.
|#
(defun ref/head (category-or-edge left-referent right-referent
                 &optional called-from-unary-rule?)
  (let ((head
         (if (symbolp category-or-edge)
           (ecase category-or-edge
             (left-referent
              (indicate-head :left)
              left-referent)
             (right-referent
              (indicate-head :right)
              right-referent))
           ;; individuals, psi, categories
           category-or-edge)))
    
    (unless head
      (break "Bug in the grammar?  Decoding the head expression:~
              ~%    ~A~
              ~%for the rule ~A~
              ~%resulted in Nil." category-or-edge
             *rule-being-interpreted*))

   ; (when (typep head 'composite-referent)
    ;  (setq head (cr-head head)))

    (tr :annotating-ref/head head)
    (etypecase head
      ((or psi individual)
       (if called-from-unary-rule?
         (let ((*referent* head))
           (annotate-individual head :unary-rule))
         (annotate-individual head :globals-bound)))
      (referential-category
       ;; have to convert this into a psi that we can operate over.
       ;; The annotation is folded into the find-or-make
       (setq head
             (find-or-make-psi-for-base-category head)))
      (composite-referent
       (annotate-composite head)))
    head ))



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
  (let* (  head-edge  arg-edge  type-of-head
         (head (case (second rule-field)
                 (left-referent
                  (setq head-edge *left-edge-into-reference*
                        arg-edge *right-edge-into-reference*)
                  left-referent)
                 (right-referent
                  (setq head-edge *right-edge-into-reference*
                        arg-edge *left-edge-into-reference*)
                  right-referent)
                 (otherwise 
                  ;; Neither edge is a head line, we're presumably
                  ;; creating a new type of individual here
                  (second rule-field))))
         (binding-exp/s (cddr rule-field))
         (psi
          (etypecase head
            (psi
             (setq type-of-head
                   (lp-category (climb-lattice-to-top
                                 (psi-lattice-point head))))
             head)
            (referential-category
             (setq type-of-head head)
             (find-or-make-psi-for-base-category head))
            (individual
             (break "Shouldn't have gotten a full individual at ~
                     this stage"))))
         variable value )

    (tr :instantiating-individual-with-binding
        psi binding-exp/s)

    (dolist (pair binding-exp/s)
      (setq variable (car pair)
            value (case (cdr pair)
                    (left-referent
                     (unless arg-edge
                       (setq arg-edge *left-edge-into-reference*))
                     (unless head-edge
                       (setq head-edge *right-edge-into-reference*))
                     left-referent)
                    (right-referent
                     (unless arg-edge
                       (setq arg-edge *right-edge-into-reference*))
                     (unless head-edge
                       (setq head-edge *left-edge-into-reference*))
                     right-referent)
                    (otherwise
                     (let ((unit (cdr pair)))
                       (etypecase unit
                         (psi unit)
                         (individual unit)
                         (referential-category
                          (find-or-make-psi-for-base-category unit)))))))

      (setq psi (extend-psi-by-binding
                 variable value psi))

      ;; annotate what c+v the value has been bound to.
      (annotate-site-bound-to value variable type-of-head))

    ;; annotate this combination
    (cond ((and head-edge arg-edge) ;; canonical case
           (annotate-realization-pair
            (psi-lattice-point psi) *rule-being-interpreted*
            head-edge arg-edge))

          (*single-daughter-edge* ;; called from unary subtype
           (annotate-realization-pair
            (psi-lattice-point psi) *rule-being-interpreted*
            *parent-edge-getting-reference* :unary-rule)))           
       
    psi ))



;;;-----------------------------------------------------------
;;; specializing the type of the referent individual/category
;;;-----------------------------------------------------------

(defun ref/subtype (ref-exp left-referent right-referent)
  (when (symbolp ref-exp)
    (setq ref-exp (ecase ref-exp
                    (left-referent left-referent)
                    (right-referent right-referent))))
  (unless *referent*
    (break "Subtype called without a head specified -- check rule:~
            ~%  ~A" *rule-being-interpreted*))

  (let ((what-to-do
         (etypecase ref-exp
           (referential-category :simple-subtype)
           (list
            (let ((operation (first ref-exp)))
              (ecase operation
                (:instantiate-individual-with-binding
                 :build-companion-and-subtype)))))))
    (case what-to-do
      (:simple-subtype
       (corresponding-unit-of-subtype *referent* ref-exp))
      (:build-companion-and-subtype
       (let ((other-referent
              (setup-and-dispatch-referent-expression 
               ref-exp left-referent right-referent)))
         (make-composite-referent 
          :head *referent*
          :others (list other-referent)))))))

(defun setup-and-dispatch-referent-expression 
       (ref-exp left-referent right-referent)
  (ecase (first ref-exp)
    (:instantiate-individual-with-binding
     (ref/instantiate-individual-with-binding
      ref-exp left-referent right-referent *right-edge-into-reference*))
    ))





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
        value  head-edge  arg-edge )

    (unless (or (typep body 'psi)
                (typep body 'composite-referent))
      (break "Conversion omitted: the body to which the binding is ~
              to be added~%is not a partially saturated individual:~
              ~%   body: ~a" body))
    (unless value-symbol
      (break "Threading bug -- no value for the value symbol ~A~
              ~%in the binding expression: ~A" value-symbol binding-exp))

    (setq value (if value-datum
                  (symbol-value value-symbol)
                  (ecase value-symbol
                    (right-referent 
                     (setq head-edge *left-edge-into-reference*
                           arg-edge *right-edge-into-reference*)
                     right-referent)
                    (left-referent
                     (setq head-edge *right-edge-into-reference*
                           arg-edge *left-edge-into-reference*)
                     left-referent))))

    (unless value
      (unless (or *do-domain-modeling-and-population*
                  *ignore-capitalization*)
        (break "Bug:The referent passed in via ~A~%to be bound to ~A is Nil,~
                ~%but you aren't allowed to bind a variable to nil."
               value-symbol variable)))
    
    (when value
      ;; /// Earlier treatment. Rembember to cross-index at some point
      ;; This does all the work: allocates the binding object
      ;; and cross indexes it against the two individuals
      ;(bind-variable variable value body)
      
      (let ((extended-psi
             (typecase body
               (composite-referent
                (opportunistic-binding-to-composite-head
                 variable value body
                 head-edge arg-edge))
               (psi
                (extend-psi-by-binding
                 variable value body)))))

        ;; //// annotate the value re. what c+v it's been bound to

        ;; annotate this combination
        (when (typep extended-psi 'psi)
          ;; composite case has does the annotation within the
          ;; code that does the opportunistic binding.
          (annotate-realization-pair
           (psi-lattice-point extended-psi) *rule-being-interpreted*
           head-edge arg-edge))

        extended-psi ))))



(defun opportunistic-binding-to-composite-head (variable value c
                                                head-edge arg-edge)
  (tr :looking-for-opportunistic-binding variable c)
  (let ((head (cr-head c))
        (others (cr-others c))
        (doing-head? t) ;; index for the loop
        extended-psi  variable-bound?  new-others )
    ;; Are any of these psi and are they open in the variable we're
    ;; about to bind: first-come, first-served. Otherwise bind it to
    ;; the head since we have to dispose of it at the point when it
    ;; adjoins. 
    (dolist (body (cons head others))
      (unless variable-bound?
        (etypecase body
          (psi
           (if (is-open-in body variable)
             (then (tr :bind-to-psi-open-in body variable)
                   (setq variable-bound? t)
                   (setq extended-psi (extend-psi-by-binding
                                       variable value body)))
             (else
               (tr :not-binding-to-because-not-open-in body variable)))))
        (if doing-head?
          (then (when extended-psi
                  (setf (cr-head c) extended-psi)))
          (push (or extended-psi
                    body)
                new-others))
        ;; cleanup loop variable
        (setq doing-head? nil)))
    
    (when (null variable-bound?)
      (tr :nothing-open-defaulting-to-head variable head)
      (setq extended-psi (extend-psi-by-binding variable value head))
      (setf (cr-head c) extended-psi))

    (annotate-realization-pair (psi-lattice-point extended-psi)
                               *rule-being-interpreted*
                               head-edge arg-edge)
    
    (setf (cr-others c) (nreverse new-others))
    ;(break "look at composite 'c'")
    c ))

