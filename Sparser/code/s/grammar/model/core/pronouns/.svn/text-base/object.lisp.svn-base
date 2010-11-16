;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1991  Content Technologies Inc.
;;; copyright (c) 1992  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "object"
;;;   Module:  "model;core:pronouns:"
;;;  version:  February 1991      system version 1.8.1

(in-package :sparser)

;;;--------
;;; object
;;;--------

(define-category pronoun)
;  :slots ((name (word :pronoun)))
;  :index (:hash-on-slot name))

(defstruct (pronoun
            (:print-function print-pronoun-structure))
  rules name )


(defun print-pronoun-structure (obj stream depth)
  (declare (ignore depth))
  (write-string "#<pronoun " stream)
  (princ-word (pronoun-name obj) stream)
  (write-string ">" stream))

(defun display-pronoun (pronoun stream)
  (display-word (pronoun-name pronoun) stream))


;;;------------
;;; ancilaries
;;;------------

(setf (cat-index (category-named 'category::pronoun))
      (make-index/hash-on-slot))

(defun find/pronoun (word)
  (gethash word (cat-index (category-named/c-symbol
                            'category::pronoun))))

(defun pronoun-named (string)
  (let ((word (resolve-string-to-word string)))
    (find/pronoun word)))

(defun index/pronoun (word pronoun)
  (setf (gethash word (cat-index (category-named/c-symbol
                                  'category::pronoun)))
        pronoun))

(defun all-Pronouns ()
  (let ( accumulating-pronouns )
    (maphash #'(lambda (word pronoun)
                 (declare (ignore word))
                 (push pronoun
                       accumulating-pronouns))
             (cat-index (category-named/c-symbol
                         'category::pronoun)))
    accumulating-pronouns))


(defun list-the-pronouns ()
  (let ((the-pronouns (all-pronouns)))
    (pl (sort the-pronouns
              #'word-order :key #'pronoun-name)
        nil)))


(defun delete-pronoun (string)
  (let* ((word (word-named string))
         (pronoun (find/pronoun word)))
    (unless pronoun
      (error "There is no pronoun named ~A" string))
    (delete/pronoun pronoun word)))

(defun delete/pronoun (pronoun
                       &optional
                       (word (pronoun-name pronoun)) )
  ;; delete the rules that invoke it
  (dolist (rule (pronoun-rules pronoun))
    (delete-cfr/cfr rule))
  ;; strand it -- remove it from the catalog
  (remhash word (cat-index (category-named/c-symbol
                            'category::pronoun)))
  pronoun )


;;;---------------
;;; defining form
;;;---------------

(defun define-pronoun (string form-category)

  (let ((word (resolve/make string))
        pronoun )

    (if (setq pronoun (find/pronoun word))
      pronoun
      (else
        (setq pronoun (make-pronoun
                      :name word))
        (let ( rules )
          (push (define-cfr category::pronoun `( ,word )
                  :form form-category
                  :referent pronoun)
                rules)
          (let ((uppercase (resolve/make string)))
            (push (define-cfr category::pronoun `( ,uppercase )
                    :form form-category
                    :referent pronoun)
                  rules))                
          (let ((uppercase (resolve/make (string-capitalize string))))
            (push (define-cfr category::pronoun `( ,uppercase )
                    :form form-category
                    :referent pronoun)
                  rules))                
          (setf (pronoun-rules pronoun) rules))

        (index/pronoun word pronoun)
        pronoun ))))

