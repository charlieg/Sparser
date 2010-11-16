;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993,1994,1995 David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "stranded VP"
;;;   Module:  "grammar;rules:CA:"
;;;  Version:  0.1 April 1995

;; initiated 7/16/93 v2.3, fleshed out the edge building 8/4
;; 0.1 (4/26/95) added case for 'subj , vp'

(in-package :sparser)


(set-ca-action  category::VP  'VP-Ca-dispatch)
  ;; reacts to the form-category on a stranded edge



(defun vP-CA-dispatch (vp-edge)

  ;; common dispatch point for trying to connect up VPs that are
  ;; stranded after their portion of the forest level has gone
  ;; quiescent.  Only two cases for the moment: participles and
  ;; subject search across appositives.  /// add check against
  ;; sentence-start (for imperatives) and gathering information
  ;; from the tense/aspect of the VG. 

  (if (comma-just-before-edge? vp-edge)
    (then
      (tr :comma-to-left-of-vp vp-edge)
      (let ((prior-edge  ;; just to the left of the comma
             (edge-ending-at (chart-position-before
                              (pos-edge-starts-at vp-edge)))))
        (if prior-edge
          (if (eq (edge-form prior-edge) category::S )
            ;; if the prior edge is a clause then we'll assume
            ;; we're a participle //// without bothering to check the
            ;; form of our verb (i.e. that it's oblique).
            (let ((higher-subject
                   (extract-subject-from-clause prior-edge)))
              
              (if higher-subject
                (then ;; complete the equivalent clause for this vp
                  (tr :upstairs-subject-found higher-subject)
                  (span-participial-adjunct vp-edge
                                            prior-edge
                                            higher-subject))
                (else
                  (tr :higher-subject-not-found prior-edge))))
            (else
              ;; There's an edge, but it isn't an S.  Maybe it's
              ;; the subject that this vp is looking for.
              (subject-search/check-adjacent-edge/comma prior-edge vp-edge)))
          (else
            ;; there's no edge adjacent to the comma, just some unknown
            ;; word, so we search for a suitable subject somewhere to 
            ;; the left ///pick this up for non-S adjacent edges as well
            (subject-search/adjacent-comma/no-adj-edge vp-edge)))))

    (else
      (subject-search/walk-leftwards-no-comma vp-edge))))





(defun span-participial-adjunct (vp s subject)

  ;; We care less about the derived constituent structure than
  ;; about getting the right slots filled in the VP's denotation
  ;; We Chomsky-adjoin the vp to the s, and then look up the
  ;; appropriate subject rule (//not checking form passives) and
  ;; do it's semantic part.

  (make-chart-edge :left-edge s   ;;n.b. the comma gets stranded
                   :right-edge vp
                   :category (edge-category s)
                   :form (edge-form s)  ;; note the different fringe ??
                   :referent (edge-referent s)
                   :rule :S-comma-VP )

  (let ((subj-rule (subject-rule (edge-referent vp))))
    ;; if we execute the referent part of the rule we'll get the
    ;; the unit that we would have if the rule had been encountered
    ;; in the normal course of events.   Probably the right thing
    ;; happened just by side-effect since the vp holds the individual
    ;; to which the subject is probably just another binding, 
    ;; but we explicitly set the referent here just in case the
    ;; semantic interpretation changes the type or instantiates a
    ;; new object, though that seems unlikely
    (when subj-rule
      (let ((unit (referent-from-rule nil  ;; left-edge
                                      vp   ;; right-edge
                                      vp   ;; parent-edge
                                      subj-rule
                                      :left-ref  subject)))

        (setf (edge-referent vp) unit)))))
       



(defun subject-rule (unit)
  (let* ((type (etypecase unit
                 (referential-category unit)
                 (individual (car (indiv-type unit)))))
         (rules (cadr (member :rules (cat-realization type)))))

    (dolist (cfr rules)
      ;; the list is usually about half a dozen items, with the
      ;; phrasal cases at the beginning, so this serial search
      ;; isn't so bad
      (when (eq :subject
                (cadr (member :relation (cfr-plist cfr))))
        (return-from Subject-rule cfr)))

    (tr :couldnt-find-subject-rule unit type)
    nil ))




;;;--------
;;; traces
;;;--------


(deftrace :comma-to-left-of-vp (vp-edge)
  (when *trace-ca*
    (trace-msg "Triggering CA search because of the comma to the left ~
                of~%the stranded VP: ~A" vp-edge)))

(deftrace :upstairs-subject-found (indiv)
  (when *trace-ca*
    (trace-msg "Identified ~A~
                ~%   as the unit that is the subject of the S to the ~
                left" indiv)))

(deftrace :higher-subject-not-found (prior-edge)
  (when *trace-ca*
    (trace-msg "Could not locate the subject in ~A" prior-edge)))


(deftrace :couldnt-find-subject-rule (unit type)
  (when *trace-ca*
    (trace-msg "Could not find the subject rule for ~A~
                ~%  which is the primary type of ~A"
               type unit)))

