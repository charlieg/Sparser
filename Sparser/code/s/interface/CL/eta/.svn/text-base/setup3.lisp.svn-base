;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;; 
;;;     File:  "setup"
;;;   Module:  "interface;PRW"
;;;  Version:   1.5  January 1991
;;;

(in-package :CTI-source)

;; Change Log:
;;  1.1  Fixed a bug in the calculation of character positions when
;;       the linguistic-object is an edge and it ends at the furthest
;;       rightwards extension of the chart up to that moment.
;;  1.2  (v1.5)  fixed another bug in those calculations that occurred
;;       when this routine was called on a unary category directly
;;       dominating a word where the word started in the last cell of
;;       the position array.  [actually, nothing changed in this file
;;       except for some cleanup of the indentation.  The fix is in the
;;       definition of Chart-position-before, in objects;chart:array1
;;  1.3  Revamped somewhat to accomodate to "subsuming edges" version of
;;       the "Complete" routine that ultimately feeds this routine when
;;       running under the Recognizer-setting of the Analyzer's switches
;;  1.4  (v1.5  11/27 @C&L)  Changed the flow of the conditionals at the
;;       bottom of the routine so as to handle the condition that the
;;       break that had been there before (see ver. "1" of this file) was
;;       no longer needed.
;;  1.5  (v1.7  1/14)  Fixed a fencepost interaction with the refilling
;;       of the character buffer.
;;


(defun Set-up-and-call-topic-stamping-function (topic-association
                                                linguistic-object)
  ;; called by Carry-out-action
  (let* ((topic (eta-topic topic-association))
         (rule
          ;; the word may well have been independently defined, but it's
          ;; significance was established by the rule that defined the
          ;; topic association.  The polyword almost certainly exists only
          ;; because of the topic association rule
          (etypecase linguistic-object
            (word     topic-association)
            (edge     topic-association)))
         (position/start
          (etypecase linguistic-object
            (word (+ (pos-character-index
                      (chart-position *position-of-pending-word*))
                     *length-accumulated-from-prior-buffers*))
            (edge (pos-character-index
                   (ev-position (edge-starts-at linguistic-object))))))
         (position/end
          (etypecase linguistic-object
            (word (+ (pos-character-index
                      (chart-position *position-after-pending-word*))
                     *length-accumulated-from-prior-buffers*))
            (edge (pos-character-index
                   (ev-position (edge-ends-at linguistic-object)))))))

    (when (and (typep linguistic-object 'edge)
               (null (pos-terminal
                      (ev-position (edge-ends-at linguistic-object)))))
      ;; We've gotten as far out in the chart as it has yet gone and
      ;; have to calculate the index because it isn't set yet.
      (let* ((penultimate-position
              (chart-position-before
               (ev-position (edge-ends-at linguistic-object))))
             (penultimate-word
              (pos-terminal penultimate-position)))
        (setq position/end
              (+ (pos-character-index penultimate-position)
                 (if penultimate-word
                   (length (word-pname penultimate-word))
                   0)))))

    (cond ((> position/start position/end)
           ;(break "Intermittent chart initialization error: ~
           ;        start position greater than end")
           (setq position/start (+ (if (= 0 *length-accumulated-from-prior-buffers*)
                                     0
                                     (- *length-accumulated-from-prior-buffers*
                                        *length-of-character-input-buffer*))
                                   position/start)
                 position/end   (+ *length-accumulated-from-prior-buffers*
                                   position/end)))

          ;(t ;; there had been a test here: (typep linguistic-object 'edge)
          ;   ;; but this addition applies to any kind of evidence object,
          ;   ;; not just edges
          ; (setq position/start (+ *length-accumulated-from-prior-buffers*
          ;                         position/start)
          ;       position/end   (+ *length-accumulated-from-prior-buffers*
          ;                         position/end)))
          )

    (let ((length-of-segment (- position/end position/start)))
      (when (> length-of-segment *length-of-character-input-buffer*)
        (setq position/end
              (- position/end *length-of-character-input-buffer*))))

    (evidence-for-topic topic
                        linguistic-object
                        rule
                        position/start
                        position/end
                        )))

