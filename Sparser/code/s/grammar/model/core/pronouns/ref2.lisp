;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.
;;; copyright (c) 1992  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "ref"
;;;   Module:  "model;core:pronouns:"
;;;  version:  1.8  September 1991

;; 1.1  (2/7 v1.8.1)  Added check for actual edge as neighbor in
;;      Seek-referent-from-pn-form.
;; 1.2  (3/19 v1.8.1) Added "its" -> company anaphor
;; 1.3  (3/20)  Added *trace-pronominalization* tracing flag
;; 1.4  (3/22)  Fixed mistake (edge for referent) in co. and generally
;;      cleaned up the code.
;; 1.5  (3/25)  Changed the default on person to always go for the most recent
;;      anaphor and not worry about the edge context when it wasn't known.
;; 1.6  (3/26)  Added code for context of after [company-reports] by copying
;;      the code for [person-reports]
;; 1.7  (4/9 v1.8.2)  added cases for doing "she"
;; 1.8  (9/17 v1.9) Crippled Seek-plural-people-for-pn so that it no longer
;;      presumes that "they" refers to a person.  ///have to give it a real
;;      capability.
;; 1.9 (7/14/92 v2.3)  Minimally reworked to use the new discourse history

(in-package :sparser)

;;;-----------
;;; CA action
;;;-----------

