;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1991 David D. McDonald and the
;;;                    Brandeis/NMSU Tipster project  -- all rights reserved
;;;
;;;     File:  "positions"
;;;   Module:  "interface;save runs:"
;;;  version:  1.0  November 1991

;; initiated 11/10 ddm @CRL

(in-package :CTI-source)

;;;------------------------------------------------------
;;; special form for iterating through all the positions
;;;------------------------------------------------------

(defvar *p* nil
  "This is the variable for the Do-edges iterator.  It will be
   bound to the edge the iterator is presently accessing.")

(defmacro do-positions (&rest body)
  `(do-positions/expr ',body))

(defun do-positions/expr (body)
  (when *position-array-is-wrapped*
    (error "Not enough positions were allocated to handle this run of ~
            Sparser without wrapping."))

  (dotimes (i *number-of-next-position*)
    (let ((*p* (aref *the-chart* i)))
      (dolist (form body)
        (eval form)))))


;;;------------
;;; identifier
;;;------------

(defun identifier/position (p)
  (format nil "position~A" (pos-array-index p)))


