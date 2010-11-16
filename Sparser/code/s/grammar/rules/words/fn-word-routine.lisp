;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992,1993,1994.1995  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "fn word routine"
;;;    Module:   "grammar;rules:words:"
;;;   Version:   0.7 May 1995

;; 0.1 (12/17/92 v2.3) redid the routine so it was caps insensitive and handled
;;      bracketing.
;; 0.2 (5/15/93) Added Function-word? and the marker on the word's plist
;; 0.3 (1/12/94) Having bracket assignment first remove any old brackets so that
;;      it's easy to make revisions.
;; 0.4 (7/29) extended the code to be able to handle polywords
;; 0.5 (8/7) removed its 'etypecase' and made the 'otherwise' nil.
;; 0.6 (10/24) embelleshed check to let brackets come in as bracket objects
;; 0.7 (11/16) added keyword for form category
;;     (5/12/95) fixed glitch in format stmt.

(in-package :sparser)


(defun function-word? (word)
  (typecase word
    (word (cadr (member :function-word (label-plist word))))
    (polyword
     (cadr (member :function-word (pw-plist word))))
    (otherwise
     nil )))


(defun define-function-word (string
                             &key ((:brackets bracket-symbols))
                                  ((:form name-of-form-category)))

  (let ((word (resolve-string-to-word/make string))
        (form (if name-of-form-category
                (let ((category
                       (etypecase name-of-form-category
                         (symbol (category-named name-of-form-category))
                         ((or referential-category mixin-category category)
                          name-of-form-category))))
                  (unless category
                    (break "The category ~A isn't defined yet"
                           name-of-form-category))
                  category )
                t )))

    (etypecase word
      (word (setf (label-plist word)
                  `( :function-word ,form ,@(label-plist word) )))
      (polyword
       (setf (pw-plist word)
             `( :function-word ,form ,@(pw-plist word)))))

    (unless (rule-set-for word)
      (establish-rule-set-for word))
    
    (when bracket-symbols
      (delete-existing-bracket-assignments word)
      (let ( bracket )
        (dolist (bracket-symbol bracket-symbols)
          (unless (or (bracket-p bracket-symbol)
                      (and (symbolp bracket-symbol)
                           (boundp bracket-symbol)))
            (error "The ostensive bracket symbol ~A isn't defined"
                   bracket-symbol))

          (setq bracket (eval bracket-symbol))
          (unless (bracket-p bracket)
            (error "The symbol ~A evals to ~A~%instead of to a bracket"
                   bracket-symbol bracket))

          (assign-bracket/expr word bracket))))

    word ))

