;;; -*- Mode: Lisp; Syntax: COMMON-LISP; Base:10; -*-
;;; $Id$
;;; Copyright (c) 2007 BBNT Solutions LLC. All Rights Reserved

;; initiated 3/30/07. 

(unless (find-package :ddm-util) 
  (defpackage :ddm-util
    (:use :common-lisp :asdf)))

(in-package :ddm-util)

(defsystem :ddm-util
  :serial t
  :components (;;(:file "lispm") --  Mine for routines not in util
	       (:file "util")
	       (:file "push-debug")
	       (:file "indexed-object")
	       (:file "indentation")
	       ;; (:file "csv-read")
	       (:file "auto-gen")))

(defmethod perform :after ((op load-op)
			   (component
			    (eql (find-component (find-system :ddm-util)
						 "auto-gen"))))
  (use-package '(:push-debug
		 )
	       (find-package :ddm-util)))


#|
;;--- from Poirot

;;--- From Mark - needs to be in a different package
;(load "~/ws/nlp/util/csv-read.lisp")

;;;--- new 
(load "~/ws/nlp/util/auto-gen.lisp")
|#
