;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1991 David D. McDonald and the
;;;                    Brandeis/NMSU Tipster project  -- all rights reserved
;;;
;;;     File:  "edges"
;;;   Module:  "interface;save runs:"
;;;  version:  1.0  November 1991

;; initiated 11/10 ddm @CRL

(in-package :CTI-source)


;;;--------------------------------------------------
;;; special form for iterating through all the edges
;;;--------------------------------------------------

(defvar *e* nil
  "This is the variable for the Do-edges iterator.  It will be
   bound to the edge the iterator is presently accessing.")

(defmacro do-edges (&rest body)
  `(do-edges/expr ',body))

(defun do-edges/expr (body)
  (when *edge-resource-is-wrapped*
    (error "Not enough edges were allocated to handle this run of ~
            Sparser without wrapping."))

  (dotimes (i *index-of-furthest-edge-ever-allocated*)
    (let ((*e* (aref *all-edges* i)))
      (dolist (form body)
        (eval form)))))


;;;------------
;;; identifier
;;;------------

(defun identifier/edge (e)
  (format nil "edge~A" (edge-position-in-resource-array e)))


;;;---------------------------------------------------------
;;; the form that is written to represent it in the Outfile
;;;---------------------------------------------------------

(defun write/edge/outfile-format (e &optional (stream t))
  (format stream "~%(define-edge ~A"  (get-id e))
  (format stream "~%  :array-position ~A")
  (format stream "~%  :category ~A"
          (outfile-format/label (edge-category e)))
  (format stream "~%  :form ~A" )
  (format stream "~%  :referent ~A")
  (format stream "~%  :rule ~A")
  (format stream "~%  :starting-position ~A")
  (format stream "~%  :ending-position   ~A")
  (format stream "~%  :left-daughter ~A")
  (format stream "~%  :right-daughter ~A")
  (format stream "~%  :used-in ~A")

  (format stream ")~%"))

