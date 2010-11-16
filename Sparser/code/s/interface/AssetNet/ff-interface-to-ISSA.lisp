
;;; David McDonald
;;; phone (617) 646-4124
;;; fax 648-1735

;; The comment character is a semi-colon -- everything  after
;; the semi-colon is ignored on that line.

;;;------------------------------------
;;; Interface between Sparser and ISSA
;;;------------------------------------

(in-package :user)
  ;; lisp starts in this package, this guarentees that the function
  ;; names in this file will be recognized when you are testing them
  ;; by typing them into the interactive Lisp window.


;; Then we have to make lisp appreciate that the function it is
;; going to call is "foreign" rather than defined in lisp.
;;
;; I'm assuming here that your ANET_ERNANCMT function takes three
;; values, each one being a string.  I suspect from your documentation
;; (pg. 4-4) that I've got this wrong, and that its maybe a single
;; structure/record with three fields -- but is there a single such
;; record that is overwritten each time it is used? or is a new record
;; constructed each time? In any event, the discussion in the Lucid
;; lisp manual about overwritting foreign data structures is so far
;; pretty opaque, so I'll wait for more instructions here.
;;
(def-foreign-function (anet_ernancmt (:language :c)
                                     (:return-type :null))
  (tkr          :string)
  (qtr_idr      :string)
  (earnings_amt :string))


;; Now we have to load the part of your code that I' be calling.
;; The file name goes between double quotes.
;; This call to load the file shouldn't be executed until AFTER the
;; foreign function definition has been executed.
;;
(load-foreign-files "usr/users/ISSA/XXXXXXX.o")


(defun test-message (ticker    ;; e.g. "IBM"
                     quarter   ;; "3Q91"
                     earnings  ;; "-1.23"     //??is this ok for losses??
                     )
  ;; this matches the modularity of my actual call, i.e. I form the
  ;; strings in separate routines and then pass them to one routine
  ;; to go out to your stuff.

  (anet_ernancmt ticker quarter earnings))


;; e.g. evaluate this form:
;;      (ticker-message "IBM" "3Q91" "-1.23")

