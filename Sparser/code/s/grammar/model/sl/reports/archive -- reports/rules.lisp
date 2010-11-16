;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "rules"
;;;   Module:  "model;sl:reports:"
;;;  version:  July 1991

;; initiated in May 1991
;; 1.1  (7/17 v1.8.6) Shifted over to c::report-verb rather than 
;;      c::__!report-verb and started adding new cases, e.g. ThisCo


(in-package :CTI-source)


;;;------------
;;; categories
;;;------------

(define-category  person-reports)
(define-category  company-reports)

;;;---------------------
;;; basic subject forms
;;;---------------------

(def-cfr person-reports (person report-verb)
  :form subj+vg
  :referent (:composite report+person right-edge left-edge))


(def-cfr company-reports (company report-verb)
  :form subj+vg
  :referent (:composite report+company right-edge left-edge))

(def-cfr company-reports (ThisCo report-verb)
  :form subj+vg
  :referent (:composite report+company right-edge left-edge))

