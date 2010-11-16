;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER COMMON-LISP) -*-
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$

;;---------- This is a dribble file of examples -- Do not load ------------

;;;------------
;;; crib sheet
;;;------------




;;;-------------------
;;; Dribbled examples
;;;-------------------

6/7/08

"many of the ..."

How do we tell if "many" is defined already?

SPARSER> (p "many")
many

                                 SOURCE-START
e0                               "many"
                                 END-OF-SOURCE
:DONE-PRINTING
SPARSER> (d (e# 0))
#<edge0 1 "many" 2> is a structure of type EDGE.  It has these slots:
 CATEGORY           #<word "many">
 FORM               #<ref-category QUANTIFIER>
 REFERENT           #<word "many">
 STARTS-AT          #<edges starting at 1>
 ENDS-AT            #<edges ending at 2>
 RULE               ((6) NIL . 40960)
 LEFT-DAUGHTER      #<word "many">
 RIGHT-DAUGHTER     :LITERAL-IN-A-RULE
 USED-IN            NIL
 POSITION-IN-RESOURCE-ARRAY  0
 CONSTITUENTS       NIL
 SPANNED-WORDS      NIL
#<edge0 1 "many" 2>

SPARSER> (d (word-named "many"))
#<word "many"> is a structure of type WORD.  It has these slots:
 PLIST
    (:FUNCTION-WORD #<ref-category QUANTIFIER> :GRAMMAR-MODULE
     #<grammar-module *QUANTIFIERS*> :FILE-LOCATION
     "/Users/ddm/ws/nlp/Sparser/code/s/grammar/rules/words/quantifiers1.fasl")
 SYMBOL             WORD::|many|
 RULE-SET           #<rule-set for #<word "many">>
 PNAME              "many"
 MORPHOLOGY         NIL
 CAPITALIZATION     :LOWER-CASE
 CAPITALIZATION-VARIANTS  NIL
#<word "many">
SPARSER> 

SPARSER> (d (rule-set-for *))
#<rule-set for #<word "many">> is a structure of type RULE-SET.  It has
these slots:
 BACKPOINTER        #<word "many">
 SINGLE-TERM-REWRITES  NIL
 RIGHT-LOOKING-IDS  (NIL . 40960)
 LEFT-LOOKING-IDS   (6)
 FSA                NIL
 PHRASE-BOUNDARY    #<brackets for #<word "many">>
 COMPLETION-ACTIONS  NIL
 PLIST              NIL
#<rule-set for #<word "many">>

SPARSER> (d (rs-phrase-boundary *))
#<brackets for #<word "many">> is a structure of type
BRACKET-ASSIGNMENT.  It has these slots:
 ENDS-BEFORE        #<bracket ].PHRASE >
 BEGINS-BEFORE      #<bracket .[NP >
 ENDS-AFTER         NIL
 BEGINS-AFTER       NIL
 BACKPOINTER        #<word "many">
#<brackets for #<word "many">>


;;;------------------------------------------------------------
;; Finding the data for setting up a form rule to roll this up

(p "were reported on Monday, August 29, 2005")
were reported on Monday, August 29, 2005

                                 SOURCE-START
e2    REPORT-VERB             1 "were reported" 3
e17   TIME                    3 "on monday , august 29 , 2005" 10
                                 END-OF-SOURCE
SPARSER> (d (e# 2))
#<edge2 1 report-verb 3> is a structure of type EDGE.  It has these
slots:
 CATEGORY           #<ref-category REPORT-VERB>
 FORM               #<ref-category VERB+PASSIVE>
 REFERENT           #<report-verb "report" 2>
 STARTS-AT          #<edges starting at 1>
 ENDS-AT            #<edges ending at 3>
 RULE               #<PSR105  {verb+ed} -> be verb+ed>
 LEFT-DAUGHTER      #<edge0 1 be 2>
 RIGHT-DAUGHTER     #<edge1 2 report-verb 3>
 USED-IN            NIL
 POSITION-IN-RESOURCE-ARRAY  2
 CONSTITUENTS       NIL
 SPANNED-WORDS      NIL

; This tells us that we need to raise the type of the VG up to Event
; so that we have a suite of generic properties to bind the time
; (and location, modality, ...)

; Time is the concrete class, so the form has to come from the VG
; The fact that this is labeled verb+passive rather than just verb
; will multiply the number of rules we need to write, so some though
; should go into how to couch this. Perhaps a function that provides
; a wrapper to abstract this away is to the point -- question is
; where to stash it. Presumably late in the syntax of verbs.


;;----------------------------------------------------------------
SPARSER> (d (category-named 'sequencer))
#<ref-category SEQUENCER> is a structure of type REFERENTIAL-CATEGORY.
It has these slots:
 PLIST
    (:1ST-PERMANENT-INDIVIDUAL #<sequencer "during" 6>
     :PERMANENT-INDIVIDUALS
     (#<sequencer "during" 6> #<sequencer "before" 5>
      #<sequencer "after" 4> #<sequencer "subsequent" 3>
      #<sequencer "next" 2> #<sequencer "last" 1>)
     :1ST-PERMANENT-INDIVIDUAL #<sequencer "during" 6>
     :PERMANENT-INDIVIDUALS
     (#<sequencer "during" 6> #<sequencer "before" 5>
      #<sequencer "after" 4> #<sequencer "subsequent" 3>
      #<sequencer "next" 2> #<sequencer "last" 1>)
     :1ST-PERMANENT-INDIVIDUAL #<sequencer "during" 6>
     :PERMANENT-INDIVIDUALS
     (#<sequencer "during" 6> #<sequencer "before" 5>
      #<sequencer "after" 4> #<sequencer "subsequent" 3>
      #<sequencer "next" 2> #<sequencer "last" 1>)
     :INSTANCES
     (#<sequencer "during" 6> #<sequencer "before" 5>
      #<sequencer "after" 4> #<sequencer "subsequent" 3>
      #<sequencer "next" 2> #<sequencer "last" 1>)
     :COUNT 6 :INSTANCES-ARE-PERMANENT T :GRAMMAR-MODULE
     #<grammar-module *SEQUENCERS*> :FILE-LOCATION
     "/Users/ddm/ws/nlp/Sparser/code/s/grammar/model/core/adjuncts/sequence/object.fasl")
 SYMBOL             CATEGORY::SEQUENCER
 RULE-SET           #<rule-set for #<ref-category SEQUENCER>>
 SLOTS              (#<variable NAME :: PRIMITIVE WORD>)
 BINDS              NIL
 REALIZATION
    (:SCHEMA ((:WORD . #<variable NAME :: PRIMITIVE WORD>) NIL NIL NIL)
     :RULES NIL)
 LATTICE-POSITION   #<top-lp of sequencer  50>
 OPERATIONS         #<operations for sequencer>
 MIX-INS            NIL
 INSTANCES          #<EQL hash-table with 6 entries @ #x10a4970a>
 RNODES             NIL

;;-----------------------------------------------------------
SPARSER> (p "next week")
next week

                                 SOURCE-START
e2    TIME                    1 "next week" 3
                                 END-OF-SOURCE
:DONE-PRINTING
SPARSER> (d (e# 2))
#<edge2 1 time 3> is a structure of type EDGE.  It has these slots:
 CATEGORY           #<ref-category TIME>
 FORM               #<ref-category NP>
 REFERENT           #<psi relative-time 33>
 STARTS-AT          #<edges starting at 1>
 ENDS-AT            #<edges ending at 3>
 RULE               #<PSR315  time ->  sequencer time-unit>
 LEFT-DAUGHTER      #<edge0 1 sequencer 2>
 RIGHT-DAUGHTER     #<edge1 2 time-unit 3>
 USED-IN            NIL
 POSITION-IN-RESOURCE-ARRAY  2
 CONSTITUENTS       NIL
 SPANNED-WORDS      NIL
#<edge2 1 time 3>
SPARSER> (d (psr# 315))
#<PSR315  time ->  sequencer time-unit> is a structure of type CFR.  It
has these slots:
 SYMBOL             RULE::PSR315
 CATEGORY           #<ref-category TIME>
 RHS
    (#<ref-category SEQUENCER> #<ref-category TIME-UNIT>)
 COMPLETION         NIL
 FORM               #<ref-category NP>
 RELATION           NIL
 REFERENT
    (:INSTANTIATE-INDIVIDUAL-WITH-BINDING #<ref-category RELATIVE-TIME>
     (#<variable RELATIVIZER :: relative-time-adverb> . LEFT-REFERENT)
     (#<variable REFERENCE-TIME :: time> . RIGHT-REFERENT))
 SCHEMA             #<schr NP -> MODIFIER NP-HEAD >
 PLIST
    (:RELATION :DEFINITE-MODIFIER :GRAMMAR-MODULE
     #<grammar-module *TIME*> :FILE-LOCATION
     "/Users/ddm/ws/nlp/Sparser/code/s/grammar/model/core/time/relative-moments.fasl")
#<PSR315  time ->  sequencer time-unit>


;;-----------------------------------------------------------------------
SPARSER> (p "A breach in the Industrial Canal, ")
A breach in the Industrial Canal, 

                                 SOURCE-START
e2    BREACH                  1 "a breach" 3
e11   IN-LOCATION             3 "in the industrial canal" 7
e10                              "COMMA"
                                 END-OF-SOURCE
:DONE-PRINTING
SPARSER> (tree 11)
E11 IN-LOCATION               p3 - p7   rule 218
  E3 "in"                     p3 - p4   (348160)
    "in"
  E9 NAME                     p4 - p7   sdm-span-segment
    E5 "the"                  p4 - p5   (335872 . 315392)
      "the"
#<edge11 3 in-location 7>
;; //// Where is the wacko label coming from on e5 -- it's pulling out the
;; wrong field.


;;---------------------------------------------------------------
7/14/08
;; debug the issue in pnf, which is off the wall
(p "An Iraqi girl died on Jan. 17.")

(trace-network)
(trace-brackets)
(trace-pnf)

8/9/08
SPARSER> (p "An girl died on Jan. 17.")
An girl died on Jan. 17.

                                 SOURCE-START
e0                               "an"
e13   DIE                     2 "girl died on jan . 17" 8
e11                              "PERIOD"

Why is "An" not combining with "girl" ??  Because there isn't a rule
for it. "girl" is spanned by [person, common-noun]. The easiest thing
would be a form-form rule if we could sanction it (only have to state
it once, vs for every sort of common noun. The 'girl' rule is in
/model/core/people/kinds.lisp:

(define-category  girl
  :instantiates person
  :specializes person
  ;;/// How do we index this sort of thing?
  :realization (:common-noun "girl"))

;; 8/28/08

SPARSER> (p "19:00:00")
19:00:00

;; This looks like a real bug in how the data structures are assembled
;; in this instance that I've seen hints about before. 

 0: (SWANK::DEBUG-IN-EMACS #<SIMPLE-ERROR @ #x10e0dbfa>)
  1: (SWANK:SWANK-DEBUGGER-HOOK #<SIMPLE-ERROR @ #x10e0dbfa> #<Function SWANK-DEBUGGER-HOOK>)
  2: (ERROR "No generic access function for rule-sets defined ~
                 ~%  for objects of type ~A" SYMBOL)
  3: (RULE-SET-FOR :DOTTED-INTERMEDIARY)
  4: (LET ((RS (RULE-SET-FOR LABEL))) (WHEN RS (CASE DIRECTION (:RIGHT-LOOKING #) (:LEFT-LOOKING #) (OTHERWISE #))))
  5: (LET ((LABEL (IF # EDGE #))) (WHEN LABEL (LET (#) (WHEN RS #))))
  6: (CATEGORY-IDS #<edge10 1 number_: 3> :RIGHT-LOOKING :FORM)
  7: (FORM-IDS/RIGHTWARD #<edge10 1 number_: 3>)
  8: (LET* ((LEFT-CATEGORY-IDS (CATEGORY-IDS/RIGHTWARD LEFT-EDGE)) (LEFT-FORM-IDS (FORM-IDS/RIGHTWARD LEFT-EDGE)) (RIGHT-CATEGORY-IDS (CATEGORY-IDS/LEFTWARD RIGHT-EDGE)) (RIGHT-FORM-IDS (FORM-IDS/LEFTWARD RIGHT-EDGE))) (IF (OR LEFT-FORM-IDS RIGHT-FORM-IDS) (THEN (TR :CHECKING-FORM-LABEL-CATEGORY-RULES) (OR # # #)) (ELSE (TR :NEITHER-HAS-CATEGORY-ON-FORM-IDS) (MULT/CHECK-FORM-OPTIONS LEFT-EDGE RIGHT-EDGE))))
  9: (MULT/IDS-ON-FORM-LABEL #<edge10 1 number_: 3> #<edge9 3 numeric-time 6>)
 10: (MULTIPLY-CATEGORIES (675840) NIL #<edge10 1 number_: 3> #<edge9 3 numeric-time 6>)
 11: (OR (MULTIPLY-CATEGORIES LEFT-CATEGORY-IDS RIGHT-CATEGORY-IDS LEFT-EDGE RIGHT-EDGE) (WHEN *EDGES-FROM-REFERENT-CATEGORIES* (MULTIPLY-REFERENTS LEFT-EDGE RIGHT-EDGE)))
 12: (LET ((LEFT-CATEGORY-IDS (CATEGORY-IDS/RIGHTWARD LEFT-EDGE)) (RIGHT-CATEGORY-IDS (CATEGORY-IDS/LEFTWARD RIGHT-EDGE))) (OR (MULTIPLY-CATEGORIES LEFT-CATEGORY-IDS RIGHT-CATEGORY-IDS LEFT-EDGE RIGHT-EDGE) (WHEN *EDGES-FROM-REFERENT-CATEGORIES* (MULTIPLY-REFERENTS LEFT-EDGE RIGHT-EDGE))))
 13: (MULTIPLY-EDGES #<edge10 1 number_: 3> #<edge9 3 numeric-time 6>)
 14: (CHECK-ONE-ONE #<edge10 1 number_: 3> #<edge9 3 numeric-time 6>)
 15: (CHECK-FOR-RIGHT-EXTENSIONS/FOREST #<edge10 1 number_: 3>)
 16: (SETUP-RETURNS-FROM-PPTT-&-RUN #<edge9 3 numeric-time 6> #<position6 6 "">)
 17: (END-OF-SOURCE-CHECK #<word END-OF-SOURCE> #<position6 6 "">)
 18: (CHECK-FOR-[-FROM-WORD-AFTER #<word END-OF-SOURCE> #<position6 6 "">)
 19: (SCAN-NEXT-SEGMENT #<position6 6 "">)

;; Turns out to be a due to unanticipated fanout from a change last
;; year to allow a low-level routine in the rule lookup to look at
;; the form levels on an edge rather than just the category label,
;; but I hadn't appreciated/remembered that on dotted rules (expansions
;; of n-ary rules) the form label on the intermediaries is a symbol
;; and therefore should be ignored.


;; 2/4/10

Places I had to find:

Bracket reasoning is in "grammar;rules:brackets:judgements1"

sort-out-result-of-newline-analysis in "analyzers;psp:fill chart:newline"
bump-&-store-word in "analyzers;psp:fill chart:store5"

"init;versions:v2.3:workspace:abbreviations" -- these should move early and central

"analyzers:tokenizer:token FSA"

globals are in "drivers;inits:sessions:globals1"
analysis-core is in "drivers;sources:core1"
switch-settings is in "drivers;inits:switches2"

;; 2/9/10
-- Figuring out how to adjust the treatment of brackets on quantifiers to properly
interact with determiners: "a few percent less"

(setq *display-word-stream* t)

sparser> (f "/Users/ddm/ws/nlp/corpus/mcl-msg-with-table.lisp")
If you start up  the new RMCL application and call ROOM, you will see  
it report the total size of the lisp heap as being a
few

sparser> (display-chart-brackets)
 0 source-start ]1[ "if" ]2[ "you" ]3[ "start" ]4 "up" ]5[ "the" 6 "new" 7 "rmcl" 8[ "application" ]9 "and" 10[ "call" 11 "room" ]12 comma ]13[ "you" ]14[ "will" 15 "see" ]16[ "it" ]17[ "report" ]18[ "the" ]19[ "total" ]20[ "size" ]21 "of" ]22[ "the" 23 "lisp" 24 "heap" ]25 "as" ]26[ "being" ]27[ "a" ]28[ "few" 29 nil


                                 source-start
                                 "if"
e0    pronoun/second          2 "you" 3
e1    start                   3 "start" 4
e2 e3                            "up" :: up, direction
e8    application             5 "the new rmcl application" 9
                                 "and"
e10   name-word               10 "call room" 12
e11                              "comma"
e12   pronoun/second          13 "you" 14
e16   see                     14 "will see" 16
e17   pronoun/inanimate       16 "it" 17
e18   report-verb             17 "report" 18
e22   size                    18 "the total size" 21
e23                              "of"
e27   heap                    22 "the lisp heap" 25
e28                              "as"
e29   be                      26 "being" 27
e30                              "a"
                                 "few"
:done-printing
sparser> (ie 27)
#<edge27 22 heap 25> is a structure of type edge.  It has these slots:
 category           #<ref-category heap>
 form               #<ref-category np>
 referent           #<heap 1>
 starts-at          #<edges starting at 22>
 ends-at            #<edges ending at 25>
 rule               #<PSR190  {n-bar} -> "the" n-bar>
 left-daughter      #<edge24 22 "the" 23>
 right-daughter     #<edge26 23 heap 25>
 used-in            nil
 position-in-resource-array  27
 constituents       nil
 spanned-words      nil


#<brackets for #<word "a">> is a structure of type bracket-assignment.
It has these slots:
 ends-before        #<bracket ].phrase >
 begins-before      #<bracket .[article >
 ends-after         nil
 begins-after       nil
 backpointer        #<word "a">

#<brackets for #<word "few">> is a structure of type
bracket-assignment.  It has these slots:
 ends-before        #<bracket ].phrase >
 begins-before      #<bracket .[np >
 ends-after         nil
 begins-after       nil
 backpointer        #<word "few">

;; judgements1 in /grammar/rules/brackets for adjudication
;; (d (brackets-for-word "few"))


;; 4/17/10
;; Puzzle with an segment that incorporates leading comma

sparser> (top-edges-setting/ddm)
:no-dm&p
sparser> (p "as mentioned earlier, signalling pathways with")
as mentioned earlier, signalling pathways with

                                 source-start
e0                               "as"
e1                               "mentioned"
                                 "earlier"
e2                               "comma"
                                 "signalling"
                                 "pathways"
e3                               "with"
                                 end-of-source
:done-printing
sparser> (display-bracketed-segments)

"source-start"
[ "as" ]
[ "mentioned" ]
"earlier"
[ "comma" "signalling" "pathways" ] ;; <==== comma should be stranded !
"with"
nil
sparser> (d (brackets-for-word "comma"))
#<brackets for #<word comma>> is a structure of type
bracket-assignment.  It has these slots:
 ends-before        #<bracket ].punctuation >
 begins-before      nil
 ends-after         nil
 begins-after       #<bracket punctuation.[ >
 backpointer        #<word comma> 
#<brackets for #<word comma>>

sparser> (display-chart-brackets)
 0 source-start ]1[ "as" ]2[ "mentioned" ]3 "earlier" ]4[ comma 5[ "signalling" 6 "pathways" ]7 "with" ]8[ end-of-source 9 nil
nil

sparser> (p "as mentioned earlier, signalling pathways with")

...
#<word "earlier"> introduces brackets:
   Placing ].adverb on ends-here of p3
Asking whether there is a ] on p3 because of 'earlier'
   there is
There is a ].adverb on p3
Segment started at p2 ended at p3 by #<bracket ].adverb >
Post-scan characterization of segment between p2 and p3: one-edge-over-entire-segment
[segment] p2 - p3  coverage = one-edge-over-entire-segment
[segment] spanned-segment
[scan] scan-next-segment #<position3 3 "earlier">
Asking whether there is a [ on p3 because of 'earlier'
   no, there isn't
#<word "earlier"> introduces brackets:
   Placing adverb.[ on starts-here of p4
Asking whether there is a ] on p4 because of 'earlier'
   no, there isn't
Asking whether there is a [ on p4 because of 'earlier'
   there is
Setting the left segment boundary to p4
   because of the adverb.[ in front of nil
,
#<word comma> introduces brackets:
   Placing ].punctuation on ends-here of p4
Asking whether there is a ] on p4 because of ','
   there is
There is a ].punctuation on p4
Segment started at p4 ended at p4 by #<bracket ].punctuation >
Post-scan characterization of segment between p4 and p4: null-span
[segment] p4 - p4  coverage = null-span
Asking whether there is a [ on p4 because of ','
   no, there isn't
#<word comma> introduces brackets:
   Placing punctuation.[ on starts-here of p5
Asking whether there is a ] on p5 because of ','
   no, there isn't
Asking whether there is a [ on p5 because of ','
   there is
Setting the left segment boundary to p5  ;; <=== that's what we expect
   because of the punctuation.[ in front of nil
 signalling
Asking whether there is a ] on p5 because of 'signalling'
   no, there isn't
...
 pathways
Asking whether there is a ] on p6 because of 'pathways'
   no, there isn't
...
 with
#<word "with"> introduces brackets:
   Placing ].preposition on ends-here of p7
Asking whether there is a ] on p7 because of 'with'
   there is
There is a ].preposition on p7
Segment started at p5 ended at p7 by #<bracket ].preposition > ;; <=== good
Post-scan characterization of segment between p5 and p7: no-edges
[segment] p5 - p7  coverage = no-edges
[segment]  no-edges
[scan] scan-next-segment #<position7 7 "with">
Asking whether there is a [ on p7 because of 'with'
   no, there isn't
#<word "with"> introduces brackets:
   Placing preposition]. on ends-here of p8
   Placing preposition.[ on starts-here of p8
Asking whether there is a ] on p8 because of 'with'
   there is
There is a preposition]. on p8
Ignoring the #<bracket preposition]. > at p8 in front of nil
   because the left-boundary of the next segment hasn't been established yet.
Asking whether there is a [ on p8 because of 'with'
   there is
Setting the left segment boundary to p8
   because of the preposition.[ in front of nil

sparser> (untrace-brackets)
nil
sparser> (setq *readout-segments* t) 
t  ;; hard-wired in to pts ("parse the segment") to do a print-segment after
   ;; each one is completed

sparser> (p "as mentioned earlier, signalling pathways with")
as mentioned earlier
[ "mentioned" ]
, signalling pathways with
[ "signalling pathways" ]
   ;; so this says the appearance of the comma is an artifact of the code
   ;; in (display-bracketed-segments)
