;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1994  David D. McDonald  -- all rights reserved
;;;
;;;      File:   "toplevel"
;;;    Module:   "interface;SUN:"
;;;   Version:   December 1994

;; initiated 12/14/94

(in-package :sparser)

;;;-----------------
;;; initializations
;;;-----------------

(defun setup-for-SUN ()
  (sun-switch-settings)
  (setup-for-SUN-srdb-texts)
  (setq *current-wb-subview-mode* :edges)
  (launch-all-in-one-workbench)
  (launch-SUN-markup-overlay))


(defun sun-switch-settings ()
  (establish-character-translation-protocol :no-changes)
  (what-to-do-with-unknown-words :no-properties)
  (establish-type-of-edge-vector-to-use :vector)
  (establish-version-of-capitalization-dispatch :no-op)
  (setq *polyword-routine* :single-completions)
  (establish-version-of-assess-edge-label :treetops)
  (setq *make-edges-for-unknown-words-from-their-properties* nil)
  (establish-version-of-next-terminal-to-use
   :hide-POS-tags 'next-terminal/hide-pos-tags)
  (establish-kind-of-chart-processing-to-do :just-do-terminals)
  (establish-version-of-look-at-terminal 
   :check-tag-routines 'scan-for-tag-patterns)
  (establish-version-of-complete :ca/ha)
  (setq *do-forest-level* nil
        *do-conceptual-analysis* nil
        *do-heuristic-boundary-detection* nil)
  (setq *switch-setting* :Sun-setting))


(defun setup-for-SUN-srdb-texts ()
  (adjust-text-to-fixed-line-length)  ;;(use-original-lines-of-text)
  (use-Initial-Caps-&-colon-NL-fsa))


;;--- patches

(unintern 'word::|and| (find-package :word))
  ;; this symbol is referenced in some file that is loaded, so it
  ;; appears in the word lookup table.

(defparameter *ignore-capitalization* t)
  ;; This is bound in [core;names:fsa:driver] and there isn't
  ;; any reason to load that code



;;;-------
;;; state
;;;-------

(defvar *position-where-entry-starts* nil)

(defun initialize-SUN-toplevel ()
  (setq *position-where-entry-starts* nil)
  (close-down-subtype-selection-tableau-state))

(define-per-run-init-form '(initialize-SUN-toplevel))


;;;---------------------------------
;;; toplevel call from the Listener
;;;---------------------------------

(defvar *smu/file-being-analyzed*  nil)
(defvar *smu/dossier-file*  nil)
(defvar *smu-outfile*  *standard-output*)


(defun run-SUN-srdb-file (name-of-file-to-analyze
                          name-of-dossier-for-results)
  (setup-for-sun)
  (setq *smu/file-being-analyzed* name-of-file-to-analyze
        *smu/dossier-file* name-of-dossier-for-results)

  (with-open-file (*smu-outfile* name-of-dossier-for-results
                   :direction :output
                   :if-does-not-exist :create
                   :if-exists :append )
 (break)
    (analyze-text-from-file name-of-file-to-analyze)))



;;;------------------------
;;; pause after each entry
;;;------------------------

(define-completion-action (category-named 'colon-delimited-header)
                          :between-entry-pause
                          'check-header-for-entry-start)

#| These edges are introduced by a completion action over the
colon that follows the header. (The header is a sequence of
full-caps words beginning with a newline.)
   This routine picks out one of the headers as special since
it indicates that we've started a new entry. This event triggers
the updating of the entry information (via Note-entry-start)
and puts Sparser into a pause. |#

(defun check-header-for-entry-start (leading-header-edge)
  (let ((referent (edge-referent leading-header-edge)))
    (unless referent
      (break "Assumption violated: expected this header edge to ~
              have a referent.~%~A~%" leading-header-edge))
    (let ((word (value-of 'name referent)))

      (when (eq word (word-named "idsrdb"))  ;;//change when name routine fixed
        (let ((next-start (pos-edge-starts-at leading-header-edge)))

          (let ((prior-header-edge
                 (note-entry-start leading-header-edge)))
            (when prior-header-edge
              ;; irrelevant the first time through
              (scroll-edge-to-top prior-header-edge))
            (when *position-where-entry-starts*
              ;; check that this isn't the first entry we've just begun,
              ;; in which case that global would be nil
              (pause-between-entries))

            (setq *position-where-entry-starts* next-start)))))))


(defun pause-between-entries ()
  (initialize-smu-state)
  (ccl:dialog-item-enable *smu/next-phrase*)
  (update-workbench)
  (put-parse-into-pause "---- between entry pause -----"))

(defun scroll-edge-to-top (edge)
  (let ((line#
         (cdr (pos-display-char-index (pos-edge-starts-at edge)))))
    (scroll-tv-to line#)))



;;;--------------------------------------
;;; keeping track of where entries begin
;;;--------------------------------------

(defparameter *file-pos/entry-just-started* nil
  "This is the entry whose header edge triggers the routine.
   We haven't scanned any of its words yet.")

(defparameter *file-pos/entry-just-finished* nil
  "This is the entry we've just finished scanning in. 
   The next move will be to go back over it asynchronously
   and markup its tagged phrases. (The phrases were identified
   as it was scanned and there are now edges over them.) ")

(defparameter *number-of-entry-to-be-marked* nil
  )

(defparameter *number-of-entry-just-marked* nil
  )


(defparameter *header-edge/entry-just-started* nil)
(defparameter *header-edge/entry-about-to-be-marked* nil)

(defun clear-file-position-data ()
  (setq *file-pos/entry-just-started* nil
        *file-pos/entry-just-finished* nil
         *number-of-entry-to-be-marked* nil
         *number-of-entry-just-marked* nil
         *header-edge/entry-just-started* nil))

(define-per-run-init-form '(clear-file-position-data))



(defun note-entry-start (header-edge)
  ;; called from Check-header-for-entry-start when the header is
  ;; 'SRDB ID', signalling the start of an entry.
  (let ((buffer-index
         (pos-character-index (ev-position
                               (edge-starts-at header-edge)))))
    (when (= buffer-index 0)
      (when (not (= *initial-filepos* 0))
        (setq buffer-index *initial-filepos*)))

    ;; recycle the restart-data
    (unless (= buffer-index 0)
      (setq *file-pos/entry-just-finished*
            *file-pos/entry-just-started*))
    (setq *file-pos/entry-just-started* buffer-index)

    (when *number-of-entry-to-be-marked*
      ;; This was set on the last pass, now copy it onto the
      ;; global for the entry we've just completed marking up.
      ;; It will be reset just below
      (setq *number-of-entry-just-marked*
            *number-of-entry-to-be-marked*)
      (save-final-per-entry-information))

    (when *file-pos/entry-just-finished*
      ;; Save out the index data on the last entry, i.e. the one
      ;; that we're about to review and markup.  Note that we
      ;; haven't updated the pointer to the header edge yet.
      (let ((entry-number
             (save-entry-location *header-edge/entry-just-started*
                                  *file-pos/entry-just-finished*)))

        ;; While saving the character-pos information for restarting
        ;; the file part way through, that routine looked at the
        ;; number following the header of this entry that we're
        ;; about to markup.
        (setq *number-of-entry-to-be-marked* entry-number)))

    (setq *header-edge/entry-about-to-be-marked*
          *header-edge/entry-just-started*)
    (setq *header-edge/entry-just-started* header-edge)
    *header-edge/entry-about-to-be-marked* ))



(defun save-entry-location (header-edge its-filepos)
  ;; write this out so that in subsequent sessions we can pick up
  ;; where we left off
  (let* ((pos-after-colon (pos-edge-ends-at header-edge))
         (index-word (pos-terminal pos-after-colon))
         (entry-number (parse-integer (word-pname index-word))))

    (format *smu-outfile*
            "~&~%~
             ~%(define-entry-start :entry ~A :filepos ~A)~%"
            entry-number its-filepos)

    entry-number ))



(defun save-final-per-entry-information ()
  (let ((entry-number *number-of-entry-just-marked*))
    (format *smu-outfile*
            "~&~%~
             ~%(define-mistake-data :entry ~A :count ~A)~%"
            entry-number *number-of-mistakes-in-entry*)

    (setq *number-of-mistakes-in-entry* 0)
    entry-number ))
            


;;;------------------
;;; restart routines
;;;------------------

(defun redo-last-entry ()
  ;; this one has been scanned and we're (presumably) in the
  ;; middle of marking it up.
  (unless *file-pos/ongoing-entry*
    (break "No record of where the current entry starts"))
  (analyze-text-from-file/at-filepos *smu/file-being-analyzed*
                                     *file-pos/entry-just-finished*))

(defun restart-ongoing-entry ()
  ;; this is the one we're in the middle of scanning.
  ;; Keep the ongoing i/o files and open up the outfile again.
  ;; This should run from toplevel with the outfile closed.
  (with-open-file (*smu-outfile* *smu/dossier-file*
                   :direction :output
                   :if-does-not-exist :create
                   :if-exists :append )
    (clear-special-text-display-window)
    (when *initial-filepos*
      (setq *file-pos/entry-just-started*
            (+ *file-pos/entry-just-started*
               *initial-filepos*)))
    (analyze-text-from-file/at-filepos
     *smu/file-being-analyzed* *file-pos/entry-just-started*)))



(defparameter *initial-filepos* 0
  "For use when using Resume-srdb-file so that the filepos
   recorded for the entry that it resumes with will have
   the right value and not start at 0.")


(defun resume-srdb-file (name-of-file-to-analyze
                         name-of-dossier-for-results
                         filepos)

  (setup-for-sun) ;; rebuild the workbench

  (setq *smu/file-being-analyzed* name-of-file-to-analyze
        *smu/dossier-file* name-of-dossier-for-results
        *initial-filepos* filepos)

  ;(load name-of-dossier-for-results)
  ;(declare-all-existing-individuals-permanent)

  (with-open-file (*smu-outfile* name-of-dossier-for-results
                     :direction :output
                     :if-does-not-exist :create
                     :if-exists :append )

    (analyze-text-from-file/at-filepos name-of-file-to-analyze
                                       filepos )))

