;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; Copyright (c) 2009-2010 BBNT Solutions LLC. All Rights Reserved
;;; $Id$
;;;
;;;      File:  "loader"
;;;    Module:  "grammar/model/sl/poirot/"
;;;   version:  February 2010

;; initiated 8/31/09. Elaborated through 9/17

(in-package :sparser)

;; "MOB date must be greater than 10 days after today's date"


;; "10 days" -> ts@Duration

(in-package :ltml)

(defmethod instantiate-measurement ((quantity sparser::individual)
				    (unit ts@UnitOfTime))
  ;;/// Once we shift over to implicit classes, then the 'quantity'
  ;; can be narrowed to 'sparser:number or some such
  ;; (break "quantity = ~a  unit = ~a" quantity unit)
  (let ((n (sparser::number-value quantity)))
    (ltml::instantiate-SFL-concept 'ts@Duration
	:property-value-pairs `(:top@quantity ,n
				:top@measuredIn ,unit))))

(in-package :sparser)

(def-form-rule (number common-noun/plural)
    :form np
    :new-category amount-of-time
    :referent (:function ltml::instantiate-measurement left-edge right-edge))
(def-form-rule-to-AP (number common-noun/plural)
    quantifier-premod)


;; "January 5" -> ts@Date (work in progress)

(in-package :ltml)

(defmethod instantiate-month-dd ((month ts@MonthOfTheYear)
				    (day sparser::individual))
  (let* ((n (sparser::number-value day))
	 (d (ltml::instantiate-SFL-concept 'ts@DayOfMonth
					   :property-value-pairs `(:ts@month ,month
								   :top@eltPosition ,n)))
	 (m (ltml::instantiate-SFL-concept 'ts@MonthInYear
					   :property-value-pairs `(:ts@referenceMonth ,month))))
    (ltml::instantiate-SFL-concept 'ts@Date
				   :property-value-pairs `(:ts@month ,m
							   :ts@referenceDay ,d))))

(in-package :sparser)

(def-form-rule (common-noun number)
    :form np
    :new-category month-dd
    :referent (:function ltml::instantiate-month-dd left-edge right-edge))
(def-form-rule-to-AP (common-noun number)
    quantifier-postmod)

;;--- today's date

(defmethod generalized-possession ((who ltml::ts@TemporalIndexical) ;; left
				   (what ltml::OwlClass))           ;; right
  ;; The indexical is something like 'today'. 
  ;; The class is effectively the restriction on some slot on the
  ;; indexical. In our canonical example it's the 'date' slot.
  ;; We want to return the value of slot for the indexical.
  ;(break "who = ~a  what = ~a" who what)
  ;; Under time constraints for a demo -- making an assumption about
  ;; the class and property rather than doing it straight
  (push-debug `(,who ,what))
  (unless (eq (co:name what) 'ltml::ts@Date)
    (error "Stub that only handles ts@Date's for its 'what'~
          ~%Instead got ~a" what))
  (let ((date (ltml::ts@date who)))
    (format t "~&date = ~a~%" date)
    date))


;; Poo! Form rules elevate the category of the form edge, so when we
;; apply this to "today's date" the label on the edge is 'today',
;; which isn't the correct head.
;;//// Need a variant on form rules to cover this case when we're
;; not operating on the head as we normally are. Presumably an
;; additional field will suffice. 
;(def-form-rule (possessive date)
;    :form np
;    :referent (:function generalized-possession left-edge right-edge))

;; Hack hack
(def-cfr date (today date)
  :form np
  :referent (:function generalized-possession left-edge right-edge))



;;--- "after today's date"

(in-package :ltml)

(defmethod define-interval-start ((relation ts@IntervalStartRelation)
				  (date ts@Date))
  (instantiate-SFL-concept 'ts@TimeInterval
      :property-value-pairs `(:ts@starting ,date)))
  
(in-package :sparser)

(def-cfr relative-date (temporal-relation date)
  ;; As an alternative to the specific lable of temporal-relation
  ;; could use/adapt the build-in category 'sequencers' which gets
  ;; prepositions like "before" or "during". Since these apply to
  ;; both time and space (at least), the generalization makes sense.
  :form pp
  :referent (:function ltml::define-interval-start left-edge right-edge))


;;--- "10 days after today's date"

;; What would be best would be to have the amount, which is an np,
;; look at the referent of the pp and decide whether that's something
;; that is compatible with it semantically. For the time being,
;; we'll need something ad-hoc to dates and amounts-of-time 
;; (ts@TemporalMeasure).
(in-package :ltml)

(defmethod define-interval-duration ((amount ts@Duration)
				     (interval ts@TimeInterval))
  (setf (top@quantity interval) amount)
  interval)

(in-package :sparser)

(def-cfr date (amount-of-time relative-date)
  :form np
  :referent (:function ltml::define-interval-duration left-edge right-edge))



;;--- "greater than <amount>"

;; When we have the full sentence ("MOB date must be <amount>" then stating
;; a 3-term relationship seems clear enough. But this predicate adjective
;; by itself is something different.
;;   It seems like what we have here is a function that takes a 'subject'
;; and states the relationship that it has to this amount (of time).
;; Of course we don't have those sorts of things in Poirot (though they're
;; natural to Sparser), so it has to be something different.

(in-package :ltml)

#|
   instantiate-SFL-concept top@ThreePlacePredicate
        :top@predicate ,comparative
        :top@object ,date

   instantiate-SFL-concept top@OpenPredicate
        :top@relation ,tpp
        :top@openVariable ,(lookup 'top@subject)
|#

(in-package :sparser)

(def-cfr date (comparative date)
  :form adjp ;; "Adjective Phrase" In this case the comparative
  ;; is taking the date as its np complement to form an adjp.
  :referent ;;(:function ltml::XXXX left-edge right-edge))
  ;; Here's something so that it won't simply die when we get here.
  ;; The classes sketched just above are possibilities, but need 
  ;; to work it out with Mark and wait for the whole thing.
  ;; Cries out for a PSI treatment, but that means shadowing the
  ;; relevant classes in Krisp so not going there yet (9/14/09 ddm)
     (:daughter right-edge))

