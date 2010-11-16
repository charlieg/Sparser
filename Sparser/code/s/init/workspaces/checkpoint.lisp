;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER COMMON-LISP) -*-
;;; Copyright (c) 2009 BBNT Solutions LLC. All Rights Reserved
;;; $Id$

;; Started April 6, 2009. Modified occassionally through 10/23.

;; ---------- this file should -not- be loaded -----------------

  Checkpoint ops -- reading transcripts from TransTalk

cd ~/apps/acl/AllegroCL
./mlisp8

(load "~/ws/nlp/Sparser/code/s/init/scripts/checkpoint-ops.lisp")
;;
;; Executing your equivalent of this statement will load Sparser
;; with the grammar modules specific to checkpoint operations.

;; New cases from the GeoInt sessions
#|
"empty your pockets"
"tell your family to get out of the car"
   -- son, daughter, father, mother, wife, friend, friends
"move to the other side of the car"
   -- rear, front
|#

(in-package :sparser)

;; Useful trace
(trace-psi-construction)

(checkpoint-regression-test) ;; only has analyses we like

(setq *return-value* nil) 
  ;; turns off export. Important when debuging the
  ;; texts that aren't working


; Going along with this are these files
#|

 init/scripts/checkpoint-ops
   Sets the flags read by everything

 init/everything
   Looks for 

 init/versions/3.1/config/grammars/checkpoint-ops  
   Specialized grammar module setting

 init/versions/3.1/loaders/grammar-modules
   Has definition of the module

 init/versions/3.1/loaders/logicals
   Gives it a logical directory location "ckpt;"

 init/versions/3.1/loaders/grammar
   Loads it if its grammar module is included.

 grammar/sl/checkpoint/  
   a new directory in the "sublanguage" portion of the grammar
   with a loader file to say what files to load and, right now,
   just the file 'vocabulary' with simplified object definitions

 drivers/inits/switches2.lisp has an additional case, checkpoint-ops-setting
   with runtime settings tailored to this application

|#

;;--- 4/27/09

SPARSER> (pp "open the trunk")  ;; note: 'pp', not 'p'
open the trunk
(OPEN (OBJECT TRUNK))



;;--- Cheat sheet for examining output

;Read through the file which has lots of short abbreviations for
;commonly done things:
;   Sparser/code/s/init/versions/3.1/workspace/abbreviations.lisp
 
SPARSER> (p "this is  a test") ;; combination of parse & print treetops
this is  a test

                                 SOURCE-START
e3    THIS-IS                 1 "this is" 3
e4                               "a"
                                 "test"
                                 END-OF-SOURCE
:DONE-PRINTING

SPARSER> (ie 3)  ;; describe edge number 3 ("e3")
#<edge3 1 this-is 3> is a structure of type EDGE.  It has these slots:
 CATEGORY           #<ref-category THIS-IS>
 FORM               NIL
 REFERENT           NIL
 STARTS-AT          #<edges starting at 1>
 ENDS-AT            #<edges ending at 3>
 RULE               #<PSR380  this-is ->  "this" "is">
 LEFT-DAUGHTER      #<edge0 1 "this" 2>
 RIGHT-DAUGHTER     #<edge1 2 "is" 3>
 USED-IN            NIL
 POSITION-IN-RESOURCE-ARRAY  3
 CONSTITUENTS       NIL
 SPANNED-WORDS      NIL
#<edge3 1 this-is 3>

