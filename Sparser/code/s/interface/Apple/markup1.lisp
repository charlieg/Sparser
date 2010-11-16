;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "markup"
;;;   Module:  "interface;Apple:"
;;;  Version:  1.2  September 6, 1994

;; Changelog:
;; 1.1 added 'section-object' capability to all the explicit (non-hidden)
;;  markup.
;; 1.2 markup that only indicates the start and title of a section had its
;;  call-structure for section-objects slightly adjusted.

(in-package :sparser)


;;--- paired markup
;; para
;; section
;; subsection
;; subsubsection
;; sequence
;; enumerate
;; list
;; item
;; warn
;; fig
;; table
;; important
;; note

;;--- hidden paired markup
;; ital
;; bold

;;--- annotation
;; syn


(defparameter *trace-bkb-sections* nil)
;(setq  *trace-bkb-sections* t)
;(setq  *trace-bkb-sections* nil)


;;;--------------------
;;; section delimiters
;;;--------------------

(define-markup-tag-pair 'bkb/paragraph
  "/para"  "/epara"
  :initiation-action 'start-new-paragraph
  :termination-action 'finish-ongoing-paragraph )

;; uses standard paragraph routines


(define-markup-tag-pair 'bkb/chapter
  "/chapter"  "/echapter"
  :initiation-action 'bkb/start-chapter-title
  :termination-action 'bkb/end-chapter-title )

(defun bkb/start-chapter-title (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%chapter start: ~A~%" sm-edge))
  (close-pending/initiate-new-section sm-edge :root))

(defun bkb/end-chapter-title (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%chapter end: ~A~%" end-edge)))



(define-markup-tag-pair 'bkb/section
  "/section"  "/esection"
  :initiation-action 'bkb/start-section-title
  :termination-action 'bkb/end-section-title )

(defun bkb/start-section-title (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%section start: ~A~%" sm-edge))
  (close-pending/initiate-new-section sm-edge "bkb/chapter"))

(defun bkb/end-section-title (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%section end: ~A~%" end-edge)))



(define-markup-tag-pair 'bkb/subsection
  "/subsection"  "/esubsection"
  :initiation-action 'bkb/start-subsection-title
  :termination-action 'bkb/end-subsection-title )

(defun bkb/start-subsection-title (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%subsection start: ~A~%" sm-edge))
  (close-pending/initiate-new-section sm-edge 
                                      '("bkb/section" "bkb/chapter")))

(defun bkb/end-subsection-title (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%subsection end: ~A~%" end-edge)))



(define-markup-tag-pair 'bkb/subsubsection
  "/subsubsection"  "/esubsubsection"
  :initiation-action 'bkb/start-subsubsection-title
  :termination-action 'bkb/end-subsubsection-title )

(defun bkb/start-subsubsection-title (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%subsubsection start: ~A~%" sm-edge))
  (close-pending/initiate-new-section sm-edge
                                      '("bkb/subsection"
                                        "bkb/section"
                                        "bkb/chapter")))

(defun bkb/end-subsubsection-title (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%subsubsection end: ~A~%" end-edge)))




(define-markup-tag-pair 'bkb/sequence
  "/sequence"  "/esequence"
  :initiation-action 'bkb/start-sequence
  :termination-action 'bkb/end-sequence )

(defun bkb/start-sequence (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%sequence start: ~A~%" sm-edge))
  (instantiate-section sm-edge))

(defun bkb/end-sequence (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%sequence end: ~A~%" end-edge))
  (pop-ongoing-section))



(define-markup-tag-pair 'bkb/list
  "/list"  "/elist"
  :initiation-action 'bkb/start-list
  :termination-action 'bkb/end-list )

(defun bkb/start-list (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%list start: ~A~%" sm-edge))
  (instantiate-section sm-edge))

(defun bkb/end-list (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%list end: ~A~%" end-edge))
  (pop-ongoing-section))




(define-markup-tag-pair 'bkb/enumerate
  "/enumerate"  "/eenumerate"
  :initiation-action 'bkb/start-enumerate
  :termination-action 'bkb/end-enumerate )

(defun bkb/start-enumerate (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%enumerate start: ~A~%" sm-edge))
  (instantiate-section sm-edge))

(defun bkb/end-enumerate (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%enumerate end: ~A~%" end-edge))
  (pop-ongoing-section))




(define-markup-tag-pair 'bkb/item
  "/item"  "/eitem"
  :initiation-action 'bkb/start-item
  :termination-action 'bkb/end-item
  :interior-markup '(note-line-number
                     itemno= ))

(defun bkb/start-item (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%item start: ~A~%" sm-edge))
  (instantiate-section sm-edge))

(defun bkb/end-item (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%item end: ~A~%" end-edge))
  (pop-ongoing-section))


(defun note-line-number (interior-markup)
  (unless (null (cdr interior-markup))
    (break "Expected only one edge in the interior, but there are ~A:~
            ~%  ~A" (length interior-markup) interior-markup))
  (when *trace-bkb-sections*
    (let ((edge (first interior-markup)))
      (unless (edge-p edge)
        (break "Grammar bug? expected the interior of a line number ~
                to parse~%to an edge but got ~A" edge))
      (unless (eq (edge-category edge)
                  (category-named 'line-value))
        (break "Grammar bug? expected the interior of a line number ~
                to parse~%to a 'line-value' but got~%  ~A" edge))
      (format t "~%   number ~A"
              (value-of 'value (edge-referent edge))))))


(def-cfr line-value ("itemno=" number)
  :referent (:daughter right-edge))





(define-markup-tag-pair 'bkb/figure
  "/fig"  "/efig"
  :initiation-action 'bkb/start-figure
  :termination-action 'bkb/end-figure )

(defun bkb/start-figure (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%figure start: ~A~%" sm-edge))
  (instantiate-section sm-edge))

(defun bkb/end-figure (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%figure end: ~A~%" end-edge))
  (pop-ongoing-section))




(define-markup-tag-pair 'bkb/table
  "/table"  "/etable"
  :initiation-action 'bkb/start-table
  :termination-action 'bkb/end-table )

(defun bkb/start-table (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%table start: ~A~%" sm-edge))
  (instantiate-section sm-edge))

(defun bkb/end-table (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%table end: ~A~%" end-edge))
  (pop-ongoing-section))




(define-markup-tag-pair 'bkb/warning
  "/warn"  "/ewarn"
  :initiation-action 'bkb/start-warning
  :termination-action 'bkb/end-warning )

(defun bkb/start-warning (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%warning start: ~A~%" sm-edge))
  (instantiate-section sm-edge))

(defun bkb/end-warning (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%warning end: ~A~%" end-edge))
  (pop-ongoing-section))




(define-markup-tag-pair 'bkb/important
  "/important"  "/eimportant"
  :initiation-action 'bkb/start-important
  :termination-action 'bkb/end-important )

(defun bkb/start-important (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%important start: ~A~%" sm-edge))
  (instantiate-section sm-edge))

(defun bkb/end-important (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%important end: ~A~%" end-edge))
  (pop-ongoing-section))




(define-markup-tag-pair 'bkb/note
  "/note"  "/enote"
  :initiation-action 'bkb/start-note
  :termination-action 'bkb/end-note )

(defun bkb/start-note (sm-edge)
  (when *trace-bkb-sections*
    (format t "~%note start: ~A~%" sm-edge))
  (instantiate-section sm-edge))

(defun bkb/end-note (end-edge start-edge)
  (declare (ignore start-edge))
  (when *trace-bkb-sections*
    (format t "~%note end: ~A~%" end-edge))
  (pop-ongoing-section))




;;;--------------
;;; face changes
;;;--------------

(define-invisible-markup :tag-pair  'bold-face
  "/bold"  "/ebold"
  :initiation-action 'start-bold-region
  :termination-action 'end-bold-region)

(defun start-bold-region (position)
  (when *trace-hidden-markup*
    (format t "~%bold region starts at p~A~%"
            (pos-token-index position))))

(defun end-bold-region (position)
  (when *trace-hidden-markup*
    (format t "~%bold region ends at p~A~%"
            (pos-token-index position))))



(define-invisible-markup :tag-pair  'italic-face
  "/ital"  "/eital"
  :initiation-action 'start-italic-region
  :termination-action 'end-italic-region)

(defun start-italic-region (position)
  (when *trace-hidden-markup*
    (format t "~%italic region starts at p~A~%"
            (pos-token-index position))))

(defun end-italic-region (position)
  (when *trace-hidden-markup*
    (format t "~%italic region ends at p~A~%"
            (pos-token-index position))))




;;;-----------------------------------
;;; embedded annotation on every word
;;;-----------------------------------

(define-invisible-markup :annotation 'syntax
  "/syn"
  :initiation-action 'trace-syn
  :interior-markup '(embellish-analysis-of-prior-word

                     @next  ;; syntactic mark indicating that the features already
                            ;; seen constitute one analysis of the word and those
                            ;; to follow constitute another. Can be repeated any
                            ;; number of times, each time indicating a separate
                            ;; analysis

                     @AD-A>
                     @ADVL         ;; adverbial
                     @AN
                     @AN>
                     @APP          ;; head noun in apposition
                     @CC           ;; coordinator
                     @CS
                     @DN>          ;; "this"
                     @+FAUXV
                     @+FMAINV      ;; tensed 'main predicator' ("finite")
                     @-FMAINV      ;; untensed main predicator (infinitive)
                     @GN           ;; premodifying genitive (e.g. "sound's")
                     @I-OBJ
                     @INFMARK>     ;; infinitive marker
                     @NEG
                     @NN           ;; premodifying noun
                     @NN>  
                     @NPHR
                     @<NOM         ;; other postmodifier
                     @<NOM-FMAINV
                     @<NOM-OF
                     @OBJ          ;; head noun acting as direct object
                     @<P           ;; other complement of preposition
                     @<P-FMAINV
                     @PCOMPL-O
                     @PCOMPL-S
                     @QN
                     @SUBJ         ;; head noun acting as subject
                     ))



(defparameter *trace-syn-markup* nil)
;(setq *trace-syn-markup* t)
;(setq *trace-syn-markup* nil)

(defun trace-syn (position-before features)
  (when *trace-syn-markup*
    (trace-msg "Annotating the word \"~A\" at p~A with the features~
                ~%   ~A"
               (pos-terminal position-before)
               (pos-token-index position-before)
               features)))
    

(defparameter *annotation-with-no-function* nil)
;(setq *annotation-with-no-function* nil)

(defun embellish-analysis-of-prior-word (list-of-polywords)
  ;; Called during 'word-level' processing after all the standard
  ;; actions have been taken -- including the introduction of edges --
  ;; but before any actions are taken on the next-word. 
  ;;   The list of 'polywords' is the actual annotation that
  ;; was included in this instance (as opposed to the set of all
  ;; conceivable annotation that is listed with the definition
  ;; of the marker.
  ;;   We go through each of the terms and see if it has
  ;; an action that it wants to apply to the 'current-word',
  ;; which is to say the word that just proceeded the point of
  ;; the annotation.  The action is coordinated by a call to
  ;; the shell function 'operate-on-current-word', which maintains
  ;; a set of global variables for the action to access that
  ;; pick out the sorts of things it might want to operate on.
  ;;   We also keep track of the annotating terms that don't
  ;; have any actions associated with them in case that was an
  ;; oversight.

  (let ( function  pw-name )
    (dolist (pw list-of-polywords)
      (setq pw-name (pw-symbol pw))
      (setq function (get pw-name :annotation-function))
      (if function
        (sparser::operate-on-current-word function)
        (unless (member pw-name *annotation-with-no-function*
                        :test #'eq)
          (push pw-name *annotation-with-no-function*))))))



;;----------- globals available to the routines ------------
;; *word*
;; *position-before*
;; *position-after*
;; *preterminals*  --the edges spanning the word, if any
;; *left-segment-boundary*
;; *right-segment-boundary*

(defmacro define-annotation-function (symbol &body body)
  (let* ((fn-name (intern 
                   (concatenate 'string
                                (symbol-name symbol)
                                "-ANNOTATOR")
                   (find-package :apple-interface)))
         (fn-body
          `(defun ,fn-name () ,@body))
         (down-symbol (intern
                       (string-downcase (symbol-name symbol))
                       *word-package*)))

    (setf (get down-symbol :annotation-function) fn-name)
    fn-body ))

;;--- cases

(define-annotation-function @DN
  (when *trace-syn-markup*
    (break)))

