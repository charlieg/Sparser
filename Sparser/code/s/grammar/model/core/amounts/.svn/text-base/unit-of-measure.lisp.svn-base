;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993,1994 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "unit of measure"
;;;   module:  "model;core:amounts:"
;;;  Version:  October 1994

;; initiated 9/18/93 v2.3.  10/24/94 added defdata

(in-package :sparser)

;;;--------
;;; object
;;;--------

(define-category  unit-of-measure
  :specializes nil
  :instantiates self
  :binds ((name :primitive word))
  :index (:permanent :key name)
  :realization (:common-noun name))


;;;--------------------
;;; pro-forma def-form
;;;--------------------

(defun define-unit-of-measure (string)
  (define-individual 'unit-of-measure :name string))

;;;---------
;;; defdata
;;;---------

(define-autodef-data  'unit-of-measure
  :display-string "units of measure"
  :form 'define-unit-of-measure
  :dossier  "dossiers;units of measure"
  :module *amounts*
  :description "a word that names the units in which something can be measured: as in '15 ___ of stuff'"
  :examples "\"ton\", \"inch\"" )

