;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(interface-testing LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "bankruptcy"
;;;   Module:  "interface;PRW:rules:"
;;;  Version:   1.0   August 1990
;;;

(in-package :interface-testing)


;;;---------------------------------------------------
;;; "federal bankruptcy-court protection"  in (BCY1)
;;;---------------------------------------------------

(def-cfr bankruptcy-court ("bankruptcy-court"))

(def-cfr bankruptcy-court ("federal" bankruptcy-court))

(def-cfr bankruptcy-court-protection
         (bankruptcy-court "protection"))


;;;-------------------------------------------------------
;;; "the bankruptcy court that has jurisdiction" in BCY2
;;;-------------------------------------------------------

(def-cfr bankruptcy-court ("bankruptcy" "court"))


;;;---------------------------------------------------------
;;; "under Chapter 11 of the federal Bankruptcy Code"  BCY2
;;;---------------------------------------------------------

(def-cfr/multiple-rhs chapter-11
                      (("Chapter 11")
                       (chapter-11 of-the-bankruptcy-code)
                       ("under" chapter-11)))

(def-cfr of-the-bankruptcy-code ("of" bankruptcy-code))


(def-cfr/multiple-rhs bankruptcy-code
                      (("Bankruptcy Code")
                       ("federal" bankruptcy-code)
                       (United-States bankruptcy-code)
                       ("the" bankruptcy-code)))

(def-cfr under-the-bankruptcy-code ("under" bankruptcy-code))

(def-cfr United-States ("U.S."))



;;;---------------------------------------
;;; "it sought bankruptcy-law protection"
;;;---------------------------------------
;;   (bcy3.1)

(def-cfr bankruptcy-law ("bankruptcy-law"))

(def-cfr/multiple-rhs bankruptcy-protection
                      ((bankruptcy-law "protection")))

(def-cfr/multiple-rhs sought-BCY-protection
                      (("sought" bankruptcy-protection)))


;;;-----------------------------------------------
;;; "reorganization plan under Chapter 11 of ..."
;;;-----------------------------------------------
;;   (bcy3.2)

(def-cfr/multiple-rhs reorganization-plan
                      (("reorganization plan")
                       (reorganization-plan under-the-bankruptcy-code)
                       ("proposed" reorganization-plan)))


;;;--------------------------------------------------
;;; "initiated Chapter 11 bankruptcy reorganization"
;;;--------------------------------------------------
;;   (bcy3.3)

(def-cfr initiated-Chapter-11 ("initiated" chapter-11))

(def-cfr bankruptcy-reorganization ("bankruptcy reorganization"))

(def-cfr/multiple-rhs initiated-reorganization
                      ((initiated-Chapter-11 bankruptcy-reorganization)
                       ))

;;;------------------------
;;; the topic associations
;;;------------------------

(define-association-with-topic 'bankruptcy-court 'bcy)

(define-topic-associations 'bcy
  '(chapter-11
    bankruptcy-law))

