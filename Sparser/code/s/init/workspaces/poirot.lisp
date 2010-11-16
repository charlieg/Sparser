;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CL-USER COMMON-LISP) -*-
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$
;;;
;;;      File:   "poirot"
;;;    Module:   "init;workspaces:"
;;;   version:   September 2009

;; initiated 9/1/09. Elaborated through 9/13

(load "~/ws/nlp/Sparser/code/s/init/scripts/poirot.lisp")
;; 1. Sparser has to be loaded before Poirot in order to set the global and
;; define the function for reading the realization statements in the class
;; and individual definitions.


;; 2. Load Poirot
(asdf:operate 'asdf:load-op :service-defs) ;; or
(asdf:operate 'asdf:load-op :interprettrace) 

(in-package :sparser)

;; 3. Expand the realizations
(progn  ;; in the sparser package
  (setq *trace-realization-definition* t)
    ;; provide some feedback
  (setq *expand-realizations-when-enqueued* t)
    ;; for modifying/elaborating realization definitions after the
    ;; initial load
  (expand-realizations)) ;; runs the realization forms that were
                         ;; stored when Poirot was loaded

;; 4. Has to be loaded later because it references poirot classes in its methods
(gload "poirot;time")

;; 5. Initialize the time code. Create the "actuals"
(in-package :ltml)
(initialize-time-to-first-day-of-year "1/1/2009" 'Thursday)

;; 6. Provide a value for the indexical
(ltml::today)