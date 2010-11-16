;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1992-1998 David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2008 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$
;;;
;;;     File:  "phrases"
;;;   Module:  "model;core:time:"
;;;  version:  1.0 January 2008

;; initiated 4/9 v1.8.2
;; 1.0 (12/15/92 v2.3) bumped version to prepare for new semantics
;;     (10/19/94) cleaned up the parts that are out of date
;;     (1/3/98) started adding form rules for adverbs
;;     (1/1/08) Added 'date' and the form and referents to the mapcar,
;;      Added the form rule for them with 's'.

(in-package :sparser)


#|  This is a purely syntactic analysis.  The hooks are there to
distinguish the various meanings, but no referents are presently
defined.  The analysis patently overgenerates, but then that's
arguably not the parser's responsibility.  |#


;;;----------------------
;;; soak up prepositions
;;;----------------------

(def-cfr of-time ("of" time))

(mapcar #'(lambda (preposition)
            (define-cfr category::time `(,preposition ,category::time-unit)
	      :form category::pp :referent '(:daughter right-referent))
            (define-cfr category::time `(,preposition ,category::weekday)
	      :form category::pp :referent '(:daughter right-referent))
            (define-cfr category::time `(,preposition ,category::month)
	      :form category::pp :referent '(:daughter right-referent))
            (define-cfr category::time `(,preposition ,category::year))
	      :form category::pp :referent '(:daughter right-referent)
            (define-cfr category::time `(,preposition ,category::time)
	      :form category::pp :referent '(:daughter right-referent))
            (define-cfr category::time `(,preposition ,category::date)
	      :form category::pp :referent '(:daughter right-referent)))

        (list (resolve-string-to-word/make "at")
              (resolve-string-to-word/make "by")
              (resolve-string-to-word/make "for")
              (resolve-string-to-word/make "in")
              (resolve-string-to-word/make "on")
              (resolve-string-to-word/make "over")))



;;;--------------------------
;;; combination with clauses
;;;--------------------------

(def-form-rule (s calculated-day)
  :form s
  :referent (:head left-edge
             :bind (time right-edge)))

(def-form-rule (s time)
  :form s
  :referent (:head left-edge
             :bind (time right-edge)))


;;;----------
;;; oddities
;;;----------

(def-cfr time (time "ago"))

