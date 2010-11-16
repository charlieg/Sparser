;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992,1993,1994,1995 David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2007 BBNT Solutions LLC. All Rights Reserved
;;; $Id:
;;; 
;;;     File:  "presentation"
;;;   Module:  "drivers;timing:"
;;;  Version:  October 2007

;; file created 2/91. Given content 1/6/95
;; Added Time decoded 1/23. 10/2/07 Extended and added Allegro variation.

(in-package :sparser)


;;;--------------------------------------------
;;; analysis based on the elapsed-time samples
;;;--------------------------------------------

(defun run-string-for-timing (string)
  (let ((*display-word-stream* nil))
    (analyze-text-from-string string)
    (let ((tps (/ *time-at-chart-level*
                  *number-of-next-position*)))
      (format t "~&speed: ~4,1F tokens/msec" (float tps))
      )))


(defun run-string-for-timing/no-forest (string)
  (let ((*display-word-stream* nil)
        (*do-forest-level* nil))
    (analyze-text-from-string string)
    (let ((tps (/ *time-at-chart-level*
                  *number-of-next-position*)))
      (format t "~&speed: ~4,1F tokens/msec" (float tps))
      )))


;;;-----------------------------------------------------------
;;; analysis based on decoding what the Time function returns
;;;-----------------------------------------------------------

(defun time-analysis (input-string)
  (let* ((*display-word-stream* nil)
         (trace-string (make-string-output-stream))
         (*trace-output* trace-string))

    (time (pp input-string))

    (analyze-and-report-timing-data
     (get-output-stream-string trace-string))))
      

#+:allegro
(defun analyze-and-report-timing-data (time-report-string)
; cpu time (non-gc) 40 msec user, 0 msec system
; cpu time (gc)     20 msec user, 0 msec system
; cpu time (total)  60 msec user, 0 msec system
; real time  66 msec
; space allocation:
;  115,682 cons cells, 4,760,424 other bytes, 0 static bytes
  (format t "~a" time-report-string)
  (multiple-value-bind (number units)
      (extract-ms-from-time-report-string time-report-string)
    (let* ((word-count *number-of-next-position*)
	   (tokens-per-second
	    (case units
	      (:msec
	       (let ((tokens-per-milisecond (/ word-count number)))
		 (* tokens-per-milisecond 1000)))
	      (otherwise
	       (break "New time unit: ~a" units)))))
      (format t "~&speed: ~4,1F tokens/second"
	      (float tokens-per-second)))))


(defun extract-ms-from-time-report-string (s)
  ;; "; cpu time (non-gc) 40 msec user, 0 msec system\n..."
  (let* ((close-pos (position #\) s))
	 (number-start-pos (+ 2 close-pos))
	 (number-initial-string (subseq s number-start-pos))
	 (space-pos (position #\space s))
	 (number-string (subseq number-initial-string 0 (1+ space-pos))))
    (let ((units (extract-initial-time-unit 
		  (subseq number-initial-string (+ 2 space-pos)))))
      (values (read-from-string number-string)
	      units))))

(defun extract-initial-time-unit (s)
  (let* ((space-pos (position #\space s))
	 (unit-string (subseq s 0 space-pos)))
    (cond
      ((string-equal unit-string "msec") :msec)
      (t (break "New instance of a time unit: ~a" unit-string)))))


#+:coral
(defun analyze-and-report-timing-data (trace-string)
  (multiple-value-bind (total-seconds
			multitasking-time
			bytes-allocated)

      (decode-time-report
       (get-output-stream-string trace-string))

    (let ((net-time (- total-seconds multitasking-time))
	  (word-count *number-of-next-position*))
      
      (let ((tokens-per-second (/ word-count
				  net-time)))
	
	(format t "~&speed: ~4,1F tokens/second, ~
                     ~A bytes allocated"
		(float tokens-per-second)
		bytes-allocated)))))

#+:coral
(defun decode-time-report (s)
  ;; e.g. "
  ;; (PP *1K-A-VICE-PRESIDENT*) took 7725 milliseconds (7.725 seconds) to run.
  ;; Of that, 127 milliseconds (0.127 seconds) were spent in The Cooperative Multitasking Experience.
  ;;  639384 bytes of memory allocated.
  ;; "

  (multiple-value-bind (seconds rest-of-string)
                       (extract-seconds-from-time-report s)

    (multiple-value-bind
      (time-in-cooperative-multitasking-experience rest2)
      (extract-cme-from-time-report rest-of-string)

      (let ((bytes-allocated
             (extract-bytes-alloc-from-time-report rest2)))

        (values seconds
                time-in-cooperative-multitasking-experience
                bytes-allocated)))))



(defun extract-seconds-from-time-report (s)
  ;; The report starts by giving the expression that was timed.
  ;; Since it ends in a close paren it's a good place to start
  (let* ((close-pos (position #\) s))
         (after-exp (subseq s (1+ close-pos))))
    (let* ((pos-of-open
            ;; the next open paren is just before the number
            (position #\( after-exp))
           (pos-of-close
             ;; Then we find the close
             (position #\) after-exp)))
      
      (let ((seconds (subseq after-exp
                             (+ pos-of-open 1)
                             (- pos-of-close 8))))
        (values
         (read-from-string seconds)
         (subseq after-exp (1+ pos-of-close)))))))


(defun extract-cme-from-time-report (remainder)
  (let ((pos-of-open (position #\( remainder))
        (pos-of-close (position #\) remainder)))

    (let ((cme (subseq remainder
                       (+ pos-of-open 1)
                       (- pos-of-close 8))))
      (values
       (read-from-string cme)
       (subseq remainder (1+ pos-of-close))))))


(defun extract-bytes-alloc-from-time-report (remainder)
  (let ((pos-of-period (position #\. remainder))
        (pos-of-b (position #\b remainder)))

    (let ((bytes (subseq remainder
                         (+ pos-of-period 3)
                         (- pos-of-b 1))))
      (read-from-string bytes))))
  


