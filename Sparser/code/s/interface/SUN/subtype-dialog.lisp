;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "subtype dialog"
;;;    Module:   "interface;SUN:"
;;;   Version:   December 1994

;; initiated 12/15/94

(in-package :sparser)

;;;---------
;;; actions
;;;---------

(defparameter  *subtype-dialog/ok*
  (MAKE-DIALOG-ITEM
   'BUTTON-DIALOG-ITEM
   #@(20 12)
   #@(40 16)
   "ok"
   'return-from-subtype-dialog
   :DEFAULT-BUTTON  T ))


(defparameter  *subtype-dialog/add-category*
  (MAKE-DIALOG-ITEM
   'BUTTON-DIALOG-ITEM
   #@(99 12)
   #@(100 16)
   "add category"
   'add-category-to-subtype-dialog
   :VIEW-FONT '("Courier" 10 :SRCOR :PLAIN)
   :DEFAULT-BUTTON NIL))


(defparameter  *subtype-reconsider*
  (MAKE-DIALOG-ITEM
  'BUTTON-DIALOG-ITEM
  #@(216 12)
  #@(53 16)
  "reset"
  'subtype/hide-and-return-to-workbench
  :DEFAULT-BUTTON NIL))


;;;-----------
;;; the table
;;;-----------

(defclass subtype-selection-table (sequence-dialog-item) ())

(defparameter *subtype-dialog/category-table* nil)

(defparameter *subtype-dialog/sequence* nil)

(defparameter *selected-subtype* nil)


(defun setup-subtype-selection-table ()
  (setq *subtype-dialog/category-table*
        (make-instance 'subtype-selection-table
          :view-container *subtype-selection-window*
          :view-position #@(9 39)
            ;; n.b. this position is relative to the tableau window
          :view-size #@(250 290)
          ::CELL-SIZE #@(234 16)  ;;?? relationship to a :visible-dimensions arg. ??
          :SELECTION-TYPE :SINGLE
          :TABLE-HSCROLLP NIL
          :TABLE-VSCROLLP T
          :sequence-wrap-length 2000
          :dialog-item-action 'set-subtype-category
          :table-print-function 'print-subtype/table
          :TABLE-SEQUENCE *subtype-dialog/sequence* )))


;;;-----------------------------------------
;;; print and action routines for the table
;;;-----------------------------------------

