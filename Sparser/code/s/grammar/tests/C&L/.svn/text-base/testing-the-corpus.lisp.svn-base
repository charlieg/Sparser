;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "C&L testing corpus"
;;;   Module:  "grammar;tests:"
;;;  version:  1.1  January 1991       v1.7

;;1.1  (1/4, v1.7)  Pathname changes

(in-package :CTI-source)


;;;--------------------------------------------
;;; running over articles in C&L's test corpus
;;;--------------------------------------------

(def-logical-pathname "C&L test corpus;"
  "hd;CTI:Miolnir:xx non-CTI:C&L:corpus 11/24:")


(defun f/prw (pathname)
  (princ pathname)
  (when *open-stream-of-source-characters*
    (close-character-source-file))
  (let ((*initial-region* :text-body)
        (*display-word-stream* nil))
    (analyze-text-from-file pathname)))




(defparameter *C&L-90-article-text-corpus*
 '(
    (f/prw "C&L test corpus;90mondb01-ACAR")
    (f/prw "C&L test corpus;90mondb01-EAID")
  (f/prw "C&L test corpus;90mondb01-FWAL03")
  (f/prw "C&L test corpus;90mondb01-LHIDEF")
  (f/prw "C&L test corpus;90mondb01-LYUZEN")
    (f/prw "C&L test corpus;90mondb01-OBUD")
  (f/prw "C&L test corpus;90mondb02-EKAIFU")
    (f/prw "C&L test corpus;90mondb02-EOLS")
  (f/prw "C&L test corpus;90mondb02-FSPACE")
    (f/prw "C&L test corpus;90mondb02-LGEO")
 (f/prw "C&L test corpus;90mondb02-OFILL10")
    (f/prw "C&L test corpus;90mondb02-ONET")
   (f/prw "C&L test corpus;90mondb02-OTRIP")
  (f/prw "C&L test corpus;90mondb02-PFREED")   ;;Pfreed error
    (f/prw "C&L test corpus;90mondb03-FCAR")
    (f/prw "C&L test corpus;90mondb03-OTOK")
  (f/prw "C&L test corpus;90mondb04-ATRADE")
  (f/prw "C&L test corpus;90mondb04-D1WORD")
   (f/prw "C&L test corpus;90mondb04-DWORD")
   (f/prw "C&L test corpus;90mondb04-ENEAL")
   (f/prw "C&L test corpus;90mondb04-FLAND")
   (f/prw "C&L test corpus;90mondb04-OCLAY")
    (f/prw "C&L test corpus;90mondb04-OEAS")
(f/prw "C&L test corpus;90mondb04-OPREPARE")
    (f/prw "C&L test corpus;90mondb04-OYEN")
   (f/prw "C&L test corpus;90mondb05-ASAVE")
  (f/prw "C&L test corpus;90mondb05-CURR01")
   (f/prw "C&L test corpus;90mondb05-EJAPA")
  (f/prw "C&L test corpus;90mondb05-F1AUTO")
  (f/prw "C&L test corpus;90mondb05-FAUTOS")
  (f/prw "C&L test corpus;90mondb05-FHONDA")
  (f/prw "C&L test corpus;90mondb05-FWAL29")
    (f/prw "C&L test corpus;90mondb05-OAIR")
   (f/prw "C&L test corpus;90mondb06-ADAVE")
   (f/prw "C&L test corpus;90mondb06-EHOLL")
  (f/prw "C&L test corpus;90mondb06-FJAPEL")
  (f/prw "C&L test corpus;90mondb06-FWAL05")
    (f/prw "C&L test corpus;90mondb06-OTIE")
    (f/prw "C&L test corpus;90mondb06-UJAK")
  (f/prw "C&L test corpus;90mondb07-CURR12")
  (f/prw "C&L test corpus;90mondb07-CURR15")
  (f/prw "C&L test corpus;90mondb07-DBMEGA")
   (f/prw "C&L test corpus;90mondb07-ECHAN")
    (f/prw "C&L test corpus;90mondb07-EHAM")
  (f/prw "C&L test corpus;90mondb07-EJAPAN")
 (f/prw "C&L test corpus;90mondb07-F1PLANT")
 (f/prw "C&L test corpus;90mondb07-FALLY")
 (f/prw "C&L test corpus;90mondb07-LRAIN")
(f/prw "C&L test corpus;90mondb07-O1PART")
 (f/prw "C&L test corpus;90mondb07-OCHEN")
 (f/prw "C&L test corpus;90mondb07-OCHEN")
 (f/prw "C&L test corpus;90mondb07-OELEC")
 (f/prw "C&L test corpus;90mondb07-OPART")
 (f/prw "C&L test corpus;90mondb07-OWIFE")
 (f/prw "C&L test corpus;90mondb07-UHOPE")
 (f/prw "C&L test corpus;90mondb08-EREUS")
(f/prw "C&L test corpus;90mondb08-OCOUNT")
 (f/prw "C&L test corpus;90mondb08-ONEGO")   ;;Pfreed error
(f/prw "C&L test corpus;90mondb09-CURR01")
(f/prw "C&L test corpus;90mondb09-CURR02")
(f/prw "C&L test corpus;90mondb09-CURR26")
(f/prw "C&L test corpus;90mondb09-CURR28")
(f/prw "C&L test corpus;90mondb09-DCOW27")
  (f/prw "C&L test corpus;90mondb09-FJAP")
(f/prw "C&L test corpus;90mondb09-FRAN02")
  (f/prw "C&L test corpus;90mondb09-FSAM")
  (f/prw "C&L test corpus;90mondb09-FTOK")
 (f/prw "C&L test corpus;90mondb09-OSUMM")
(f/prw "C&L test corpus;90mondb10-CURR05")
(f/prw "C&L test corpus;90mondb10-CURR07")
(f/prw "C&L test corpus;90mondb10-CURR09")
(f/prw "C&L test corpus;90mondb10-EJAPAN")
 (f/prw "C&L test corpus;90mondb10-ELIEB")
 (f/prw "C&L test corpus;90mondb10-OLAND")
 (f/prw "C&L test corpus;90mondb10-OMEET")
 (f/prw "C&L test corpus;90mondb10-OSWAP")
(f/prw "C&L test corpus;90mondb11-ABLOSS")
  (f/prw "C&L test corpus;90mondb11-AFOR")
(f/prw "C&L test corpus;90mondb11-CURR14")
  (f/prw "C&L test corpus;90mondb11-ENOV")
  (f/prw "C&L test corpus;90mondb11-EOKA")
 (f/prw "C&L test corpus;90mondb11-F1NET")
  (f/prw "C&L test corpus;90mondb11-FNET")
(f/prw "C&L test corpus;90mondb12-AECON4")
(f/prw "C&L test corpus;90mondb12-AGLOBE")
(f/prw "C&L test corpus;90mondb12-CURR19")
(f/prw "C&L test corpus;90mondb12-ECOU20")
  (f/prw "C&L test corpus;90mondb12-ED22")
(f/prw "C&L test corpus;90mondb12-OBIRTH")
 (f/prw "C&L test corpus;90mondb12-OJAPA")  ;;Pfreed error
))



(defvar *articles-yet-to-do* nil)
(defvar *articles-done* nil)

(defun iterate-through-articles
       (&optional (article-list *C&L-90-article-text-corpus*)
                  &aux article-form
                       (count 0))
  (setq *articles-yet-to-do* article-list)
  (loop
    (setq article-form (pop *articles-yet-to-do*))
    (incf count)
    (format t "~%~A. " count)
    (eval article-form)
    (push article-form *articles-done*)
    (when (null *articles-yet-to-do*)
      (return))))



(when (y-or-n-p "Run through the test corpus?")
  (iterate-through-articles))

