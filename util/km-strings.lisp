;;; FILE: strings.lisp

;;; File: strings.lisp
;;; Author: Peter Clark
;;; Date: August 1994
;;; Purpose: String manipulation with Lisp

#|
dmcdonald@bbn.com
  2/18/09 added optional 'from-end' argument to contains
|#

#|
;;; Also this works nicely!
(let ((stream (see <file>)))
  (prog1
      (loop for item = (read stream nil 'eof-marker) until (eq item 'eof-marker) collect item)
    (cond ((streamp stream) (close stream)))))

Template for a file reader. Or just use (read-file <file> 'sexpr)
(defun <name> (&optional (file <default-file>))
  (let ( (stream (see file)) )
    (loop until (not (progn
      (let* ( (data (read stream nil 'eof-marker)) )
	(cond 
	 ((eq data 'eof-marker) nil)
	 (t (<process-fn> data)
	    t))))))
    (cond ((streamp stream) (close stream)))
    t))

REVISED: Simply do: (apply-to-file-exprs #'process-line "myfile.km")
|#

;;; Read file as lines of strings
(defun apply-to-file-lines (function file)
  (let ( (stream (see file)) )
    (loop until 
	  (not (progn
		 (let* ( (data (read-line stream nil nil)) )
		   (cond 
		    ((null data) nil)
		    (t (apply function (list data))
		       t))))))
    (cond ((streamp stream) (close stream)))
    t))

;;; Read file as sxeprs
(defun apply-to-file-exprs (function file)
  (let ( (stream (see file)) )
    (loop until 
	  (not (progn
		 (let* ( (data (read stream nil 'eof-marker)) )
		   (cond 
		    ((eq data 'eof-marker) nil)
		    (t (apply function (list data))
		       t))))))
    (cond ((streamp stream) (close stream)))
    t))

(defparameter *whitespace-chars* '(#\Space #\Tab #\Newline #\Return #\Linefeed #\Page))
(defparameter *newline-string* (make-string 1 :initial-element '#\Newline))

;;; (a b) -> "(a b)"		       
(defun truncate-string (string &optional (maxlen 60))
  (cond ((not (stringp string)) 
	 (format t "ERROR! Non-string given to truncate-string in utils.lisp!~%")
	 string)
	((< (length string) maxlen) string)
	(t (concat (subseq string 0 maxlen) "..."))))

;;; ======================================================================

;;; "[cat]" -> "cat", "\"cat\"" -> "cat"
(defun strip-endchars (string) (subseq string 1 (- (length string) 1)))

;;; t for "A", "B", "C", etc.
(defun uppercase-letterp (word)
  (and (= (length word) 1) (alpha-char-p (elt word 0)) (upper-case-p (elt word 0))))

;;; (split-at "abcde" "bc") ---> "a" and "de"
;;; (split-at "abcde" "xx") ---> nil
(defun split-at (string substring &key from-end)
  (let ( (start0 (search substring string :from-end from-end)) )
    (cond (start0 (values (subseq string 0 start0)
			  (subseq string (+ start0 (length substring))))))))

;;; Returns a single value = list of two elements, or NIL if no split is possible
(defun split-at1 (string substring &key from-end)
  (let ( (start0 (search substring string :from-end from-end)))
    (cond (start0 (list (subseq string 0 start0)
			(subseq string (+ start0 (length substring))))))))

;;; (splits-at "a + b + c" " + ") -> ("a" "b" "c")
(defun splits-at (string substring)
  (let ( (start0 (search substring string)) )
    (cond (start0 (cons (subseq string 0 start0)
			(splits-at (subseq string (+ start0 (length substring))) substring)))
	  (t (list string)))))

(defun contains (string substring &optional from-end?)
  (search substring string :from-end from-end?))

(defun right-of (string substring &key from-end)
  (multiple-value-bind 
   (left right)
   (split-at string substring :from-end from-end)
   (declare (ignore left))
   right))

(defun left-of (string substring &key from-end)
  (split-at string substring :from-end from-end))		; just ignore second return value

;;; ASSUMES string has no trailing whitespace
(defun rightmost-word (string)
  (last-el (string-to-list string)))

;;; ======================================================================

;;; shorthand
(defun concat (&rest list) (my-concat list))
(defun concat-list  (list) (my-concat list))

; Redefinition from Francis Leboutte to avoid the following error in some Lisp implementations:
; Error: Argument list too long in APPLY: concatenate to (string...)
; > (my-concat '("a" "b" "c" "d" "e" "f" "g" "h") 8)
; "abcdefgh"
(defun my-concat (strings)
   (if (< (length strings) call-arguments-limit)
       (apply #'concatenate 'string strings)
     (let ((result (make-string (reduce #'+ (mapcar #'length strings))))
           (start 0))
       (dolist (string strings result)
         (replace result string :start1 start)
         (incf start (length string))))))

;(defun my-concat (list len)
;  (cond ((<= len *max-concat-length*) 
;	 (apply #'concatenate (cons 'string list)))
;	(t (concatenate 'string
;			(apply #'concatenate (cons 'string (subseq list 0 *max-concat-length*)))
;			(my-concat (subseq list *max-concat-length*)
;				   (- len *max-concat-length*))))))

; --------------------

;;; contains only whitespace
(defun white-space-p (string &key (whitespace-chars *whitespace-chars*))
  (white-space2-p string 0 (length string) whitespace-chars))

(defun white-space2-p (string n nmax whitespace-chars)
  (cond ((= n nmax))
	((member (char string n) whitespace-chars :test #'char=)
	 (white-space2-p string (+ n 1) nmax whitespace-chars))))
  
;;; ======================================================================
;;; Simpler version of scan-to (below)
;;; ======================================================================

;;; (break-up-at "c:dd>eee:f>" :delimeter-chars '(#\: #\>)) -> ("c" ":" "dd" ">" "eee" ":" "f" ">")
(defun break-up-at (string &key delimeter-chars)
  (break-up-at0 delimeter-chars string 0 0 (length string) 'positive))
    
(defun break-up-at0 (delimeter-chars string m n nmax polarity)
  (cond ((= n nmax) (list (subseq string m n)))		; reached the end.
	(t (let ( (curr-char (char string n)) )
	     (cond ((or (and (eq polarity 'positive) (member curr-char delimeter-chars :test #'char=))
			(and (eq polarity 'negative) (not (member curr-char delimeter-chars :test #'char=))))
		    (cons (subseq string m n)
			  (break-up-at0 delimeter-chars string n n nmax 
					(cond ((eq polarity 'positive) 'negative) (t 'positive)))))
		   (t (break-up-at0 delimeter-chars string m (1+ n) nmax polarity)))))))

;;; ======================================================================
;;;		STRING-TO-LIST   
;;; This nifty little utility breaks a string up into its word
;;; and delimeter components. Always starts with delimeter:


;;; (string-to-list '"the cat, sat on t-he m/at ")
;;; ==> ("" "the" " " "cat" ", " "sat" " " "on" " " "t-he" " " "m/at" " ")

;;; ======================================================================

;;; (string-to-words "the cat on the mat") -> ("the" "cat" "on" "the" "mat")
;;; (string-to-words "the cat_n1 is big" :wordchars '(not whitespace)) -> ("the" "cat_n1" "is" "big")
(defun string-to-words (string &key (wordchars 'alphanum))
  (remove-delimeters (string-to-list string :wordchars wordchars)))

;;; USER(3): (string-to-list "the cat sat")
;;; ("" "the" " " "cat" " " "sat")
;;; [1] This is a special-purpose bit of code which makes sure "." within
;;;     a string (eg. "Section 2.2.1") is *not* categorized as a delimeter.
(defun string-to-list (string &key (wordchars 'alphanum))
  (scan-to wordchars string 0 0 (length string)))

(defun scan-to (delimeter string m n nmax)
  (cond ((= n nmax) (list (subseq string m n)))		; reached the end.
	(t (let ( (curr-char (char string n))
		  (next-char (cond ((< (1+ n) nmax) (char string (1+ n)))
				   (t #\ ))) )
	     (cond ((and (is-type curr-char delimeter)
			 (not (and (char= curr-char #\.) 	; [1]
				   (alphanumericp next-char))))
		    (cons (subseq string m n)
			  (scan-to (invert-type delimeter) string n n nmax)))
		   (t (scan-to delimeter string m (1+ n) nmax)))))))

;;; x -> (not x); (not x) -> x
(defun invert-type (type)
  (cond ((and (listp type)
	      (eq (first type) 'not))
	 (second type))
	(t `(not ,type))))

;(defun embedded-delimeter (curr-char next-char type)
;  (declare (ignore type))
;  (and (char= curr-char #\.)
;       (alphanumericp next-char)))

(defun is-type (char type)
  (cond ((and (listp type)
	      (eq (first type) 'not))
	 (not (is-type char (second type))))
        ((eq type 'alphanum) (not (delimeter char)))
	((eq type 'whitespace) (member char *whitespace-chars* :test #'char=))
	(t (format t "ERROR! is-type: Unrecognized delimeter type ~a!~%" type))))

;;; 5/7/99: *Do* want to break up software/hardware into two words.
;;; (defun delimeter (char)
;;;  (and (not (alphanumericp char))
;;;       (not (char= char #\-))
;;;       (not (char= char #\/))))
(defun delimeter (char) (not (alphanumericp char)))

;;; Remove the delimeter components:
(defun remove-delimeters (list)
  (cond ((eq (cdr list) nil) nil)		;;; length 0 or 1
	(t (cons (cadr list) (remove-delimeters (cddr list))))))

;;; ======================================================================
;;; A bit more generic

;;; (new-scan-to "c:dd>eee:f>" :delimeter-chars '(#\: #\>)) -> ("c" ":" "dd" ">" "eee" ":" "f" ">")
(defun new-scan-to (string &key delimeter-chars)
  (new-scan-to0 delimeter-chars string 0 0 (length string) 'positive))
    
(defun new-scan-to0 (delimeter-chars string m n nmax polarity)
  (cond ((= n nmax) (list (subseq string m n)))		; reached the end.
	(t (let ( (curr-char (char string n)) )
	     (cond ((or (and (eq polarity 'positive) (member curr-char delimeter-chars :test #'char=))
			(and (eq polarity 'negative) (not (member curr-char delimeter-chars :test #'char=))))
		    (cons (subseq string m n)
			  (new-scan-to0 delimeter-chars string n n nmax 
					(cond ((eq polarity 'positive) 'negative) (t 'positive)))))
		   (t (new-scan-to0 delimeter-chars string m (1+ n) nmax polarity)))))))

;;; ======================================================================

#|
Break list of string fragments into lines
USER: (list-to-lines '("" "the" " " "cat" " " "sat" "
  " "on" " " "th" " " "emat" "
" "I" " " "think" "."))
-> ("the cat sat" "  on th emat" "I think.")
|#
(defun list-to-lines (strings &optional reverse-line-bits-so-far)
  (cond ((endp strings) 
	 (cond (reverse-line-bits-so-far (list (concat-list (reverse reverse-line-bits-so-far))))))	; otherwise nil
	(t (multiple-value-bind
	    (left right)
	    (split-at (first strings) *newline-string*)
	    (cond (left (cons (concat-list (reverse (cons left reverse-line-bits-so-far)))
			      (list-to-lines (cons right (rest strings)))))
		  (t (list-to-lines (rest strings) (cons (first strings) reverse-line-bits-so-far))))))))

;;; ======================================================================

;; " a " -> "a "
;; "  " -> ""
(defun remove-leading-whitespace (string) 
  (string-left-trim *whitespace-chars* string))

(defun remove-trailing-whitespace (string) 
  (string-right-trim *whitespace-chars* string))

;;; " a " -> "a"
(defun trim-whitespace (string)
  (string-trim *whitespace-chars* string))

;;; " a " -> t
(defun contains-whitespace (string)
  (some #'(lambda (char) (find char string)) *whitespace-chars*))

(defun whitespace-char (char) (member char *whitespace-chars* :test #'char=))
  
;;; (remove-from-end "A cat..." '(#\. #\? #\! #\; #\ )) -> "A cat"
(defun remove-from-end (string chars)
  (cond ((string= string "") "")
	((member (last-char string) chars :test #'char=)
	 (remove-from-end (trim-from-end string 1) chars))
	(t string)))

;;; ======================================================================

;;; mapchar; like mapcar, except it maps a function onto every
;;; character of a string rather than every element in a list.
;;; This should probably be a macro rather than a function.

(defun mapchar (function string) (mapcar function (explode string)))

(defun explode (string)
  (loop for i from 0 to (1- (length string))
	collect (char string i)))

(defun implode (charlist) (coerce charlist 'string))

;;; Range is 32 to 126. So to add N, we do   32 + (C - 32) + N

(defun crypt (string &key (shift 50)) (implode (mapcar #'(lambda (c) (shift-char c :shift shift)) (explode string))))

(defun shift-char (c &key (shift 50)) 
  (let ((new-code (+ (char-code c) shift)))
    (cond ((> new-code 126) (code-char (- new-code 95))) ; 127 -> 32
	  (t (code-char new-code)))))

;;; ======================================================================

;;; copied from Denys, and modified...

(defun break-string-at (string break-char)
  (loop
    for start0 = 0 then end
    and end = 0
    while (setq start0 (position-if-not
		       #'(lambda (char) (char= char break-char))
		       string :start start0))
    do    (setq end (position-if
		     #'(lambda (char) (char= char break-char))
		     string :start start0))
    collecting (subseq string start0 end)
    while end))

;;; ======================================================================

;;; (commaed-list '("a" "b" "c")) -> ("a" ", " "b" ", " "c")
(defun commaed-list (list &optional (delimeter ", "))
  (cond ((endp list) nil)
	((singletonp list) list)
	(t (cons (car list) (cons delimeter (commaed-list (cdr list) delimeter))))))

;;; Previously called spaced-list  
;;; (spaced-string '("a" "b" "c")) -> ("a b c")
(defun spaced-string (list) (concat-list (spaced-list list)))

(defun spaced-list (list)
  (cond ((endp list) nil)
	((singletonp list) list)
	(t (cons (first list) (cons " " (spaced-list (rest list)))))))
  
;;; ----------

(defun  last-char (string) (cond ((string/= string "") (char string (- (length string) 1)))))

; Optimization from Francis Leboutte
;(defun first-char (string) (cond ((string/= string "") (char string 0))))
(defun first-char (string)
  ;; les déclarations de type ne semblent pas apporter grand chose dans ce cas
  (declare (type simple-string string))
  (declare (optimize (speed 3) (safety 0) (space 0) (debug 0)))
  (if (string= "" string)
    nil
    (schar string 0)))

;;; (last-but-n-char "cat" 1) -> #\a
(defun last-but-n-char (string n) (cond ((> (length string) n) (char string (- (length string) (+ 1 n))))))

;;; (butlast-char "cats") -> "cat"
(defun butlast-char (string)
  (cond ((string/= string "") (subseq string 0 (1- (length string))))))

(defun butfirst-char (string)
  (cond ((string/= string "") (subseq string 1 (length string)))))

;;; (ends-with "abcde" "de") -> t
;;; Modified June 1999, to work with lists too (ends-with '(a b c d) '(c d))
(defun ends-with (string substr)
  (and (>= (length string) (length substr))
       (equal (subseq string (- (length string) (length substr)))
		substr)))

;;; (starts-with "step 10" "step") -> t
;;; Modified June 1999, to work with lists too (starts-with '(a b c d) '(a b))
(defun starts-with (string substr)
  (and (>= (length string) (length substr))
       (equal (subseq string 0 (length substr))
		substr)))

;;; Trim n characters from the end of string
(defun trim-from-end (string n)
  (subseq string 0 (- (length string) n)))

(defun trim-from-start (string n)
  (subseq string n (length string)))

(defun symbol-starts-with (symbol char)
  (char= char (char (symbol-name symbol) 0)))

;;; USER(2): (remove-wrapper "(the cat)" "(" ")") -> "the cat"
(defun remove-wrapper (string start0 end)
  (cond ((and (starts-with string start0)
	      (ends-with string end)
	      (>= (length string) (+ (length start0) (length end))))
	 (subseq string (length start0) (- (length string) (length end))))
	(t string)))

;;; ----------------------------------------
;;; (double-quotify-list '("cat" "the big cat")) -> '("cat" "\"the big cat\"")
(defun double-quotify-list (words &optional (delim-chars '(#\ )))
  (cond ((stringp words) (double-quotify words delim-chars))
	(t (mapcar #'(lambda (word)
		       (double-quotify word delim-chars))
		   words))))

(defun double-quotify (word &optional (delim-chars '(#\ )))
  (cond ((some #'(lambda (char)
		   (member char delim-chars :test #'char=))
	       (explode word))
	 (add-doublequotes word))
	(t word)))

(defun add-doublequotes (string) (concat "\"" string "\""))

;;; ======================================================================
;;;	Break up a string into pieces, preserving quoted adjacencies
;;; 	and trimming leading/ending white-space.
;;; ======================================================================

#| (break-up (string '|    aadsf a  " " "" "the cat" 1/2 a"b"c  de"f|))
("aadsf" 
 "a" 
 " " 
 "the cat" 
 "1/2" 
 "a" 
 "b" 
 "c" 
 "de" 
 "f")
|#
;;; NOTE: delim-chars MUSTN'T be a '"'
(defun break-up (string &optional (delim-chars '(#\ )))
  (break-up2 string 0 0 (length string) nil delim-chars))	  ; nil means "not in quotes"

;;; n is the current character (0 = first character)
;;; m is the start of the current 'word' still being read. If n = m then a word was just done.
(defun break-up2 (string m n nmax quotep &optional (delim-chars '(#\ )))
  (cond ((and (= n nmax) (= m n)) nil)			  ; ignore trailing white-space
	((= n nmax) (list (subseq string m n)))		  ; reached the end.
	(t (let ( (curr-char (char string n)) )
	     (cond ((and (not quotep)				  ; delimiter following start or a delimeter, so skip
			 (member curr-char delim-chars :test #'char=)
			 (= m n))
		    (break-up2 string (1+ n) (1+ n) nmax quotep delim-chars)) ; ... so ignore it
		   ((and (not quotep)				  ; found a delimiter
			 (member curr-char delim-chars :test #'char=))
		    (cond ((= m n)				  ; nothing between delimeters...
			   (break-up2 string (1+ n) (1+ n) nmax quotep delim-chars))    ; ... so ignore it
			  (t (cons (subseq string m n)
				   (break-up2 string (1+ n) (1+ n) nmax quotep delim-chars)))))
		   ((char= curr-char #\") 			  			; found a '"', so toggle quotep 
		    (break-up2 string m (1+ n) nmax (not quotep) delim-chars))
		   (t (break-up2 string m (1+ n) nmax quotep delim-chars)))))))

;;; ----------

;;; (_car1) -> (_car1)
;;; (_car1 _car2) -> (_car1 "and" _car2)
;;; (_car1 _car2 _car3) -> (_car1 "," _car2 ", and" _car3)
(defun andify (vals)
  (case (length vals)
	(0 nil)
	(1 vals)
	(2 (list (first vals) " and " (second vals)))
	(3 (list (first vals) ", " (second vals) ", and " (third vals)))
	(t (cons (first vals) (cons ", " (andify (rest vals)))))))

(defun orify (vals)
  (case (length vals)
	(0 nil)
	(1 vals)
	(2 (list (first vals) " or " (second vals)))
	(3 (list (first vals) ", " (second vals) ", or " (third vals)))
	(t (cons (first vals) (cons ", " (orify (rest vals)))))))

;;; (commaify '(a b c d)) -> ("A, " "B, " "C, " "D")
(defun commaify (vals)
  (cond ((endp vals) nil)
	((singletonp vals) (list (string (first vals))))
	(t (cons (concat (string (first vals)) ", ") (commaify (rest vals))))))

;;; ----------

;;; (add-escapes "a+b"" '(#\+ #\") -> "a\+b\""
(defun add-escapes (string specials)
  (cond ((not (stringp string))
	 (format t "ERROR! add-escapes: argument ~s isn't a string!~%" string))
	(t (concat-list (mapcar #'(lambda (char)
				    (cond ((member char specials) (concat "\\" (string char)))
					  (t (string char))))
				(explode string))))))

;;; (now) -> "22/4/1999 11:49.24"
(defun now ()  
  (multiple-value-bind 
      (s m h d mo y)
      (get-decoded-time)
    (format nil "~s/~s/~s ~s:~s.~s" mo d y h m s)))

;;; (common-startstring '("emergency" "emergencies")) -> "emergenc"
(defun common-startstring (strings)
  (cond ((singletonp strings) (first strings))
	(t (subseq (first strings) 0 (loop 
				       for i from 0 to (1- (apply #'min (mapcar #'length strings)))
				       until (some #'(lambda (string) 
						       (char/= (char string i) 
							       (char (first strings) i)))
						   (rest strings))
				       finally (return i))))))

;;; "a b c" -> "c", "a" -> "a" 
(defun last-word (string)
  (subseq string (1+ (or (search " " string :from-end t) -1))))

;;; ----------

;;; ("cat" "dog") -> ("cat" " " "dog")
(defun insert-spaces (words) 
  (insert-delimeter words " "))				; in utils.lisp

;;; ----------

(defun ynread (&optional (question-str ""))
  (format t question-str)
  (let ( (answer-str (read-line)) )
    (cond ((string= answer-str "y") 'y)
	  ((string= answer-str "n") 'n)
	  (t (format t "Please enter `y' or `n'!~%")
	     (ynread question-str)))))

;;; ----------------------------------------

(defun number-stringp (string)  (string-to-number string))

;;; [1] Avoid (string-to-number "9:00") -> Error: Package "9" not found. [file position = 2]
(defun string-to-number (string &key (fail-mode 'fail))
  (cond ((not (stringp string))
	 (format t "; ERROR! (string-to-number ~s) should be given an ascii string as an argument!~%" string))
	((string= string "") nil)
	((let ((string0 (remove #\, string :test #'char=))) ; "3,000" -> "3000"
	   (handler-case
	     (multiple-value-bind
		 (number unread-char-no)
		 (read-from-string string0)
	       (cond ((and (numberp number)
			   (= unread-char-no (length string0)))
		      number)))
	   (error (error)			; [1]
	     (declare (ignore error))))))
	((eq fail-mode 'error)
	 (format t "; ERROR! (string-to-number ~s) should be given an ascii string representation of a number!~%" 
		 string))))

(defun clear-screen () (format t ""))

(defun pause ()
  (format t "Press <RETURN> to continue...")
  (read-line))

;;; ----------------------------------------

;;; USER(105): (remove-string "cat" "the cat on")
;;; -> "the  on"
(defun remove-string (bit string)
  (multiple-value-bind
   (left right)
   (split-at string bit)
   (cond (left (concat left (remove-string bit right)))
	 (t string))))

;;; ======================================================================

#|
SAPIR(133): (read-to "the cat; the mat" '(#\;))
"the cat"
" the mat"
#\;
SAPIR(134): (read-to "the cat; the mat" '(#\@))
"the cat; the mat"
""
nil
SAPIR(136): (read-to "the cat the mat;" '(#\;))
"the cat the mat"
""
#\;
|#
(defun read-to (string chars)
  (let ( (break-point (loop for i from 0 to (1- (length string))
			    until (member (elt string i) chars :test #'char=) 
			    finally (return i))) )
    (cond ((= break-point (length string)) (values string "" nil))
	  (t (values (subseq string 0 break-point) 
		     (subseq string (1+ break-point) (length string)) 
		     (elt string break-point))))))

;;; ======================================================================

#|
GIVEN a list of strings broken at arbitrary points
THEN concatenate and rebreak the strings at <nl> points only
AND truncate when max-document-size characters have been reached
	[1c] USER(9): (list-to-lines-with-size-limit '("the big" "cat sat " "on
	the" "mat I think today") :max-document-size 20)
returns TWO values
	("the bigcat sat on" "the")
	t				; max document size was reached
|#
(defun list-to-lines-with-size-limit (strings &key (max-document-size 1000))
  (let* ( (rebroken-strings (list-to-lines-with-size-limit0 strings :max-document-size max-document-size))
	  (max-document-size-reached (>= (apply #'+ (mapcar #'length rebroken-strings)) max-document-size)) )
    (values rebroken-strings max-document-size-reached)))

(defun list-to-lines-with-size-limit0 (strings &key (max-document-size 1000) (length-so-far 0) reverse-line-bits-so-far)
  (cond ((or (endp strings) 
	     (>= length-so-far max-document-size))
	 (cond (reverse-line-bits-so-far (list (concat-list (reverse reverse-line-bits-so-far))))))	; otherwise nil
	(t (multiple-value-bind
	    (left right)
	    (split-at (first strings) *newline-string*)
	    (cond (left (cons (concat-list (reverse (cons left reverse-line-bits-so-far)))
			      (list-to-lines-with-size-limit0 (cons right (rest strings)) 
							      :max-document-size max-document-size
							      :length-so-far (+ length-so-far (length left)))))
		  (t (list-to-lines-with-size-limit0 (rest strings) 
						     :max-document-size max-document-size
						    :length-so-far (+ length-so-far (length (first strings)))
						    :reverse-line-bits-so-far (cons (first strings) reverse-line-bits-so-far))))))))


;;; "_Car23" -> TWO values: "_Car" 23
;;; "_Car" -> TWO values: "_Car" NIL
(defun trim-numbers (string &key number-chars (with-warnings t))
  (cond 
   ((string= string "") 
    (cond (with-warnings (format t "; WARNING! Null string passed to trim-numbers!~%")))
    "")
   ((digit-char-p (last-char string))
    (trim-numbers (butlast-char string) 
		  :number-chars (cons (last-char string) number-chars) :with-warnings with-warnings))
   (t (values string (cond (number-chars (string-to-number (implode number-chars))))))))

;;; --------------------

;;; directory can be a directory or include a pattern, e.g., 
;;; (files-in-directory (concat *test-suite-directory* "*.lisp"))
;;; [1] Allegro built-in
(defun files-in-directory (directory)
  (mapcar #'(lambda (pathstr)
	      (multiple-value-bind
		  (path file)
		  (split-at pathstr "/" :from-end t)
		(declare (ignore path))
		(or file
		    (multiple-value-bind
			(path2 file2)
			(split-at pathstr "\\" :from-end t)
		      (declare (ignore path2))
		      (or file2
			  pathstr)))))
	  (mapcar #'namestring (directory directory))))	; [1]

;;; ----------------------------------------------------------------------

;;; Allegro specific
(defun is-user-interrupt (error) (search "Keyboard interrupt" (format nil "~a" error)))

;;; Note: Message must include "Keyboard interrupt" string so the is-user-interrupt text is passed
(defun throw-ctrl-c-error () (error "(Keyboard interrupt from the user)"))

(defun handle-ctrl-c-error (error) (cond ((is-user-interrupt error) (throw-ctrl-c-error))))

;;; ======================================================================

;;; Multiple applications
(defun substitute-strings (string alist)
  (cond ((endp alist) string)
	(t (let* ((old-dot-new (first alist))
		  (old (first old-dot-new))
		  (new (rest old-dot-new)))
	     (substitute-strings (substitute-string old new string) (rest alist))))))

;;; (substitute-string "a" "AA" "a cat is ra") -> "AA cAAt is rAA"
(defun substitute-string (old new string) (concat-list (substitute-string0 old new string)))

(defun substitute-string0 (old new string)
  (let ((pos (search old string)))
    (cond (pos `(,(subseq string 0 pos) 
		 ,new 
		 ,@(substitute-string0 old new (subseq string (+ pos (length old)) (length string)))))
	  (t (list string)))))

;;; ======================================================================  

#|
(fold <string> <n>): Break a long string up after approximately <n> characters,
preferring to break at a space if possible.

(fold "the cat is on the mat in the park in the rainrainrainrainrainrainrain" 10)
"the cat
is on the
mat in
the park
in the
rainrainra
inrainrain
rainrain"
|#  
(defun fold (string0 n)
  (let ((string (trim-whitespace string0)))
    (cond 
     ((<= (length string) n) string)  
     (t (concat-list (insert-delimeter (fold0 string n) *newline-str*))))))
  
(defun fold0 (string n)
  (cond 
   ((<= (length string) n) (list string))
   (t (let ((space-posn (or (position #\  string :end n :from-end t) n)))
	(cons (subseq string 0 space-posn) 
	      (fold0 (remove-leading-whitespace (subseq string space-posn (length string))) n))))))

