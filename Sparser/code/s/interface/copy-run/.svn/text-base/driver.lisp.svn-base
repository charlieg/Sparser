;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1991 David D. McDonald and the
;;;                    Brandeis/NMSU Tipster project  -- all rights reserved
;;;
;;;     File:  "driver"
;;;   Module:  "interface;save runs:"
;;;  version:  1.0  November 1991

;; initiated 11/10 ddm @CRL

(in-package :CTI-source)


(defun save-run ()
  ;; two passes.  The first creates ids for every object and stores
  ;; them in a table.  The second opens a file (or files?) and writes
  ;; out expressions for them, along with whatever else we decide
  ;; we want in it (them).

  (make-id-table)  ;; pass1

  ;; pass2
  ;; (with-open-file outfile...
  (do-edges
   (write/edge/outfile-format *e*))
  (do-positions
   (write/position/outfile-format *p*)))

