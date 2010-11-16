;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER LISP) -*-
;;; copyright (c) 1992 David D. McDonald  -- all rights reserved
;;;
;;;     File:  "cmd loop"
;;;   Module:  "interface;AssetNet:"
;;;  version:  January 1992

(in-package :sparser)


(defun assetNet-command-loop ()
  (format t *salutation*)
  (catch 'exit-AssetNet-loop
    (loop
      (read-line-as-AssetNet-command))))


(defun read-line-as-AssetNet-command ()
  (let ( line-string length token index )

    (format t *command-line-prompt*)

    (setq line-string (read-line))
    (setq length (length line-string))

    (when (= length 0)
      (return-from Read-line-as-AssetNet-command))

    (multiple-value-setq (token index)
                         (read-from-string line-string))

    ;(format t "~&token = ~A  index = ~A" token index)

    (catch 'return-to-command-line
      (typecase token
        (symbol
         (case token
           (go
            (parse-GO-command line-string length index))
           (?
            (help/AssetNet-command-line))
           (help
            (help/AssetNet-command-line))
           (eval
            (parse-EVAL-command line-string length index))
           (quit
            (format t "~%~%Leaving the command loop and returning ~
                       to Lisp.~
                       ~%To enter the loop again, type~
                       ~%  (AssetNet-command-loop)~
                       ~%~%")
            (throw 'exit-AssetNet-loop :quit-from-loop))
           (:bad-input
            (format t "~%~A is not a valid command" token)
            (help/AssetNet-command-line))
           (otherwise
            (format t "~%~A is not a valid command" token)
            (help/AssetNet-command-line))))       
        (otherwise
         (format t "~%~A is not a valid command" token)
         (help/AssetNet-command-line))))))


;;;------
;;; help
;;;------

(defun help/AssetNet-command-line ()
  (format t "~%~%The following commands are accepted:~
             ~%  \"GO <number>\"~
             ~%       Analyses just the headline file with the ~
             indicated number.~
             ~%  \"GO <number> ALL\"~
             ~%       Analyses all the headline files starting ~
             with that number ~
             ~%       file, pausing ~A seconds between files.~
             ~%       Type return to go back to ~
             the command line.~
             ~%  \"GO\"~
             ~%       Same as \"GO 1 ALL\".~
             ~%  \"HELP\"~
             ~%       Prints this message~
             ~%  \"QUIT\"~
             ~%       Exits the command loop and returns to Lisp.~
             ~%       To restart the loop, type~
             ~%           (assetnet-command-loop)~
             ~%~%"
          *wait-between-commanded-input-files*))


;;;----------
;;; commands
;;;----------

(defun parse-EVAL-command (line-string length index)
  (when (not (= length index))
    (let ((exp
           (read-from-string (subseq line-string index))))
      (typecase exp
        (symbol (print (eval exp)))
        (list   (print (eval exp)))
        (string (format t "~%~A" exp))
        (otherwise (format t "~%ignoring unknown object: ~A"
                           exp)))
      (terpri))))


(defun parse-GO-command (line-string length index)
  (when (= length index)
    (analyze-all-the-files)
    (return-from Parse-GO-command))

  (let ( number-token subindex )

    (multiple-value-setq (number-token subindex)
                         (read-from-string
                          (subseq line-string index)))
    (unless (numberp number-token)
      (format t "~%The command GO can be followed by a number, ~
                 but not~
                 ~%by a ~A~
                 ~%"  (type-of number-token))
      (return-from Parse-GO-command))

    (when (= (- length index)
             subindex)
      (analyze-file-N number-token)
      (return-from Parse-GO-command))

    (let ((final-token
           (read-from-string (subseq line-string
                                     (+ index subindex)))))
 ;(break "2")
      (if (eq final-token 'all)
        (analyze-all-the-files/start-at-N number-token)
        (progn
          (format t "~%Expected \"All\" after the number, not ~A"
                  final-token)
          (help/AssetNet-command-line))))))
