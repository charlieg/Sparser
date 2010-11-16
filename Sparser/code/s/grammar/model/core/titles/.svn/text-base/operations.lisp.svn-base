;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993,1994,1995 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "operations"
;;;   Module:  "model;core:titles:"
;;;  version:  September 1995

;; created 6/10/93 v2.3, first populated 1/6/94.  7/22 commented out
;; the autodef that don't make sense yet.  (9/12) tweeked the autodef

(in-package :sparser)


;;;----------
;;; printing
;;;----------

(defun princ-title (obj stream)
  (princ-word (value-of 'name obj) stream))

(define-special-printing-routine-for-category  title
  :short ((write-string "#<" stream)
          (princ-title obj stream)
          (write-string ">" stream))
  :full ((write-string "#<title " stream)
          (princ-title obj stream)
          (write-string ">" stream)))


(define-special-printing-routine-for-category  qualified-title
  :short ((let ((*print-short* t))
            (write-string "#<" stream)
            (princ-title (value-of 'title obj) stream)
            (write-string ", " stream)
            (princ-title-qualifier (value-of 'qualifier obj) stream)
            (write-string ">" stream)))
  :full ((write-string "#<qualified-title " stream)
         (princ-title (value-of 'title obj) stream)
         (write-string ", " stream)
         (princ-title-qualifier (value-of 'qualifier obj) stream)
         (write-string ">" stream)))


;;;-------
;;; forms
;;;-------

(defun define-title (string)
  (define-individual 'title :name string))

(defun define-title-head (string)
  (define-individual 'title-head :name string))

(defun define-title-modifier (string)
  (define-individual 'title-modifier :name string))

(defun define-title-qualifier (string)
  (define-individual 'title-qualifier :name string))



;;;-----------------
;;; auto definition
;;;-----------------

(define-autodef-data 'title
  :module *titles*
  :display-string "Job titles"
  :not-instantiable t )

#|  these don't make sense until titles;object1 is debugged
(define-category full-titles)
  ;; dummy -- standin for title that can be instantiated
(define-autodef-data 'full-titles
  :display-string "full title"
  :form 'define-title
  :module *full-titles*
  :dossier "dossiers;titles" )

(define-autodef-data 'title-head
  :display-string "noun"
  :form 'define-title-head
  :module *title-heads*
  :dossier "dossiers;title heads")

(define-autodef-data 'title-modifier
  :display-string "adjective"
  :form 'define-title-modifier
  :module *title-modifiers*
  :dossier "dossiers;title modifiers")  |#

(define-autodef-data 'title-qualifier
  :display-string "status"
  :form 'define-title-qualifier
  :description "a word that modifies a title by describing how a person relates to it"
  :examples "\"acting\" \"former\""
  :module *title-qualifiers*
  :dossier "dossiers;title qualifiers")