(defun print-subtype/table (st stream)
  (if (or (referential-category-p st)
          (category-p st))
    (format stream "~A" (string-downcase
                         (symbol-name (cat-symbol st))))
    (format t "~&~%----- item in subtype table is not a category~
               -----~%      ~A~%~%" st)))


(defun set-subtype-category (table)
  (declare (ignore table))
  (update-selected-subtype-from-selected-cell)
  (ccl:dialog-item-enable *subtype-dialog/ok*))


;;;-------------------
;;; the dialog window
;;;-------------------

(defclass subtype-selection-tableau (dialog) ())

(defparameter *subtype-selection-window* nil)

(defun launch-subtype-selection-tableau ()
  (setq *subtype-selection-window*
        (MAKE-INSTANCE 'subtype-selection-tableau
          :WINDOW-TYPE  :DOCUMENT-WITH-GROW
          :window-title "subtypes"
          :VIEW-POSITION  #@(400 250)
          :VIEW-SIZE  #@(291 338)
          :VIEW-FONT  '("Chicago" 12 :SRCOR :PLAIN)
          :VIEW-SUBVIEWS
          (LIST *subtype-dialog/ok*
                *subtype-dialog/add-category*
                *subtype-reconsider*
                *subtype-dialog/category-table* ))))


(defmethod window-close ((w subtype-selection-tableau))
  (close-down-subtype-selection-tableau-state)
  (call-next-method w))

(defun close-down-subtype-selection-tableau-state ()
  (setq *subtype-selection-window* nil
        *subtype-dialog/category-table* nil
        *subtype-dialog/sequence* nil
        *parent-category-to-subtype-dialog* nil )
  (ccl:dialog-item-enable *smu/subtypes-button*))



;;;-------------------
;;; Button operations
;;;-------------------

(defparameter *parent-category-to-subtype-dialog* nil)

(defun bring-up-subtypes-dialog (button)
  ;; On the overlay to the workbench -- mode entry-point
  (declare (ignore button))
  ;; Called when the subtypes button is pushed, which is intended to
  ;; be before clicking 'markup'.  We see which toplevel button is
  ;; selected and bring up the corresponding set of daughter
  ;; categories.
  (ccl:dialog-item-disable *smu/subtypes-button*)
  (ccl:dialog-item-disable *subtype-dialog/ok*)
  (let* ((keyword (readout-smu-classification-buttons))
         (parent-category (category-for-smu-classification keyword))
         (daughters (cat-lattice-position parent-category)))

    (setq  *parent-category-to-subtype-dialog* parent-category)
    (setq *subtype-dialog/sequence* daughters)

    (unless *subtype-dialog/category-table*
      (setup-subtype-selection-table))
    (ccl:set-table-sequence *subtype-dialog/category-table*
                            daughters)
    (if *subtype-selection-window*
      (ccl:window-select *subtype-selection-window*)
      (launch-subtype-selection-tableau))))



;;--- Add category

(defun add-category-to-subtype-dialog (button)
  ;; Called when the button is clicked. Intended at the alternative
  ;; to selecting one of the categories already visible in the
  ;; table.
  (declare (ignore button))
  (let ((name (ccl:get-string-from-user
               "Enter the name of the new category"
               :size #@(300 150)
               :position #@(400 200)
               :initial-string "" )))

    (let ((new-subtype (define-smu-subtype
                         name *parent-category-to-subtype-dialog*)))
      (fit-new-category-into-subtype-dialog new-subtype))))


(defun fit-new-category-into-subtype-dialog (category)
  ;; Called from Add-category-to-subtype-dialog.
  ;; The new category was just added to the beginning of the list of
  ;; subtypes in the parent's lattice point.  For the moment I won't
  ;; bother alphabetizing these.
  ;;   Reset the table's sequence and select the new category.
  (setq *subtype-dialog/sequence*
        (cat-lattice-position *parent-category-to-subtype-dialog*))
  (ccl:set-table-sequence *subtype-dialog/category-table*
                          *subtype-dialog/sequence*)
  (setq *selected-subtype* category)
  (find&select-cat-in-subtype-dialog category))


(defun find&select-cat-in-subtype-dialog (category)
  ;; General subroutine
  (let* ((n (find-category-position-in-list category
                                            *subtype-dialog/sequence*))
         (cell (ccl:index-to-cell *subtype-dialog/category-table*
                                  n ))
         (index (ccl:cell-to-index *subtype-dialog/category-table*
                                   0 cell)))
    (ccl:cell-select *subtype-dialog/category-table*
                     0 index)))


(defun find-category-position-in-list (category list-of-categories)
  (let ((sublist (member category list-of-categories :test #'eq)))
    (- (length list-of-categories)
       (length sublist))))



;;;-------------------------
;;; selected cell -> global
;;;-------------------------

(defun update-selected-subtype-from-selected-cell ()
  (let ((cell (car (ccl:selected-cells *subtype-dialog/category-table*))))
    (when cell
      (let* ((index (ccl:cell-to-index *subtype-dialog/category-table*
                                       cell))
             (category (elt (ccl:table-sequence
                             *subtype-dialog/category-table*) index)))
        (setq *selected-subtype* category)))))


(defun deselect-subtype-dialog-selection ()
  (let* ((table *subtype-dialog/category-table*)
         (selections (ccl:selected-cells table)))
    (when selections
      (if (null (cdr selections))
        (let* ((cell (car selections))
               (index (ccl:cell-to-index table cell)))
          (ccl:cell-deselect table 0 index))))))
     


;;;----------------------
;;; leaving this tableau
;;;----------------------

(defun return-from-subtype-dialog (button)
  (declare (ignore button))
  (if (null *selected-subtype*)
    ;; threading of button states should never let this happen,
    ;; but no sense in taking chances
    (then (format t "~&~%----- no subtype has been selected~
                     -----~%")
          (ccl:dialog-item-disable *subtype-dialog/ok*))
    (else
      (setq *current-smu-classification*
            *selected-subtype*)
      (deselect-subtype-dialog-selection)
      (ccl:window-hide *subtype-selection-window*))))


(defun subtype/Hide-and-return-to-workbench (button)
  (declare (ignore button))
  ;; Called by clicking the 'reset' button.
  ;; The idea is to provide an out if the user sees that the
  ;; toplevel buttons are in the wrong state.  We hide the
  ;; window but don't update the classification
  (ccl:dialog-item-enable *smu/subtypes-button*)
  (deselect-subtype-dialog-selection)
  (ccl:window-hide *subtype-selection-window*))

