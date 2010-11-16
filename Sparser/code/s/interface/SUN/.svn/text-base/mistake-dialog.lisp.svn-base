;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "mistake dialog"
;;;    Module:   "interface;SUN:"
;;;   Version:   December 1994

;; initiated 12/19/94

(in-package :sparser)


;;;---------
;;; actions
;;;---------

(defparameter  *mistake-dialog/ok*
  (MAKE-DIALOG-ITEM
   'BUTTON-DIALOG-ITEM
   #@(20 12)
   #@(40 16)
   "ok"
   'return-from-mistake-dialog
   :DEFAULT-BUTTON  T ))


(defparameter  *mistake-dialog/add-category*
  (MAKE-DIALOG-ITEM
   'BUTTON-DIALOG-ITEM
   #@(99 12)
   #@(100 16)
   "add category"
   'add-category-to-mistake-dialog
   :VIEW-FONT '("Courier" 10 :SRCOR :PLAIN)
   :DEFAULT-BUTTON NIL))


(defparameter  *mistake-reconsider*
  (MAKE-DIALOG-ITEM
  'BUTTON-DIALOG-ITEM
  #@(216 12)
  #@(53 16)
  "reset"
  'mistake/hide-and-return-to-workbench
  :DEFAULT-BUTTON NIL))



;;;-----------
;;; the table
;;;-----------

(defclass mistake-selection-table (sequence-dialog-item) ())

(defparameter *mistake-dialog/category-table* nil)

(defparameter *mistake-dialog/sequence* nil)

(defparameter *selected-mistake* nil)


(defun setup-mistake-selection-table ()
  (setq *mistake-dialog/category-table*
        (make-instance 'mistake-selection-table
          :view-container *mistake-selection-window*
          :view-position #@(9 39)
            ;; n.b. this position is relative to the tableau window
          :view-size #@(250 290)
          ::CELL-SIZE #@(234 16)  ;;?? relationship to a :visible-dimensions arg. ??
          :SELECTION-TYPE :SINGLE
          :TABLE-HSCROLLP NIL
          :TABLE-VSCROLLP T
          :sequence-wrap-length 2000
          :dialog-item-action 'set-mistake-category
          :table-print-function 'print-mistake/table
          :TABLE-SEQUENCE *mistake-dialog/sequence* )))


;;;-----------------------------------------
;;; print and action routines for the table
;;;-----------------------------------------

