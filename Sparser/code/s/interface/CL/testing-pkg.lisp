;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "testing pkg"
;;;   Module:  "interface;PRW"
;;;  Version:   1.0  September 1990
;;;

(in-package :CTI-source)


(or (find-package :it)
    (make-package :it
                  :nicknames '(:interface-testing)
                  :use :lisp))


