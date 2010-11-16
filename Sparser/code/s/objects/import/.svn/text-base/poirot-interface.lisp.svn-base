;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved
;;; $Id$
;;;
;;;      File:  "poirot-interface"
;;;    Module:  "objects/import
;;;   version:  August 2009

;; N.b. this file of structural elements is gated by the *poirot* grammar module.
;; initiated 8/27/09. Elaborated through 8/31

(in-package :sparser)

;;--- poirot package

(unless (find-package :ltml)
  ;; The re-definition when poirot's core Lisp code is loaded 
  ;; will greatly elaborate this, so not worrying about keeping 
  ;; the two in sync. 
  (defpackage :ltml
    (:use :common-lisp)))

;;--- flag

(defvar ltml::*nlp-facilities-are-loaded* t
  "Read in ltml::define-Owl-Class")


;;;------------------------------------------------------------------
;;; Associating Poirot objects with their realization specifications
;;;------------------------------------------------------------------

(defvar *list-of-enqueued-realizations* nil
  "When we're not doing them live, the realization expressions
 are pushed onto this list")

(defvar *expand-realizations-when-enqueued* nil
  "Flag that signals that the expressions should be vivified as soon
 as they are received.")

(defvar *trace-realization-definition* nil)

(defun ltml::enqueue-realization (object form)
  ;; Called in ltml::define-Owl-Class or ltml::define-individual
  ;; when an 'realization' element  is seen.
  ;; Could be extended to properties or even restrictions I suppose. 
  (when *trace-realization-definition*
    (format t "~&Realization of ~a~
               ~%    mapped to ~a~%" object form))
  (let ((pair `(,object . ,form)))
    (if *expand-realizations-when-enqueued*
      (vivify-object-realization-spec-pair pair)
      (push pair *list-of-enqueued-realizations*))))


;;;--------------------------------
;;; vivifying those specifications
;;;--------------------------------

(defun expand-realizations ()
  ;; Called explicitly from top-level after Poirot's ontology has been loaded
  (dolist (pair *list-of-enqueued-realizations*)
      (vivify-object-realization-spec-pair pair)))


