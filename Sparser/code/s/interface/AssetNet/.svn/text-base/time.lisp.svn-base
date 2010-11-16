;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1989 David D. McDonald
;;; copyright (c) 1990,1991  Content Technologies Inc.
;;; copyright (c) 1992 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "time"
;;;   Module:  "interface;AssetNet:"
;;;  version:  January 1992 

(in-package :sparser)


;;;-----------------------
;;;     components
;;;-----------------------

(defun date-as-formatted-string ()
  (multiple-value-bind (second minute hour
                        date month year day-of-week
                        daylight-savings-time-p time-zone)
                       (get-decoded-time)
    ;(break "time formats")

    (let ((year-abbrev
           (mod year 100)))
      (format nil "~A/~A/~A" month date year-abbrev))))


(defun time-as-formatted-string (&key
                                 ((:dot dot-instead-of-colon) nil))
  (multiple-value-bind (second minute hour
                        date month year day-of-week
                        daylight-savings-time-p time-zone)
                       (get-decoded-time)

    ;(break "time formats")
    (let ((year-abbrev
           (mod year 100)))
      (if dot-instead-of-colon
        (format nil "~A.~A.~A" hour minute second)
        (format nil "~A:~A:~A" hour minute second)))))


;;;-----------------------
;;;     composites
;;;-----------------------

(defun date-&-time-as-formatted-string (&key
                                        ((:dot dot-instead-of-colon)
                                         nil))
  (format nil "~A ~A"
          (date-as-formatted-string)
          (time-as-formatted-string :dot dot-instead-of-colon)))



(defun hour-minute-second/string ()
  (multiple-value-bind (second minute hour
                        date month year day-of-week
                        daylight-savings-time-p time-zone)

                       (get-decoded-time)

    (declare (ignore date month year day-of-week
                     daylight-savings-time-p time-zone))

    (format nil "~A_~A_~A" hour minute second)))