(set-completion-action/edge/category category::pronoun
                                    'seek-referent-from-pn-form)

(set-traversal-action  category::pronoun  'seek-referent-from-pn-form)


;;;----------------------
;;; dispatch off pronoun
;;;----------------------

(defun seek-referent-from-pn-form (pn-edge)
  (when *trace-pronominalization*
       (format t "~&Looking for a referent for the pronoun ~A~%" pn-edge))
  
  (ecase (cat-symbol (edge-form pn-edge))

    (category::pronoun/possessive/human/male
     (seek-person-for-pn pn-edge))
    (category::pronoun/human/male
     (seek-person-for-pn pn-edge))
    (category::pronoun/possessive/human/female
     (seek-person-for-pn pn-edge))
    (category::pronoun/human/female
     (seek-person-for-pn pn-edge))

    (category::pronoun/inanimate
     (seek-company-for-pn pn-edge))
    (category::pronoun/possessive/inanimate
     (seek-company-for-pn pn-edge))

    (category::pronoun/animate/plural
     (seek-plural-people-for-pn pn-edge))
    (category::pronoun/possessive/animate/plural
     (seek-plural-people-for-pn pn-edge))))


;;;------------------------------
;;; the toplevel "Seek" routines
;;;------------------------------

(defun seek-person-for-pn (pn-edge)
  (let* ((left-neighbor (top-edge-at/ending (pos-edge-starts-at pn-edge)))
         (right-neighbor (top-edge-at/starting (pos-edge-ends-at pn-edge))))

    (if (or left-neighbor right-neighbor)
      ;; in sparse text, there may not be a parsed edge next to
      ;; the pronoun, but only an unknown word

      (if (eq left-neighbor :multiple-initial-edges)
        (respan-pn-with-most-recent-person-anaphor pn-edge)
        (else
          (case (cat-symbol (edge-category left-neighbor))
            (category::person-reports
             (respan-pn-with-person-from-person-reports
              pn-edge left-neighbor))
            (word::period
             (respan-pn-with-most-recent-person-anaphor pn-edge))
            (otherwise
             (respan-pn-with-most-recent-person-anaphor pn-edge)))))
      (else
        (respan-pn-with-most-recent-person-anaphor pn-edge)))))


(defun seek-company-for-pn (pn-edge)
  (let ((left-neighbor (top-edge-at/ending (pos-edge-starts-at pn-edge))))
    (cond ((eq left-neighbor :multiple-initial-edges) ;;////////
           (respan-pn-with-most-recent-company-anaphor pn-edge))
          ((and left-neighbor
                (typep left-neighbor 'edge))
           (case (cat-symbol (edge-category left-neighbor))
             (category::company-reports
              (respan-pn-with-company-from-company-reports
               pn-edge left-neighbor))
             (otherwise
              (respan-pn-with-most-recent-company-anaphor pn-edge))))
          (t
           (respan-pn-with-most-recent-company-anaphor pn-edge)))))


(define-category  person-anaphor/plural)

(defun seek-plural-people-for-pn (pn-edge)
  (let ((person-category
         (case (cat-symbol (edge-form pn-edge))
           (category::pronoun/animate/plural   category::person)
           (category::pronoun/possessive/animate/plural category::person-possessive)
           (otherwise
            (break/debug "Unanticipated kind of form category")))))
    
    ;(make-new-edge-over-pronoun pn-edge
    ;                            person-category
    ;                            category::np
    ;                            category::person-anaphor/plural)
    ))


;;;----------------------------------
;;; getting the work done with rules
;;;----------------------------------

#|  If the evidence isn't present at the time the edge is laid down
then we have to take steps to put in the proper referent once it does
appear.  |#

;; /// it would be nice to differentiate this by +-possessive

(def-csr  pronoun company  :left-context  company-reports
  :referent (:copy left-edge))



;;;---------------------------
;;; extract & respan routines
;;;---------------------------

;;---- company

(defun respan-pn-with-most-recent-company-anaphor (pn-edge)
  (let ((company-edge (anaphor-with-category category::company))
        (company-category
         (case (cat-symbol (edge-form pn-edge))
           (category::pronoun/inanimate category::company)
           (category::pronoun/possessive/inanimate category::company-possessive)
           (otherwise
            (break/debug "Unanticipated kind of form category")))))

    (if company-edge
      (make-new-edge-over-pronoun pn-edge
                                  company-category
                                  category::np
                                  (edge-referent company-edge))
      (else
        (when *trace-pronominalization*
          (format t "~&~%No company available in the potential-anaphors ~
                     list for pn \"its\"~%"))
        (make-new-edge-over-pronoun pn-edge
                                    company-category
                                    category::np
                                    :unresolved-company-anaphor)
        ))))


(defun respan-pn-with-company-from-company-reports (pn-edge
                                                    co-rpts-edge)
  (let ((rpt-ref (edge-referent co-rpts-edge)))
    (unless (and (composite? rpt-ref)
                 (eq (first rpt-ref) category::report+company))
      (break/debug "Respan pn from company-reports edge:  new case")
      (return-from Respan-pn-with-company-from-company-reports))

    (let ((company (third rpt-ref))
          (company-category
           (case (cat-symbol (edge-form pn-edge))
             (category::pronoun/inanimate category::company)
             (category::pronoun/possessive/inanimate category::company-possessive)
             (otherwise
              (break/debug "Unanticipated kind of form category")))))

      (make-new-edge-over-pronoun pn-edge
                                  company-category
                                  category::np
                                  company))))



;;------ person

(defun respan-pn-with-most-recent-person-anaphor (pn-edge)
  (multiple-value-bind (person-edge anaphor-table-entry)
                       (anaphor-with-category category::person)
    (declare (ignore anaphor-table-entry))

    (let ((person-category
           (case (cat-symbol (edge-form pn-edge))
             (category::pronoun/human/male   category::person)
             (category::pronoun/human/female category::person)
             (category::pronoun/possessive/human/male   category::person-possessive)
             (category::pronoun/possessive/human/female category::person-possessive)
             (otherwise
              (break/debug "Unanticipated kind of form category")))))
      
      (if person-edge
        (make-new-edge-over-pronoun pn-edge
                                    person-category
                                    category::np
                                    (edge-referent person-edge))
        (else
          (when *trace-pronominalization*
            (format t "~&~%No person available in the potential-anaphors ~
                       list for pn ~A~%" pn-edge))
          (make-new-edge-over-pronoun pn-edge
                                      person-category
                                      category::np
                                      :unresolved-person-anaphor)
          )))))


(defun respan-pn-with-person-from-person-reports (pn-edge
                                                  pers-rpts-edge)
  (let ((rpt-ref (edge-referent pers-rpts-edge)))
    (unless (and (composite? rpt-ref)
                 (eq (first rpt-ref) category::report+person))
      (format t "~%Respan pn from person-reports edge:  new case~%")
      (return-from Respan-pn-with-person-from-person-reports))

    (let ((person (third rpt-ref))
          (person-category
           (case (cat-symbol (edge-form pn-edge))
             (category::pronoun/human/male   category::person)
             (category::pronoun/human/female category::person)
             (category::pronoun/possessive/human/male   category::person-possessive)
             (category::pronoun/possessive/human/female category::person-possessive)
             (otherwise
              (break/debug "Unanticipated kind of form category")))))

      (make-new-edge-over-pronoun pn-edge
                                  person-category
                                  category::np
                                  person))))

