;;; -*- Mode: Lisp; Syntax: Common-lisp; -*-
;;; $Id$
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved

;;; /nlp/Poirot/workspace-ddm.lisp

(in-package :cl-user)

;; A parameter that affects the choice of grammar-configuration and
;; Sparser switch-settings by determining which script is used to
;; load the system. -- choose one. 
;; If you do noting it defaults to :poirot 
(defvar *sparser-script-setting* :fire) ;; the full grammar
(defvar *sparser-script-setting* :checkpoint)

(defvar *poirot-load* :mdis) ;; default
(defvar *poirot-load* :xplain)
(defvar *poirot-load* :medivac)

;; All in one
(load "/Users/ddm/ws/nlp/Poirot/load-nlp-poirot.lisp")

;;--- reading out a realization schema (for want of a better term)
;;    from an edge (hacks & short-cuts galore)
(load "/Users/ddm/ws/nlp/Poirot/load-nlp-poirot.lisp")
(progn 
  ;; #1 give us an edge to use as a model
  (sparser::p "10 days")  ;; n.b. "10 months" blows up -- method is too narrowly typed

  ;; #2 Make a model of the way that edge was parsed and associate that
  ;;    model (rpath) with the category of the referent
  (setq mumble::rpath (sparser::rpath-from-edge (sparser::e# 3)))
  ;; That code is in grammar/model/sl/poirot/ad-hoc-annotation
  ;; As a side-effect it does the equivalent of this:
  ;;     (sparser::assign-rdata (ltml::getOwlClass ltml:ts@Duration) rpath)

  ;; #3 Now make a new instance to work with
  (setq mumble::i (ltml:instantiate-SFL-concept 'ltml::ts@Duration :env (ltml::ns-env 'ltml::ts) :property-value-pairs `(:top@measuredIn ,(ltml:lookup 'ltml::ts@Month) :top@quantity 5)))
) ;; end progn of setup expressions  

;; #4
(in-package :mumble)
(turn-on-tracker) ;; traces progress through the surface structure tree
(turn-off-tracker)
(say i)  ;; in mumble/interpreters/top-level
;; which first goes to 
;; (realization-for i)  in Poirot/realization-mapping
;; which in turn uses
;; (convert-to-derivation-tree sparser::rpath i) in Mumble/derivation-trees/conversions



;;--- earlier baby step realization
(in-package :mumble)

;; goal -- "a date" Presently just says "date" because there's no feature
;;   set to provide the determiner and the resource is just the word
(setq date (ltml::lookup 'ltml::ts@Date))
(setq rdata (sparser::get-rdata date))
(turn-on-tracker)
(say date)


;;--- Sparser traces in frequent use
(trace-network-flow) ;; exhaustive lowest-level detail
(trace-pnf)  ;;  pnf = "proper name routine"
(trace-brackets) ;; placing and reacting to brackets
(trace-segments) ;; initiating and managing phrase segments

;;;-------------------------------------------------
;;; Constituent pieces (for doing the load by-hand)
;;;-------------------------------------------------

(asdf:operate 'asdf:load-op :sfl)

(asdf:operate 'asdf:load-op :ddm-util)
(load "/Users/ddm/ws/nlp/Mumble/loader.lisp")

(load "/Users/ddm/ws/nlp/Sparser/Code/s/init/scripts/fire.lisp")
(load "/Users/ddm/ws/nlp/Sparser/Code/s/init/scripts/mdis.lisp")
(load "/Users/ddm/ws/nlp/Sparser/Code/s/init/scripts/checkpoint-ops.lisp")
(load "/Users/ddm/ws/nlp/Sparser/Code/s/init/everything.lisp")

(asdf:operate 'asdf:load-op :service-defs)
(asdf:operate 'asdf:load-op :interprettrace)

(in-package :sparser)
(progn
  (setq *trace-realization-definition* t)
  (setq *expand-realizations-when-enqueued* t)
  (expand-realizations))
(gload "poirot;time")