SPARSER> (psr# 380) ;; accessor, not an inspector
#<PSR380  this-is ->  "this" "is">
SPARSER> (d *)  ;; decribe the last value
#<PSR380  this-is ->  "this" "is"> is a structure of type CFR.  It has
these slots:
 SYMBOL             RULE::PSR380
 CATEGORY           #<ref-category THIS-IS>
 RHS                (#<word "this"> #<word "is">)
 COMPLETION         NIL
 FORM               NIL
 RELATION           NIL
 REFERENT           NIL
 SCHEMA             NIL
 PLIST
    (:GRAMMAR-MODULE #<grammar-module *ambush*> :FILE-LOCATION
     "/Users/ddm/ws/nlp/Sparser/code/s/init/scripts/../../../../code/s/grammar/model/sl/ambush/call-signs.lisp")
#<PSR380  this-is ->  "this" "is">

;; So that tells us (in the plist) that this rule, which doesn't carry
;; any meaning (referent = nil) was introduces as part of the
;; ambush grammar module and is in the call-signs file.


;; The data structures are all structs, which means all the accessors
;; have type-specific prefixes. They're sort of obvious, but even I have
;; to look them up some times.

SPARSER> (ie 4)
#<edge4 3 "a" 4> is a structure of type EDGE.  It has these slots:
 CATEGORY           #<word "a">
 FORM               #<ref-category DET>
 REFERENT           #<word "a">
 STARTS-AT          #<edges starting at 3>
 ENDS-AT            #<edges ending at 4>
 RULE               ((93) 356352 . 303104)
 LEFT-DAUGHTER      #<word "a">
 RIGHT-DAUGHTER     :LITERAL-IN-A-RULE
 USED-IN            NIL
 POSITION-IN-RESOURCE-ARRAY  4
 CONSTITUENTS       NIL
 SPANNED-WORDS      NIL
#<edge4 3 "a" 4>

SPARSER> (edge-left-daughter (e# 4)) ;; prefix is "edge-"
#<word "a">
SPARSER> (d *)
#<word "a"> is a structure of type WORD.  It has these slots:
 PLIST
    (:FUNCTION-WORD #<ref-category DET> :FUNCTION-WORD
     #<ref-category DET> :GRAMMAR-MODULE
     #<grammar-module *determiners*> :FILE-LOCATION
     "/Users/ddm/ws/nlp/Sparser/code/s/init/scripts/../../../../code/s/grammar/rules/words/determiners.lisp")
 SYMBOL             WORD::|a|
 RULE-SET           #<rule-set for #<word "a">>
 PNAME              "a"
 MORPHOLOGY         NIL
 CAPITALIZATION     :LOWER-CASE
 CAPITALIZATION-VARIANTS  NIL
#<word "a">

SPARSER> (word-rule-set *)
#<rule-set for #<word "a">>

SPARSER> (d *)
#<rule-set for #<word "a">> is a structure of type RULE-SET.  It has
these slots:
 BACKPOINTER        #<word "a">
 SINGLE-TERM-REWRITES  NIL
 RIGHT-LOOKING-IDS  (356352 . 303104)
 LEFT-LOOKING-IDS   (93)
 FSA                (#<PSR693  a.m. -> "a.m.">)
 PHRASE-BOUNDARY    #<brackets for #<word "a">>
 COMPLETION-ACTIONS  NIL
 PLIST              NIL
#<rule-set for #<word "a">>

SPARSER> (d (rs-phrase-boundary *))
#<brackets for #<word "a">> is a structure of type BRACKET-ASSIGNMENT.
It has these slots:
 ENDS-BEFORE        #<bracket ].PHRASE >
 BEGINS-BEFORE      #<bracket .[ARTICLE >
 ENDS-AFTER         NIL
 BEGINS-AFTER       NIL
 BACKPOINTER        #<word "a">
#<brackets for #<word "a">>


;;------ 4/20 while doing surgery on things

; (setq etf (exploded-tree-family-named 'transitive/specializing-pp))
; (d (setq schr2 (cadr (etf-cases eft))))

; (sv-prep-marked-o "ket" "out of")
; This started out as "get" "out of", but as I modified the eft that was
; involved, I wanted to stay with the same general plan but switch verbs
; so there wouldn't be hard-to-explain cross-talk between versions.
; Whence the respelling -- gradually walking up the alphabet from "g"

SPARSER> (display-chart :style :all-edges)
no edges starting at 0: #<word SOURCE-START>
edges starting at 1: #<word "ket">
  0 #<edge0 1 ket/out of 2>
edges starting at 2: #<word "out">
  0 #<edge1 2 "out of" 4>
  1 #<edge2 2 spatial-orientation 4>
no edges starting at 3: #<word "of">
edges starting at 4: #<word "the">
  0 #<edge3 4 "the" 5>
  1 #<edge5 4 individual 6>
edges starting at 5: #<word "car">
  0 #<edge4 5 car 6>
no edges starting at 6: #<word END-OF-SOURCE>
NIL
SPARSER> (display-chart-brackets)
 0 SOURCE-START ]1[ "ket" ]2[ "out" 3 "of" ]4[ "the" 5[ "car" ]6 END-OF-SOURCE 7 nil
NIL
SPARSER> (ie 2)
#<edge2 2 spatial-orientation 4> is a structure of type EDGE.  It has
these slots:
 CATEGORY           #<ref-category SPATIAL-ORIENTATION>
 FORM               #<ref-category PREPOSITION>
 REFERENT           #<spatial-orientation "out of" 15>
 STARTS-AT          #<edges starting at 2>
 ENDS-AT            #<edges ending at 4>
 RULE               #<PSR953  spatial-orientation ->  "out of">
 LEFT-DAUGHTER      #<edge1 2 "out of" 4>
 RIGHT-DAUGHTER     :SINGLE-TERM
 USED-IN            NIL
 POSITION-IN-RESOURCE-ARRAY  2
 CONSTITUENTS       NIL
 SPANNED-WORDS      NIL
#<edge2 2 spatial-orientation 4>

SPARSER> (delete/cfr (psr# 953))
#<PSR953  spatial-orientation ->  "out of">
; This is a test to confirm a conjecture -- I eliminate this rule
; and see what the parse is now. 

SPARSER> (trace-edges)
T
SPARSER> (p "ket out of the car")
ket
The word "ket" has 1 single-term rules:
  (#<PSR1143  ket/out of ->  "ket">)

creating #<edge0 1 ket/out of 2> from #<word "ket">
    rule: #<PSR1143  ket/out of ->  "ket">
introducing single-term edge:
  #<edge0 1 ket/out of 2>
 out of

creating #<edge1 2 "out of" 4> for #<PSR424  out of -> "out of"> the car

Edge for a literal in a rule #<edge2 4 "the" 5>
introducing edge over literal:
  #<edge2 4 "the" 5>
The word "car" has 1 single-term rules:
  (#<PSR399  car ->  "car">)

creating #<edge3 5 car 6> from #<word "car">
    rule: #<PSR399  car ->  "car">
introducing single-term edge:
  #<edge3 5 car 6>
[March] Looking rightward for an edge ending at p6
[March]     #<edge3 5 car 6> ends there.
[March] Looking leftwards from p5 for an edge adjacent to e3
[March]     #<edge2 4 "the" 5> ends there.
[Multiply] Checking (e2+e3)  #<word "the"> + #<ref-category CAR>
[Multiply]    both labels have some ids
[Multiply]    both edges have category combinations
[Multiply]    it succeeded with PSR401
      individual ->  "the" car
  creating e4  from e2 + e3 via PSR401
[March] Looking rightward for an edge ending at p6
[March]     #<edge4 4 individual 6> ends there.
[March] #<edge4 4 individual 6> starts on the segment boundary

[Multiply] Checking (e1+e4)  #<polyword "out of" > + #<ref-category INDIVIDUAL>
[Multiply]    both labels have some ids
[Multiply]    both edges have category combinations
[Multiply]    it succeeded with PSR430
      out-of-individual ->  "out of" individual
  creating e5  from e1 + e4 via PSR430
[Multiply] Checking (e0+e5)  #<ref-category KET/OUT OF> + #<ref-category out-of-INDIVIDUAL>
[Multiply]    both labels have some ids
[Multiply]    both edges have category combinations
[Multiply] one of the edges' form labels has category ids
[Multiply] Checking (e0+e5)  #<ref-category VERB> + #<ref-category out-of-INDIVIDUAL>
Trying #<ref-category VERB> (form) + #<ref-category out-of-INDIVIDUAL>   (e0+e5)
   which do not compose


                                 SOURCE-START
e0    KET/OUT OF              1 "ket" 2
e5    out-of-INDIVIDUAL       2 "out of the car" 6
                                 END-OF-SOURCE
:DONE-PRINTING

; As suspected. We get the preposition to work (polyword preposition),
; but given the strictures of the parsing algorithm, the bracket (correctly)
; laid down by the preposition is leting the direct object get the preposition
; before the verb can.
 

brackets-for-word

;;------- examples to use

move {forward, along, on}

come on 
keep going / keep going

stop

halt

get out of the car {vehicle, ...}

cna I see your/some id

show me some identifcation please

id please


come over here please

can you ////  

please have your {wwife/ passenger} stand over there
you /come/go over hear


--- conversationsl
where are  you going

who is traveling with you

 where are you from

where are you traveling { going} today

who is in the car with you 

who is that with you



what's in the trunk 

do you have anything in your trunk

(please) open the trunk (for me)


do you mind if { I'm going to }
search the vehicle / car /  your car



what is that

what's in the box


(you can)
Proceed

get back in the car (and continue)

come on



put you hand on your head

lie on the ground

get down (on the eground)

lie down




