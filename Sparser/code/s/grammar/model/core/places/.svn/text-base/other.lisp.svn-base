;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994,1995  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "other"
;;;   Module:  "model;core:places:"
;;;  version:  September 1995

;; initiated 4/4/94 v2.3.  Added string/region 10/5.  Added missing typecase
;; to String-for 6/22.  (9/12) tweeked the autodef

(in-package :sparser)


(define-category  region     ;; e.g. New England
  :instantiates  location
  :specializes  location
  :binds ((name :primitive word)
          (aliases  :primitive list)
          (containing-place . location))
  :index (:permanent :key name)
  :realization (:word name))


(defun string/region (r)
  (let ((name (value-of 'name r)))
    (etypecase name
      (word (word-pname name))
      (polyword (pw-pname name)))))


(defun define-region (name-string &key part-of aliases)
  (declare (ignore part-of))
  (let ((name
         (etypecase name-string
           (string (resolve-string-to-word/make name-string))
           (word name-string)))
        obj )

    (if (setq obj (find-individual 'region :name name))
      obj
      (let ( rule  rules )
        (setq obj (define-individual 'region :name name ))

      #|(setq rule
              (list (define-cfr category::location `( ,name )
                      :form category::proper-noun
                      :referent obj))) |#

        (when aliases
          (let ( word )
            (dolist (alias-string aliases)
              (setq word (resolve-string-to-word/make alias-string))
              (push (define-cfr category::region `( ,word )
                      :form category::proper-noun
                      :referent obj)
                    rules))
            (when rules
              (setq rule (cons rule (nreverse rules))))))

        (setf (unit-plist obj)
              `(:rules ,rules ,@(unit-plist obj)))

        obj ))))


;;;-----------------
;;; auto definition
;;;-----------------

(define-autodef-data 'region
  :display-string "region"
  :form 'define-region
  :module *other-locations*
  :dossier "dossier;regions"
  :description "A word or polyword that names a type of geographical entity that we don't have a more specific category for (e.g. it's not a city or country)"
  :examples "\"New England\"" )

