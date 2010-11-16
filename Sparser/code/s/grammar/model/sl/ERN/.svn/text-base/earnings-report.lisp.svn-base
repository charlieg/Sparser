;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1995-1998  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "earnings report"
;;;   Module:  "model;sl:ERN:"
;;;  Version:  1.0 July 1998

;; initiated 12/20/95. Elaborated through 1/8/96
;; 1.0 (7/12/98) Started to rework the files into the new era of lattice-points.

(in-package :sparser)

;;;--------------------------------------------------------------------
;;; a toplevel stub to provide a hook for the individual autodef items
;;;--------------------------------------------------------------------

(define-category company-financials
  :specializes nil )

(define-autodef-data 'company-financials
  :module *finance*
  :display-string "Company financials"
  :not-instantiable t )


;;;-------------------
;;; the full relation
;;;-------------------

#| The full relationship [////and the verbs that indicate that a clause
is stating some or all of it ]]].  I've set it up as a flat record with
lots of optional elements in the sense that relatively few of these
will occur in a single clause. |#


(define-category  financial-report
  :specializes nil
  :instantiates self
  :binds ((company . company)
          (datum . financial-data)
          (reporting-period . time)
          (value . money)
          (value-per-share . money)
          (percentage-changed . percentage)
          (direction-of-change . direction)
          (comparative-value . money)
          (comparative-value-per-share . money)
          (reporting-period-compared . time)))

