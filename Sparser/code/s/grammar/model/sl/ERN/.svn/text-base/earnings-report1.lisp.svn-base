;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1995-2000  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "earnings report"
;;;   Module:  "model;sl:ERN:"
;;;  Version:  2.0 September 2000

;; initiated 12/20/95. Elaborated through 1/8/96
;; 1.0 (7/12/98) Started to rework the files into the new era of lattice-points.
;; 2.0 (9/5/00) Started reworking (again) to incorporate realizations within the
;;      category definition.

(in-package :sparser)

;;;--------------------------------------------------------------------
;;; a toplevel stub to provide a hook for the individual autodef items
;;;--------------------------------------------------------------------

(define-category company-financial
  :specializes nil )

(define-autodef-data 'company-financials
  :module *finance*
  :display-string "Company financials"
  :not-instantiable t )


;;;------------------------------
;;; the basic (minimal) relation
;;;------------------------------

(define-category ern   ;; not just earnings, any financial can head it, e.g. "sales"
  :specializes company-financial
  :instantiates self
  :binds ((company . company)
          (financial . financial)
          (reporting-period . (quarter year))
          (value . money)
          (esp . money/shr


#|

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
          (reporting-period-compared . time))
#|  :realization 
     ((:tree-family
       :mapping )
      ) |#
     )        |#

