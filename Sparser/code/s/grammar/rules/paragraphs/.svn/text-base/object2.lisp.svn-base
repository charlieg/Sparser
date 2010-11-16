;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1991,1992,1993,1994 David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2010 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$
;;; 
;;;     File:  "object"
;;;   Module:  "grammar;rules:paragraphs:"
;;;  Version:  2.1 March 2010

;; 1.1 (10/25/93 v2.0) [-> "1"]  New design for section markers
;; 1.2 (1/5/94 v2.3) fleshing out the object now that it's being used
;; 1.3 (1/14) wrote a nicer print routine
;;     (5/2) added Print-paragraph-#
;; 2.0 (8/17) converted to section-objects.
;; 2.1 (3/16/10) Converted them back to avoid PSI hassles. Added next-paragraph

(in-package :sparser)

;;;----------
;;; globals
;;;----------

(defvar *current-paragraph* nil
  "points to the paragraph whose text is being analyzed")

(defvar *next-paragraph* nil
  "points to the paragraph that is about to start. Serves as a global
   across the update functions that wire them together, see 
   finish-ongoing-paragraph. ")

(defvar *number-of-paragraphs-so-far* 0
  "a count of the total number of paragraphs seen in the
   article up to and including the current one")

(defvar *paragraphs-in-the-article* nil
  "a push list of all the paragraphs seen so far, with the
   current one on the front")


(defun initialize-paragraph-state ()
  (setq *current-paragraph* nil
        *paragraphs-in-the-article* nil
        *number-of-paragraphs-so-far* 0)
  (reinitialize-the-paragraph-resource))


;;;--------
;;; object
;;;--------

(defstruct (paragraph
            (:print-function print-paragraph-structure))

  number  ;; an integer starting at 1 giving the order in which the
          ;; paragraph appeared in the article
  start   ;; position of the first word in the paragraph
  end     ;; position just after the last word
  before  ;; the previous paragraph (if any)
  after   ;; the next paragraph (if any)
  )


(defun print-paragraph-structure (obj stream depth)
  (declare (ignore depth))
  (write-string "#<paragraph " stream)
  (princ (paragraph-number obj) stream)
  (when (paragraph-start obj)
    (format stream " p~A - "
            (pos-token-index (paragraph-start obj))))
  (when (paragraph-end obj)
    (format stream "p~A "
            (pos-token-index (paragraph-end obj))))
  (write-string ">" stream))


(defun print-paragraph-# (p)
  ;; convenient as a minimal trace by putting it on an After-
  ;; paragraph-action
  (unless (paragraph-p p)
    (break "Object passed in as a paragraph isn't.~%~A" p))
  (let ((*print-short* t))
    (format t "~&~%~A ended~%~%" p)))


;;;------------------------
;;; resource of paragraphs
;;;------------------------

(or (boundp '*number-of-paragraphs-to-make-in-advance*)
    (defparameter *number-of-paragraphs-to-make-in-advance*
                  10))

(defparameter *paragraph-resource* nil)

(defun pre-allocate-paragraphs (&aux para)
  ;; called at launch time as an initialization along with
  ;; the initialization of the chart and edge resources
  (dotimes (i *number-of-paragraphs-to-make-in-advance*)
    (setq para (make-paragraph))
    (push para *paragraph-resource*)))

(defun allocate-more-paragraphs ( &aux para )
  ;; called from Allocate-paragraph whenever the list goes to nil
  (dotimes (i *number-of-paragraphs-to-make-in-advance*)
    (setq para (make-paragraph))
    (push para *paragraph-resource*)))

(defun reinitialize-the-paragraph-resource ()
  (dolist (p *paragraphs-in-the-article*)
    (deallocate-paragraph p)))


(defun allocate-paragraph ()
  (if *paragraph-resource*
    (pop *paragraph-resource*)
    (else
      (allocate-more-paragraphs)
      (pop *paragraph-resource*))))


(defun deallocate-paragraph (p)
  (setf (paragraph-number p) nil
        (paragraph-start p) nil
        (paragraph-end p) nil)
  (push p *paragraph-resource*)
  p )

