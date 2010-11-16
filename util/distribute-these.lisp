;;; -*- Mode: Lisp; Syntax: COMMON-LISP; Base:10; -*-
;;; $Id:util.lisp 9571 2008-07-02 16:54:04Z matighet $
;;; Copyright (c) 2006 BBNT Solutions LLC. All Rights Reserved

(in-package :ltml)
;; n.b. modify this when utilities are unified

;;;-----------------------------------------------------------
;;;   syntactic sugar (functions that ought to be in CL)
;;;-----------------------------------------------------------

(defmacro then (&body forms) `(progn ,@forms))
(defmacro else (&body forms) `(progn ,@forms))

(defun d (o)
  (describe o)
  o)

(defun string-append (&rest list-of-strings)
  (let ( strings )
    (dolist (s list-of-strings)
      (push (typecase s
              (string s)
              (symbol (format nil "~a" (symbol-name s)))
              (number (format nil "~a" s))
              (pathname
               (format nil "~a" (namestring s)))
              (namespace
               (format nil "~a" (ns-short-form s)))
              (otherwise
               (break "string-append - new type: ~a~%~a"
                      (type-of s) s)))
            strings))
    (apply #'concatenate 'string (nreverse strings))))

(defun concat (&rest list-of-strings)
  (ltml-intern (apply #'string-append list-of-strings)))

;; copied from lispm
(defmacro let-with-dynamic-extent (bindings &body body)
  `(let ,bindings
     (declare (special ,@(mapcar #'car bindings)))
     ,@body))

(defmacro let-with-dynamic-extent-unless-bound (bindings &body body)
  (let ((v1 (caar bindings)))
    `(if (boundp ',v1)
       ,@body
       (let ,bindings
         (declare (special ,@(mapcar #'car bindings)))
         ,@body))))

(defmacro push-new (value place)
  ;; forgot that pushnew is in CL -- and I tend to spell it this
  ;; way by instinct. Maybe it was spelled that way in MacLisp.
  `(when (not (member ,value ,place))
    (push ,value ,place)))

(defun append-new (&rest lists)
  (let ((output-list (nreverse (copy-list (car lists))))
        (appended-lists-in-order (cdr lists)))
    (dolist (sublist appended-lists-in-order)
      (dolist (item sublist)
        (push-new item output-list)))
    (nreverse output-list)))

(unless (fboundp 'assq)
(defun assq (item alist)
  (assoc item alist :test #'eq))
  )
;; these ought to be substitution macros, but I don't know
;; if we can do that
(unless (fboundp 'memq)
(defun memq (item list)
  (member item list :test #'eq)))

(defun keys-of-association-list (alist)
  (let ( symbols )
    (dolist (pair alist)
      (push (car pair) symbols))
    (nreverse symbols)))

(defun tail-cons (item list)
  "Add the item to the end of the list"
  (case (length list)
    (0
     (list item))
    (1
     (list (car list) item))
    (otherwise
     (let ((last-cell (last list)))
       (rplacd last-cell
               (list item))
       list))))

(defun deep-copy (l)
  (cond
   ((consp l)
    (cons (deep-copy (car l))
          (deep-copy (cdr l))))
   (t l)))

(defun flatten (list-of-lists)
  "Returns a single-level list of all the symbols or other non-cons
   objects at the fringe of the tree in their pre-next order."
  ;; (flatten '(a b (c) d (e (f g)) (h) i (((j k) l)) m))
  (let ( result )
    (dolist (item list-of-lists)
      (if (consp item)
        (setq result (append (nreverse (flatten item)) result))
        (push item result)))
    (reverse result)))

(defun flattenc (cons-structure)
  "Returns a single-level list of all the non-cons objects at the
   edge of the tree, except for nils.  Can deal with non-list cdrs."
  ;; (flattenc '(a b (c) d () (e (f . g)) (h) i (((j k) . l)) m))
  (let* ((head (cons t nil)) (tail head))
    (labels ((walk (l)
               (if (consp l)
                   (progn (walk (car l)) (walk (cdr l)))
                 (when l
                   (rplacd tail (cons l nil))
                   (setf tail (cdr tail))))))
      (walk cons-structure)
      (cdr head))))

(defun sexp-contains-symbol (sexp symbol)
  (catch 'found-symbol
    (_sexp-contains-symbol sexp symbol)))
(defun _sexp-contains-symbol (sexp symbol)
  (when (eq (car sexp) symbol)
    (throw 'found-symbol t))
  (when (consp (car sexp))
    (_sexp-contains-symbol (car sexp) symbol))
  (when (cdr sexp)
    (_sexp-contains-symbol (cdr sexp) symbol)))


(defun split-list-on-first-keyword (list)
  (let ( before after-including-keyword )
    (do ((item (car list) (car rest))
         (rest (cdr list) (cdr rest)))
        ((null item))
      (if (keywordp item)
        (then (setq after-including-keyword (cons item rest))
              (return))
        (push item before)))
    (values (nreverse before)
            after-including-keyword)))


(defvar *gensym-symbol-alist* nil)

(defun gensymbol (symbol &optional no-dash) ;;/// add package
  ;; The braincells are working overtime, but I seem to recall that there
  ;; was a version of gensym that took a symbol and incf'd (from 0) on
  ;; that symbol.
  (let ((entry (assoc symbol *gensym-symbol-alist*)))
    (if entry
      (let ((count (incf (cdr entry))))
        (rplacd entry count)
        (_gensymbol symbol count no-dash))
      (else
        (push `(,symbol . 1) *gensym-symbol-alist*)
        (_gensymbol symbol 1 no-dash)))))

(defun _gensymbol (symbol count no-dash)
  (ltml-intern (string-append (symbol-name symbol)
			      (if no-dash
				  ""
				"-" )
			      (format nil "~a" count))))

(defun ltml-intern (string)
  "Intern the string as a symbol in the LTML package."
  (intern string (find-package :ltml)))  ;; #.(package-name *package*))))


(defvar *package-strictness*)         ; predeclare, since loaded before globals
(defun ensure-ltml-symbol (s)
  (when *package-strictness*
    (unless (eq (symbol-package s) (find-package :ltml))
      (unless (nth-value 1 (ltml-intern s)) ; OK when imported or external
        (when (eq *package-strictness* :warn)
          (warn "Packaging problem: had to intern symbol ~s (of ~s) in ~
                 ltml package." s (symbol-package s)))))))

(defun ordinal-ending (n)
  ;; for print methods involving ordinal numbers
  (let* ((string (format nil "~a" n))
         (last-char (elt string (1- (length string)))))
    (case last-char
      (#\1 "st")
      (#\2 "d")
      (#\3 "d")
      (otherwise "th"))))


(defun string->list-of-symbols (string)
  (let ((start 0)
        (end (position #\space string))
        (rest string)
        symbols  )
    (if (null end)
      (intern string)
      (else
        (loop
           while end
           do
             (let ((substring (subseq rest start end)))
               (push (intern substring)
                     symbols)
               (setq rest (subseq rest (1+ end)))
               (setq end (position #\space rest))))
        (push (intern rest)
              symbols)
        (nreverse symbols)))))

(defun string->Java-style-symbol (string)
  (let* ((symbols (string->list-of-symbols string))
         (capitalized-strings
          (mapcar #'(lambda (symbol)
                      (string-capitalize (symbol-name symbol)))
                  symbols)))
    (apply #'concat capitalized-strings)))

(defun upcase-first-letter (string)
  ;; string-capitalize downcases all the characters after the first,
  ;; so it does the wrong thing with camel-case symbols
  (typecase string
    (string)
    (symbol (setq string (symbol-name string))))
  ;; This is a destructive operation, so we have to work off a copy
  (let* ((s (copy-seq string))
         (first-char (char s 0)))
    (setf (char s 0) (char-upcase first-char))
    s))

(defun capitalize-symbol (symbol)
  (unless (symbolp symbol)
    (error "Called the wrong function. capitalize-symbol takes a symbol, ~
             not a ~a~%~a" (type-of symbol) symbol))
  (let ((string (symbol-name symbol)))
    (intern (upcase-first-letter string))))

(defun replace-periods-with-underbars (string)
  (unless (stringp string) (error "Only apply to strings. Got a ~a instead~%~a"
                                  (type-of string) string))
  (substitute #\_ #\. string))

(defun replace-bad-URI-characters (string)
  (substitute
   #\_
   #\space
   (substitute
    #\_
    #\(
    (substitute
     #\_
     #\)
     (substitute
      #\_
      #\.
      (substitute
       #\_
       #\:
       string))))))

(defun sexp->string (sexp)
  (with-output-to-string (s)
    (format s "(")
    (sexp-to-string1 s sexp)
    (format s ")")))

(defun sexp-to-string1 (s sexp)
  (let ((first (car sexp))
        (rest (cdr sexp)))
    (when first
      (typecase first
        (symbol (format s "~a " (symbol-name first)))
        (cons (format s "(")
              (sexp-to-string1 s first)
              (format s ") "))
        (integer (format s "~a " first))
        (string (format s "~a " first))
        (otherwise
         (break "Unexpected type of item passed to sexp-to-string1: ~a~%~a"
                (type-of first) first))))
    (when rest
      (sexp-to-string1 s rest))))

(defun ends-in (reference-string target-string)
  (typecase reference-string
    (string)
    (symbol (setq reference-string (symbol-name reference-string)))
    (otherwise (error "Only applies to string.~%The first arg is a ~a~%~a"
                      (type-of reference-string) reference-string)))
  (unless (stringp target-string)
    (error "The second argument 'target' must be a string~%~a  ~a"
           (type-of target-string) target-string))
  (let ((index (search target-string reference-string)))
    (when index
      (= (+ index (length target-string))
         (length reference-string)))))

(defun launder-sexp-symbols-package (sexp new-package)
  (typecase sexp
    (symbol
     (if (keywordp sexp) sexp (intern (symbol-name sexp) new-package)))
    (cons
     (let ((first (launder-sexp-symbols-package (car sexp) new-package))
           (rest (launder-sexp-symbols-package (cdr sexp) new-package)))
       (cons first rest)))
    (otherwise ;; numbers, structs, class-instances, ...
     sexp)))



(defmacro format-nl (stream string &rest args)
  `(let* ((format-string (format nil "~&~%~%~%~a~%~%~%~%~%" ,string))
          (form (list* 'format ,stream format-string ',args)))
     (eval form)))


;; Generic method for equivalence testing
(defmethod eqv (a b) (equalp a b))

;; tp converts a generalized boolean to a boolean (only T or NIL)
(defun tp (x) (if x t nil))

;;--- MAPSET
;; A converse to the standard map function, mapset
;; takes each element of list as a set of arguments for the
;; function, and returns a list of results of application.
;; e.g. (mapset #'+ '((1 2) (3 4 5) (6) (7 8 9))) -> (3 12 6 24)
(defun mapset (fn list)
  (when (consp list)
    (cons (apply fn (car list))
          (mapset fn (cdr list)))))

;;--- Macros for currying functions
;; pcf (partial call function) appends rest of arguments and calls the function
;; example: (mapcar (pcf + 2 3) '(4 5 6)) -> (9 10 11)
(defmacro pcf (f &rest args)
  `(function (lambda (&rest completion) (apply #',f ,@args completion))))

;; ppf (partial pattern call function) first fills in blanks left by
;;   call-variables then appends rest of args to the end of the call
;; example: (mapcar (ppf find ?X '(1 2 3 4)) '(2 5 1 d)) -> (2 nil 1 nil)
(defun call-variablep (x)
  (and (symbolp x) (eq (elt (symbol-name x) 0) #\?)))
(defmacro ppf (f &rest args)
  (let ((params (remove-if-not #'call-variablep args)))
    `(lambda (,@params &rest completion) (apply #',f ,@args completion))))


(defun compile-and-load (file &key (verbose *compile-verbose*)
                               (print *compile-print*))
  #+allegro
  (excl:compile-file-if-needed file :verbose verbose :print print)
  (load file :verbose verbose :print print))


;; Method for displaying the contents of a hashtable
(defun hashtable-to-alist (table)
  (let ((alist '()))
    (maphash (lambda (k v) (push (cons k v) alist)) table)
    alist))

;; (leaf-map #'sqrt '(((4 1) 25) (9 100) 64)) = (((2.0 1.0) 5.0) (3.0 10.0) 8.0)
(defun leaf-map (fn tree)
  (if (listp tree)
      (mapcar (pcf leaf-map fn) tree)
    (funcall fn tree)))

;;;; with-popped-alist-value
;; If alist contains key, then bind the associated value to valvar,
;;   execute the body, and remove the pair from the list (non-destructively)
;; alist will be referred to multiple times, so the ref must be idempotent
;; The popping happens before evaluation of body.
(defmacro with-popped-alist-value ((key alist valvar) &rest body)
  (let ((pair (gensym "pair")))
    `(let ((,pair (assoc ,key ,alist)))
       (when ,pair
         (setq ,alist (remove ,key ,alist :key #'car :count 1))
         (let ((,valvar (cdr ,pair)))
           ,@body)))))


;;;; ENSURE
;; If the accessed value is default, initializes it.
(defmacro ensure (accessor init &optional (default? '#'null))
  (let ((v (gensym)))
    `(let ((,v ,accessor))
       (when (funcall ,default? ,v) (setf ,v (setf ,accessor ,init)))
       ,v)))

;;--- time routines

(defun month-day-year ()
  (multiple-value-bind (second minute hour
                        date month year day-of-week
                        daylight-savings-time-p time-zone)
      (get-decoded-time)

    (declare (ignore second minute hour
                     day-of-week daylight-savings-time-p
                     time-zone))

    (values month date year)))

(defun day-month-&-year-as-formatted-string ()
  (multiple-value-bind (month day year)
      (month-day-year)
    (format nil "~A/~A/~A" month day year)))

(defun time-as-formatted-string (&optional time
                                 &key dot-instead-of-colon)
  (multiple-value-bind (second minute hour
                               date month year day-of-week
                               daylight-savings-time-p time-zone)
      (if time
          (decode-universal-time time)
          (get-decoded-time))

    (declare (ignore date month year day-of-week
                     daylight-savings-time-p time-zone))

    (if dot-instead-of-colon
      (format nil "~A.~A.~A" hour minute second)
      (format nil "~A:~A:~A" hour minute second))))

(defun date-&-time-as-formatted-string (&key dot-instead-of-colon)
  (format nil "~A ~A"
          (day-month-&-year-as-formatted-string)
          (time-as-formatted-string nil :dot-instead-of-colon dot-instead-of-colon)))


(defun parse-ltml-date-time-to-mins (timestr)
  (multiple-value-bind (day pos1) (read-from-string timestr)
    (let* ((pos2 (position #\: timestr))
           (hrstr (subseq timestr pos1 pos2))
           (minstr (subseq timestr (1+ pos2)))
           (hr (read-from-string hrstr))
           (min (read-from-string minstr)))
;       (print (list day hr min))
      (+ min (* 60 (+ hr (* 24 day)))))))

(defun ltml-time-less-equal (str1 str2)
  (<= (parse-ltml-date-time-to-mins str1) (parse-ltml-date-time-to-mins str2)))

(defun ltml-time-equal (str1 str2)
  (= (parse-ltml-date-time-to-mins str1) (parse-ltml-date-time-to-mins str2)))

(defun ltml-time-lessthan (str1 str2)
  (< (parse-ltml-date-time-to-mins str1) (parse-ltml-date-time-to-mins str2)))



;;;----------------------------
;;; compact trace-msg facility
;;;----------------------------
;; Reports activity at a configurable set of verbosities
;; A trace message may be
;; In general, verbosity levels should be:
;; 0 = nothing
;; 1 = key messages only
;; 2 = all significant messages
;; 3+ = any level of detail desired

(defvar *trace-levels* (make-hash-table))
(defvar *active-trace-categories* (make-hash-table))

;; takes (symbol number)
(defun Trace-lvl (&rest args)
  (labels ((parse-pair (args)
             (let* ((type (pop args)) (level (pop args)))
               (assert (and (symbolp type) (numberp level)) (type level)
                 "[~A ~A] is not a [symbol number] trace level" type level)
               (setf (gethash type *trace-levels*) level)
               (when args (parse-pair args)))))
    (when args
      (when (numberp (first args))
        (setf (gethash :default *trace-levels*) (pop args)))
      (when args (parse-pair args)))
    (hashtable-to-alist *trace-levels*)))
(Trace-lvl 0)                           ; set default to zero

(defun Trace-off ()
  (clrhash *trace-levels*)
  (clrhash *active-trace-categories*)
  (Trace-lvl 0))

(defun Trace-categories () (hashtable-to-alist *active-trace-categories*))

;; A trace-msg prints to std-out when its at or over verbosity for its category
(defmethod Trace ((level real) (category symbol) &rest msg-and-args)
  (let ((verbosity (or (gethash category *trace-levels*)
                       (gethash :default *trace-levels*))))
    (incf (gethash category *active-trace-categories* 0))
    (when (and (plusp verbosity) (>= verbosity level))
      (let ((trace-string (string-append "~&" (car msg-and-args) "~%")))
        (apply #'format *standard-output* trace-string (cdr msg-and-args))))))
;; without a category, trace-msg goes into the default category
(defmethod Trace ((level real) (msg string) &rest args)
  (apply #'Trace level :default msg args))

;; backward compatibility
(defun trace-msg (string &rest args)
  (apply #'Trace 2 :default string args))

(defmacro with-tracing-level (category number &body body)
  (let ((saved (gensym "saved")) (value (gensym "value")))
    `(let ((,saved (gethash ',category *trace-levels*)))
       (setf (gethash ',category *trace-levels*) ,number)
       (let ((,value ,@body))
         (setf (gethash ',category *trace-levels*) ,saved)
         ,value))))



;;; replaced with ltml-utils package.  Restore if you don't like
;;; this. [2007/03/29:rpg]

;;;(export '(then else
;;;       d
;;;       string-append concat
;;;       let-with-dynamic-extent let-with-dynamic-extent-unless-bound
;;;       push-new append-new
;;;       assq memq
;;;       gensymbol
;;;       string->list-of-symbols string->Java-style-symbol
;;;       sexp->string
;;;       ))


;;;------------------------------------------------
;;; from Peter Clark's open-source utilities in KM
;;;------------------------------------------------

;;; (break-up-at "c:dd>eee:f>" :delimeter-chars '(#\: #\>)) -> ("c" ":" "dd" ">" "eee" ":" "f" ">")
(defun break-up-at (string &key delimeter-chars)
  (break-up-at0 delimeter-chars string 0 0 (length string) 'positive))

(defun break-up-at0 (delimeter-chars string m n nmax polarity)
  (cond
    ((= n nmax) (list (subseq string m n)))             ; reached the end.
    (t (let ( (curr-char (char string n)) )
         (cond ((or (and (eq polarity 'positive)
                         (member curr-char delimeter-chars :test #'char=))
                    (and (eq polarity 'negative)
                         (not (member curr-char delimeter-chars :test #'char=))))
                (cons (subseq string m n)
                      (break-up-at0 delimeter-chars string n n nmax
                                    (cond ((eq polarity 'positive) 'negative) (t 'positive)))))
               (t (break-up-at0 delimeter-chars string m (1+ n) nmax polarity)))))))


;;;---------------------------------------------------------------------------
;;; We never want to call intern without specifying the package into which we
;;; are interning.  This is a shadowing definition
;;;---------------------------------------------------------------------------
(defun intern (string &optional package-desig)
  (unless package-desig
    (cerror "Intern in current package" 
	    "Are you being unsafe? LTML wants a package when it interns")
    (setf package-desig *package*))
  (cl:intern string package-desig))