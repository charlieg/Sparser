;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992-1999  David D. McDonald  -- all rights reserved
;;; extensions copyright (c) 2007-2010 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$
;;;
;;;      File:   "quantifiers"
;;;    Module:   "grammar;rules:words:"
;;;   Version:   1.4 February 2010

;; broken out from "fn words - cases" 12/17/92 v2.3.  Added some 1/13/94
;; 0.1 (7/25) revised "many" and "several" to be like the others rather than
;;      just having a ].phrase bracket
;; 0.2 (8/16) gave "not" a tentative bracketing   9/6 "{some,any,every}one", "much"
;; 1.0 (11/16) giving some of them all default edges so dm&p can generalize over them
;;      The ones that stand alone are still problematic.
;;     (12/5) added "additional"
;; 1.1 (8/16/97) gated the use of objects. 
;; 1.2 (12/26/99) redid the category with modern indexing scheme. (Haven't touched
;;      the def form yet.)
;;     (2/8/07) Removed toplevel check around the definition of the category - see note.
;; 1.3 (6/9/08) Made everything a quantifier, providing more rule options.
;;     (11/14) Added 'as xx as' phrase as quantifiers, which is a good fit syntactically
;; 1.4 (2/10/10) Revised the ]. bracket to be specific to quantifier to adjudicate correctly
;;      for np-internal instances: "a few ...".

(in-package :sparser) 

(define-category  quantifier
    :specializes nil
    :instantiates nil
    :binds ((word  :primitive word)))
;; This definition used to be conditioned on whether we included the model,
;; but the ACL compiler choked on that in a bizare way


(defun define-quantifier (string &key brackets rules)
  (let* ((word (define-function-word string
                 :brackets brackets
                 :form 'quantifier)))

    (if *include-model-facilities*
      (let ((object (find-individual 'quantifier :word word))
	    cfrs )
        (unless object
          ;; it's the first time the definition has been made.
          ;; Subsequent evaluations of the form will still update
          ;; the bracket information since that's done within the
          ;; function word processing regardless of whether the word
          ;; already exists
          (setq object (define-individual 'quantifier
                         :word word)))

	(when (memq 'det rules)
          (let ((cfr (def-form-rule/resolved 
                       `(,word ,category::noun)       ;; rhs
                       category::np                   ;; form
                       `(:daughter right-referent)))) ;; referent
	    (push cfr cfrs)))

	(when (memq 'of rules)
	  ;; if we make this a conventional cfr, the bracket in front
	  ;; of "of" will push us to the segment level before we can
	  ;; see the rule, which is an unnecessary source of complexity
	  (let* ((string (string-append string " of"))
		 (pw (define-polyword/expr string))
		 (cfr (def-cfr/expr 'quantifier-of `(,string)
			:form 'det
			:referent object)))
	    (push cfr cfrs)))
			  
	(push-onto-plist object cfrs :rules)
        object )

      (let ((cfr (def-form-rule/resolved 
                       `(,word ,category::noun)      ;; rhs
                       category::np
                       nil )))
        cfr ))))

;(when cl-user::*psi-2009*
;  (break "quantifiers"))

;; Should move these to a dossier, but my poor memory suggests that
;; there's some dependency that forced them up this early in the
;; first place (ddm 6/12/07)
(define-with-all-instances-permanent
  
    ;; Creating the individual gives us "many" => "many"
    ;; det:  "many" + noun form rule
    ;; of:  pw - "many of", cfr quantifier-of -> "many of"

  (define-quantifier "all"     :brackets '( ].quantifier  .[np ) :rules '(det of))
  (define-quantifier "any"     :brackets '( ].quantifier  .[np ) :rules '(det of))
  (define-quantifier "both"    :brackets '( ].quantifier  .[np ) :rules '(det of))
  (define-quantifier "each"    :brackets '( ].quantifier  .[np ) :rules '(det of))
  (define-quantifier "every"   :brackets '( ].quantifier  .[np ))
;; various
  (define-quantifier "some"    :brackets '( ].quantifier  .[np ) :rules '(det of))
  (define-quantifier "few"     :brackets '( ].quantifier  .[np ) :rules '(det of))
  (define-quantifier "many"    :brackets '( ].quantifier  .[np ) :rules '(det of))
  (define-quantifier "much"    :brackets '( ].quantifier  .[np ) :rules '(det of))
  (define-quantifier "several" :brackets '( ].quantifier  .[np ) :rules '(det of))


  (define-quantifier "as many as" :brackets '( ].quantifier  .[np )) ;; :rules '(det))
  ;; the rule blows up in a late stage of the form rule construction, presumably
  ;; because of the differences in the struct used for a word and the one for
  ;; a polyword
  (define-quantifier "as much as" :brackets '( ].quantifier  .[np ))
  (define-quantifier "as little as" :brackets '( ].quantifier  .[np ))
  (define-quantifier "as few as" :brackets '( ].quantifier  .[np ))


  (define-quantifier "such"    :brackets '( ].quantifier  .[np ) :rules '(det))
  
  (define-quantifier "none" :brackets '( ].quantifier  phrase.[ ) :rules '(of))
  
  (define-quantifier "no"   :brackets '( ].quantifier  .[np ) :rules '(det))
  
  
  (define-quantifier "another" :brackets '( ].quantifier  .[np ) :rules '(det of))
  
  ;; //?? Make special note of the cases that can take a preceding "the" ??
  
  (define-quantifier "additional" :brackets '( ].quantifier  .[np ) :rules '(det))
  (define-quantifier "other"      :brackets '( ].quantifier  .[np ) :rules '(det))


;;///////////////// don't belong here! want to be 'nominals' or some such
  (define-function-word "something" :brackets '( ].quantifier  .[np ))
  (define-function-word "nothing"   :brackets '( ].quantifier  .[np ))
  (define-function-word "anything"  :brackets '( ].quantifier  .[np ))
  
  (define-function-word "others"  :brackets '( ].quantifier  .[np  np]. ))
  
  (define-function-word "someone"  :brackets '( ].quantifier  .[np  np]. ))
  (define-function-word "everyone" :brackets '( ].quantifier  .[np  np]. ))
  (define-function-word "anyone"   :brackets '( ].quantifier  .[np  np]. ))
  (define-function-word "no one"   :brackets '( ].quantifier  .[np  np]. ))
  

  (define-function-word "not"  :brackets '( ].quantifier ))  ;; ??
  ;; gets you out of a problem with "...be careful not to..."
  ;; where without this there's a break before "to"

  )  ;; ends wrapper


