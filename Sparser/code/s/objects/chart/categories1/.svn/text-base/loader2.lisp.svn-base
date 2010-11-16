;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1992,1993,1994,1995 David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "loader"
;;;   Module:  "objects;categories:"
;;;  Version:  July 1992

;; 2.0 (7/16/92 v2.3) Bumped the number on the whole directory to 1 to freely
;;      change everything here for the new representation regime.

(in-package :sparser)


;; package for categories -- analogous to what is done for words

(or (boundp '*category-package*)
    (defconstant *category-package*
                 (or (find-package :category)
                     (make-package :category
                                   :nicknames '()
                                   :use nil ))))

(lload "cat;object2")
(lload "cat;printers")
(lload "cat;lookup1")
(lload "cat;form1")

