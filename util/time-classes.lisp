;;; -*- Mode: Lisp; Syntax: COMMON-LISP; Base:10; -*-
;;; $Id$
;;; Copyright (c) 2010 David D. McDonald

;; Derived from Poirot code, converted  10/28/10

(unless (find-package :time)
  (defpackage time
    (:use :common-lisp :ddm-util)))

(in-package :time)

;;;--------------------------------------
;;; class needed to hook up realizations
;;;--------------------------------------

(defclass realizable ()
  ((realization))
  (:documentation "Provides something for mumble:realization-for to
 sink its teeth into. Interpreted at runtime rather than load time."))


;;;-----------------------------------------
;;; top classes referred to by time classes
;;;-----------------------------------------

(defclass Ordered ()
    ((container) (previous) (next)))

(defclass Positioned (Ordered)
  ((eltPosition)))

(defclass MeasureWithLargerSmallerGrainSize ()
  ((larger) (smaller) (numberOfUnits)))



(defclass UnitOfMeasure ()
  ()
  (:documentation "Corresponds to a word that names the units in which something
 can be meaured; as in '15 ___ of stuff, e.g. 'feet', "))

(defclass Quantity ()
  ()
  (:documentation "Like a number, this is the answer to 'how many'. Linguistically
 it patterns just like a number in its ability to compose with units of
 measure and to act as a determiner, e.g. 'dozen', 'handfull'"))

(defclass Measurement ()
  ((measuredIn) ;;UnitOfMeasure)
  (quantity))
  (:documentation "This captures composites like '10 yards' or '2 months'.
 The quanity property should be an OR with number, which would come down
 to making the restriction a union of the two classes, but we don't have
 the syntax for that yet."))

;; (ddm 8/5/09) You can measure anything, and the act of measuring
;; deliniates an 'amount' of the stuff that you're measuring
;; e,g, "five cups of flour", "(I've only had) one good idea (all morning)"
;; That suggests pushing the restriction all the way up to Object
(defclass Amount ()
  ((measurment) ;; Measurement
   (stuff)) ;; Object
  (:documentation "Whenever you make a measurement you are measuring something.
 This class makes that explicit by reifying the 'chunk' or 'deliniation'
 of something that the measurement picks out. It couples the measurement,
 which is an abstract thing, with the thing being measured, which gives
 us a concrete thing that lets us, e.g., make comparisons over time:
 'My Aunt Jean has gotten shorter now that she's in her 90s'. (98 actually)
 Generally speaking Amounts should be interned, Measurements should
 not be."))


(defclass MeasureWithLargerSmallerGrainSize () ;; mixin
  ((larger) ;; UnitOfMeasure
   (smaller) ;; UnitOfMeasure
   (numberOfUnits)) ;; xsd@nonNegativeInteger
  (:documentation "There's a question of what to do when there are several
 ways to divide up a unit. Weeks are problematic since they don't
 fit evenly into any larger unit. If we want to represent several
 subdivisions we need to make this a class and treat it like
 a referenced interface.
   The number of units is the number of the smaller inside the larger."))


;;;----------------------------------------
;;;----------------------------------------
;;;      Calendar time and intervals      
;;;----------------------------------------
;;;----------------------------------------

;;--- mixins to organize the operations

(defclass CyclicalTemporalSequence
      (Ordered ;; previous, next, container
       Positioned) ;; eltPosition 
  ((previous) ;; (cardinality 1) - Time)
   (next) ;; (cardinality 1) - Time)
   (container))) ;; (cardinality 1) - Time))
;;//// without value restrictions of some sort these specializations
;; don't do anything for us. Need to modify defclass (or migrate to
;; a CLOS-enhanced defcategory) so we can have value restrictions
;; that are enforced at instantiation time.
(defclass TimeMeasureWithLargerSmallerGrainSize
      (MeasureWithLargerSmallerGrainSize)
  ((larger) ;; (cardinality 1) - UnitOfTime)
   (smaller))) ;; (cardinality 1) - UnitOfTime))

#+ignore ;; not used
(defclass TemporalOrderedSet ;; move to top -- not a mixin and generic
      (OrderedSet)
   (elt - Time))

(defclass SelfIndexingTime ()
   ((members))) ;; (cardinality 1) - TemporalOrderedSet))
      


;;------ The top of the time class hierarchy

(defclass Time ()
  ())
;  (realization (:kind "time"))
;  (:documentation "Undifferentiated time stuff. The root of all time sorts.
; Not a plausible referent for anything other than the word 'time'."))


(defclass TimeInterval
     ( Time 
		 Measurement)
  (starting ;; (cardinality 1) - TimePoint)
  (ending ;; (cardinality 1) - TimePoint)
  (duration - UnitOfTime) ;; should be Duration
  ;; but can't convert it over to Duration until the time.lisp code has been
  ;; modified to conform. It is using UnitOfTime which was, upon consideration
  ;; and the liberation of the symbol 'Duration, a mistake. However that's not
  ;; my highest priority just now (ddm 11/20/09)
  (:documentation 
"Represents a period of time with some non-trivial extent.
 The duration is usually measured in temporal units but in principle
 could be measured implicitly by reference to some process.  There is
 no commitment at this level as to whether we are talking about
 intervals in the abstract or actual particulars that have or will
 occur."))

(defclass TimePoint
       ( TimeInterval)
  (starting ;; (cardinality 0))
  (ending ;; (cardinality 0))
  (duration ;; (cardinality 0))
  (:documentation "Represents an atomic moment in time at some (so far implicit)
 grain size. At the relevant granuality at which thing of, e.g., a day
 as a point in time we are unconcerned with its latient properties
 qua TimeInterval. There is nothing inside it that we care about, which is
 what is meant by 'atomic'. If we shift to a finer granuality these properties
 will become salient and our perspective will shift."))


;;--- Next level down

(defclass GenericTime
     ( TimeInterval)
  (:documentation "This is the root of a set of classes that describe time without
 anchoring it to the time line."))

; When we say "Chirstmas is the 25th of December" we are making a
; statement that is true for all years. It is generic. When we say
; "Christmas falls on a Friday this year" we are talking about an
; actual day in an actual month. It has either transpired or it has
; not."

(defclass ActualTime 
     ( TimeInterval)
  (:documentation "This is the root of actual dates and the concrete components
 of date, past or future"))


(defclass TemporalIndexical
      ( Indexical Time)
  (date ;; (cardinality 1) - Date)
  (:documentation "Might not be the best name. Used for 'today', 'tomorrow', 
and 'yesterday'."))


;;--- Measurements of time

(defclass UnitOfTime
      ( UnitOfMeasure TimeMeasureWithLargerSmallerGrainSize)
  (indexicalProperty :self-indexing)
  (:documentation "The units used to measure time: seconds, decades, fortnights, etc."))

(defclass Duration
      ( Measurement)
  (measuredIn ;; (cardinality 1) - UnitOfTime)
  (indexicalProperty :self-indexing)
  (:documentation "A measurement involves a number or some other sort of 'counting'
 quantifier such 'a few' or 'several' plus the unit one is counting. This
 class says that the units must be units of time. Considered making this
 a subclass of Amount ('three dozen eggs') but that analysis is hard
 to sustain in the linguistic realizations since the fact that the stuff
 we are mesuring is ts@Time rarely comes out (??'three years worth of time')
 and the treatment of Amount is not the best since it submerges the
 measurement under a property."))


;;--- "Patterns" for expressing, usually actual, dates

(defclass DatePattern
      ( Pattern)
  (dayDigits (maxcardinality 1) - xsd@integer)
  (monthDigits ;; (cardinality 1) - xsd@integer)
  (yearDigits ;; (cardinality 1) - xsd@integer)
  (datePatternOrder ;; (cardinality 1) - Description)
  (indexicalProperty :self-indexing)
  (:documentation "Specifies the order and size of the number and slashes style of writing
 dates, e.g. 'MM/DD/YYYY'. The datePatternOrder is in practice going to be
 and arbitrary token that spells out the order -- something like US-Date vs.
 European-Date and the like."))



;;;----------------------------------------
;;; Classes & individuals for generic time
;;;----------------------------------------

;;--- Years

(defclass CycleOfYears
     ( CyclicalTemporalSequence)
  (previous - CalendarYear)
  (next - CalendarYear))

(defclass CalendarYear
     ( GenericTime CycleOfYears HasName SelfIndexingTime))
 ;; Century? Millenium?


;;--- Months

(defclass CycleOfMonths 
     ( CyclicalTemporalSequence)
  (previous - MonthOfTheYear)
  (next - MonthOfTheYear)
  (container - CalendarYear))

(defclass MonthOfTheYear
     ( GenericTime CycleOfMonths HasName SelfIndexingTime)
  (numberOfDays (maxcardinality 2) ;; leap years
	    - xsd@integer))

(defclass LeapYearMonthOfTheYear
     ( MonthOfTheYear)
  (:documentation "Only real impact is on the automatic calculation of days"))


;;--- Days

(defclass CycleOfDays
     ( CyclicalTemporalSequence)
  (previous - DayOfMonth)
  (next - DayOfMonth)
  (container - MonthOfTheYear))

(defclass DayOfMonth
     ( GenericTime CycleOfDays HasName)
  (month ;; (cardinality 1) - MonthOfTheYear))


;;--- Days of the week

(defclass CycleOfDaysOfTheWeek
     ( CyclicalTemporalSequence)
  (previous - DayOfWeek)
  (next - DayOfWeek))

(defclass DayOfWeek
     ( GenericTime CycleOfDaysOfTheWeek HasName))
  ;; name, previous, next, position. Unless what the container should be



;;---- Time of Day

(defclass TimeZone
     ( HasName)
  (shortName ;; (cardinality 1) - xsd@string) ;;//// elevate
  (deltaBehindUTC ;; (cardinality 1) - xsd@integer)
  (daylightTime ;; (cardinality 1) - exp@Boolean))
;; What more interesting superclasses do these two have?
;; They're descriptions of time stuff but not time stuff per se.
(defclass AntePostMeridian
     ( HasName))


(defclass CycleOfHoursOfTheDay
     ( CyclicalTemporalSequence)
  (previous ;; (cardinality 1) - HourOfDay)
  (next ;; (cardinality 1) - HourOfDay))

(defclass HourOfDay
     ( GenericTime CycleOfHoursOfTheDay HasName)
  (amOrPm ;; (cardinality 1) - AntePostMeridian)
  (timeZone ;; (cardinality 1) - TimeZone))

(defclass CycleOfMinutesInAnHour
     ( CyclicalTemporalSequence)
  ;; obviously only computed when we need it
  (previous ;; (cardinality 1) - MinuteOfHour)
  (next ;; (cardinality 1) - MinuteOfHour))

(defclass MinuteOfHour
     ( GenericTime CycleOfMinutesInAnHour HasName))


;;;------------------------
;;; Classes of actual time
;;;
;;; 10/29/09 added realizations here for year, month, hour, & minute.
;;; I'm not sure if that's a good idea or if we should only use the
;;; realizations for these found in the "units to measure time with"
;;; section at the end of this file...?
;;; Also, I'm not sure if specifying a category is appropriate or
;;; necessary, so maybe (:kind year "year") should be (:kind "year").
;;; - Charlie
;;;------------------------

(defclass ActualYear ;; maybe just compute them
     ( ActualTime CyclicalTemporalSequence 
		 HasName SelfIndexingTime)
;  (referenceYear ;; (cardinality 1) - CalendarYear)
;; Isn't clear whether the notion of a reference year buys us anything.
;; Waiting on a motivating example
  (previous - ActualYear)
  (next - ActualYear)
  (realization (:kind actual-year "year")))
  
(defclass MonthInYear
     ( ActualTime CyclicalTemporalSequence 
		 HasName SelfIndexingTime)
  (referenceMonth ;; (cardinality 1) - MonthOfTheYear)
  (year ;; (cardinality 1) - ActualYear)
  (indexicalProperty :self-indexing)
  (realization (:kind month-in-year "month")))

(defclass Date
     ( ActualTime CyclicalTemporalSequence
		 HasName SelfIndexingTime)
  (referenceDay ;; (cardinality 1) - DayOfMonth)
  (dayOfTheWeek ;; (cardinality 1) - DayOfWeek)
  (month  ;; (cardinality 1) - MonthInYear)
  (realization (:kind date "date")))

(defclass HourInDay
     ( ActualTime HasName SelfIndexingTime)
  (referenceHour ;; (cardinality 1) - HourOfDay)
  (day ;; (cardinality 1) - Date)
  (realization (:kind hour-in-day "hour")))

(defclass MinuteInHour
     ( ActualTime HasName SelfIndexingTime)
  (referenceMinute ;; (cardinality 1) - MinuteOfHour)
  (hour ;; (cardinality 1) - HourInDay)
  (realization (:kind minute-in-hour "minute")))


;;;--------------------
;;; Temporal Relations
;;;--------------------

;; The whole Allen calculus goes here. For now (9/10/09) just a taste

(defclass TemporalRelation ( Time Relation))

(defclass IntervalStartRelation
     ( TemporalRelation)
  (indexicalProperty :self-indexing))


(Individual IntervalStartRelation After
  (realization (:preposition temporal-relation "after")))
     ;; the :preposition realization mapping isn't working 11/01/09



;;;------------------
;;; instance objects
;;;------------------

;;--- Indexicals

;; These all have counterparts of the same name (lowercase) in the time
;; code that will calculate them with respect to 'now' and the system clock

(Individual TemporalIndexical Today
  (name "today")
  (realization (:indexical "today")))

(Individual TemporalIndexical Tomorrow
  (name "tomorow")
  (realization (:indexical "tomorow")))

(Individual TemporalIndexical Yesterday
  (name "yesterday")
  (realization (:indexical "yesterday")))

;; An unbounded number of compositional indexicals can be formed via phrases
;; like "the day after tomorrow" or "three weeks from Tuesday"


;;--- generic months

(Individual MonthOfTheYear January
  (name "January") (previous December) (next February) (eltPosition 1) (numberOfDays 31) (realization (:kind month-of-the-year "January")))

(Individual LeapYearMonthOfTheYear February
  (name "February") (previous January) (next March) (eltPosition 2) (numberOfDays 28) (realization (:kind month-of-the-year "February")))

(Individual MonthOfTheYear March
  (name "March") (previous February) (next April) (eltPosition 3) (numberOfDays 31) (realization (:kind month-of-the-year "March")))

(Individual MonthOfTheYear April
  (name "April") (previous March) (next May) (eltPosition 4) (numberOfDays 30) (realization (:kind month-of-the-year "April")))

(Individual MonthOfTheYear May
  (name "May") (previous April) (next June) (eltPosition 5) (numberOfDays 31) (realization (:kind month-of-the-year "May")))

(Individual MonthOfTheYear June
  (name "June") (previous May) (next July) (eltPosition 6) (numberOfDays 30) (realization (:kind month-of-the-year "June")))

(Individual MonthOfTheYear July
  (name "July") (previous June) (next August) (eltPosition 7) (numberOfDays 31) (realization (:kind month-of-the-year "July")))

(Individual MonthOfTheYear August
  (name "August") (previous July) (next September) (eltPosition 8) (numberOfDays 31) (realization (:kind month-of-the-year "August")))

(Individual MonthOfTheYear September
  (name "September") (previous August) (next October) (eltPosition 9) (numberOfDays 30) (realization (:kind month-of-the-year "September")))

(Individual MonthOfTheYear October
  (name "October") (previous September) (next November) (eltPosition 10) (numberOfDays 31) (realization (:kind month-of-the-year "October")))

(Individual MonthOfTheYear November
  (name "November") (previous September) (next December) (eltPosition 11) (numberOfDays 30) (realization (:kind month-of-the-year "November")))

(Individual MonthOfTheYear December
  (name "December") (previous November) (next January) (eltPosition 12) (numberOfDays 31) (realization (:kind month-of-the-year "December")))

     
;;--- generic days of the week

(Individual DayOfWeek Sunday
   (name "Sunday") (previous Saturday) (next Monday) (eltPosition 1) (realization (:kind day-of-week "Sunday")))

(Individual DayOfWeek Monday
   (name "Monday") (previous Sunday) (next Tuesday) (eltPosition 2) (realization (:kind day-of-week "Monday")))

(Individual DayOfWeek Tuesday
   (name "Tuesday") (previous Monday) (next Wednesday) (eltPosition 3) (realization (:kind day-of-week "Tuesday")))

(Individual DayOfWeek Wednesday
   (name "Wednesday") (previous Tuesday) (next Thursday) (eltPosition 4) (realization (:kind day-of-week "Wednesday")))

(Individual DayOfWeek Thursday
   (name "Thursday") (previous Wednesday) (next Friday) (eltPosition 5) (realization (:kind day-of-week "Thursday")))

(Individual DayOfWeek Friday
   (name "Friday") (previous Thursday) (next Saturday) (eltPosition 6) (realization (:kind day-of-week "Friday")))

(Individual DayOfWeek Saturday
   (name "Saturday") (previous Friday) (next Sunday) (eltPosition 7) (realization (:kind day-of-week "Saturday")))


(Individual AntePostMeridian am (name "a.m.") (realization (:kind ante-post-meridian "a.m.")))
(Individual AntePostMeridian pm (name "p.m.") (realization (:kind ante-post-meridian "p.m.")))


;  Can't evaluate the duration until the time code is loaded,
;  which is after this ontology has been loaded -- so compute these.
;(Individual TimeZone EDT 
;  (name "Eastern Daylight Time")
;  (shortName "EDT")
;  (deltaBehindUTC (make-duration 5 'Hour))
;  (daylightTime exp@True))


;;;-------------
;;; actual time
;;;-------------

;; Actual years, months, etc. are built by construction. 
;; See /ltml/src/lisp/time.lisp


;;;----------------------------
;;; units to measure time with
;;;----------------------------

(Individual UnitOfTime Year
  (smaller Month)
  (realization (:kind unit-of-time "year")))

(Individual UnitOfTime Month
  (smaller Week)
  (larger Year)
  (numberOfUnits 12)
  (realization (:kind unit-of-time "month")))

(Individual UnitOfTime Week
  (smaller Day)
  (larger Month)
  (numberOfUnits 52)
  (realization (:kind unit-of-time "week")))

(Individual UnitOfTime Day
  (smaller Hour)
  (larger Week)
  (numberOfUnits 24)
  (realization (:kind unit-of-time "day")))

(Individual UnitOfTime Hour
  (smaller Minute)
  (larger Day)
  (numberOfUnits 24)
  (realization (:kind unit-of-time "hour")))

(Individual UnitOfTime Minute
  (smaller  Second)
  (larger Hour)
  (numberOfUnits 60)
  (realization (:kind unit-of-time "minute")))

(Individual UnitOfTime Second
  ;; Could obviously go lower, but isn't relevant ot our usual work
  (larger Minute)
  (numberOfUnits 60)
  (realization (:kind unit-of-time "second")))


;;-- Useful durations

(Individual Duration one-day
   (measuredIn ts@Day)
   (quantity 1))


;;;----------------------------------------------------
;;---- Legacy notion of time, i.e. unanalyzed strings
;;     Should not get into MDIS
;;;----------------------------------------------------

;;; The form is ddd hh:mm or hh:mm -- goes on value property
(defclass TimeLength ( Time ID))

;; Moved Duration to trans@ (10/23/09 ddm)


;; FixedTime has hundreds of references, so routing it out is unlikely
;; to be worth the effort.
(defclass FixedTime
  ;( hobbs@CalendarClockDescription)
  ;(hobbs@minutes ;; (cardinality 1) - xsd@decimal)
  ( TimeLength))
