;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "def form"
;;;   Module:  "model;sl:reports:"
;;;  version:  July 1991

;; initiated 7/16 v1.8.6

(in-package :CTI-source)


;;;------------------------
;;; category for the verbs
;;;------------------------

(define-category  report-verb)


;;;------
;;; form
;;;------

(defun Define-event-type/report (&key tensed/singular tensed/plural
                                      past-participle present-participle
                                      infinitive  nominalization
                                      )
  (let ((infinitive-word (resolve/make infinitive))
        report )
    (if (setq report (find/report infinitive-word))
      report
      (else
        (setq report (make-report :name infinitive-word))

        (let ((rules (define-main-verb  'report-verb
                       :referent  report
                       :tensed/singular    tensed/singular
                       :tensed/plural      tensed/plural
                       :past-participle    past-participle
                       :present-participle present-participle
                       :infinitive         infinitive
                       :nominalization     nominalization)))

          (setf (report-rules report) rules))

        (index/report infinitive-word report)
        report ))))

