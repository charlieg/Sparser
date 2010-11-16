;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(USER LISP) -*-
;;; copyright (c) 1990  Content Technologies, Inc.  -- all rights reserved
;;;
;;;     file: "operations"
;;;   module: "interface;menus:menu bars:"
;;;

(in-package :user)


(defun flush-all-Allegro-menus-but (list-of-strings)
  "Removes from the presently established menubar any menu whose
   name isn't on the list.  Does nothing special about the AppleCore,
   but depends on Allegro's note about Multifinder to keep it from
   going away."

  (let ( keepers
         menu )
    (dolist (string list-of-strings)
      (setq menu (find-menu string))
      (when menu
        (push menu keepers)))
    (set-menubar (nreverse keepers))))


(defun restore-menubar ()
  (set-menubar *default-menubar*))

