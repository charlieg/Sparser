;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1991 David D. McDonald and the
;;;                    Brandeis/NMSU Tipster project  -- all rights reserved
;;;
;;;     File:  "id table"
;;;   Module:  "interface;save runs:"
;;;  version:  1.0  November 1991

;; initiated 11/10 ddm @CRL

(in-package :CTI-source)

;;;-----------------------
;;; Table and subroutines
;;;-----------------------

(defparameter *id-table*
              (make-hash-table :test #'equal)
  "Holds the object -> id relation")


(defun initialize-id-table ()
  (clrhash *id-table*))


(defun store-id (object id)
  (setf (gethash object *id-table*) id))

(defun get-id (object)
  (gethash object *id-table*))


(defun ids-&-objects ()
  (maphash #'(lambda (object id)   ;; key, value
               (format t "~&~A <- ~A~%"
                       id object))
           *id-table*))


;;;--------
;;; driver
;;;--------

;;--- temporaries
;;       The iteration macro calls Eval, so a local in Make-id-table
;;       isn't going to be visi

(defun make-id-table ()
  (let ( id )
    (declare (special id))
    (do-edges
     (setq id (identifier/edge *e*))
     (store-id *e* id)
     (format t "~&~A -> ~A~%" *e* id))
    (do-positions
     (setq id (identifier/position *p*))
     (store-id *p* id)
     (format t "~&~A -> ~A~%" *p* id))))
