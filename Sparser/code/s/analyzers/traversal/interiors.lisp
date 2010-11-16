;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1991,1992,1993,1994  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "interiors"
;;;   Module:  "analyzers;traversal:"
;;;  Version:  June 1994

;; initiated 10/19/91. fleshed out 10/30. had to put dispatch on
;; label type in 10/31.   5/15 fixed it for the case of the daughter
;; edge being an ambiguous word -- "AN".  6/8/94 added trap for unclassified
;; cases

(in-package :sparser)

;;;----------------
;;; runtime driver
;;;----------------

(defun dispatch-on-single-span-interior/angle-brackets (pos-before-open
                                                        pos-after-open
                                                        pos-before-close
                                                        pos-after-close)
  (declare (ignore pos-before-close))

  ;; get the spanning edge, then
  ;; see if its label has the :<_>interpretation tag on its plist
  ;; in which case execute that rule to form the edge over the
  ;;   whole bracketed segment

  (let ((daughter-edge (ev-top-node (pos-starts-here pos-after-open)))
        label cfr )
    (if (eq :multiple-initial-edges daughter-edge)
      (then
        (let ((edge-vector (ev-edge-vector (pos-starts-here pos-after-open)))
              plist )
          (dotimes (i (ev-number-of-edges (pos-starts-here pos-after-open)))
            (setq label (edge-category (aref edge-vector i))
                  plist (etypecase label
                          (category (cat-plist label))
                          (word (word-plist label))))
            (when (setq cfr (cadr (member :<_>interpretation plist)))
              (setq daughter-edge (aref edge-vector i))
              (return)))))
      (else
        (setq label (edge-category daughter-edge)
              cfr (cadr (member :<_>interpretation
                                 (etypecase label
                                   (category (cat-plist label))
                                   (word (word-plist label))))))))
    (if cfr
      (let ((spanning-edge
             (make-edge-over-long-span
              pos-before-open
              pos-after-close
              (cfr-category cfr)
              :rule cfr
              :form (cfr-form cfr)
              :referent
                (case (cfr-referent cfr)
                  (:the-single-edge
                   (edge-referent daughter-edge))
                  (:right-daughter
                   (edge-referent
                    (edge-right-daughter daughter-edge)))))))

        (setf (edge-left-daughter spanning-edge) daughter-edge)
        (setf (edge-right-daughter spanning-edge)
              :spanned-paired-punct-interior)
        spanning-edge )

      (else
        (trap-unclassified-phenomena-inside-<> pos-after-open)
        (let ((edge (make-edge-over-long-span
                     pos-before-open
                     pos-after-close
                     category::angle-brackets
                     :rule  :traversal/angle-brackets)))
          edge)))))



;;;---------------------
;;; routine for <> hook
;;;---------------------

(defun define-<>-interior-hook (label function)
  )
