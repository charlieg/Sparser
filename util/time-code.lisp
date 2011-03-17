;;; -*- Mode: Lisp; Syntax: COMMON-LISP; Base:10; -*-
;;; $Id$
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved

(in-package :ltml)

#|  Known bugs (10/4/09)

--The initialization of the days of the week may be wrong.
  It thinks that Wednesday 8/6 is actually a Monday, though it correctly
    established that 8/1 was a Saturday -- but it has the 31st as a Tuesday
    when it's actually a Monday.
-- Durations are specified by units of time rather than instances of Duration

12/8/09 -- DOW are definitely wrong. Projecting out to create 8/5/2010 it
  declares that it's a Saturday when actually it's a Thursday.

-- Actual months of 2009 are not being created with the correct scope
though the pattern seems to be the same as for actual years and don't get
indexed for lookup.

12/2/09

The last day of December 2009 isn't created and associated with that
actual month. This causes the code that would create 1/1/10 given
12/31/09 (n-days-from-now) to die because it can't compute the day of
the week.


|#

;;;-------------------------------
;;; initialization of actual time
;;;-------------------------------

;; (initialize-time-to-first-day-of-year "1/1/2009" 'Thursday)
(defmethod initialize-time-to-first-day-of-year ((date-string string)
                                                 (day-of-the-week symbol))
  ;; Create the first and last days of each month, generic and actual
  ;; Create last year and next year but don't initialize them.
  ;; The input is a string in month/date/year format plus the day of the week
  ;; that date falls on. The intended use is that we specify the first day
  ;; of the year, e.g. "1/1/2009" 'Thursday.
  (when (null date-string)
    (setq date-string *stipulated-start-date*
          day-of-the-week 'Thursday)) ;;/// if one is parameterized so should the other
  (initialize-the-generic-months)
  (initialize-the-generic-hours-of-the-day)
  (multiple-value-bind (day-string month-string year-string)
      (extract-components-of-date-string date-string)
    (let ((year (find-or-make-year year-string))) ;; actual year
      (initialize-year year day-of-the-week)
      (values (find-or-make-date day-string month-string year-string day-of-the-week)
              (today))))) ;; (lookup 'ts@Today)



(defun initialize-the-generic-months ()
  (dolist (month-name '(ts@January ts@February ts@March ts@April ts@May ts@June
                        ts@July ts@August ts@September ts@October ts@November
                        ts@December))
    (let ((month (lookup month-name)))
      (find-or-make-generic-day-in-month 1 month)
      (find-or-make-generic-day-in-month (numberOfDays month) month))))

(defun initialize-the-generic-hours-of-the-day ()
  (loop for i from 1 to 24
       with first-hour = nil
       and previous-hour = nil
     do
    (let* ((tag-symbol (ltml-intern (string-append "ts@" i)))
           (am/pm (determine-am-vs-pm i))
           (timezone (lookup 'ts@EDT)) ;; probably should be a parameter
           (name (string-append i  " o'clock " (name am/pm)))
           (hour (instantiate-SFL-concept 'ts@HourOfDay :tag tag-symbol :env (ns-env 'ts)
                                          :property-value-pairs
                                            `(:top@name ,name
                                              :top@eltPosition ,i
                                              :ts@amOrPm ,am/pm
                                              :ts@timeZone ,timezone
                                              :ts@duration ,(lookup 'ts@Hour)))))
      (when (= i 1)
        (setq first-hour hour))
      (when (= i 24)
        (setf (next hour) first-hour)
        (setf (previous first-hour) hour))
      (when previous-hour
        (setf (next previous-hour) hour)
        (setf (previous hour) previous-hour))
      (setq previous-hour hour))))





(defmethod initialize-year ((year ts@ActualYear) (first-day-of-the-week symbol))
  (let ((fdow (lookup first-day-of-the-week (ns-env 'ts))))
    (initialize-year year fdow)))

(defmethod initialize-year ((year ts@ActualYear) (first-day-of-the-week ts@DayOfWeek))
  (make-year-before year) ;; these are actually find-or-make
  (make-year-after year)
  (initialize-the-actual-months-of year first-day-of-the-week))

(defmethod initialize-the-actual-months-of ((year ts@ActualYear)
                                            (first-day-of-the-week symbol))
  (let ((first-day (lookup first-day-of-the-week (ns-env 'ts))))
    (initialize-the-actual-months-of year first-day)))

(defmethod initialize-the-actual-months-of ((year ts@ActualYear)
                                            (first-day ts@DayOfWeek))
  (let ((day-of-the-week (find-previous first-day 1))) ;; index
    (dolist (month-name '(ts@January ts@February ts@March ts@April ts@May ts@June
                          ts@July ts@August ts@September ts@October ts@November
                          ts@December))
      (let* ((generic-month (lookup month-name))
             (actual-month (find-or-make-actual-month generic-month year)))
        (setq day-of-the-week (find-next day-of-the-week 1))
        ;(break "~a starts on a ~a" generic-month day-of-the-week)
        (find-or-make-date 1 actual-month year day-of-the-week)
        (setq day-of-the-week (find-next day-of-the-week
                                         (1- (numberOfDays generic-month))))
        ;(break "~a ~a is a ~a" month-name (numberOfDays generic-month) day-of-the-week)
        (find-or-make-date (numberOfDays generic-month) actual-month year
                           day-of-the-week)))))


;;;------------
;;; indexicals
;;;------------

(defmethod now (&optional (description string))
  "Constructs the time object that represents the present time, either
 taken from the system clock if no argument is given or from that
 description, which should be a string in a conventional format
 such as '4/27/2009'."
  ;; this variable binding does nothing but generate compiler warnings, so I
  ;; killed it. [2009/11/09:rpg]
  ;;(multiple-value-bind (hour minute second daylight-savings-time-p time-zone)
      (extract-m-h-s-etc-from-system-time)
;;)
)

(defmethod today ()
  "Returns the current ts@Date by reading the system clock. Sets the
   indexical of the same name."
  (multiple-value-bind (day-number month-number year-number dow-number)
      (extract-d-m-y-dow-from-system-time)
    (let ((date (find-or-make-date day-number month-number
                                   year-number dow-number))
          (i (lookup 'ts@Today)))
      (setf (ts@date i) date)
      date)))

(defun tomorrow ()
  (let ((date (n-days-from-now (today) 0))
        (i (lookup 'ts@Tomorrow)))
    (setf (ts@date i) date)
    date))


(defmethod this-year (&optional numberForYear)
  (unless numberForYear
    (setq numberForYear (extract-year-from-system-time)))
  (find-or-make-year numberForYear))


;;;--------------
;;; Constructors
;;;--------------

;;--- Actual Years

(defmethod find-or-make-year ((year integer))
  (find-or-make-year (format nil "~a" year)))

(defmethod find-or-make-year ((yearString string))
  "Doesn't make the years before or after since that would lead to an infinite loop"
  (when (= 2 (length yearString))
    (setq yearString (extrapolate-year-string-from-two-digits yearString)))
  (let ((name (ltml-intern (string-append "ts@" yearString))))
    (or (lookup name)
        (instantiate-SFL-concept 'ts@ActualYear :tag name :env (ns-env 'ts)
                                 :property-value-pairs
                                     `(:top@name ,yearString
                                       :top@eltPosition ,(read-from-string yearString)
                                       :ts@duration ,(lookup 'ts@Year))))))

(defmethod make-year-before ((year ts@ActualYear))
  (or (previous year)
      (let* ((this-year# (eltPosition year))
             (year-before# (1- this-year#))
             (year-before (find-or-make-year (format nil "~a" year-before#))))
        (setf (next year-before) year)
        (setf (previous year) year-before)
        year-before)))

(defmethod make-year-after ((year ts@ActualYear))
  (or (next year)
      (let* ((this-year# (eltPosition year))
             (year-after# (1+ this-year#))
             (year-after (find-or-make-year (format nil "~a" year-after#))))
        (setf (next year) year-after)
        (setf (previous year-after) year)
        year-after)))


;;--- Actual Months

(defmethod find-or-make-actual-month ((month-string string) (year ts@ActualYear))
  (let ((generic-month (lookup-month-by-position (read-from-string month-string))))
    (find-or-make-actual-month generic-month year)))

(defmethod find-or-make-actual-month ((month-number integer) (year ts@ActualYear))
  (let ((generic-month (lookup-month-by-position month-number)))
    (find-or-make-actual-month generic-month year)))


(defmethod find-or-make-actual-month ((generic-month ts@MonthOfTheYear)
                                      (year ts@ActualYear))
  (or (find generic-month (members year) :key #'referenceMonth :test #'eq)
      (let* ((name (concat "ts@" (name generic-month) (name year)))
             (miy (instantiate-SFL-concept
                   'ts@MonthInYear :tag name :env (ns-env 'ts)
                   :property-value-pairs
                      `(:ts@referenceMonth ,generic-month
                        :top@name ,(string-append (name generic-month) " "
                                              (name year))
                        :top@eltPosition ,(eltPosition generic-month)
                        :ts@year ,year))))
        (push miy (members year))
;; These need a day of the week passed in, and the appropriates calculation
;; made for the dow of the last day.
;       (find-or-make-date 1 miy year)
;       (find-or-make-date (numberOfDays generic-month) miy year)
        miy)))



;;--- Generic Days

(defmethod find-or-make-generic-day-in-month ((number integer) (month string))
  (let ((m (lookup-type month 'ts@MonthOfTheYear (ns-env 'ts))))
    (unless m (error "No MonthOfTheYear named ~a" month))
    (find-or-make-generic-day-in-month number m)))

(defmethod find-or-make-generic-day-in-month ((number integer) (month ts@MonthOfTheYear))
  ;;/// This populates the entire month because it sets the previous and next fields
  ;; of the day, which wasn't the original intention. But is 365 individuals interestingly
  ;; different from 24 since computations over days are likely to be frequent?
  (when (or (<= number 0) (> number (numberOfDays month)))
    (error "The date number ~a is out of range for ~a" number month))
  (let ((list (members month)))
    (or (find number list :key #'eltPosition :test #'eql)
        (let* ((name (concat (name month) number))
               (dom (instantiate-SFL-concept
                     'ts@DayOfMonth :tag name :env (ns-env 'ts)
                     :property-value-pairs `(:ts@month ,month
                                             :top@name ,(format nil "~a" number)
                                             :top@eltPosition ,number))))
          (push dom (members month)) ;; index it locally
          (setf (duration dom) (lookup 'ts@Day)) ;;(lookup 'ts@one-day)) ;; a day is a Day long
          (unless (= number 1)
            (let ((yesterday
                   (find-or-make-generic-day-in-month (1- number) month)))
              (setf (previous dom) yesterday)))
          (unless (= number (numberOfDays month))
            (let ((tomorrow
                   (find-or-make-generic-day-in-month (1+ number) month)))
              (setf (next dom) tomorrow)))
          (setf (container dom) month)
          dom))))



;;--- Actual Days

(defmethod string-to-date (date-string  &optional day-of-the-week)
  (multiple-value-bind (day-string month-string year-string)
      (extract-components-of-date-string date-string)
    (let* ((year (find-or-make-year year-string))
           (month (find-or-make-actual-month month-string year)))
      (find-or-make-date day-string month year day-of-the-week))))

(defun string-to-date/or-pattern (string)
  ;; handles ambiguity of type within mdis date generator D-CALC services
  (if (or (search "MM" string)
          (search "mm" string))
    (find-or-make-date-pattern string)
    (string-to-date string)))

;;;---------------------------------------------------------------------------
;;; There was a syntactic mixup here --- the optional arguments had type
;;; specifications, which they can't have in CLOS.  I pushed the type
;;; specifications into ASSERT forms I hope to be equivalent. [2010/01/28:rpg]
;;;---------------------------------------------------------------------------

(defmethod find-or-make-date ((day integer) (month integer) (year integer) &optional dow)
  (assert (or (null dow) (integerp dow)))
  (let ((actual-year (find-or-make-year year)))
    (find-or-make-date day
                       (find-or-make-actual-month month actual-year)
                       actual-year
                       (lookup-day-of-the-week-by-position dow))))

(defmethod find-or-make-date ((day string) (month string)
                              (year string) &optional day-of-the-week)
  (assert (or (null day-of-the-week) (symbolp day-of-the-week)))
  (let* ((actual-year (find-or-make-year year))
         (actual-month (find-or-make-actual-month month actual-year)))
    (find-or-make-date day actual-month actual-year day-of-the-week)))

(defmethod find-or-make-date ((day string) (month ts@MonthInYear)
                              (year ts@ActualYear) &optional day-of-the-week)
  (assert (or (null day-of-the-week) (symbolp day-of-the-week)))
  (let ((dow (lookup day-of-the-week (ns-env 'ts))))
    (find-or-make-date (read-from-string day) month year dow)))

(defmethod find-or-make-date ((day integer) (month ts@MonthOfTheYear)
                              (year ts@ActualYear) &optional day-of-the-week)
  (assert (or (null day-of-the-week) (typep day-of-the-week 'ts@DayOfWeek)))
  (let ((actual-month (find-or-make-actual-month month year)))
    (find-or-make-date day actual-month year day-of-the-week)))

(defmethod find-or-make-date ((day integer) (month ts@MonthInYear)
                              (year ts@ActualYear) &optional day-of-the-week)
  (assert (or (null day-of-the-week) (typep day-of-the-week 'ts@DayOfWeek)))
  (unless day-of-the-week
    (setq day-of-the-week (calculate-day-of-the-week day month year)))
  (let ((generic-day (find-or-make-generic-day-in-month day (referenceMonth month))))
    (or (find day (members month) :key #'eltPosition :test #'eql)
        (let* ((name (ltml-intern
                      (format nil "ts@~2,'0d/~2,'0d/~4,'0d" 
			      (eltPosition month) day (name year))))
               (date (instantiate-SFL-concept
                      'ts@Date :tag name :env (ns-env 'ts)
                      :property-value-pairs `(:ts@referenceDay ,generic-day
                                              :ts@dayOfTheWeek ,day-of-the-week
                                              :ts@month ,month
                                              :top@eltPosition ,day))))
          (push date (members month))
          date))))


;;--- Time of day
;;(defmethod find-or-make-minute-of-hour ((number integer) (hour ts@HourOfDay)))

;;--- am vs. pm
;; prior to 10/24/09, this was: ...((and (>= hour 0) (< hour 11))...
;; which incorrectly returned ts@pm for (determine-am-vs-pm 11)
;; rather than ts@am
(defmethod determine-am-vs-pm ((hour integer))
  (cond
    ((and (>= hour 0) (< hour 12))
     (lookup 'ts@am))
    (t (lookup 'ts@pm))))

;;;------------------------
;;; constructing accessors
;;;------------------------

;;--- days

(defmethod find-or-make-next-day ((today ts@Date))
  ;; Has to be constructed since the days aren't all filled in and can't
  ;; just use 'next'. Given that they aren't filled in we also have to
  ;; look for month and year boundaries
  (or (next today)
      (let* ((number (1+ (eltPosition today)))
             (todays-month (ts@month today))
             (todays-year (ts@year todays-month))
             (next-days-month
              (if (> number (numberOfDays (referenceMonth (month today))))
                (next-month (referenceMonth (month today))
                            (year (month today)))
                (month today)))
             (next-days-year
              (if (eq todays-month next-days-month)
                todays-year
                (if (last-month-of-the-year? todays-month)
                  (next-year (year (month today)))
                  (year (month today))))))
        (find-or-make-date number next-days-month next-days-year
                           (next (dayOfTheWeek today))))))

;(defmethod find-or-make-previous-day ((today ts@Date))
;  (or (previous today)
;      (


;;--- months

(defmethod next-month ((m ts@MonthInYear) (year ts@ActualYear))
  (or (next m)
      (find-or-make-actual-month (next (referenceMonth m)) year)))

(defmethod next-month ((m ts@MonthOfTheYear) (year ts@ActualYear))
  (let ((actual-month (get-month (top@eltPosition m) year)))
    (next-month actual-month year)))

(defmethod get-month ((n integer) (year ts@ActualYear))
  (find n (members year) :key #'eltPosition :test #'eq))

;;(defmethod last-day-of ((m ts@MonthInYear)))


;;--- years

(defmethod next-year ((this-year ts@ActualYear))
  (let ((next-year (next this-year)))
    ;; initialize it if it isn't already
    (let* ((last-month (get-month 12 this-year))
           (first-month-of-next-year (next last-month)))
      (unless first-month-of-next-year
        (initialize-year
         next-year (next (dayOfTheWeek (last-day-of last-month))))))
    next-year))


;;--- Arbitrary intervals

(defmethod make-duration ((quantity integer) (unit symbol))
  (let ((time-unit (lookup-type unit 'ts@UnitOfTime (ns-env 'ts))))
    (make-duration quantity time-unit)))

(defmethod make-duration ((quantity integer) (unit ts@UnitOfTime))
  ;; Any use-case for interning them? Or are they more like literals.
  (instantiate-SFL-concept 'ts@Duration :env (ns-env 'ts)
                           :property-value-pairs
                              `(:top@measuredIn ,unit
                                :top@quantity ,quantity)))



;;;------------
;;; Predicates
;;;------------

(defmethod last-month-of-the-year? ((month ts@MonthInYear))
  ;;/// Implement the booleans on the cyclic times ?
  (= 12 (eltPosition (referenceMonth month))))


;;;--------------
;;; calculations
;;;--------------

(defmethod find-next ((unit ts@CyclicalTemporalSequence) (iterations integer))
  (let ((index -1)
        (next-unit unit))
    (loop
       (incf index)
       (when (= index iterations)
         (return next-unit))
       (setq next-unit (next next-unit)))))

(defmethod find-previous ((unit ts@CyclicalTemporalSequence) (iterations integer))
  (let ((index -1)
        (previous-unit unit))
    (loop
       (incf index)
       (when (= index iterations)
         (return previous-unit))
       (setq previous-unit (previous previous-unit)))))


(defmethod n-days-from-now ((now ts@Date) (n integer))
  "Returns the ts@Date of the day that is N days further into the (relative) future
   than the specified date."
  (let ((next-day now))
    (loop for count from 0 to n
       do (setq next-day (find-or-make-next-day next-day)))
    next-day))


(defmethod n-days-before-now ((now ts@Date) (n integer))
   "Returns the ts@Date of the day that is N days further into the (relative) past
    than the specified date."
   (let ((previous-day now))
     (loop for count from 0 to n
        do (setq previous-day (find-or-make-previous-day previous-day)))
     previous-day))


;;--- comparisons

(defmethod later-than? ((d1 ts@Date) (d2 ts@Date))
  ;; This is effectively a sort. We're asking if date1 is later
  ;; in the calendar than date2, and return t if it is.
  (cond
    ((not (eq (year (month d1)) (year (month d2))))
     (later-than? (year (month d1)) (year (month d2))))
    ((not (eq (month d1) (month d2)))
     (later-than? (month d1) (month d2)))
    ((not (= (eltPosition d1) (eltPosition d2)))
     (> (eltPosition d1) (eltPosition d2)))
    ((eq d1 d2)
     nil)
    (t (push-debug `(,d1 ,d2))
       (error "Fell through later-than calculation"))))

(defmethod later-than? ((y1 ts@ActualYear) (y2 ts@ActualYear))
  (> (eltPosition y1) (eltPosition y2)))

(defmethod later-than? ((m1 ts@MonthInYear) (m2 ts@MonthInYear))
  (> (eltPosition m1) (eltPosition m2)))


;;--- Comparisons from the LTML manual

(defmethod dateEarlierThan ((d1 ts@Date) (d2 ts@Date))
  (later-than? d2 d1))

(defmethod dateEarlierThanOrEqualTo ((d1 ts@Date) (d2 ts@Date))
  (or (eq d1 d2)
      (dateEarlierThan d1 d2)))

(defmethod dateLaterThan ((d1 ts@Date) (d2 ts@Date))
  (later-than? d1 d2))

(defmethod dateLaterThanOrEqualTo ((d1 ts@Date) (d2 ts@Date))
  (or (eq d1 d2)
      (dateLaterThan d1 d2)))


;;;----------
;;; Mappings
;;;----------

(defun lookup-month-by-position (number-beween-1-and-12)
  (case number-beween-1-and-12
    (1 (lookup 'ts@January))
    (2 (lookup 'ts@February))
    (3 (lookup 'ts@March))
    (4 (lookup 'ts@April))
    (5 (lookup 'ts@May))
    (6 (lookup 'ts@June))
    (7 (lookup 'ts@July))
    (8 (lookup 'ts@August))
    (9 (lookup 'ts@September))
    (10 (lookup 'ts@October))
    (11 (lookup 'ts@November))
    (12 (lookup 'ts@December))
    (otherwise
     (format t "~&~%The number ~a does not identify any month.~
                ~%Defaulting to September" number-beween-1-and-12)
     (lookup 'ts@September))))

(defun lookup-day-of-the-week-by-position (number-between-1-and-7)
  (case number-between-1-and-7
    (0 (lookup 'ts@Monday))
    (1 (lookup 'ts@Tuesday))
    (2 (lookup 'ts@Wednesday))
    (3 (lookup 'ts@Thursday))
    (4 (lookup 'ts@Friday))
    (5 (lookup 'ts@Saturday))
    (6 (lookup 'ts@Sunday))
    (otherwise
     (lookup 'ts@Monday))))

;; adapted from Zeller's Rule
(defmethod calculate-day-of-the-week ((day integer) (month-obj ts@MonthInYear)
                                      (year-obj ts@ActualYear))
  (let* ((month (eltPosition month-obj))
         (m (nth (- month 1) '(11 12 1 2 3 4 5 6 7 8 9 10)))
         (year (if (> m 10) (- (eltPosition year-obj) 1) (eltPosition year-obj)))
         (c (floor year 100))
         (y (- year (* c 100)))
         (offset (mod (- (+ day (floor (/ (- (* 13 m) 1) 5)) y (floor (/ y 4)) (floor (/ c 4)))
                         (* 2 c)) 7))
         (dow (nth offset '(6 0 1 2 3 4 5))))
    (lookup-day-of-the-week-by-position dow)))




;;;----------
;;; patterns
;;;----------

(defvar *pattern-strings-to-instances* (make-hash-table :test #'equal))

;; Horrific hack just to get through the cases in mdis. Flesh it out for real
;; when setting up the language generation protocols for these.

(defun find-or-make-date-pattern (string)
  ;; string is some variation on this: "MM/DD/YYYY"
  ;; This serves as the indexing routine.
  ;; Called from find-or-make-type-specific-referent
  (or (gethash string *pattern-strings-to-instances*)
      (let* ((name (concat "Pattern-" string))
             (i (instantiate-SFL-concept 'ts@DatePattern
                    :tag name  :env (ns-env 'ts))))
        (setf (gethash string *pattern-strings-to-instances*) i))))


;;;-----------------------
;;; system-time utilities
;;;-----------------------

;; In util there is
;;    month-day-year -> numbers
;;    day-month-&-year-as-formatted-string -> "m/d/y"
;;    time-as-formatted-string -> "h:m:s"
;;    date-&-time-as-formatted-string -> as above, separated by a space
;;    parse-ltml-date-time-to-mins -> number of seconds

(defun extract-year-from-system-time ()
  (multiple-value-bind (second minute hour
                        date month year day-of-week
                        daylight-savings-time-p time-zone)
      (get-decoded-time)
    (declare (ignore second minute hour
                     date month day-of-week
                     daylight-savings-time-p time-zone))
    year))

(defun extract-d-m-y-dow-from-system-time ()
  (multiple-value-bind (second minute hour
                        date month year day-of-week
                        daylight-savings-time-p time-zone)
      (get-decoded-time)
    (declare (ignore second minute hour
                     daylight-savings-time-p time-zone))
    #+ignore(when (= day-of-week 0)
      (format t "The number ~a does not identify any day of the week.~
               ~%Declaring it to be Monday" day-of-week)
      (setq day-of-week 2))
    (values date month year day-of-week)))


(defun extract-components-of-date-string (month-day-year)
  (if (string-equal month-day-year "<null>") 
      (values 1 1 0)
    (let* ((delimiter
	    (cond
	     ((position #\/ month-day-year) #\/)
	     ((position #\- month-day-year) #\-)
	     (t (error "No slashes or dashes in the month-day-year argument~
                     ~%   ~a" month-day-year))))
	   (list (break-up-at month-day-year :delimeter-chars `(,delimiter)))
	   (month (nth 0 list))
	   (day (nth 2 list))
	   (year (nth 4 list)))
      (when (= 2 (length year))
	(setq year (extrapolate-year-string-from-two-digits year)))
      (values day month year))))

(defmethod extrapolate-year-string-from-two-digits ((digits string))
  "Splits on mid-century"
  (let* ((1st-digit (subseq digits 0 1))
         (number (read-from-string 1st-digit)))
    (if (>= number 5)
      (string-append "19" digits)
      (string-append "20" digits))))

(defun extract-m-h-s-etc-from-system-time ()
  (multiple-value-bind (second minute hour
                        date month year day-of-week
                        daylight-savings-time-p time-zone)
      (get-decoded-time)
    (declare (ignore date month year day-of-week))
    (values hour minute second daylight-savings-time-p time-zone)))


;;;---------------
;;; print methods
;;;---------------

(defmethod print-object ((m ts@MonthOfTheYear) stream)
  (format stream "#<~a>" (name m)))

(defmethod print-object ((m ts@MonthInYear) stream)
  (format stream "#<~a ~a>" (name (referenceMonth m)) (name (year m))))

(defmethod print-object ((d ts@Date) stream)
  (format stream "#<~a ~a ~a~a, ~a>"
          (name (dayOfTheWeek d))
          (name (month (referenceDay d)))
          (eltPosition (referenceDay d))
          (ordinal-ending (eltPosition (referenceDay d)))
          (name (year (month d)))))

(defmethod date-in-slashed-form ((d ts@Date))
  (format nil "~a/~a/~a"
          (eltPosition (month d))
          (eltPosition (referenceDay d))
          (name (year (month d)))))

(defmethod print-object ((tm ts@Duration) stream)
  (format stream "#<~a ~a>" (quantity tm) (tag-to-symbol (measuredIn tm))))

(defmethod print-object ((i ts@TemporalIndexical) stream)
  (let ((date (date i)))
    (if date
      (format stream "#<~a ~a>" (name i) (date-in-slashed-form (date i)))
      (call-next-method))))


;;;----------------------------
;;; emitters: object => string
;;;----------------------------

(defmethod month-to-string ((month ts@MonthInYear) &optional always-two-digits?)
  (let ((n (top@eltPosition month)))
    (if (and (< n 10)
             always-two-digits?)
       (format nil "0~a" n)
       (format nil "~a" n))))

(defmethod year-to-string ((y ts@ActualYear) &optional only-two-digits?)
  (if (null only-two-digits?)
    (top@name y)
    (subseq (top@name y) 2)))

(defmethod date-to-string ((date ts@Date) &optional (ordering-convention :us))
  (let ((m (month-to-string (ts@month date)))
        (d (top@eltPosition date))
        (y (year-to-string (ts@year (ts@month date)))))
    (ecase ordering-convention
      (:us (format nil "~a/~a/~a" m d y))
      (:europe (format nil "~a/~a/~a" d m y))
      (:year-first (format nil "~a/~a/~a" y m d)))))

;;--- to-ltml

(defmethod trace-parameter-value-to-ltml ((d ts@Date))
  (qualify (date-to-string d) (ns-env 'ts)))

(defmethod to-ltml ((d ts@Date))
  ;; To be reversible, the symbol that we get here has to match the
  ;; name convention in find-or make date. Otherwise we can't recover
  ;; the Date from the symbol. 
  ;;(qualify (date-to-string d) (ns-env 'ts)))
  ;;   This doesn't pad the months or days when they're single digit
  (tag-to-symbol d))
