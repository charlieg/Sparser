;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.
;;; copyright (c) 1992 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "drivers"
;;;   Module:  "interface;AssetNet:"
;;;  version:  1.0  December 1991  v1.8.3

(in-package :sparser)


;;;-------------------
;;; reading the chart
;;;-------------------
#|
   This scheme assumes that the chart can be scanned from beginning
to end and the entire analysis will be germaine to a single earnings
report (true of isolated headlines).
   The first constituent in the chart is the stock symbol, the rest
are parsed independently (no phrases are formed) and accumulated in
variables.  |#

(defvar *company-stock-symbol* nil)
(defvar *quarter*              nil)
(defvar *earnings*             nil)

(defun clear-AN-globals ()
  (setq *company-stock-symbol* nil
        *quarter*              nil
        *earnings*             nil))


(defun scan-chart-for-AN-information ()
  (clear-AN-globals)
  (let ((position (chart-position 0))
        (n 0)
        edge terminal )

    (when *trace-chart-scan* (terpri) (tts) (terpri))

    (loop
      (setq terminal (pos-terminal position))
      (when (= n 1)
        (setq *company-stock-symbol* terminal))
      (incf n)

      (if (eq terminal word::end-of-source)
        (return)
        (else
          (setq edge (ev-top-node (pos-starts-here position)))
          (when *trace-chart-scan*
            (format t "~&edge: ~A~%" edge))

          (if (typep edge 'edge)
            (then
              (case (cat-symbol (edge-category edge))
                (category::quarter
                 (setq *quarter* edge))
                (category::earnings/shr
                 (setq *earnings* edge)))

              (setq position (pos-edge-ends-at edge)))

            (setq position (chart-position-after position))))))

    (when *trace-chart-scan*
      (format t "~%~%Result of scan:~
                 ~%  stock symbol: ~A~
                 ~%       quarter: ~A~
                 ~%  earnings/shr: ~A~%~%"
              *company-stock-symbol* *quarter* *earnings*))

    *earnings* ))

