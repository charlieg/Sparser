;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1993,1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:  "new menus"
;;;    Module:  "interface;windows:menus:"
;;;   version:  0.2 January 1994

;; initiated 6/17/93 v2.3, fleshed out 6/20 on Book
;;

(in-package :sparser)

;;;--------------------------------------------
;;; window to send the menu-driven displays to
;;;--------------------------------------------

(defclass demo-output-window (ccl::fred-window)
  ()
  (:default-initargs
    :window-type :document-with-zoom
    :window-title "Output Objects"
    :view-position #@(5 40)
    :view-size #@(550 330)
    :view-font '("courier" 12 :srcor :bold)
    ))

(defparameter *demo-output* nil)

(defun Demo-window ()
  (setq *demo-output* (make-instance 'demo-output-window)))




;;;-------------------------
;;; displaying the treetops
;;;-------------------------

(defun Display-treetops ()
  (unless *demo-output* (demo-window))
  (print-treetops *demo-output*)
  (format *demo-output* "~%~%~%~%"))

(defparameter *menu-item/treetops-display*
  (make-instance 'menu-item
    :menu-item-title "treetop edges"
    :menu-item-action
       #'(lambda ()
           (eval-enqueue (display-treetops)))
     )) ;; standin


;;;----------------------------------
;;; displaying the discourse history
;;;----------------------------------

(defun Display-discourse-history ()   ;; standin
  (unless *demo-output* (demo-window))
  (print-discourse-history *demo-output*))

(defparameter *menu-item/discourse-history-display*
  (make-instance 'menu-item
    :menu-item-title "objects recovered"
    :menu-item-action
      #'(lambda ()
          (eval-enqueue (display-discourse-history)))
    ))


;;;-------------------------
;;; displaying segmentation
;;;-------------------------

(defun Display-bracketing ()     ;; standin
  (display-bracketed-segments :stream *demo-output*)
  (format *demo-output* "~%~%~%~%"))

(defparameter *menu-item/brackets*
  (make-instance 'menu-item
    :menu-item-title "segment bracketing"
    :menu-item-action
      #'(lambda ()
          (eval-enqueue (display-bracketing)))))





;;;-----------
;;; main menu
;;;-----------

(defparameter *sparser-menu* (make-instance 'menu
                               :menu-title "Sparser"))


(add-menu-items *sparser-menu*

                (make-instance 'menu-item
                  :menu-item-title "Belmoral article"
                  :menu-item-action
                    #'(lambda ()
                        (eval-enqueue (belmoral))))

                (make-instance 'menu-item
                  :menu-item-title "-")

                *menu-item/treetops-display*
                *menu-item/discourse-history-display*
                *menu-item/brackets*

                )
                  

(menu-install *sparser-menu*)
;(menu-deinstall *sparser-menu*)

