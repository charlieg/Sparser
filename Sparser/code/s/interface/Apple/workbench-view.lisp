;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(APPLE SPARSER LISP) -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;      File:  "workbench view"
;;;    Module:  "interface;Apple:"
;;;   version:  1.0 September 7, 1994

(in-package :apple)

;;;-------------------------
;;; interface specification
;;;-------------------------

(sparser::define-workbench-subview  :domain-model-view
  :flag  '*show-domain-model-in-wb*
  :table-populator 'list-object-types-from-discourse-history

  :subitem-populator 'list-category-instances-from-discourse-history

  :item-printer 'print-table-item/domain-model
  :selection-action 'domain-model-item-action


  :double-click-action  'domain-model-double-click-action )



;;;----------------------
;;; printing table items
;;;----------------------

#| The table starts out showing only the domain-modeling categories
and the number of instances each one has accumulated.   As items, these
are lists:  ( <category> . <instance count> )      |#

(defun print-table-item/domain-model (item stream)
  (if item
    (let ((obj (car item)))
      (if (or (typep obj 'sparser::referential-category)
              (typep obj 'sparser::category) 
              (typep obj 'sparser::mixin-category))
        (sparser::princ-category-and-instance-count item stream)
        
        (else ;; its the table entry for an individual
          (write-string "   " stream)  ;; indentation
          (sparser::princ-individual-and-instance-count item stream))))

    ;; this is the case when the window and table are first brought up
    ;; and haven't yet been populated
    (write-string "" stream)))

    


;;;----------------------
;;; populating the table
;;;----------------------

(defun list-object-types-from-discourse-history ()
  ;; called from Update-auxiliary-view. The list this returns
  ;; is used to populate the table.  We just list the categories,
  ;; 'opening' a category and also listing its individuals is
  ;; mediated by the selection action: Domain-model-item-action

  (let ((types-in-history (sparser::salience-sorted-types-in-discourse))
        item-list )

    (dolist (category types-in-history)
      (push (sparser::category-&-count category)
            item-list))
      
    (nreverse item-list)))



(defun list-category-instances-from-discourse-history (category-item)
  ;; called from Update-auxiliary-view when one or more of the categories
  ;; has been selected meaning that their instances are to be
  ;; included in the table --- this supplies that list of instances.
  ;; n.b. the 'category-item' is a cons of the category and the number
  ;; of instances.   The choice of sorting routine is determined by
  ;; the radio buttons at the bottom of the window.

  (let ((instance-dh-entries
         (sparser::discourse-entry (first category-item))))
    (let ((sorted-entries
           (sort (copy-list instance-dh-entries)
                 ;; if anything goes wrong in the sort function we can
                 ;; lose the discourse entry since the operation is
                 ;; distructive -- hence this 'copy' to avoid that
                 sparser::*instance-sorting-routine*)))
      sorted-entries)))



;;;-----------------------------------------
;;; what happens when an item is clicked on
;;;-----------------------------------------

(defun domain-model-item-action (item)
  ;; called when one of the table items gets a click.
  ;; The item will always be a list. Sometimes it will indicate
  ;; a category, other times an individual (an instance of one
  ;; of the categories.
  (let ((obj (car item)))
    (etypecase obj

      ((or sparser::referential-category 
           sparser::category 
           sparser::mixin-category)
       (sparser::add-categories-individuals-to-subview-table obj))

      (sparser::individual
       (if (eq obj sparser::*prior-unit-selected-in-aux-subview*)
         ;; There is a timing problem in the handling of double clicks
         ;; that is fixed by taking advantage of this global.  I want
         ;; the text-view to be selected when we set up the item
         ;; walk. This entails making it the top window on the desktop,
         ;; and that has the undesirable effect of having that window
         ;; get the second click of the double click that was
         ;; intended for this window -- ergo this window can't be
         ;; double clicked when the item being clicked on is an
         ;; individual.   By using this global, we can circumvent
         ;; the problem because the second click of the double click
         ;; is indeed seen by this window, it just isn't interpreted
         ;; by MCL as a 'double click'.  The actual Apple rule for
         ;; double-clicks includes not moving from the spot where
         ;; the first click occurred, and this global amounts to
         ;; doing that check.   This has the perhaps undesirable effect
         ;; of losing the timing information, so that two successive
         ;; clicks on the same individual -- however far apart in 
         ;; time -- will be treated as a 'double-click', but that 
         ;; seems unavoidable barring serious low-level mouse hacking.
         (domain-model-double-click-action item)
         (when sparser::*text-out*
           (sparser::setup-item-walk item)))))))
  

(defun domain-model-double-click-action (item)
  (let ((obj (car item)))
    (etypecase obj
      ((or sparser::referential-category 
           sparser::category 
           sparser::mixin-category)
       (sparser::display-in-inspector obj))
      (sparser::individual
       (sparser::display-in-inspector obj)))))

;;;--------------------------------------
;;; ordering the categories in the table
;;;--------------------------------------

(defparameter *presentation-order-for-domain-model-types*

  ;; This table is used by Salience-sorted-types-in-discourse to
  ;; determine the order in which the different categories are
  ;; to appear in the view.  If a category isn't mentioned here
  ;; it goes at the end of the sequence in alphabetical order

  `((,(sparser::category-named 'term)                . 100 )
    (,(sparser::category-named 'pair-term)           . 101 )
    (,(sparser::category-named 'verb-object)         . 110 )
    (,(sparser::category-named 'subject-verb)        . 111 )

    (,(sparser::category-named 'infinitive-relation) . 120 )
    (,(sparser::category-named 'genitive)            . 130 )

    (,(sparser::category-named 'have)                . 200 )
    (,(sparser::category-named 'be)                  . 201 )
    (,(sparser::category-named 'anonymous-agentive-action)  . 202 )  ;; "do"

    (,(sparser::category-named 'name)                . 300 )
    (,(sparser::category-named 'pronoun)             . 301 )
    (,(sparser::category-named 'single-capitalized-letter)  . 302 )

    (,(sparser::category-named 'modifier)            . 400 )
    (,(sparser::category-named 'frequency-of-event)  . 405 )

    (,(sparser::category-named 'number)              . 500 )
    (,(sparser::category-named 'quantity)            . 501 )

    (,(sparser::category-named 'time)                . 600 )

    (,(sparser::category-named 'segment)             . 1000 )

    ))

(defparameter sparser::*category-sorting-table*
              *presentation-order-for-domain-model-types*
  "The connection to Salience-sorted-types-in-discourse is mediated by
   this global so that it can be readily changed from application to
   application." )

