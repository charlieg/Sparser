;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:APPLE-INTERFACE -*-
;;;
;;; copyright and other intellectual interests in this file and
;;; the information it contains are governed by the contract signed
;;; March 28, 1994 between  David D. McDonald of 14 Brantwood Road,
;;; Arlington Massachusetts, and Apple Computer, Inc.
;;; 
;;;     File:  "workspace"
;;;   Module:  "interface;Apple:"
;;;  Version:  2.0  September 15, 1994

;;Changelog
;; 1.1  More operations added.
;; 2.0  New tailoring of the workbench described, runtimes of whole
;;  books discussed. 
;;  Nothing else that was described for version 1.1 (8/15) has changed.

(in-package :apple-interface)


;;;---------------------
;;; object reclaimation
;;;---------------------

#| One of the things that has been added since the June release is a
facility for reclaiming objects in Sparser's model so that their
data structures can be reused. It still has some quirks for object
types that haven't been recently upgraded, but those quirks can be
avoided completely if you make all existing model objects permanent
before you execute Sparser.  That is the right thing to do anyway,
and eventually it will be automatic.  |#

(sparser::declare-all-existing-individuals-permanent)

#|  The objects from the last run are reclaimed at the start of the
next run. They are truely expunged, i.e. their storage space is
reused in the course of the run.    |#


;;--- implications for runtimes (9/15)

#| The number of objects instantiated is something like a order of
magnitute more than the number of words scanned.  If you're just 
analyzing single phrases, then the time to reclaim them (which will
be added to the time of the next run) will be much less then a second
and you'll never notice it.  If you are doing a whole section then
on the next run you'll experience a wait of perhaps half a dozen
seconds before you're next analysis begins.

On the other hand a whole book has roughly 30k words. Once you've
run a book through Sparser you can go for coffee when you start the
next call to Sparser since it is going to take a bit more than
twenty minutes to do the reclaimation. |#


;;;--------------
;;; sanity check
;;;--------------

#|  A good sanity check that the basic mechanisms have been loaded
is to try to parse the null string. It exercises a surprisingly large
proportion of the system.  N.b. this will blow up if the existing
individuals (objects) haven't been declared permanent.  |#

;(sparser::p "")



;;;------
;;; .dis
;;;------

#| To get reasonable results, the *. files corresponding to the
files (chapters) to be analyzed have to be run.  To run the .dis
analysis for a single file you call:  

(assimilate-dis.out  <file namestring> )

To run over all the files in a whole book, it makes sense to first
define a 'document-stream' for the book like the examples in
the interface file [doc streams].  Having done that you can run

(run-dis-over-book  <document-stream-name> )


 With the trace below on, each word will be printed as it is reached
in the file and analyzed. In code in the [dis.out reader] file you
will find somewhat more extensive tracing -- as format statements
-- that has been commented out.  With the tracing off (the default)
all you will see is a short comment at the end of each file giving
the number of tokens and new words seen. |#

;(setq *trace-.dis-interface* t)
;(setq *trace-.dis-interface* nil)

#|  This is the driver. It takes the name of a document stream as
its input (which is where it gets the location of the directory from)
and constructs the filename that it is actually going to operate from.
If you want to operate over different files this is where the
change would be made.  

