;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992,1993,1994,1995,1996 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "dates"
;;;   Module:  "model;core:time:"
;;;  version:  1.2 January 1996

;; 1.0 (12/15/92 v2.3) setting up for new semantics
;; 1.1 (9/18/93) actually doing it
;; 1.2 (9/13/95) redoing the rules as binaries to get around bug in
;;      the referent calcuation for final dotted cfrs.
;;     (1/2/96) added other weekday+date rule

(in-package :sparser)

;;;------------
;;; the object
;;;------------

(define-category date
  :specializes time
  :instantiates time
  :binds ((day-of-the-month . day-of-the-month)
          (year . year)
          (weekday . weekday))
  :index (:temporary :sequential-keys year day-of-the-month))

;;;-------
;;; rules
;;;-------

#|  old nary form --- blows up in referent calc because the
    dotted rule expansion isn't appreciated and the 'third-edge'
    isn't seen in the (dotted) top binary cfr that is what
    actually completes

(def-cfr date  (day-of-the-month "," year)
  :form np
  :referent (:instantiate-individual date
                :with (day-of-the-month first-edge
                       year third-edge)))

;;--- taking in adjuncts
(def-cfr date  ( date "," weekday )
  :form np
  :referent (:head first-edge
             :bind (weekday third-edge)))  |#


;;--- binary alternatives (better design anyway ?)

(def-cfr comma-year ( "," year )
  :form appositive
  :referent (:daughter right-edge))

(def-cfr comma-weekday ( "," weekday )
  :form appositive
  :referent (:daughter right-edge))

(def-cfr comma-date ( "," date )
  :form appositive
  :referent (:daughter right-edge))


(def-cfr date ( day-of-the-month comma-year )
  :form np
  :referent (:instantiate-individual date
                :with (day-of-the-month left-edge
                       year right-edge)))

(def-cfr date  ( date comma-weekday )
  :form np
  :referent (:head left-edge
             :bind (weekday right-edge)))

(def-cfr date  ( weekday comma-date )
  :form np
  :referent (:head right-edge
             :bind (weekday left-edge)))



