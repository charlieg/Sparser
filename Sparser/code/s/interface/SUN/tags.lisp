;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "tags"
;;;    Module:   "interface;SUN:"
;;;   Version:   December 1994

;; broken out as its own file 12/14/94

(in-package :sparser)


(defun define-sftp-data (tag keyword &optional capitalize?)
  (let ((word
         (etypecase tag
           (word tag)
           (string (word-named tag)))))
    (unless word
      (when capitalize?
        (setq tag tag))
      (setq word (define-word tag)))
    (push-onto-plist word keyword :typical-containing-category)
    keyword ))


;;;-----------------------
;;; cases for the tag set
;;;-----------------------

;;--- tags w/in a NP

(define-sftp-data "nn"  :np)
(define-sftp-data "nnp" :np)   ;; singular
(define-sftp-data "nns" :np)   ;; plural
(define-sftp-data "jj"  :np)   ;; adjectives

(define-sftp-data "jjs"  :np)   ;; adjectives

;;--- determiner

(define-sftp-data "dt"  :determiner)

;;--- "all" as a pre-determiner
(define-sftp-data "pdt"  :determiner)




;;--- tags w/in a VG

(define-sftp-data "vb"  :vg)   ;; "be"
(define-sftp-data "vbd" :vg)   ;; "had"
(define-sftp-data "vbz" :vg)   ;; "is"
(define-sftp-data "vbp" :vg)   ;; "are"
(define-sftp-data "vbn" :vg)   ;; "located"
(define-sftp-data "vbg" :vg)   ;; "following"
(define-sftp-data "md"  :vg)   ;; modals

;;--- numbers

(define-sftp-data "cd" :number)


;;--- prepositions

(define-sftp-data "in" :preposition)


;;--- ??  "however"

(define-sftp-data "rb"  :binder)

;;--- conjunctions, e.g. "&"
(define-sftp-data "cc"  :conjunction)


;;--- WH

(define-sftp-data "wrb"  :wh)


;;--- pronouns

(define-sftp-data "prp"  :pronoun)


;;--- ??  "more"
(define-sftp-data "rbr"  :other)
(define-sftp-data "jjr"  :other)  ;; "one or [more] of ..."



;;--- "there"
(define-sftp-data "ex"  :other)

;;--- ??  "that"
(define-sftp-data "wdt"  :other)

;;--- "to"
(define-sftp-data "to"    :to)

;;--- ???  "1" 
(define-sftp-data "ls"    :other)

;;--- "yes"
(define-sftp-data "uh"   :interjection)




;;--- punctuation

(define-sftp-data "." :punctuation)
(define-sftp-data "," :punctuation)
(define-sftp-data ":" :punctuation)
(define-sftp-data "\"" :punctuation)
(define-sftp-data "$" :punctuation)

(define-sftp-data "open-paren" :punctuation t)
(define-sftp-data "close-paren" :punctuation t)

;;--- "*" 
(define-sftp-data "sym"  :punctuation)  ;; symbol (?)

