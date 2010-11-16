;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "pers+title"
;;;   Module:  "model forms;sl:whos news:posts:"
;;;  version:  1.0  January 1991    

(in-package :CTI-source)


;;;--------
;;; lambda
;;;--------

(define-category person+title)  ;;composite


;;;------------------------
;;; phrase structure rules
;;;------------------------

;; ///// replace these with more careful ones
;(def-cfr person (person title)
;  :referent (:composite person+title
;                        left-edge right-edge))
;
;(def-cfr person (title person)
;  :referent (:composite person+title
;                        right-edge left-edge))


(def-cfr person (person comma-title)
  :referent (:composite person+title
                        left-edge right-edge))


(def-cfr comma-person ("," person)
  :referent (:daughter right-edge))

(def-cfr person (title comma-person)
  :referent (:composite person+title
                        right-edge left-edge))



(def-cfr title (title to-person)
  :referent (:composite person+title
                        right-edge left-edge))


(def-cfr person (title/caps person)
  :referent (:composite person+title
                        left-edge right-edge))



;;;-------------------------
;;; context-sensitive rules
;;;-------------------------

(def-csr  name person   :left-context  title/caps
  :referent (:function find-or-make/person right-edge))


(def-csr  name person
         :right-context title
  :referent (:find-object find-or-make/person left-edge))

(def-csr  name person
         :left-context title
  :referent (:find-object find-or-make/person right-edge))