(defun print-mistake/table (st stream)
  (if (or (referential-category-p st)
          (category-p st))
    (format stream "~A" (string-downcase
                         (symbol-name (cat-symbol st))))
    (format t "~&~%----- item in mistake table is not a category~
               -----~%      ~A~%~%" st)))


(defun set-mistake-category (table)
  (declare (ignore table))
  (update-selected-mistake-from-selected-cell)
  (ccl:dialog-item-enable *mistake-dialog/ok*))


;;;-------------------
;;; the dialog window
;;;-------------------

(defclass mistake-selection-tableau (dialog) ())

(defparameter *mistake-selection-window* nil)

(defun launch-mistake-selection-tableau ()
  (setq *mistake-selection-window*
        (MAKE-INSTANCE 'subtype-selection-tableau
          :WINDOW-TYPE  :DOCUMENT-WITH-GROW
          :window-title "subtypes"
          :VIEW-POSITION  #@(400 250)
          :VIEW-SIZE  #@(291 338)
          :VIEW-FONT  '("Chicago" 12 :SRCOR :PLAIN)
          :VIEW-SUBVIEWS
          (LIST *mistake-dialog/ok*
                *mistake-dialog/add-category*
                *mistake-reconsider*
                *mistake-dialog/category-table* ))))


(defmethod window-close ((w mistake-selection-tableau))
  (close-down-mistake-selection-tableau-state)
  (call-next-method w))

(defun close-down-mistake-selection-tableau-state ()
  (setq *mistake-selection-window* nil
        *mistake-dialog/category-table* nil
        *mistake-dialog/sequence* nil))



;;;-------------------
;;; Button operations
;;;-------------------

(define-category  mistake
  :specializes nil
  :instantiates nil )


(defparameter *parent-category-to-mistake-dialog* (category-named 'mistake))
  

(defun bring-up-mistake-dialog ()
  ;; Called from Mark-phrase-as-mistaken
  (declare (ignore button))
  ;; Called when the 'mark it' button is pushed and the 'mistake' radio
  ;; button is pushed.
  (ccl:dialog-item-disable *mistake-dialog/ok*)
  (let* ((parent-category (category-named 'mistake))
         (daughters (cat-lattice-position parent-category)))

    (setq *mistake-dialog/sequence* daughters)

    (unless *mistake-dialog/category-table*
      (setup-mistake-selection-table))
    (ccl:set-table-sequence *mistake-dialog/category-table*
                            daughters)
    (if *mistake-selection-window*
      (ccl:window-select *mistake-selection-window*)
      (launch-mistake-selection-tableau))))


;;--- Add category

(defun add-category-to-mistake-dialog (button)
  ;; Called when the button is clicked. Intended at the alternative
  ;; to selecting one of the categories already visible in the
  ;; table.
  (declare (ignore button))
  (let ((name (ccl:get-string-from-user
               "Enter the name of the new category"
               :size #@(300 150)
               :position #@(400 200)
               :initial-string "" )))

    (let ((new-mistake (define-smu-subtype
                         name *parent-category-to-mistake-dialog*)))
      (fit-new-category-into-mistake-dialog new-mistake))))


(defun fit-new-category-into-mistake-dialog (category)
  ;; Called from Add-category-to-mistake-dialog.
  ;; The new category was just added to the beginning of the list of
  ;; subtypes in the parent's lattice point.  For the moment I won't
  ;; bother alphabetizing these.
  ;;   Reset the table's sequence and select the new category.
  (setq *mistake-dialog/sequence*
        (cat-lattice-position *parent-category-to-mistake-dialog*))
  (ccl:set-table-sequence *mistake-dialog/category-table*
                          *mistake-dialog/sequence*)
  (setq *selected-mistake* category)
  (find&select-cat-in-mistake-dialog category))


(defun find&select-cat-in-mistake-dialog (category)
  ;; General subroutine
  (let* ((n (find-category-position-in-list category
                                            *mistake-dialog/sequence*))
         (cell (ccl:index-to-cell *mistake-dialog/category-table*
                                  n ))
         (index (ccl:cell-to-index *mistake-dialog/category-table*
                                   0 cell)))
    (ccl:cell-select *mistake-dialog/category-table*
                     0 index)))




;;;-------------------------
;;; selected cell -> global
;;;-------------------------

(defun update-selected-mistake-from-selected-cell ()
  (let ((cell (car (ccl:selected-cells *mistake-dialog/category-table*))))
    (when cell
      (let* ((index (ccl:cell-to-index *mistake-dialog/category-table*
                                       cell))
             (category (elt (ccl:table-sequence
                             *mistake-dialog/category-table*) index)))
        (setq *selected-mistake* category)))))


(defun deselect-mistake-dialog-selection ()
  (let* ((table *mistake-dialog/category-table*)
         (selections (ccl:selected-cells table)))
    (when selections
      (if (null (cdr selections))
        (let* ((cell (car selections))
               (index (ccl:cell-to-index table cell)))
          (ccl:cell-deselect table 0 index))))))
     


;;;----------------------
;;; leaving this tableau
;;;----------------------

(defun return-from-mistake-dialog (button)
  (declare (ignore button))
  (if (null *selected-mistake*)
    ;; threading of button states should never let this happen,
    ;; but no sense in taking chances
    (then (format t "~&~%----- no mistake has been selected~
                     -----~%")
          (ccl:dialog-item-disable *mistake-dialog/ok*))
    (else
      (deselect-mistake-dialog-selection)
      (ccl:window-hide *mistake-selection-window*)
      (record-mistake))))


(defun mistake/Hide-and-return-to-workbench (button)
  (declare (ignore button))
  ;; Called by clicking the 'reset' button.
  ;; The idea is to provide an out if the user sees that the
  ;; toplevel buttons are in the wrong state.  We hide the
  ;; window but don't update the classification
  (deselect-mistake-dialog-selection)
  (ccl:window-hide *mistake-selection-window*))


(defun record-mistake ()
  (unless *smu/current-phrase*
    (break "expected the current-phrase to have a value"))
  (let ((words (string-of-words-between 
                (pos-edge-starts-at *smu/current-phrase*)
                (pos-edge-ends-at *smu/current-phrase*))))
    (format *smu-outfile*
            "~&~%~
             ~%(define-instance-of-mistake ~A~
             ~%   \"~A\" )~%~%"
            (string-downcase (cat-symbol *selected-mistake*))
            words)))
