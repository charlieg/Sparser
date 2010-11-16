;;; -*- Mode: Lisp; Syntax: Common-lisp; -*-
;;; $Id$

;;;  MUMBLE-86:  design

;;; Copyright (C) 1985, 1986, 1987, 1988  David D. McDonald
;;;   and the Mumble Development Group.  All rights
;;;   reserved. Permission is granted to use and copy
;;;   this file of the Mumble-86 system for
;;;   non-commercial purposes.
;;; Copyright (c) 2006 BBNT Solutions LLC. All Rights Reserved

(in-package :common-lisp)

(unless (find-package :ddm-util)
  (break "Setup problem -- ddm-util should have been loaded"))

(defpackage :mumble (:use :common-lisp :ddm-util))

(in-package :mumble)
(export '(mumble demos build-mumble-frame)
	(find-package :mumble))
(shadow '(labels
	  locative
	  number)
	 (find-package :mumble))
