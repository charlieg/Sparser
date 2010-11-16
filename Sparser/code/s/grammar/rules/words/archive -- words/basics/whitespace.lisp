;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;;
;;;      File:   "whitespace"
;;;    Module:   "grammar;rules:words:basics:"
;;;   Version:   1.0  June 1990
;;;

(in-package :CTI-source)

;; This is a file of rules specifying what characters should be deemed
;; to be whitespace, and thereby ignored by Next-terminal/no-whitespace
;; and similar tokenizer layers.
;;   It is expected that this set will vary among text sources and
;; analysis rule-sets.  It is also not unreasonable for it to vary for
;; one or two characters during the course of the same analysis depending
;; on the section of the envelope file or article being analyzed.
;; Consequently these are defaults.

(define-to-be-whitespace w::one-space)
(define-to-be-whitespace w::2-spaces)
(define-to-be-whitespace w::3-spaces)
(define-to-be-whitespace w::4-spaces)
(define-to-be-whitespace w::5-spaces)
(define-to-be-whitespace w::6-spaces)
(define-to-be-whitespace w::7-spaces)
(define-to-be-whitespace w::8-spaces)
(define-to-be-whitespace w::9-spaces)
(define-to-be-whitespace w::10-spaces)
(define-to-be-whitespace w::11-spaces)
(define-to-be-whitespace w::12-spaces)
(define-to-be-whitespace w::13-spaces)
(define-to-be-whitespace w::14-spaces)
(define-to-be-whitespace w::15-spaces)
(define-to-be-whitespace w::16-spaces)

