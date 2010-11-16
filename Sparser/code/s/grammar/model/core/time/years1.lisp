;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992,1993,1994 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "years"
;;;   Module:  "model;core:time:"
;;;  version:  1.1 October 1994

;; initiated in February 1991
;; 0.1 (4/9 v1.8.2)  Added the years from 1959 to 1979
;; 0.2 (7/31 v1.8.6)  Gave years "month" fields to facilitate real indexing
;; 1.0 (12/15/92 v2.3) setting up for new semantics
;; 1.1 (9/18/93) actually doing it.   10/20/94 breaking out the cases

(in-package :sparser)

;;;--------
;;; object
;;;--------

(define-category year
  :specializes time
  :instantiates time
  :binds ((name  :primitive word)
          (year-of-century :primitive number))
  :index (:key name :permanent))


;;;---------------
;;; defining form
;;;---------------

(defun define-year (string integer)

  (let ((word (resolve-string-to-word/make string))
        year )

    (if (setq year
              (find-individual 'year
                               :name word))
      year
      (else
        (setq year (define-individual 'year
                     :name word
                     :year-of-century integer))

        (setf (unit-plist year)
              `(:rules
                (,(define-cfr category::year `( ,word )
                    :form category::np
                    :referent year))
                ,@(unit-plist year)))

          year ))))

