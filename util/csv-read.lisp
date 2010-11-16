(in-package "ITAS")

#-(or mcl windows)
(defmacro declaim (arg)
  `(eval-when (eval compile load)
    (proclaim ',arg)))

#+lucid
(import 'lcl::load-time-value)

#||
Reading Comma Seperated Values files:

o End of line is indicated by one or two of  either #\newline, #\linefeed, 
  or #\return.

o An empty field is indicated either as a null string followed by a comma, or
  a comma.

o It is assumed that all strings are quoted with #\".
||#

(declaim (inline end-of-line-character?))
(defun end-of-line-character? (c)
  ;;  Only 2 of these 3 are distinct!
  (or (char= c #\newline)               
      (char= c #\linefeed)
      (char= c #\return)))

#+ignore
(defun read-delimited-string (stream delimiter buffer)
  ;; Needs work.
  (declare (simple-string )))

(defmethod eof? ((stream stream))
  (eq (peek-char nil stream nil 'eof) 'eof))


;;; need to handle delimiter char inside string quotes.. mb 082396
(defun parse-csv (stream delimiter eol eof null)
  (declare (standard-char delimiter))
  (let ((*package* *itas-package*)
	(c (peek-char nil stream nil eof)))
    (if (or (eq c eof)
	    (null c))          ;;; added this -- don't know why it helps - MB
	    EOF                  ;  End of File.
        (let ((c c))
          (declare (standard-char c))
          (cond ((char= c delimiter)    ;  Null field 1.
                 (read-char stream)
                 NULL)
                ((end-of-line-character? c) ;  End of Line.
                 (read-char stream)
                 ;; Allow for an optional second EOL 
                 (let ((c (peek-char nil stream nil nil)))
                   (if (and c (end-of-line-character? c))
		       (read-char stream)))
                 EOL)
                (t (let ((thing (read-preserving-whitespace stream nil eof)))
                     ;; Skip the delimiter
                     (let ((c (peek-char nil stream nil nil)))
                       (cond ((null c))
                             ((char= c delimiter) (read-char stream))
                             ((end-of-line-character? c))
                             (t (error 
                                 "Error in parsing csv stream ~a" stream))))
		     thing #+ignore  ;; true ken'ism!
                     (if (simple-string-p thing) 
			 (let ((L (length thing)))
			   (if (zerop L) NULL
			       (if (<= L 10) (intern-string thing)
				   thing)))
			 thing))))))))

(defun parse-csv-normal (stream)
  ;; Continuation passing style.
  (let ((value (parse-csv stream #\, 'eol 'eof nil)))
    (cond ((eq value 'eof) (error "Unexpected end of file: ~a" (truename stream)))
	  ((eq value 'eol) (error "Unexpected end of line in file ~a" (truename stream)))
	  (t value))))


;; mb version - if first read on line, don't error, just return :end
(defun parse-csv-1 (stream bol)
  ;; Continuation passing style.
  (let ((value (parse-csv stream #\, 'eol 'eof nil)))
     ;; if empty line, get another...
    (cond ((and bol (eq value 'eol)) (parse-csv-1 stream bol)) 
	  ((and bol (eq value 'eof)) :end)
          ((eq value 'eof) (error "Unexpected end of file: ~a" (truename stream)))
	  ((eq value 'eol) (error "Unexpected end of line in file ~a" (truename stream)))
	  (t value))))





(defun read-csv-line (stream)
  (let* ((eol "eol")
         (eof "eof")
	 (thing (parse-csv stream #\, eol eof nil)))
    (if (or (eq thing eol) (eq thing eof))
      '()
      (cons thing (read-csv-line stream)))))

(defun read-csv-file (file)
  (with-open-file (s file)
    (let ((results '()))
      (loop
        (let ((record (read-csv-line s)))
          (when (null record) (return (nreverse results)))
          (push record results))))))

#+debug
(time (progn (read-csv-file "hd:schlep:pacaf-db:locs.cdf") nil))
(defpackage string (:use))

(defun intern-string (string &optional start end)
  ;; Quick, Dirty and Consful.
    (symbol-name
     (intern (if (null start) string
                 (subseq string start end))
             (load-time-value (find-package "STRING")))))
 
 
;;; this replaced by CSV-READ-VALUES 
;;; and the macro WITH-CSV-OR-TABLE found in SCHLEP-PARSE.LISP
(defmacro with-csv-reading (stream vars &body body)
  `(let (#+ignore (*package* (find-package "KEYWORD")))
    (let ,(remove nil (remove 'ignore vars))
      ,@(mapcar
	 #'(lambda (v) 
	     (if (member v '(nil ignore) :test #'eq)
		 `(parse-csv-normal ,stream)
	       `(setq ,v (parse-csv-normal ,stream))))
	 vars)
      (unless (member (parse-csv ,stream #\, 'eol 'eof nil) 
		      '(eol eof nil #\newline) :test #'eq)
	(error "Expected to be at end of line in ~A" ,stream))
      ,@body)))



;; filter out ignores using destructuring bind. read one value for each of vars.
#+ignore
(defun csv-read-values (stream vars)
  (loop for v in vars 
	for val = (parse-csv-normal stream)	 
      collect val into vals		       
      finally (if (member (parse-csv stream #\, 'eol 'eof nil) 
			  '(eol eof nil #\newline) :test #'eq)
		  (return vals)
		(error "Expected to be at end of line in ~A" stream))))
