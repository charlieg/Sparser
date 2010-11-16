;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(USER LISP) -*-
;;; copyright (c) 1990  Content Technologies, Inc.  -- all rights reserved
;;;
;;;     file: "run"
;;;   module: "interface;menus"
;;;

(in-package :user)

;;;-------------------------------------------------
;;;   running over designated source directories
;;;-------------------------------------------------

(defun install-AssetNet-menu (&aux tmp)
  (if (setq tmp (find-menu "CTI"))
    (ask tmp (menu-deinstall)))
  (let ((menu
         (oneof *menu* 
              :menu-title "CTI"
              :menu-items 
                (list
                 (oneof *window-menu-item*
                        :menu-item-title "Look for articles"
                        :menu-item-action 'AssetNet-loop )
                 (oneof *window-menu-item*
                        :menu-item-title "stop"
                        :menu-item-action 'terminate-AssetNet-loop )
                 ))))
    (ask menu (menu-install))
    (ask menu (menu-enable))
    menu ))

;; (install-AssetNet-menu)  --executed from a menu-bar file

