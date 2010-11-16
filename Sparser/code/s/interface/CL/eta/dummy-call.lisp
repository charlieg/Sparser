;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "dummy call"
;;;   Module:  "interface;PRW"
;;;  Version:   1.3  January 1991
;;;

(in-package :CTI-source)

;; Changelog:
;;  v1.1 adds a second dummy routine for paragraph starts, and puts
;; some formatting into the text of the file to sort them out.
;;  v1.2 (11/29 v1.5) shortened the printout.  The longer one is
;;       commented out.
;; 1.3  (1/4 v1.7)  Modified the printout again to include the
;;      character offsets.
;; 1.4  (1/11 v1.7)  Revised Evidence-for-topic to split into either
;;      of two cases depending on the value of *record-ETA-results*,
;;      and put the usual format statment under control of *announce-
;;      ETA-results-online*.  When the recording is done a routine in
;;      the window code is called with the data.


;;;------------------
;;; paragraph start
;;;------------------

;; This routine is called when the start of a paragraph is recognized,
;; after all other processing for that event is finished.
;;   The "paragraph-ID" is an integer representing the number of this
;; paragraph within the article being processed.


(defun Announcing-start-of-new-paragraph (paragraph-ID)
  (format t "~%~%Starting new paragraph ~A~%" paragraph-id))
  


;;;---------------------
;;; Evidence-for-topic
;;;---------------------

;; This name for the function to call when the Analysis Engine finds
;; evidence that should trigger a topic-stamping rule is burned into
;; the setup routine, Set-up-and-call-topic-stamping-function.
;;    It is expected that PRW simply supplies another definition for
;; this function, and either doesn't load this file or loads that
;; definition after this one.

(unless (boundp '*record-ETA-results*)
  (defparameter *record-ETA-results* nil
    "A flag governing whether instances of evidence are passed on
     to Record-significant-text-segment."))

(unless (boundp '*announce-ETA-results-online*)
  (defparameter *announce-ETA-results-online* t
    "A flag controlling the format statement that announces the
     ETAs as they are instantiated."))


(defun Evidence-for-topic (topic     ;; the object from the topic rule
                           evidence  ;; a word, polyword, or category
                           rule      ;; a rule or indicator from the
                                     ;; analyzer
                           location-in-char-stream/start  ;;integer
                           location-in-char-stream/end    ;;integer
                           )
  (declare (ignore rule))

  (when *announce-ETA-results-online*
    (format t "~&ETA: ~A from ~A~
               ~%     ~A - ~A~%"
            topic evidence
            location-in-char-stream/start location-in-char-stream/end))

  (when *record-ETA-results*
    (record-significant-text-segment
     topic location-in-char-stream/start
     location-in-char-stream/end evidence)))

