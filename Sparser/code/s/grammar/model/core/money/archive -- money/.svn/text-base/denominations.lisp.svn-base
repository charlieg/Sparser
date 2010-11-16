;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "denominations"
;;;   Module:  "model;core:money:"
;;;  version:  1.0  December 1990    (v1.6)

(in-package :CTI-source)


(define-category  denomination-of-money)
;  :slots ((name word :plural-is-equivalent )
;          (abbreviation word  :abbreviation))
;  :index (:hash-on-slot name))


(defstruct (denomination-of-money
            (:print-function print-denomination-of-money-structure))
  rules name abbreviation )


(defun Print-denomination-of-money-structure (obj stream depth)
  (declare (ignore depth))
  (write-string "#<denomination-of-money " stream)
  (princ-word (denomination-of-money-name obj) stream)
  (write-string ">" stream))

(defun Princ-denomination-of-money (dom stream)
  (princ-word (denomination-of-money-name dom) stream))


;;;------------
;;; ancilaries
;;;------------

(setf (cat-index (category-named 'denomination-of-money))
      (make-index/hash-on-slot))

(defun find/denomination-of-money (word)
  (gethash word (cat-index-of 'category::denomination-of-money)))

(defun Denomination-of-money-named (string)
  (let ((word (resolve-string-to-word string)))
    (find/denomination-of-money word)))


(defun Index/denomination-of-money (word denomination-of-money)
  (setf (gethash word (cat-index-of 'category::denomination-of-money))
        denomination-of-money))


(defun all-denominations-of-money ()
  (let ( accumulating-denominations-of-money )
    (maphash #'(lambda (word denomination-of-money)
                 (push denomination-of-money accumulating-denominations-of-money))
             (cat-index-of 'category::denomination-of-money))
    accumulating-denominations-of-money))

(defun list-the-denominations-of-money ()
  (let ((the-denominations-of-money (all-denominations-of-money)))
    (pl (sort the-denominations-of-money 
              #'word-order :key #'denomination-of-money-name)
        nil)))


(defun Delete-denomination-of-money (string)
  (let* ((denomination-of-money (denomination-of-money-named string)))
    (unless denomination-of-money
      (error "There is no denomination of money named ~A" string))
    (delete/denomination-of-money denomination-of-money)))

(defun Delete/denomination-of-money (denomination-of-money)
  (dolist (rule (denomination-of-money-rules denomination-of-money))
    (delete-cfr/cfr rule))
  (remhash (denomination-of-money-name denomination-of-money)
           (cat-index-of 'category::denomination-of-money))
  denomination-of-money )


;;;--------------
;;; instantiator
;;;--------------

(defun Define-denomination-of-money (name-string
                                     &key plural
                                          abbrev-string
                                          prefix-symbol
                                          postfix-symbol
                                          capitalize? )

  (let ((name (resolve/make name-string))
        (capitalized (resolve/make (string-capitalize name-string)))
        (plural-word (when plural (resolve/make plural)))
        (abbrev (when abbrev-string (resolve/make abbrev-string)))
        (prefix (when prefix-symbol (resolve/make prefix-symbol)))
        (postfix (when postfix-symbol (resolve/make postfix-symbol)))
        dom )

    (if (setq dom (find/denomination-of-money name))
      dom
      (else
        (setq dom (make-denomination-of-money
                   :name  name
                   :abbreviation  abbrev))

        (let ( rules )
          (push (define-cfr category::denomination-of-money `(,name)
                  :form nil
                  :referent dom)
                rules)
          (when capitalize?
            (push (define-cfr category::denomination-of-money
                             `(,capitalized)
                    :form nil
                    :referent dom)
                  rules))
          (when plural
            (push (define-cfr category::denomination-of-money `(,plural-word)
                    :form nil
                    :referent dom)
                  rules))
          (when abbrev
            (push (define-cfr category::denomination-of-money `(,abbrev)
                    :form nil
                    :referent dom)
                  rules))
          (when prefix
            (push (define-cfr category::denomination-of-money `(,prefix)
                    :form nil
                    :referent dom)
                  rules))
          (when postfix
            (push (define-cfr category::denomination-of-money `(,postfix)
                    :form nil
                    :referent dom)
                  rules))
          (setf (denomination-of-money-rules dom) rules))

        (index/denomination-of-money name dom)
        dom ))))


;;;-------
;;; cases
;;;-------

(define-denomination-of-money "dollar" :plural "dollars"
                                       :prefix-symbol "$" )

(define-denomination-of-money "cent"   :plural "cents"
                                       :postfix-symbol "c" )

(define-denomination-of-money "pound"  :plural "pounds")

(define-denomination-of-money "yen" :capitalize? t)

