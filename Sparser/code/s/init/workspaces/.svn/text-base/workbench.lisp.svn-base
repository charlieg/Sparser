;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1995-1999  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "workbench"
;;;   Module:  "init;workspaces:"
;;;  version:  May 1999

;; broken out from [init;versions:v2.3a:workspace:in progress] 1/30/95
;; Updated hard pathname 6/20. Added g3 pathnames 5/13/99.

(in-package :sparser)


;;--- frequent operations

;(install-sparser-menu)
;(menu-install *sparser-menu*)
;(menu-deinstall *sparser-menu*)
;(install-Sparser-menu)
;(launch-the-workbench)
;(launch-the-Autodefine-tableau)
;(setup-autodef-view)
;(point-string *)


;;--- IFT

;; Version for G3 PB
;(load "g3:Applications:Lisp:MCL 4.0:Interface Tools:make-ift.lisp")
;(interface-tools::load-ift)

;; Version for 8100
;(load "SysAp:Applications:MCL 2.0.1:Interface Tools:make-ift.lisp")
;(ift::load-ift)




;;;-----------------------------------
;;; the size of the Workbench windows
;;;-----------------------------------

;(launch-subview-as-independent-window :20-inch)
;(launch-subview-as-independent-window :14-inch)
;;;;;///(launch-subview-as-independent-window :8-inch)
;*independent-subview-window*
;*auxiliary-subview*
;(launch-text-view-as-independent-window :20-inch)
;(launch-text-view-as-independent-window :14-inch)
;(launch-text-view-as-independent-window)
;*text-out*
;*text-scroll-bar*
;*independent-text-view-window*



;;;-----------------------------
;;; debugging line 'adjustment'
;;;-----------------------------

(setq *default-line-length* 68)
;(setq *adjust-text-to-fixed-line-length* t)
;(setq *adjust-text-to-fixed-line-length* nil)


(defun one-long-line ()
  (pp "In this era of frantic competition for ad dollars, a lot of revenue-desperate magazines are getting pretty cozy with advertisers -- fawning over them in articles and offering pages of advertorial space.")
  )


(defun several-long-lines ()
  (pp "In this era of frantic competition for ad dollars, a lot of revenue-desperate magazines are getting pretty cozy with advertisers -- fawning over them in articles and offering pages of advertorial space.
So can a magazine survive by downright thumbing its nose at major advertisers?
Garbage magazine, billed as \"The Practical Journal for the Environment,\" is about to find out.
Founded by Brooklyn, N.Y., publishing entrepreneur Patricia Poore, Garbage made its debut this fall with the promise to give consumers the straight scoop on the U.S. waste crisis.
"))


(defun several-long-lines-with-extra-lines ()
  (pp "In this era of frantic competition for ad dollars, a lot of revenue-desperate magazines are getting pretty cozy with advertisers -- fawning over them in articles and offering pages of advertorial space.
So can a magazine survive by downright thumbing its nose at major advertisers?


Garbage magazine, billed as \"The Practical Journal for the Environment,\" is about to find out.

Founded by Brooklyn, N.Y., publishing entrepreneur Patricia Poore, Garbage made its debut this fall with the promise to give consumers the straight scoop on the U.S. waste crisis.


"))

