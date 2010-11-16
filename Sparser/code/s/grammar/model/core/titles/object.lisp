;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993,1994,1995 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "object"
;;;   Module:  "model;core:titles:"
;;;  version:  May 1995

;; initiated 6/10/93 v2.3.  Moved out the print macro 1/6/94 to help the
;; compiler.  1/18 added title-heads and title-modifiers.  2/28/95 added
;; string printer.  5/13 marked the object as having 'permanent' instances

(in-package :sparser)

;;;------
;;; core
;;;------

(define-category  title
  :instantiates self
  :specializes nil
  :binds ((name :primitive word))
  :index (:permanent :key name)
  :realization (:tree-family  np-common-noun
                :mapping ((np-head . :self)
                          (n-bar . :self)
                          (np . :self))
                :common-noun name ))


(defun string/title (title)
  (let ((name (value-of 'name title)))
    (etypecase name
      (word (word-pname name))
      (polyword (pw-pname name)))))


;;;------------
;;; components
;;;------------

(define-category  title-head
  :instantiates self
  :specializes nil
  :binds ((name :primitive word))
  :index (:key name)
  :realization (:common-noun name))

(define-category  title-modifier
  :instantiates self
  :specializes nil
  :binds ((name :primitive word))
  :index (:key name)
  :realization (:adjective name))