(defun run-dis-over-book (document-stream-name)
  (let ((ds (sparser::document-stream-named document-stream-name))
        dis-name )
    (initialize-dis-assimilation-process)
    (dolist (gml-name (sparser::ds-file-list ds))
      (setq dis-name
            (concatenate
             'string (subseq gml-name
                             0 (position #\. gml-name :from-end t))
             ".engsyn.out"))
      (apple:assimilate-dis.out dis-name nil))))  |#


;(run-dis-over-book '|Reference|)
;(run-dis-over-book '|PowerTalk|)



;;;----------------
;;; postprocessing
;;;----------------

#|  Running the .dis interface only defines the words in the document
and accumulates the data about them that LingSoft supplies.  To make
the data useful for Sparser's analyses you have to run some postprocessing
routines.  The function below runs all the routines that are needed at the
moment.  These routines operate over all of the .dis data that has been
accumulated up to that point, and they start by initializing their internal
tables -- this means that for the most interesting report you should
process the .dis files all at once and then run this.  The routines operate
over -all- of the accumulated .dis data each time they run.  |#

;(render.dis-data-into-Sparser-information)


#| This postprocessing includes opening a buffer that lists all the
words and the part of speech bucket that they have been assigned to.
This buffer just appears at the upper left of your screen showing 
nothing. When you select it the word lists will appear.  This buffer
is just for browsing or human reference -- none of the routines make
use of it -- so you can delete it whenever you like.  |#


;;;---------------------
;;; viewing an analysis
;;;---------------------

#|  All the work is done in a single pass. During the analysis, several 
streams of traces can be looked at incrementally or directed to a buffer 
and read afterthefact.  

There is also Sparser's workbench, where you can watch the text get analyzed 
section by section by pausing after each or you can turn off the pause option, 
set the preferences to "separate windows", let it run through an entire 
text and do all your object inspection at the end (though in that mode you 
can't look at the parser's edges).



(1)  There is a trace of the segmentation of the text, printed segment by
segment as each is analyzed, and omitting the function words or punctuation
between the segments.  Along with this trace is occasional commentary
anouncing particular actions being taken such as a word being interpreted
as a verb.  To show this trace, you set the following flag.  You can
also direct the trace to a particular stream; by default it goes to the
Listener (*standard-output*). 

;(setq sparser::*readout-segments* t)
;(setq sparser::*readout-segments* nil)

;(setq sparser::*stream-for-segment-trace* t)  ;; Listener
;(setq sparser::*stream-for-segment-trace* (fred))
;;  n.b. if you do this (if you don't, the trace will go
;;  into the Listener), you won't see any output in the
;;  buffer until you select it.  For true incremental output
;;  use the Workbench.




(2)  There is a trace (actually a draft of the output stream) that shows
both the segments and the words/punctuation between them.  You would
usually direct this trace to a stream other than the Listener. (With both
this trace and the segment readout going to the Listener you get duplications
that are too confusing to read, so that combination is blocked, with the
treetop trace taking precedence.)  This trace is controlled by these symbols:


<<<<<<<<<<  This is the readout I did for Scott  >>>>>>>>>>>>>


;(setq sparser::*inline-treetop-readout* t)
;(setq sparser::*inline-treetop-readout* nil)

;(setq sparser::*stream-to-readout-treetops-to* t)
;(setq sparser::*stream-to-readout-treetops-to* (fred))
  ;; You have to manage this buffer yourself in that if you make multiple
  ;; runs without updating the buffer used the traces from all the runs
  ;; will all go into that buffer one after the other. (This sort of thing
  ;; is carefully managed in the Workbench.)  For a permanent record
  ;; save the buffer to a file or set the symbol to a file that's open
  ;; for writing in which case it will be automatic. 


(3)  The words in the text are displayed as they are reached in the analysis.
If the workbench is being used, this display occurs in its Text view.
Otherwise, the stream that is used is determined by the value of this
symbol.  If the symbol is set to nil then the words are not displayed.

;(setq sparser::*display-word-stream* t)  ;; *standard-output*
;(setq sparser::*display-word-stream* nil)  ;; no display




;;;------------------------------------------
;;; The Workbench (revised for 9/15 release)
;;;------------------------------------------

The Workbench is launched from the Sparser menu. When it is up, the
trace of the words of the text is directed to it.

There are two major modes for the workbench. One is standard to any
use of Sparser, the other involves a view that has been specialized
to fit this project.  

The choice between the options is done in the preferences dialog which
you bring up by picking "preferences" on the Sparser menu.  On that
dialog at the top with the heading 'Workbench' there are two choices
on the left ('text only' and 'chart and objects') and one on the right
('separate windows').  The standard use is either of the two choices to
the left, the special view is part of the choice on the right.

Both of the choices to the left bring up one "Workbench" window with one
or three subviews depending on which of the two choices you make.

The choice to the right does what it's name says: it sets up two
different windows that are each larger than their counterparts in the
'all-in-one' alternative configuration of the workbench.

I'll describe the all-in-one case first, since most of what it does
applies to the 'separate windows' case as well.


;;--- Using the 'All-in-One' Workbench configuration

When you select the 'text only' option, the all-in-one configuration of
the Workbench comes up with just its Text view showing.

The buttons above this view on the left ("next" "down" "up" "previous")
are for walking through the text in the view according to how it has
been analyzed into constituents.   The "Define" button on the right is
for defining single words in terms of one or another predefined category;
it is invaluable for sublanguage analysis, but I'm not sure yet where to
apply it in this project -- perhaps for accumulating stop words. Right at
this moment the only categories primed for definition are frequency and
sequence modifiers. 

The Walk uses the chart directly, and the chart will recycle in the
course of analyzing a long text. (The current setting of the "window"
is 500 words. It can be changed trivially.)  This means that you can't
expect to walk through the beginning of the text once the analysis
has finished, since the recycling of the chart will mean that it is
completely out of sync with the earlier words.

The simplest way around this is to use the Pause facility. It is turned 
on by default. This facility will stop the analysis every time a markup 
section finishes.  When it stops, the "Resume" button becomes active, 
and you click it to continue the anaysis.

Pauses only happen when the Workbench is being used. If you close it you
can run through entire analysis without a stop.  Or, you can use the
Preferences dialog and uncheck the "Pause after paragraphs" option and the
analysis will run without a stop while scrolling the text and edges at
each section-finish.

In the "edges and contents" mode, the walk includes selecting the corresponding
edge and object.  You can also work in the opposite direction: selecting an
edge in the edges view and seeing the corresponding regions of the text
and corresponding object, or starting by selecting one of the objects.

Douple-clicking on an edge brings it up in the Lisp Inspector.  Double-
clicking on an object in the contents view brings it up in Sparser's
Object Inspector.


;;--- Using the "separate windows" configuration

This configuration is intended to be used when the focus is on running
large texts without a pause and only looking at the results once the
analysis has finished.

Its Text View is extra large -- it fills most of a 14-inch screen, and
it has buttons only for tracking multiple instances of domain items
and for pause.

When working in this mode there is only one other view. This one is
specialized for the project and comes up automatically once the
analysis is finished.

It's label is "Linguistic domain data", which reflects the status of
what is being identified just now.

It starts as just a list of the categories of all of the individuals
identified in the course of an analysis. They appear in an order
dictated by a table that is part of the interface specification; see
the file [Apple interface;workbench view].

Each category is followed by the number of different cases it has in the
text that was just analyzed. This is the number of different individuals,
not the number of instances of each of those individuals. 

A single click on a category name expands it to list each of the different
individuals of that category, along with the number of instances each has.

A single click on a category that is expanded closes it.

The individuals can be sorted by their frequency (most frequent first)
or alphabetically.  The choiceis governed by the radio buttons at the
bottom of the window.

A single click on an individual takes you to the Text View. Here you
can walk through the instances of the individual in the whole text.
When you make the click the earliest instance is selected (the text
scrolls as needed).

Once in the Text View, you use the "next" and "prior" buttons to move
from instance to instance.  The short print form of the individual
appears just above the buttons, and a number pair between the buttons
tracks where you are in the sequence of instances.

A double click on an individual brings it up in Sparser's inspector.

The inspector is pretty self explanitory. It displays the incorporated
types and bindings of an individual and the most interesting information
about other object types.  A single click identifies the full form of
the item in a line at the bottom of the window.  A double click inspects
the item at the bottom of the table or scrolls back if the object has
already been inspected.  The button "Lisp inspector" calls the regular 
MCL inspector on the currently selected object.  The radio buttons control
whether a double-click on a binding inspects the binding or the value
being bound.

|#

;;;---------------------------------------------------------
;;; running an analysis -- settings and alternative drivers
;;;---------------------------------------------------------

#|  Having a document analysed is a matter of calling Sparser in any of
the normal ways (by string, by file, by document-stream) while it is in
a particular switch setting.

Part of the setting is to have Sparser do its term-analysis of segments
(rather than run in one of its modes for information extraction where
such artful guesswork is seldom helpful).  The other part is an adaption
to the format of the documents and markup.

Since you'll be only working with one task and type of document (for the
moment anyway), then it makes sense to burn-in these settings:   |#

(sparser::dm&p-setting)   ;; "Domain-modeling and Population"

(sparser::setup-for-apple)  ;; handles the document format


#|  To do detailed studies, I've been working with smallish texts
and using the Workbench in incremental mode. (the 'chart an edges'
option in the Preferences menu.   I've included a version of the
file for MacRef Chap4 that's been divided up by sections with a
function defined for each: 's1' through 's15'.  Running a section
is fast, so watching it incrementally (e.g. pausing with each
paragraph) is a very reasonable thing to do -- its what I do when
I'm working at extending the grammar.

Running a whole chapter at a time makes sense given how the documents
are chunked into files.  This is the shell I've been using. 

(defparameter *Apple-documents-directory*
              "Macintosh HD:Apple documents:")
  ;; your location goes here -- You set this in the [Load Sparser]
  ;; file as part of specializing it to run on your machine
|#

(defun run-gml-file/Ref (n)
  (let* ((namestring (concatenate 'string
                                  *Apple-documents-directory*
                                  "Reference:Chap"
                     ;; change this if your file names are different
                                  n
                                  ":body"
                                  n
                                  ".gml"))
         (pathname (pathname namestring)))
    
    (unless (probe-file namestring)
      (break "Bad concatenation formula:~%there is no file named ~
              ~A" namestring))
    
    (sparser::do-article pathname :style 'apple)))

;; e.g.
;(run-gml-file "1")
;(run-gml-file "2")
;(run-gml-file "3")
;(run-gml-file "4")   ;; e.g. Note that the number is given as a string


#|  Running whole books

Sparser is oriented towards analyzing one file of text at a time. To get around
the fact that the MacRef and PowerTalk are structured as directories of one
file per chapter, you need to use a different driver that preempts the
customary start-of-each-file initializations.

This driver is the Sparser function Do-document-as-stream-of-files.

It takes a document stream as its input. Here is a copy of what is
put in place in the interface file [doc streams]

(defparameter MacRef/gml/document-stream
  (define-document-stream  'MacRef/gml-files
    :style-name 'apple
    :file-list
    (mapcar #'(lambda (n)
                (concatenate 'string
                             *Apple-documents-directory*
                             "new Reference:Chap"   ;; for instance
                             n
                             ":body"
                             n
                             ".gml"))
            '("1" "2" "3" "4" "5" "6" "B" "C"))))


So to analyze that book, you'd do

(do-document-as-stream-of-files MacRef/gml/document-stream)

This takes about 20 minutes when the Text View is up, which is about
20 words a second on the 900.  It feels like 1200 baud when you see
the text streaming by, i.e. a bit too fast to read.  The extra time
is essentially all in the domain modeling operations, which are almost
certainly doing far more work now then they will need to once the
procedures are shaken down more thoroughly.


|#


