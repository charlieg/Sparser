;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(USER LISP) -*-
;;; copyright (c) 1990  Content Technologies, Inc.  -- all rights reserved
;;;
;;;     file: "DEC"
;;;   module: "interface;menus:menu bars:"
;;;

(in-package :user)


(defun assetNet-menubar ()
  (flush-all-Allegro-menus-but '("File" "Edit" "Windows"))
  ;; flush all the Allegro menus but File and Windows (since 
  ;; we won't be doing any debugging, and don't want to confuse
  ;; the demonstration
  ;;   n.b. to reverse this run (restore-menubar)
  (install-AssetNet-menu))

(AssetNet-menubar)

