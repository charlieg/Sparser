;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994-1995,2011  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "other"
;;;   Module:  "model;core:places:"
;;;  version:  July 2011

;; initiated 4/4/94 v2.3.  Added string/region 10/5.  Added missing typecase
;; to String-for 6/22.  (9/12) tweeked the autodef
;;  (7/18/11) Starting makeover/rationalization from lots of ex.

(in-package :sparser)

;;;-----------------------------------
;;; specific places that are regions
;;;    and nothing more specific
;;;-----------------------------------

(define-category  region    
  ;; e.g. New England, real places
  :instantiates  location
  :specializes  location
  :binds ((name :primitive word)
          (aliases  :primitive list)
          (type . region-type)
          (containing-region . location))
  :index (:permanent :key name)
  :realization ((:proper-noun name) ;; for the predefined ones
                (:tree-family  np-common-noun/definite
                 :mapping ((np . :self)
                           (np-head . region-type)))))


(define-autodef-data 'region
  :display-string "region"
  :form 'define-region
  :module *other-locations*
  :dossier "dossier;regions"
  :description "A word or polyword that names a particular geographical entity that we don't have a more specific category for (e.g. it's not a city or country)"
  :examples "\"New England\"" )

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

        (when part-of
          (cerror "just continue"
                  "Deal with part-of in region definitions ~
                   now? (\"~a\")" name-string))

        (setf (unit-plist obj)
              `(:rules ,rules ,@(unit-plist obj)))

        obj ))))



;;;----------------------------
;;; kinds of regions/locations
;;;----------------------------

;; They will be the heads of specific region names, 
;; or of NPs describing them,

;; Could consider making them categories if we want to list
;; instances by their type. In which case look at pattern
;; in find-of-define-kind -- will need the type words for
;; independent reasons though. Needs support in PNF.

(define-category  region-type    ;; e.g. "city", "village", kinds of places
  :instantiates self
  :specializes location
  :binds ((name :primitive word))
  :index (:permanent :key name)
  :realization (:common-noun name))


(defun define-region-type (string)
  ;; Adapted from find-or-define-kind, where the analog of the
  ;; kind category is region-type
  (let* ((string-for-category #+mlisp string
                              #+(or :ccl :alisp)(string-upcase string))
         (symbol (intern string-for-category
                         (find-package :sparser)))
         (word (define-word string))
         (category (category-named symbol))
         (new? (null category)))
    (when new? ;; for re-evaluation of this file
      (let ((expr `(define-category ,symbol ;; e.g. 'city
                     :specializes region-type
                     :instantiates region-type 
                     :bindings (name ,word)
                     :realization (:common-noun ,string))))
        (setq category (eval expr))))
    (let ((rule
           (if new?
             (caadr (memq :rules (cat-realization category)))
             (construct-cfr ;; consider def-cfr/expr
              (category-named 'region-type) ;; lhs
              (list word) ;; rhs
              (category-named 'common-noun) ;; form
              category ;; referent
              :define-cfr)))) ;; source -- see note-grammar-module
      (values category
              rule))))




(define-autodef-data 'region-type
  :form 'define-kind-of-location
  :dossier "dossiers;location kinds"
  :display-string "kinds of locations"
  :module *location*
  :description "A word that names a kind of place"
  :examples "\"city\", \"lake\"" )


;; Creating a named region from a region-type



