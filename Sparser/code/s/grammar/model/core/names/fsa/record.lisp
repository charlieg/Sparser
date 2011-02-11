;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1993,1994  David D. McDonald  -- all rights reserved
;;; 
;;;     File:  "record"
;;;   Module:  "model;core:names:fsa:"
;;;  Version:  0.1 March 1994

;; initiated 5/15/93 v2.3, populated 6/7, added recording of single
;; word names 6/10. added *no-referent-calculations* option 1/6/94.
;; 0.1 (3/8) experimenting with only using the default name creators
;;      and none of the special cases.

(in-package :sparser)

;;;-------------------------------------------------
;;; standard case: multi-word, known-categorization
;;;-------------------------------------------------

(defun establish-referent-of-pn (final-state
                                 category
                                 basis-of-judgement
                                 item-list )

  (unless *no-referent-calculations*
    (let ((name-creator nil))
           ;;(get (label-symbol final-state) :name-creator)))

      (let ((name
             (if name-creator
               (funcall name-creator item-list)
               (if (eq basis-of-judgement :default-for-unknown-pattern)
                 category::name/unknown-pattern
                 (generic-name-creator item-list final-state category)))))

        ;; see if anything already has that name
        (let ((existing-referent
               (ecase (cat-symbol category)
                 (category::company
                  (find/company-with-name name))
                 (category::person
                  (find/person-with-name name))
                 (category::name
                  name ))))

          (if existing-referent
            (if (listp existing-referent)
              (if (null (cdr existing-referent))
                ;; the supplier of the candidates uses a list by
                ;; default, but there's really only one.
                (car existing-referent)
                (disambiguate-name-from-context existing-referent))
              existing-referent)

            (ecase (cat-symbol category)
              (category::company
               (make/company-with-name name))
              (category::person
               (make/person-with-name name))
              (category::name
               name ))))))))



(defun disambiguate-name-from-context (list-of-individuals)
  (break "name has to be disambiguated from context:~
          ~%   ~A~
          ~%~
          ~%Write the code." list-of-individuals))

