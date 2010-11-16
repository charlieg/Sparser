;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1992,1993,1994,1995,1996 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "fiscal"
;;;   Module:  "model;core:time:"
;;;  version:  1.0 January 1996

;; 1.0 (12/15/92 v2.3) setting up for new semantics.
;;     (12/20/95) actually putting them in. Elaborating through 1/8/96.
;;     (1/13) moved the cs rules.

(in-package :sparser)

;;;-----------------------
;;; specific fiscal years
;;;-----------------------

(define-category fiscal-year
  :specializes time
  :instantiates self
  :binds ((year . year)
          (starting-point . date)
          (ending-point . date))
  :index (:temporary :key year))

#| Without mention of the starting/ending time, this will default to
 a calendar year.  Given a specific start/end then the 'year' amounts
 to a name since its relationship to the calendar year with that name
 is pretty arbitrary.  |#

;;--- rules

;; hmm... no 'common noun as category' analysis. This is quicker,
;; but will it lose some opportunity later?
;;
(def-cfr fiscal-year ("fiscal year" year)
  :form np
  :referent (:instantiate-individual fiscal-year
             :with (year right-edge)))

(def-cfr fiscal-year ("fiscal" year)
  :form np
  :referent (:instantiate-individual fiscal-year
             :with (year right-edge)))


;;--- prepositions

(def-cfr for-fiscal-year ("for" fiscal-year)
  :form pp
  :referent (:daughter right-edge))

(def-cfr in-fiscal-year ("in" fiscal-year)
  :form pp
  :referent (:daughter right-edge))

(def-cfr of-fiscal-year ("of" fiscal-year)
  :form pp
  :referent (:daughter right-edge))


;;;--------------------------------------------------------
;;; The category for "first quarter", "three months", etc.
;;;--------------------------------------------------------

(define-category part-of-a-fiscal-year
  :specializes time
  :instantiates self
  :binds ((selector . ordinal)  ;; "first", "second"
          (unit . fractional-term)   ;; "quarter", "half" but not "third"
          (fiscal-year . fiscal-year)
          (ending-point)
          (starting-point)))





;;--- prepositions

(def-cfr for-part-of-a-fiscal-year ("for" part-of-a-fiscal-year)
  :form pp
  :referent (:daughter right-edge))

(def-cfr in-part-of-a-fiscal-year ("in" part-of-a-fiscal-year)
  :form pp
  :referent (:daughter right-edge))


(def-form-rule (preposition part-of-a-fiscal-year)
  :form pp
  :referent (:daughter right-edge))





;;;--------------------------------------
;;;  part-of-a-fiscal-year + fiscal-year
;;;--------------------------------------

;; "first quarter of fiscal 1996"
;;
(def-cfr part-of-a-fiscal-year (part-of-a-fiscal-year of-fiscal-year)
  :form np
  :referent (:head left-edge
             :bind (fiscal-year right-edge)))


;; "first quarter fiscal 1996"
;;
(def-cfr part-of-a-fiscal-year (part-of-a-fiscal-year fiscal-year)
  :form np
  :referent (:head left-edge
             :bind (fiscal-year right-edge)))


;; "first three months of fiscal 1996"
;;
(def-cfr part-of-a-fiscal-year (fraction-of-amount-of-time of-fiscal-year)
  :form np
  :referent (:instantiate-individual part-of-a-fiscal-year
             :with (selector left-edge
                    fiscal-year right-edge)))


;; (I think I saw this) "fiscal 1995 second quarter"
;;
(def-cfr part-of-a-fiscal-year (fiscal-year part-of-a-fiscal-year)
  :form np
  :referent (:head right-edge
             :bind (fiscal-year left-edge)))



;; "During the first six months of fiscal 1996"
;;    -- seems safe to throw away the "during", though if the sequencer
;;    were something like "after" then this treatment will probably 
;;    probably lose information that would be valuable
;;
(def-cfr part-of-a-fiscal-year (sequencer part-of-a-fiscal-year)
  :form pp
  :referent (:daughter right-edge))





;;;------------------------------
;;; stating the start/end points
;;;------------------------------

;; "ending Oct. 31"
(def-cfr ending-date (end day-of-the-month)
  :form participle
  :referent (:daughter right-edge))


;; "ended Oct. 31, 1995"
(def-cfr ending-date (end date)
  :form participle
  :referent (:daughter right-edge))

;; n.b. the verb "end" is in [semantics-free verbs]





;;;----------------------------------------
;;; compositions with the start/end points
;;;----------------------------------------

;; "six months ended Oct. 31, 1995"
;;
(def-cfr part-of-a-fiscal-year (amount-of-time ending-date)
  :form np
  :referent (:instantiate-individual part-of-a-fiscal-year
             :with (selector left-edge
                    unit left-edge ;; ///yeuch, but we need the index
                    ending-point right-edge)))


;; "second quarter ended Oct. 31, 1995"
;;
(def-cfr part-of-a-fiscal-year (part-of-a-fiscal-year ending-date)
  :form np
  :referent (:daughter left-edge
             :bind (ending-point right-edge)))



;;--- article gets lost //perhaps we're going to np too soon?

;; "for the six months ended Oct. 31"
(def-form-rule ("the" np)
  :form np
  :referent (:daughter right-edge))




;;;--------------------
;;; definite reference
;;;--------------------

(defun dereference-fraction-term-as-part-of-fiscal-year (fraction-term)
  ;;// this should be generalized once we have the ability
  ;; to walk up the 'used-in' view of the rule-set and see what
  ;; consumers of "quarter" there would be that would fit in the
  ;; ongoing context.
  (let ((pofy/dh (discourse-entry (category-named 'part-of-a-fiscal-year))))
    (if pofy/dh
      (let ((choice (most-recently-mentioned pofy/dh)))
        (if choice
          choice
          fraction-term )) ;; i.e. the category, just so there's a value for the referent
      fraction-term )))


(def-cfr part-of-a-fiscal-year ("the" quarter)
  :form np
  :referent (:function dereference-fraction-term-as-part-of-fiscal-year
                       right-edge))


(def-cfr part-of-a-fiscal-year ("the" period)
  :form np
  :referent (:function dereference-fraction-term-as-part-of-fiscal-year
                       right-edge))
