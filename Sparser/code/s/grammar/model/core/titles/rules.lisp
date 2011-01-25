;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993-2005,2011 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "rules"
;;;   Module:  "model;core:titles:"
;;;  version:  January 2011

;; initited 6/15/93, starting over from scratch. 3/17/05 These are
;; interacting with rules made automatically from the etf schemas,
;; so selectively commenting them out while sorting out the issues.
;; 1/22/11 Addresing the intereaction with the schemas to keep these
;; rules because references have to happen before they're created
;; haphadardly by order of ETF definition. Added case of 'to-title'

(in-package :sparser)

;;;--------------------------
;;; preposition combinations
;;;--------------------------
;; Also defined by the etf for 'join', so that creation has to
;; accept this rule or be modified to make that possible

(def-cfr as-title ("as" title)
  :form pp
  :referent (:daughter right-edge))

(def-cfr in-title ("in" title)
  :form pp
  :referent (:daughter right-edge))

(def-cfr to-title ("to" title)
  :form pp
  :referent (:daughter right-edge))
