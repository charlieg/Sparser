;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "finding actions"
;;;   Module:  "interface;Apple:"
;;;  Version:  1.1 February 3, 1995

;; 1.1  Added more cases, included alternative checking criteria that
;;      looked at edge form.
;;      (7/12) ditto. 

(in-package :sparser)

#|   If we can identify a speech-act level pattern in the vicinity of
a marked region of the text (e.g. in a section title or at the start
of an item in a sequence), then we make note of it:

The pattern is spanned by an edge from a higher order label set than
the syntactically-oriented set that would otherwise be the toplevel
of the analysis.   An object of the corresponding type is created from
the components of the new edge (it is the edge's referent).   And that
object is stored directly with the region (some 'section object') so
that we can access it at that level and use it to look for patterns
across large regions of the text.   |#


;;;---------------------------------------------------------------
;;; relationships between text regions and the speech-act objects
;;;---------------------------------------------------------------

(define-category  named-for-an-action
  :specializes nil
  :instantiates self
  :binds ((action)
          (section . section-object))
  :index (:key section))


(define-category  instruction   ;; name is pretty arbitrary -- could get confusing
  :specializes nil
  :instantiates self
  :binds ((directive . directive)
          (section . section-object))
  :index (:key section))




(defun section-help-relation (section-object)
  ;; generic access routine to return a section object's associated
  ;; domain-level object.  Presently depends on there being only
  ;; one 'section' variable in the model and works outwards from
  ;; that variable to its binding in a domain-level object and
  ;; thence to the object.  Also assumes that all of these relations
  ;; will use that variable.   Doing it this way avoids having to
  ;; list out all the relation types and search.

  (let ((section-variable (lambda-variable-named 'section)))
    (when (consp section-variable)
      (break "Life got more complicated:  there are several definitions ~
              of the~%variable 'section' with different restrictions:~
              ~%  ~A" section-variable))
    (let ((binding
           (find section-variable
                 (indiv-bound-in section-object) 
                 :key #'binding-variable)))
      (when binding
        (binding-body binding)))))


;;;----------------------------------------------------------------
;;; higher order (speech act ?) descriptions of syntactic patterns
;;;----------------------------------------------------------------

;; This is a refinement of how a VP can be analyzed
;;
(define-category  action-type    ;; participles in titles
  :specializes nil
  :instantiates self
  :binds ((action)
          (theme))
  :index (:sequential-keys action theme))


(define-category  directive   ;; imperatives in items
  :specializes nil
  :instantiates self
  :binds ((action))
  :index (:key action))


(define-category  purpose   ;; infinitives at the beginning of a marked
  :specializes nil          ;; region (and elsewhere)
  :instantiates self
  :binds ((action))
  :index (:key action))

    

;;;-----------------------------------------------
;;; displaying thes relations within a whole text
;;;-----------------------------------------------
;; straight copy of Section-structure


(defun section-help-structure ( &optional (so *root-section-object*) )

  "Starting at a given section object, go down through its daughter objects
   and for each one display its associated domain-level 'help' action
   if there is one."

  (let ((*print-short* t))
    (walk-section-tree/show-help-relations so 0)))



(defun walk-section-tree/show-help-relations (so indentation)
  (let ((daughters (reverse (value-of 'daughters so))))
    (dolist (d (if (eq so *root-section-object*)
                 daughters (cdr daughters))) ;; see Section-structure
      (format t "~&~A" (string-of-n-spaces indentation))
      (format t "~A.~A"
              (string-downcase (sm-full-name (value-of 'type d)))
              (indiv-uid d))
      (when (section-help-relation d)
        (write-string " -- ")
        (princ-section-help-relation d))
      (when (value-of 'daughters d)
        (walk-section-tree/show-help-relations
         d (+ 3 indentation))))))

(defun princ-section-help-relation (so)
  ;; horribly special cased -- needs to hook into general print routines
  ;; to be readily (transparently) extensible
  (let ((help-relation (section-help-relation so)))
    (when help-relation
      ;; either 'named-for-an-action' or 'instruction'
      (let ((text-relation (or (value-of 'action help-relation)
                               (value-of 'directive help-relation))))
        (unless text-relation
          (break "New case needed for text relation in~
                  ~%    ~A" help-relation))
        (let ((obj-to-print (value-of 'action text-relation)))
          (unless obj-to-print
            (break "New case needed for obj-to-print in~
                    ~%   ~A" text-relation))
          (format t "~A" obj-to-print))))))
      
      


;;;-----------------------------
;;; detecting these in the text
;;;-----------------------------

(set-generic-treetop-action (category-named 'start-section)
                            'sort-out-vp-data)
  ;; This executes during the last phase of operations at the 'forest' level,
  ;; i.e. after all between-segment parsing has been finished.  If it
  ;; introduces an additional edge that parsing phase will be resumed.


(defun sort-out-vp-data (sm-edge)
  ;; treetop action that occurs with every 'start' markup tag.
  ;; Looks for VP edges and if they meet certain criteria has them
  ;; reanalyzed.

  (let ((section-object (edge-referent sm-edge))
        (neighboring-edge (right-multiword-treetop
                           (pos-edge-ends-at sm-edge))))
    (if neighboring-edge
      ;; is it a vp?  If so, construct one of the higher order objects

      (let ((category-name (cat-symbol (edge-category neighboring-edge))))

        ;; The impossible cases are going first here to avoid looking
        ;; up the form category (to check for infinitives) since some of
        ;; these cases have the form field empty (///for no good reason,
        ;; e.g. 'no-analysis')
        (case category-name                   ;;--- cases that aren't VPs
            (category::subj+verb-segment )
            (category::subj+vp-segment )
            (category::np-segment )
            (category::state )          ;; "have + NP"
            (category::two-word-segment )
            (category::multi-word-segment )
            (category::start-section )  ;; two tags in a row
            (category::end-section)     ;; ditto
            (category::no-analysis )
            (otherwise
             (let ((form-name (cat-symbol (edge-form neighboring-edge))))
               (cond
                ((eq category-name 'category::verb+object-segment)
                 (help/categorize-vp/store-with-section
                  neighboring-edge section-object :verb+object-segment))

                ((or (eq category-name 'category::infinitive-segment)
                     (eq form-name 'category::infinitive))
                 (when (itype (value-of 'verb (edge-referent neighboring-edge))
                              'verb-object)
                   (help/categorize-vp/store-with-section
                    neighboring-edge section-object :infinitive)))

                (t   ;;--- Anounce new cases
                 (format t "~&------- New category after segment-start ---------~
                            ~%        category: ~A~
                            ~%            form: ~A"
                         category-name form-name)
                 (break "This is just an anouncement --  You can ~
                         ~%just continue.~%")))))))

      (else
        ;; sanity check on the extent of the parsing. If there's no
        ;; edge then it might be a case of an initial function word,
        ;; or of a tag pair with no interior.
        ;; Otherwise something didn't happen that should have and we
        ;; should look at it.
        ;;(format t "~&------- No edge after segment-start ---------")
        ))))


;;;------------------------------------------
;;; examining the edges & making the objects
;;;------------------------------------------

(defun help/categorize-vp/store-with-section (vp-edge section-object
                                              type)
  (multiple-value-bind (vg-edge dobj-edge)
                       (decompose-VP-edge vp-edge type)
    (let ((vg-form (edge-form vg-edge)))
      (unless vg-form
        (break "identified vg-edge without a form value:~
                ~%   ~A~%" vg-edge))
      (let ((categorization
             (if (eq type :infinitive)
               :purpose
               (ecase (cat-symbol vg-form)
                 (category::verb+ing    :action-type)
                 (category::verb        :imperative)
                 (category::verb+ed     :imperative)
                   ;; this case is here because of the verb "quit"
                 )))
            object  category  relation-to-section )

        (ecase categorization
          (:action-type
           (setq object (make-an-individual 'action-type
                                            :action (suitable-referent
                                                     (edge-referent vp-edge))
                                            :theme (suitable-referent
                                                    (edge-referent dobj-edge)))
                 category (category-named 'action-type))
           (setq relation-to-section
                 (make-an-individual 'named-for-an-action
                                     :action object
                                     :section section-object)))
          
          (:imperative
           (setq object (make-an-individual 'directive
                                            :action (suitable-referent
                                                     (edge-referent vp-edge)))
                 category (category-named 'directive)
                 relation-to-section
                 (make-an-individual 'instruction
                                     :directive object
                                     :section section-object)))
          
          (:purpose
           (setq object (make-an-individual 'purpose
                                            :action (suitable-referent
                                                     (edge-referent vp-edge)))
                 category (category-named 'purpose)

                 ;; So far there's no corpus evidence that a purpose clause
                 ;; that we identify as such by this method ipso facto
                 ;; provides a relationship to the section object that was
                 ;; used as the trigger.  Instead it's just a preposed
                 ;; adjunct to its sentence and we'll want to consider the
                 ;; categorization of the sentence as a whole (helped by
                 ;; having found this purpose clause) that categorizes
                 ;; the segment object
                 relation-to-section nil)))

        (let ((edge
               (make-chart-edge
                :starting-position (pos-edge-starts-at vp-edge)
                :ending-position (pos-edge-ends-at vp-edge)
                :left-daughter vp-edge
                :right-daughter  :single-term-edge
                :category category
                :form (category-named 'participle)
                :rule-name  :respan-from-context
                :referent object )))
          
          (values edge
                  relation-to-section))))))
                 
            
;;;--------------------------
;;; general (?)  subroutines
;;;--------------------------

(defun suitable-referent (edge-referent)
  ;; called from, e.g. Help/categorize-vp/store-with-section
  ;; this is a hook for when we flush segments, and provides a place
  ;; for wiggle room, glossing over imperfections and noting gaps
  (unless (individual-p edge-referent)
    (break "Data formulation problem: Expected an individual~
            ~%   and got ~A~%" edge-referent))
  (let ((referent
         (ecase (cat-symbol (itype-of edge-referent))
           (category::segment (head-of-segment edge-referent))
           (category::verb-object edge-referent)
           (category::infinitive-relation edge-referent)
           )))
    (unless referent
      (break "calculation didn't find anything"))
    referent ))


(defun decompose-VP-edge (edge type)
  (ecase type
    (:verb+object-segment
     (values (edge-left-daughter edge)
             (edge-right-daughter edge)))
    (:infinitive
     ;; the left edge will be the word "to" and the VP proper
     ;; will be below the right edge
     (let ((vp-edge (edge-right-daughter edge)))
       (unless (edge-p vp-edge)
         (break "Invalid data: expected an edge as the right daughter ~
                 of~%~A~%but didn't get one" edge))
       (unless (eq (edge-form vp-edge) category::verb+object)
         (break "Invalid data: right edge of an infinitive should have ~
                 been~%a verb+object but it isn't:~%~A" vp-edge))
       (values (edge-left-daughter vp-edge)
               (edge-right-daughter vp-edge))))
    ))

