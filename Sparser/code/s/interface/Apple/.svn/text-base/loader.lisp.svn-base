;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:CL-USER -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "loader"
;;;   Module:  "interface;Apple:"
;;;  Version:  1.2  September 26, 1994

;; Changelog
;;  1.1  divides the routines and definitions into a file set
;; that is a better reflection of what routines are modified as a group.
;;  1.2  Added [finding actions]

(in-package :cl-user)


(unless (find-package :apple-interface)
  (make-package :apple-interface
                :nicknames '(:apple)))

(unless (find-package :lingsoft)
  (make-package :lingsoft
                :nicknames '(:ls)))

(unless (find-package "<DER")   ;; see file [pos edges]
  (make-package "<DER"))



(import '(sparser::then
          sparser::else
          )
        (find-package :apple-interface))



(sparser::lload "interface;Apple:pseudo characters1")
(sparser::lload "interface;Apple:lingsoft features")
(sparser::lload "interface;Apple:online dis analysis")
(sparser::lload "interface;Apple:offline dis analysis")
(sparser::lload "interface;Apple:dis.out reader1")
(sparser::lload "interface;Apple:doc streams")
(sparser::lload "interface;Apple:markup1")
(sparser::lload "interface;Apple:interim")
(sparser::lload "interface;Apple:workbench view")
(sparser::lload "interface;Apple:finding actions")
(sparser::lload "interface;Apple:workspace")

