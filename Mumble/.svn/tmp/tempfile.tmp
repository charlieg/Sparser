;;; -*- Mode: Lisp; Syntax: Common-lisp; -*-
;;; $Id$
;;; Copyright (c) 2006-2009 BBNT Solutions LLC. All Rights Reserved

;; tweaked 3/30/07 to use shared utility area. 4/2 Gave up on pulling the
;; two utility files from a separate directory once that directory got other
;; routines, because the conditional dependency on the Mumble package was
;; too much to pull off in the time available.
;; 9/16/09 Added loader for derivation-trees. 9/18 refactored that

(in-package :user)

(defparameter mumble-location
  (if (member :allegro *features*)
    (namestring
     (make-pathname :directory (pathname-directory *load-truename*)))
    (break "Not running under Allegro Common Lisp.~
          ~%Can't construct relative pathname to location of Mumble")))

(defmacro string-append (&rest strings)
  `(concatenate 'string ,@strings))

(load (string-append mumble-location "design.lisp"))
(load (string-append mumble-location "loader/load-initial.lisp"))
;;(load (string-append mumble-location "util/lispm.lisp"))

(load (string-append mumble-location "types/defining-types.lisp"))
(load (string-append mumble-location "types/creating-objects.lisp"))
(load (string-append mumble-location "types/postprocessing.lisp"))

(load (string-append mumble-location  "derivation-trees/types.lisp"))

(load (string-append mumble-location "objects/all-the-object-types.lisp"))
(load (string-append mumble-location "objects/postprocess-objects.lisp"))
(load (string-append mumble-location "objects/postprocessing-order.lisp"))
(load (string-append mumble-location "objects/short-printers.lisp"))

(load (string-append mumble-location "util/tracker-stub"))
(load (string-append mumble-location "util/debug-stack"))

(load (string-append mumble-location "interface/bundles/standalone/defining-demos.lisp"))
(load (string-append mumble-location "interface/bundles/standalone/specification-language.lisp"))
(load (string-append mumble-location "interface/bundles/standalone/rspec-table.lisp"))
(load (string-append mumble-location "interface/bundles/standalone/interface-utilities.lisp"))
(load (string-append mumble-location "interface/bundles/standalone/demos-to-use.lisp"))

(load (string-append mumble-location "interface/browser/interface-to-text-output.lisp"))
(load (string-append mumble-location "interface/browser/glass-tty-menus.lisp"))
#+mcl (load (string-append mumble-location "interface/browser.lisp/mcl-output-window.lisp"))


(load (string-append mumble-location "interpreters/top-level.lisp"))
(load (string-append mumble-location "interpreters/realize.lisp"))
(load (string-append mumble-location "interpreters/instantiate-phrase.lisp"))
(load (string-append mumble-location "interpreters/phrase-structure-execution.lisp"))
(load (string-append mumble-location "interpreters/text-output.lisp"))
(load (string-append mumble-location "interpreters/attachment.lisp"))
(load (string-append mumble-location "interpreters/position-path-operations.lisp"))
(load (string-append mumble-location "interpreters/state.lisp"))

(load (string-append mumble-location "loader/load-midpoint.lisp"))

(load (string-append mumble-location "grammar/attachment-points.lisp"))
(load (string-append mumble-location "grammar/phrases.lisp"))
(load (string-append mumble-location "grammar/labels.lisp"))
(load (string-append mumble-location "grammar/characteristics.lisp"))
(load (string-append mumble-location "grammar/words.lisp"))
(load (string-append mumble-location "grammar/pronouns.lisp"))
(load (string-append mumble-location "grammar/tense-markers.lisp"))
(load (string-append mumble-location "grammar/traces.lisp"))
(load (string-append mumble-location "grammar/punctuation-marks.lisp"))
(load (string-append mumble-location "grammar/morphology.lisp")) ;; ok up to here
(load (string-append mumble-location "grammar/word-stream-actions.lisp"))

(load (string-append mumble-location "interface/bundles/accessory-types.lisp"))
(load (string-append mumble-location "interface/bundles/accessory-processing.lisp"))
(load (string-append mumble-location "interface/bundles/bundle-types.lisp"))
(load (string-append mumble-location "interface/bundles/bundle-drivers.lisp"))
(load (string-append mumble-location "interface/bundles/constructing-bundles.lisp"))


(load (string-append mumble-location "interface/tsro/gofers.lisp"))
(load (string-append mumble-location "grammar/numbers.lisp"))


;; These were thrown together for SELF and now feel like a short-cut that should
;; be removed in favor of derivation trees 
(load (string-append mumble-location "interface/derivations/types.lisp"))
;(load (string-append mumble-location "interface/derivations/rspec-interpretation.lisp"))
(load (string-append mumble-location "interface/derivations/discourse-reference.lisp"))

(load (string-append mumble-location "interface/bundles/specification-operators.lisp"))
(load (string-append mumble-location "interface/bundles/operators-over-specifications.lisp"))
(load (string-append mumble-location "interface/bundles/specification-templates.lisp"))

(load (string-append mumble-location "interface/bundles/tree-families.lisp"))
(load (string-append mumble-location "interface/bundles/single-choices.lisp"))
(load (string-append mumble-location "interface/bundles/curried-tree-families.lisp"))

(load (string-append mumble-location "derivation-trees/loader.lisp"))

(load (string-append mumble-location "loader/load-final.lisp"))
