;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "markup buttons"
;;;    Module:   "interface;SUN:"
;;;   Version:   December 1994

;; initiated 12/13/94. extended ...12/16

(in-package :sparser)

;;;----------------
;;; action buttons
;;;----------------

(defparameter *smu/next-phrase*        ;; "smu" = "SUN markup"
  (MAKE-DIALOG-ITEM
   'BUTTON-DIALOG-ITEM
   #@(265 152)  ;; position h/v
   #@(98 16)    ;; size h/v
   "next phrase"
   'Select-next-SUN-phrase     ;; action
   :DEFAULT-BUTTON NIL ))

(defparameter *smu/mark-it*
  (MAKE-DIALOG-ITEM
   'BUTTON-DIALOG-ITEM
   #@(389 200)
   #@(72 16)
   "mark it"
   'Mark-selected-SUN-phrase
   :DEFAULT-BUTTON T ))



(defparameter *smu/edge-decription*
  ;; At the top of the area. Gets a value when the edge has a referent
  ;; and consequently doesn't have to be marked up.
  (MAKE-DIALOG-ITEM
  'STATIC-TEXT-DIALOG-ITEM
  #@(264 149)
  #@(219 16)
  ""
  'NIL
  :VIEW-FONT '("Times" 12 :SRCOR :PLAIN)))


(defparameter *smu/subtypes-button*
  (MAKE-DIALOG-ITEM
   'BUTTON-DIALOG-ITEM
   #@(334 282)
   #@(72 22)
   "subtypes"
   'bring-up-subtypes-dialog
   :DEFAULT-BUTTON NIL))


;;;-------------------------------
;;; radio buttons for ok/mistaken
;;;-------------------------------

(defparameter *button-cluster/smu-good-bad*
  (next-button-cluster-number))

(defparameter *smu/ok*
  (MAKE-DIALOG-ITEM
   'RADIO-BUTTON-DIALOG-ITEM
   #@(383 152)
   #@(59 16)
   "ok"
   'set-smu-mode/phrase-is-good
   ;;:RADIO-BUTTON-PUSHED-P t
   :RADIO-BUTTON-CLUSTER *button-cluster/smu-good-bad* ))

(defparameter *smu/mistaken*
  (MAKE-DIALOG-ITEM
  'RADIO-BUTTON-DIALOG-ITEM
  #@(383 170)
  #@(82 16)
  "mistaken"
  'set-smu-mode/phrase-is-bad
  ;;:RADIO-BUTTON-PUSHED-P nil
  :RADIO-BUTTON-CLUSTER *button-cluster/smu-good-bad* ))


;;;-------------------------------------
;;; radio buttons for SUN-Unix/cs/other
;;;-------------------------------------

#| These don't have actions. They are read out when the classification
   data is read out. |#


(defparameter *button-cluster/smu-SUN/CS/other*
  (next-button-cluster-number))

(defparameter *smu/SUN-Unix*
  (MAKE-DIALOG-ITEM
   'RADIO-BUTTON-DIALOG-ITEM
   #@(276 323)
   #@(66 16)
   "SUN/Unix"
   'smu/SUN-Unix-pushed        
   :VIEW-FONT '("Times" 10 :SRCOR :PLAIN)
   ;;:RADIO-BUTTON-PUSHED-P (eq *smu-semantic-field* :sun-or-unix)
   :RADIO-BUTTON-CLUSTER *button-cluster/smu-SUN/CS/other*))

(defparameter *smu/generic-cs* 
  (MAKE-DIALOG-ITEM
   'RADIO-BUTTON-DIALOG-ITEM
   #@(346 323)
   #@(64 16)
   "Comp.Sci."
   'smu/generic-cs-pushed
   :VIEW-FONT '("Times" 10 :SRCOR :PLAIN)
   ;;:RADIO-BUTTON-PUSHED-P (eq *smu-semantic-field* :generic-cs)
   :RADIO-BUTTON-CLUSTER *button-cluster/smu-SUN/CS/other*))


(defparameter *smu/other-field* 
  (MAKE-DIALOG-ITEM
   'RADIO-BUTTON-DIALOG-ITEM
   #@(414 323)
   #@(44 16)
   "Other"
   'smu/semantic-field-other-pushed
   :VIEW-FONT '("Times" 12 :SRCOR :PLAIN)
   ;;:RADIO-BUTTON-PUSHED-P (eq *smu-semantic-field* :other)
   :RADIO-BUTTON-CLUSTER *button-cluster/smu-SUN/CS/other*))


;;--- pushing them

(defparameter *smu-semantic-field* :sun-or-unix)

(defun smu/SUN-Unix-pushed (button)
  (declare (ignore button))
  (setq *smu-semantic-field* :sun-or-unix))

(defun smu/generic-cs-pushed (button)
  (declare (ignore button))
  (setq *smu-semantic-field* :generic-cs))

(defun smu/semantic-field-other-pushed (button)
  (declare (ignore button))
  (setq *smu-semantic-field* :other))



;;;-----------------
;;; classifications
;;;-----------------

(defparameter *button-cluster/smu-classifications*
  (next-button-cluster-number))

(defparameter *smu/kind*
  (MAKE-DIALOG-ITEM
  'RADIO-BUTTON-DIALOG-ITEM
  #@(289 186)
  #@(72 16)
  "kind"
  'NIL
  :VIEW-FONT '("Times" 12 :SRCOR :PLAIN)
  :RADIO-BUTTON-PUSHED-P (eq :kind *current-smu-classification*)
  :RADIO-BUTTON-CLUSTER *button-cluster/smu-classifications* ))

(defparameter *smu/proper-name*
  (MAKE-DIALOG-ITEM
  'RADIO-BUTTON-DIALOG-ITEM
  #@(289 204)
  #@(90 16)
  "proper name"
  'NIL
  :VIEW-FONT '("Times" 12 :SRCOR :PLAIN)
  :RADIO-BUTTON-PUSHED-P (eq :proper-name *current-smu-classification*)
  :RADIO-BUTTON-CLUSTER *button-cluster/smu-classifications* ))

(defparameter *smu/machine-type*
  (MAKE-DIALOG-ITEM
  'RADIO-BUTTON-DIALOG-ITEM
  #@(289 222)
  #@(119 16)
  "machine type"
  'NIL
  :VIEW-FONT '("Times" 12 :SRCOR :PLAIN)
  :RADIO-BUTTON-PUSHED-P (eq :machine-type *current-smu-classification*)
  :RADIO-BUTTON-CLUSTER *button-cluster/smu-classifications* ))

(defparameter *smu/file-name*
  (MAKE-DIALOG-ITEM
  'RADIO-BUTTON-DIALOG-ITEM
  #@(289 241)
  #@(72 16)
  "file name"
  'NIL
  :VIEW-FONT '("Times" 12 :SRCOR :PLAIN)
  :RADIO-BUTTON-PUSHED-P (eq :file-name *current-smu-classification*)
  :RADIO-BUTTON-CLUSTER *button-cluster/smu-classifications* ))

(defparameter *smu/other*
  (MAKE-DIALOG-ITEM
   'RADIO-BUTTON-DIALOG-ITEM
   #@(289 270)
   #@(72 16)
   "other"
   'NIL
   :VIEW-FONT '("Times" 12 :SRCOR :PLAIN)
   :RADIO-BUTTON-PUSHED-P (eq :other *current-smu-classification*)
   :RADIO-BUTTON-CLUSTER *button-cluster/smu-classifications* ))



;;; acting on the classification radio buttons

(defun readout-smu-classification-buttons ()
  (cond
   ((ccl:radio-button-pushed-p *smu/kind*) :kind)
   ((ccl:radio-button-pushed-p *smu/proper-name*) :proper-name)
   ((ccl:radio-button-pushed-p *smu/machine-type*) :machine-type)
   ((ccl:radio-button-pushed-p *smu/file-name*) :file-name)
   ((ccl:radio-button-pushed-p *smu/other*) :other)
   (t
    (break "None of the smu classification radio buttons ~
            was pushed"))))

(defun readout-gross-semantic-field-buttons ()
  (cond
   ((ccl:radio-button-pushed-p *smu/SUN-Unix*) :sun-or-unix)
   ((ccl:radio-button-pushed-p *smu/generic-cs*) :generic-cs)
   ((ccl:radio-button-pushed-p *smu/other-field*) :other)
   (t
    (break "None of the smu semantic field radio buttons ~
            was pushed")
    *smu-semantic-field*)))


;;;-------------------
;;; launching routine
;;;-------------------

(defun launch-SUN-markup-overlay ()
  (if *workshop-window*
    (unless (eq *current-wb-subview-mode* :edges)
      (setq *current-wb-subview-mode* :edges)
      (initialize-subview-state))
    (else
      (setq *current-wb-subview-mode* :edges)
      (launch-all-in-one-workbench)))

  (ccl:add-subviews *workshop-window* *smu/next-phrase*
                                      *smu/mark-it*
                                      *smu/subtypes-button*
                                      
                                      *smu/edge-decription*

                                      *smu/ok*
                                      *smu/mistaken*
                                      
                                      *smu/kind*
                                      *smu/proper-name*
                                      *smu/machine-type*
                                      *smu/file-name*
                                      *smu/other*

                                      *smu/SUN-Unix*
                                      *smu/generic-cs*
                                      *smu/other-field*
                                      )
  (locate-buttons-for-SUN-overlay))

;(launch-SUN-markup-overlay)



(defun locate-buttons-for-SUN-overlay ()
  ;; Assumes all-in-one.  //should be matched to *monitor-size*
  (set-view-position *smu/next-phrase*  #@(265 172))  ;; h/v
  (set-view-position *smu/mark-it*      #@(383 240))
  (set-view-position *smu/subtypes-button*  #@(334 282))

  (set-view-position *smu/edge-decription*  #@(265 149))

  (set-view-position *smu/ok*           #@(353 193))
  (set-view-position *smu/mistaken*     #@(353 210))

  (set-view-position *smu/SUN-Unix*     #@(276 323))
  (set-view-position *smu/generic-cs*   #@(346 323))
  (set-view-position *smu/other-field*  #@(414 323))

  (set-view-position *smu/kind*         #@(259 206))
  (set-view-position *smu/proper-name*  #@(259 224))
  (set-view-position *smu/machine-type* #@(259 242))
  (set-view-position *smu/file-name*    #@(259 261))
  (set-view-position *smu/other*        #@(259 290))
  )




;;;----------------------------------------
;;;----------------------------------------
;;; the subdialog for the grammatical data
;;;----------------------------------------
;;;----------------------------------------

(defparameter *smu/standard-markup-subdialog/ok*
  (MAKE-DIALOG-ITEM
   'BUTTON-DIALOG-ITEM
   #@(15 20)  ;; try to align it over the 'mark it' button
   #@(46 20)
   "ok"
   'readout-button-values-onto-current-phrase
   :DEFAULT-BUTTON T))


(defparameter *smu/reconsider*
  (MAKE-DIALOG-ITEM
   'BUTTON-DIALOG-ITEM
   #@(141 63)
   #@(69 32)
   "reconsider
category"
   'smu/return-to-classification-state
   :VIEW-FONT '("Times" 12 :SRCOR :PLAIN)
   :DEFAULT-BUTTON NIL))


(defparameter *button-cluster/smu-pos*
  (next-button-cluster-number))

(defparameter *smu-pos/noun*
  (MAKE-DIALOG-ITEM
   'RADIO-BUTTON-DIALOG-ITEM
   #@(84 9)
   #@(72 16)
   "noun"
   'NIL
   :RADIO-BUTTON-PUSHED-P (eq *smu/pos-choice* :noun)
   :RADIO-BUTTON-CLUSTER *button-cluster/smu-pos* ))

(defparameter *smu-pos/verb*
  (MAKE-DIALOG-ITEM
   'RADIO-BUTTON-DIALOG-ITEM
   #@(85 25)
   #@(61 16)
   "verb"
   'NIL
   :RADIO-BUTTON-PUSHED-P (eq *smu/pos-choice* :verb)
   :RADIO-BUTTON-CLUSTER *button-cluster/smu-pos* ))

(defparameter *smu-pos/adjective*
  (MAKE-DIALOG-ITEM
   'RADIO-BUTTON-DIALOG-ITEM
   #@(158 8)
   #@(89 16)
   "adjective"
   'NIL
   :RADIO-BUTTON-PUSHED-P (eq *smu/pos-choice* :adjective)
   :RADIO-BUTTON-CLUSTER *button-cluster/smu-pos* ))

(defparameter *smu-pos/adverb*
  (MAKE-DIALOG-ITEM
   'RADIO-BUTTON-DIALOG-ITEM
   #@(159 25)
   #@(72 16)
   "adverb"
   'NIL
   :RADIO-BUTTON-PUSHED-P (eq *smu/pos-choice* :adverb)
   :RADIO-BUTTON-CLUSTER *button-cluster/smu-pos* ))


(defparameter *button-cluster/smu-features*
  (next-button-cluster-number))

(defparameter *smu-feature/count*
  (MAKE-DIALOG-ITEM
   'RADIO-BUTTON-DIALOG-ITEM
   #@(32 57)
   #@(72 16)
   "count"
   'NIL
   :RADIO-BUTTON-PUSHED-P (setq *smu/features-choice* :count)
   :RADIO-BUTTON-CLUSTER *button-cluster/smu-features* ))

(defparameter *smu-feature/mass*
  (MAKE-DIALOG-ITEM
   'RADIO-BUTTON-DIALOG-ITEM
   #@(32 74)
   #@(72 16)
   "mass"
   'NIL
   :RADIO-BUTTON-PUSHED-P (setq *smu/features-choice* :mass)
   :RADIO-BUTTON-CLUSTER *button-cluster/smu-features* ))

(defparameter *smu-feature/plural*
  (MAKE-DIALOG-ITEM
   'RADIO-BUTTON-DIALOG-ITEM
   #@(33 92)
   #@(72 16)
   "plural"
   'NIL
   :RADIO-BUTTON-PUSHED-P (setq *smu/features-choice* :plural)
   :RADIO-BUTTON-CLUSTER *button-cluster/smu-features* ))


;;--- reading these out

(defun readout-smu-pos-radio-buttons ()
  (cond
   ((ccl:radio-button-pushed-p *smu-pos/noun*) :noun)
   ((ccl:radio-button-pushed-p *smu-pos/verb*) :verb)
   ((ccl:radio-button-pushed-p *smu-pos/adjective*) :adjective)
   ((ccl:radio-button-pushed-p *smu-pos/adverb*) :adverb)
   (t
    (break "None of the smu part of speech dialog buttons ~
            was pushed"))))

(defun readout-smu-features-radio-buttons ()
  (cond
   ((ccl:radio-button-pushed-p *smu-feature/count*) :count)
   ((ccl:radio-button-pushed-p *smu-feature/mass*) :mass)
   ((ccl:radio-button-pushed-p *smu-feature/plural*) :plural)
   (t
    (break "None of the smu features dialog buttons ~
            was pushed"))))



;;--- launching it

(defparameter *smu/standard-markup-subdialog* nil)

(defclass smu/standard-markup-subdialog (dialog) ())


(defun launch-smu-standard-features-dialog ()
  (setq *smu/standard-markup-subdialog*
        (MAKE-INSTANCE 'smu/standard-markup-subdialog
          :WINDOW-TYPE :DOCUMENT-WITH-GROW
          :window-title "standard properties"
          :VIEW-POSITION #@(375 218)
          :VIEW-SIZE #@(265 139)
          :VIEW-FONT '("Chicago" 12 :SRCOR :PLAIN)
          :VIEW-SUBVIEWS (LIST *smu/standard-markup-subdialog/ok*
                               *smu/reconsider*

                               *smu-pos/noun*
                               *smu-pos/verb*
                               *smu-pos/adjective*
                               *smu-pos/adverb*
                               
                               *smu-feature/count*
                               *smu-feature/mass*
                               *smu-feature/plural*))))


(defmethod window-close ((smsd smu/standard-markup-subdialog))
  (close-down-smu/standard-markup-subdialog)
  (call-next-method smsd))

(defun close-down-smu/standard-markup-subdialog ()
  (setq *smu/standard-markup-subdialog* nil))



#|
*smu/standard-markup-subdialog/ok*
*smu/reconsider*

*smu-pos/noun*
*smu-pos/verb*
*smu-pos/adjective*
*smu-pos/adverb*

*smu-feature/count*
*smu-feature/mass*
*smu-feature/plural*  |#

