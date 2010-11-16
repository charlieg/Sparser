;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "get file"
;;;  version:  ""

(in-package :CTI-source)


(defun directory-for-input-files ()
  (unless (probe-file *source-file-directory*)
      (error "The *source-file-directory* \"~A\"~
              ~%Does not exist" *source-file-directory*))
  *source-file-directory* )


(defun construct-input-filename-N (n)
  (let* ((number-string (format nil "~A" n))
         (padded-string
          (case (length number-string)
            (1 (concatenate 'string "000" number-string))
            (2 (concatenate 'string "00" number-string))
            (3 (concatenate 'string "0" number-string))
            (4 number-string))))
    
    (let ((namestring
           (concatenate 'string
                        (directory-for-input-files)
                        *file-alphabetic-prefix*
                        padded-string
                        *file-alphabetic-postfix* )))

      (unless (probe-file namestring)
        (ecase *action-if-input-file-doesnt-exist*
          (:return-to-command-line
           (throw 'return-to-command-line :threw-out))))

      namestring )))





;;----------------------- routines for the old driver ------------

;;;----------------------
;;; making the file name
;;;----------------------

(defparameter *curent-file-number/number* nil)


(defun construct-name-of-earnings-article-file ()
  (let* ((number (or *curent-file-number/number*
                     *file-initial-index-number/number*))
         (number-string (format nil "~A" number)))

    (unless (probe-file *source-file-directory*)
      (error "The *source-file-directory* \"~A\"~
              ~%Does not exist" *source-file-directory*))

    (let ((padded-string
           (case (length number-string)
             (1 (concatenate 'string "000" number-string))
             (2 (concatenate 'string "00" number-string))
             (3 (concatenate 'string "0" number-string))
             (4 number-string))))
      
      (concatenate 'string
                   *source-file-directory*
                   *file-alphabetic-prefix*
                   padded-string
                   *file-alphabetic-postfix* ))))


;;;--------
;;; driver
;;;--------

(defun wait-for-next-article-file ()
  ;; input files will be introduced into the designated directory
  ;; at unpredicatable intervals.  This routine constructs the
  ;; name of the next file to expect, then alternatively probes
  ;; and sleeps until it appears.

  (let ((file-name (construct-name-of-earnings-article-file))
        truename )

    (when *testing-Wait-for-next-article-file*
      (format t "~%~%Waiting for Headline~%"))

    (loop
      (when (setq truename (probe-file file-name))
        (when *testing-Wait-for-next-article-file*
          (format t "~&Headline~%"))
        (return))

      (sleep *how-long-to-sleep-between-probes*)

      (when *write-ticks*
        (format t " .")))

    (if *curent-file-number/number*
      (incf *curent-file-number/number*)
      (setq *curent-file-number/number*
            (1+ *file-initial-index-number/number*)))

    truename ))

