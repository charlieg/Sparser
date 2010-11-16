;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1991-2005  David D. McDonald  -- all rights reserved
;;; extensions opyright (c) 2008 BBNT Solutions LLC. All Rights Reserved
;;; $Id:$
;;;
;;;     File:  "changed files"
;;;   Module:  "init;"
;;;  version:   2.3 December 1994

;;; This is a record of recently changed files. It isn't expected to be
;;; loaded except in unusual circumstances.  The record begins a at major
;;; backups and major instantiations, and is updated continually

;; 2/1/05 N.b. This evolved into a record of the state of the work and
;;  a place to write up conjectures and 2do, especially from 1999 onwards
;;  when the work became more sporatic.

(in-package :sparser)

(setq *there-are-changed-files* nil)  ;; :4-19-94
(defun update ()
  ;; This function is call as part of every launch of a 'development' image

  (format t "~&Updating files:")
  ;;--- Calls to load new files or files changed after
  ;;    the current image was made go here.
  
  )

#|  12/29/94 freshly backed up and cleaned the directory

;; 12/29..30 'everything' load, 'Apple' load
"init;versions:v2.3:updating"
"objects;chart:edges:object3"
"objects;forms:form rules"
"objects;rules:cfr:loader"
"objects;rules:cfr:lookup5"
"objects;rules:cfr:syntax rules"
"objects;traces:dm&p"
"objects;traces:edges1"
"analyzers;CA:anaphora3"
"analyzers;context:operations"
"analyzers;DM&P:scan1"
"analyzers;DM&P:mine terms1"
"analyzers;DM&P:scan prefixed1"
"analyzers;DM&P:mine sequences"
"analyzers;DM&P:measure"
"analyzers;psp:check:multiply3"
"interface;grammar:object dialogs"
"interface;menus:loader"
"interface;menus:module menu1"
"grammar;rules:DM&P:adverbs"
"grammar;rules:DM&P:new individuals1"
"grammar;rules:DM&P:pair terms"
"grammar;rules:DM&P:prefixes"
"grammar;rules:syntax:loader"
"grammar;rules:syntax:conjunction"
"grammar;rules:syntax:modals"
"grammar;rules:tree-families:pre-head np modifiers"

;;--- backed up 1/3/95 4.5

;; Apple load 1/3
"interface;grammar:sort"

;; (incorporating change notes from PB 1/1-1/3)
"objects;doc:header label"
"drivers;chart:header labels"
"drivers;chart:psp:scan2"
"interface;workbench:edges"
"grammar;forms:header labels"
       

;;--- apple load 1/4
"init;workspaces:Switchboard"
"objects;chart:brackets:printers1"
"objects;chart:positions:positions1"
"analyzers;sectionizing:action"
"drivers;chart:psp:adjudicators1"
"drivers;chart:header labels"
"grammar;rules:FSAs:loader - model1"
"model;core:names:loader2"
"model;core:names:fsa:classify1"

;;--- everything 1/5
"init;versions:v2.3:loaders:grammar"
"objects;traces:psp1"
"drivers;inits:switches2"
"analyzers;char-level:testing1"
"analyzers;char-level:testing/file"
"analyzers;tokenizer:testing1"
"analyzers;psp:fill-chart:testing"
"analyzers;HA:place brackets"
"drivers;chart:psp:pts5"
"interface;workbench:loader"
"interface;workbench:preferences"
"interface;workbench:text view"
"interface;workbench:text view scrolling"
"grammar;rules:HA:loader1"
"grammar;rules:HA:colon header
"grammar;rules:paragraphs:section rule"
"grammar;rules:FSAs:newlines:loader"
"grammar;rules:FSAs:newlines:blank lines"
"grammar;rules:FSAs:newlines:stack sensitive"
"grammar;rules:FSAs:newlines:indentation"
"grammar;rules:FSAs:newlines:linefeeds"
"grammar;rules:FSAs:newlines:meaningless"
"grammar;rules:FSAs:newlines:old unvetted"
"grammar;tests:loader"
"grammar;tests:timing"
"model;core:names:fsa:scan2"
;;--- backed up 1/6 noonish

;;--- everything 1/6
"init;versions:v2.3:loaders:grammar modules"
"init;versions:v2.3a:loaders:grammar modules"
"init;versions:v2.3:config:grammars:full grammar"
"init;versions:v2.3a:config:grammars:partial grammar"
"init;workspaces:Sun"
"objects;doc:loader"
"objects;doc:section markers1"
"analyzers;char-level:setup/file3"
"analyzers;DM&P:single edge"
"interface;workbench:text view"
"interface;workbench:edges"
"interface;workbench:pause"
"model;core:places:loader"
"model;core:places:directions"
"model;core:places:compass points"
"model;core:places:directional rules"
"dossiers;loader"
"dossiers;directions"
"dossiers;compass points"
"grammar;rules:CA:first item"
"grammar;rules:tree-families:morphology"
"grammar;rules:words:loader1"
"grammar;rules:words:adjectives"
"grammar;rules:words:prepositions"


;; backed up, w/ new everything load 1/9 4.0
"init;load Sparser"
"init;workspaces:Sun"
"objects;chart:words:lookup:new words4"
"analyzers;psp:assess:terminal edges2"
"drivers;inits:switches2"
"drivers;inits:sessions:globals1"
"interface;workbench:edges"
"grammar;rules:syntax:affix rules"


;; everthing -- 1/16...17,23
"init;workspaces:Sun1"
"objects;traces:DM&P"
"analyzers;DM&P:scan1"
"analyzers;DM&P:scan prefixed1"
"analyzers;DM&P:mine sequences1"
"analyzers;DM&P:forest level"
"drivers;chart:psp:trigger5"
"drivers:chart:psp:PPTT8"
"drivers;chart:psp:march/forest3"
"drivers;forest:trap2"
"interface;menus:Sparser"
"interface;workbench:loader"
"interface;workbench:edges"
"interface;workbench:define rule"
"model;core:names:fsa:examine"
"model;dossiers:kinds of companies"
"grammar;rules:DM&P:realizations"
"grammar;rules:DM&P:verb group patterns"
;;--- backed up 1/23 10.0

;;--- everything 1/23,24,25
"init:versions:v2.3:salutation"
"objects;chart:brackets:loader"
"objects;chart:brackets:rank"
"objects;chart:edges:loader3"
"objects;chart:edges:resource4"
"objects;traces:psp1"
"analyzers;DM&P:scan no edges"
"analyzers;DM&P:scan prefixed1"
"analyzers;DM&P:single edge"
"analyzers;DM&P:mine sequences1"
"analyzers;HA:loader"
"analyzers;HA:place brackets1"
"analyzers;HA:look"
"analyzers;psp:fill-chart:loader4"
"analyzers;psp:fill-chart:testing"
"analyzers;tokenizer:testing1"
"drivers;chart:select2"
"drivers;timing:presentation"
"drivers;timing:stripped all-edges"
"drivers;timing:stripped all-edges 1"
"interface;workbench:contents"
"interface;workbench:edges"
"grammar;rules:brackets:judgements"
"grammar;rules:brackets:types"
"grammar;rules:DM&P:pair terms"
"grammar;rules:DM&P:prefixes"
"grammar;rules:paragraphs:data"
"grammar;rules:syntax:affix rules"
"grammar;rules:syntax:categories"
"grammar;rules:words:prepositions"
"grammar;tests:timing"
"model;core:names:laoder2"
"model;core:names:fsa:scan2"
"model;names:fsa:classify1"
"model;names:fsa:simple classify"
;;--- backed up 1/25 4.8


;; Apple load, 1/25,26,27,30
"init;versions:v2.3a:loaders:grammar modules"
"init;versions:v2.3:loaders:grammar modules"
"init;versions:v2.3a:loaders:grammar"
"init;versions:v2.3:loaders:grammar"
"init;versions:v2.3a:config:grammars:full grammar"
"init;versions:v2.3:config:grammars:partial grammar"
"init;workspaces:Mari"
"init;workspaces:Apple"
"init;workspaces:"
"init;workspaces:"
"analyzers;DM&P:loader"
"analyzers;DM&P:mine sequences2"
"interface;workbench:loader"
"interface;workbench:inspector"
"interface;workbench:item walk1"
"grammar;rules:brackets:required"
"grammar;rules:brackets:judgements1"
"grammar;rules:brackets:types"
"grammar;rules:DM&P:access routines"
"grammar;rules:DM&P:capitalized sequences1"
"grammar;rules:DM&P:prefixes"
"grammar;rules:DM&P:realizations"
"grammar;rules:syntax:have"
"grammar;rules:syntax:modals"
"grammar;rules:words:adverbs"
"grammar;rules:words:determiners"
"grammar;rules:words:prepositions1"
"model;core:names:printing"
;;--- backed up 1/30 3.5


;; BBN load 1/30
"init;scripts:BBN"
"init;versions:v2.3:config:launch"
"init;versions:v2.3:loaders:stubs"
"objects;chart:edge-vectors:object2"

;; Everything load 2/1,2,3
"init;workspaces:Mari"
"init;workspaces:SUN1"
"analyzers;DM&P:loader"
"analyzers;DM&P:mine sequences2"
"analyzers;DM&P:single edge1"
"analyzers;traversal:forest scan"
"interface;workbench:globals"
"interface;workbench:independent contents"
"interface;workbench:loader"
"interface;workbench:swapping modes"
"grammar;rules:DM&P:capitalized sequences1"
"grammar;rules:DM&P:display"
"grammar;rules:DM&P:prefixes
"grammar;rules:words:prepositions1"
"model;core:names:fsa:driver"
"model;core:names:fsa:embedded parse"
"model;core:names:fsa:scan2"
;;--- backed up 2/3 12.0

;; Apple load 2/3
"analyzers;DM&P:single edge"
"interface;Apple:finding actions"

;;------- copied everything to floppies and
;; put on Powerbook 2/3

;; Everything load 2/13,14
"objects;traces:globals"
"objects;traces:DM&P"
"analyzers;DM&P:hook"
"analyzers;DM&P:measure"
"analyzers;DM&P:
"analyzers;DM&P:
"analyzers;psp:scan:scan1"
"drivers;chart:psp:adjudicators1"
"drivers;chart:psp:pts5"
"grammar;rules:DM&P:loader"
"grammar;rules:DM&P:realization measurements"
"grammar;rules:DM&P:new individuals1"
"grammar;rules:DM&P:realizations"
"grammar;rules:DM&P:segments"
"grammar;rules:DM&P:
"model;core:names:fsa:driver"
;;--- backed up 2/14 2.0

;; Everything 2/14
"init;workspaces:Mari"
"init;workspaces:SUN2"
"objects;model:individuals:printers"
"analyzers;DM&P:measure"
"analyzers;DM&P:mine sequences2"
"drivers;chart:psp:adjudicators1"
"drivers;chart:psp:pts5"
"drivers;inits:switches2"
"interface;workbench:API"
"interface;workbench:contents"
"grammar;rules:brackets:judgements1"
"grammar;rules:DM&P:display"
"grammar;rules:DM&P:sort"


;; Everything 2/22,23,24,27,28, 3/1,3
"init;versions:v2.3:config:grammars:full grammar"
"init;versions:v2.3:loaders:grammar"
"init;versions:v2.3:loaders:grammar modules"
"init;versions:v2.3:workspace:abbreviations"
"init;workspaces:SUN2"
"objects;chart:edge-vectors:object2"
"objects;model:categories:lattice point"
"objects;model:individuals:object"
"objects;model:tree-families:driver"
"objects;model:tree-families:loader"
"objects;model:tree-families:form"
"objects;model:tree-families:postprocessing"
"objects;model:tree-families:object"
"objects;model:tree-families:subrs"
"analyzers;doc:word freq"
"drivers;chart:psp:pts5"
"drivers;inits:switches2"
"interface;grammar:postprocessing"
"interface;workbench:API"
"interface;workbench:autodefining"
"interface;workbench:autodef window"
"interface;workbench:buttons"
"interface;workbench:contents"
"interface;workbench:define rule1"
"interface;workbench:edges"
"workbench;edge-view:view"
"workbench;edge-view:select"
"workbench;edge-view:find"
"workbench;edge-view:populate"
"workbench;edge-view:open close"
"interface;workbench:globals"
"interface;workbench:independent contents"
"interface;workbench:initializations"
"interface;workbench:loader"
"grammar;rules:paragraphs:data"
"grammar;rules:tree-families:pre-head np modifiers"
"model;core:collections:obj specific printers"
"model;core:collections:operations"
"model;core:names:printing"
"model;core:names:fsa:examine"
"model;core:names:people:prefixes2"
"model;core:names:people:versions1"
"model;core:people:names1"
"model;core:people:printers"
"model;core:places:compass points"
"model;core:titles:loader1"
"model;core:titles:object"
"model;core:titles:object1"
"model;core:titles:status"
"model;core:titles:status printer"
"model;sl:whos news:job events:je object"
"dossiers;person prefixes"
"dossiers;person versions"
;;--- backed up 3/4 7.8am

;; cont. 3/4,6,7
"objects;model:tree-families:form"
"interface;workbench:define rule"
"model;core:autodef tableau"

;;------------ Versaterm crashed 3/7 10.2
;; new Everything load  3/7,8
"init;versions:v2.3:loaders:grammar modules"
"objects;model:tree-families:driver"
"objects;model:tree-families:form"
"objects;model:tree-families:object"
"interface;workbench:define rule1"
"grammar;rules:tree-families:NP"
"grammar;rules:tree-families:that comp"
"grammar;rules:tree-families:of"
"grammar;rules:tree-families:"

;; menu's lost it 3/8 3.3, so rebuilt
;; Everything load  3/8,13,14,15
"drivers;inits:switches2"
"interface;grammar:defining verbs"
"interface;workbench:autodefining"
"interface;workbench:define rule1"
"model;sl:whos news:job events:definition widgets"
"model;sl:whos news:job events:loader2"
"model;sl:whos news:job events:macro"
"model;sl:whos news:job events:je object"
"model;sl:whos news:job events:widgets"


;; BBN load 3/16,17,18 just to adjust gr. logicals
"init;everything"
"init;scripts:v2.3g"
"init;versions:v2.3:loaders:grammar"
"init:versions:v2.3:loaders:logicals"
"init;versions:v2.3:loaders:master-loader"
"grammar;rules:DM&P:loader"
"grammar;rules:FSAs:newlines:loader"
"grammar;rules:syntax:loader3"
"model;core:collections:loader"
"model;core:names:loader2"
"model;core:names:loader-2d2"
"model;core:places:loader1"
"model;sl:pct:loader"
"model;sl:whos news:loader"
"model;sl:whos news:job events:loader2"
"grammar;tests:loader"


;; fake v2.3g load 3/18
"interface;menus:module menu1"

;; ditto 3/21
"init;Lisp:lload"
"init;scripts:v2.3g"
"init;versions:v2.3:config:grammars:public grammar"
"interface;menus:launch"
"interface;menus:module menu1"
"interface;menus:Sparser" 

;; ditto 3/29
"init;Lisp:lload"
"tools;basics:time"

;; ditto 3/31
"init;scripts:v2.3g"
"init:versions:v2.3:loaders:logicals"
"init;versions:v2.3:loaders:grammar"
"init;versions:v2.3:loaders:logicals"
"init;versions:v2.3:config:launch"
"init;versions:v2.3g:workspace:switch settings"
"drivers;inits:switches2"
"interface;workbench:globals"
"interface;workbench:preferences"
"grammar;rules:CA:loader2"
"model;dossiers:loader"

;; 4/1 ...4/5   v2.3g load(s) to test things
"init;images:do-the-save"
"init;Lisp:ddef-logical"
"init;versions:v2.3:config:launch"
"init;versions:v2.3g:config:grammars:public grammar"
"init;versions:v2.3g:config:launch"
"init;versions:v2.3:loaders:save routine"
"init;versions:v2.3g:loaders:save routine"
"init;versions:v2.3:loaders:stubs"
"init;versions:v2.3g:loaders:stubs"
"init;versions:v2.3g:workspace:switch settings"
"objects;model:individuals:reclaim"
"interface;grammar:loader"
"interface;grammar:sort individuals"
"interface;menus:module menu1"
"grammar;rules:brackets:judgements"
"grammar;rules:DM&P:loader"
"grammar;rules:words:pronouns"
"model;core:names:people:object"  ;; just de-fasl'ed
"model;dossiers:loader"




;; 4/11 at Br
"init;everything"  ;; added BR700 location

; 3.4 the menus aren't coming up because of an error in building the
; the corpus menu because not all the expected corpus modules are present
; Finished 3.9
"tools:basics:syntactic sugar:list hacking"
"tools:basics:loader"
"interface;menus:corpus"

; futzing with grammar for contracts
"model;dossiers:kinds of companies"

; missing string/company 4.2- ... 4/25
"model;core:places:countries:object1"

; no sort routine for Company says Sort-individuals-alphabetically

; the printer for companies can't hack "the U.S. Army" -- it leaves
; out 'army'.  

; (!!) why can't we open up a "..." in the edges view?

; 4.4 adding 'adverb' to the autodef list
;  // aborted -- can't open the file of autodef data because it's owned
;    by this application.

; Names:  When "Martin Marietta Services Group" is taken down as a name,
;  it gets name-word objects made for everything in it, e.g. "Services".
;  The trouble is that the nw is for the --lowercase-- version of the
;  word when it ought to be for the upper.  

; 4.7 thinking about adding 'define word(s)' right on the Sparser menu




;; 4/12 (continuation, not launch) at 14B
;;   relaunched 4/13 3pm, 4/17,19
"init;versions:v2.3:loaders:grammar modules"
"objects;chart:brackets:rank"
"objects;model:categories:define"
"objects;model:individuals:delete"
"objects;model:individuals:printers"
;;"objects;model:individuals:reclaim"
"objects;model:tree-families:postprocessing"
"objects;words:lookup:capitalization"
"analyzers;psp:referent:driver1"
"analyzers;psp:referent:new cases"
"drivers;chart:psp:pts5"
"interface;grammar:defining other words"
"interface;grammar:loader
"interface;menus:Sparser"
"interface;workbench:autodefining
"interface;workbench:autodef window"
"interface;workbench:define rule1"
"interface;workbench:inspector"
"grammar;rules:brackets:judgements1"
"grammar;rules:HA:both ends1"
"grammar;rules:syntax:categories"
"grammar;rules:tree-families:morphology"
"grammar;rules:tree-families:pre-head np modifiers"
"grammar;rules:words:adjectives"
"grammar;rules:words:adverbs"
"model;core:autodef tableau"
"model;core:collections:obj specific printers"
"model;core:companies:loader"
"model;core:companies:names to companies"
"model;core:companies:names2"
"model;core:companies:printing"
"model;core:companies:subsidiary1"
"model;core:names:loader"
"model;core:names:object"
"model;core:names:fsa:examine"
"model;core:names:fsa:scan3"
"model;core:people:loader"
"model;core:people:names to people"
"model;core:places:cities:object"
"model;dossiers:loader"
"model;sl:pct:title+company"
"model;sl:whos news:job events:definition widgets"
"model;sl:whos news:job events:macro"
"model;sl:whos news:random and hacks"


;; backed up. new Everything load 4/19,20,23,24
"init;scripts:v2.3g"
"init;versions:v2.3g:loaders:save routine"
"objects;model:categories:index instances1"
"objects;model:categories:printing"
"objects;model:individuals:define"
"objects;model:individuals:index"
"objects;model:individuals:make"
"objects;model:individuals:printers"
"objects;rules:cfr:duplicates"
"objects;rules:cfr:form6"
"objects;rules:cfr:multiplier3"
"objects;traces:psp1"
"drivers;chart:psp:flags"
"drivers;chart:psp:pts5"
"interface;workbench:initializations"
"interface;workbench:workbench"
"interface;workbench:edge-view:open close""
"interface;workbench:edge-view:select"
"interface;workbench:edge-view:view"
"grammar;rules:brackets:judgements1"
"grammar;rules:brackets:types"
"grammar;rules:CA:defNP2"
"grammar;rules:words:aux verbs"
"model;core:collections:operations"
"model;core:companies:names2"
"model;core:companies:printing"
"model;core:money:loader"
"model;core:money:objects"
"model;core:money:printers"
"model;core:names:fsa:examine"
"model;core:names:fsa:record1"
"model;core:names:fsa:subseq ref"


;; backed up 4/25 ~10am.  New load 4/25,26
"init;versions:v2.3g:config:grammars:public grammar"
"objects;model:tree-families:form"
"objects;model:tree-families:object"
"objects;model:tree-families:postprocessing"
"objects;traces:CA"
"analyzers;CA:actions"
"analyzers;CA:scanners1"
"analyzers;CA:search2"
"drivers;forest:CA4"
"interface;grammar:defining verbs"
"interface;workbench:define rule1"
"interface;workbench:loader"
"interface;workbench:def rule:globals"
"interface;workbench:def rule:schema selection"
"interface;workbench:def rule:widgits"
"interface;workbench:def rule:rule population window"
"interface;workbench:def rule:case setup"
"interface;workbench:def rule:field filling"
"interface;workbench:def rule:reference category"
"interface;workbench:def rule:construct mapping"
"interface;workbench:def rule:write cfr"
"interface;workbench:def rule:save"
"interface;workbench:def rule:control thread"
"interface;workbench:def rule:"
"grammar;rules:HA:driver"
"grammar;rules:CA:extract subj"
"grammar;rules:CA:stranded VP"
"grammar;rules:CA:subj search1"
"grammar;rules:CA:laoder2"
"grammar;rules:CA:stranded NP"
"grammar;rules:syntax:categories"
"grammar;rules:tree-families:ditransitive"
"grammar;rules:tree-families:loader"
"model;core:people:names to people"
"model;dossiers:loader"
"model;dossiers:semantics-free verbs"
"Monday 4/17;name converters"
"Monday 4/17;comma rules"
"Monday 4/17;other"


;; backed up & rebuilt 4/28 10am
"tools;basics:time"
"objects;traces:cap seq"
"analyzers;HA:place brackets1"
"drivers;chart:psp:adjudicators1"
"interface;workbench:autodef window"
"interface;workbench:def rule:case setup"
"interface;workbench:def rule:loader"
"interface;workbench:def rule:new category?"
"interface;workbench:def rule:widgits"
"grammar;rules:DM&P:sort individuals"
"grammar;rules:FSAs:abbreviations2"
"grammar;rules:tree-families:ditransitive"
"model;core:companies:loader"
"model;core:companies:non-kind co words1"
"model;core:companies:
"model;core:companies:
"model;core:companies:
"model;core:names:fsa:scan3"
"model;core:names:fsa:do transitions1"
"model;core:names:fsa:examine"
"model;dossiers:loader"
"model;dossiers:co rules"


;; backed up & rebuilt 5/1 1.3   loads on 5/2,3
"objects;traces:cap seq"
"analyzers;CA:search2"
"drivers;chart:psp:scan2"
"interface;workbench:def rule:case setup"
"interface;workbench:def rule:control thread"
"interface;workbench:def rule:field filling"
"interface;workbench:def rule:
"interface;workbench:def rule:write cfr"
"interface;workbench:def rule:widgits"
"grammar;rules:CA:subj search"
"grammar;rules:DM&P:sort individuals"
"grammar;rules:FSAs:initials2"
"grammar;rules:tree-families:loader"
"grammar;rules:tree-families:
"grammar;rules:tree-families:verbs taking pps"
"model;core:companies:non-kind co words"
"model;core:companies:names2"
"model;core:companies:object"
"model;core:companies:names to companies"
"model;core:names:fsa:do transitions1"
"model;core:names:fsa:embedded parse"
"model;core:names:fsa:examine"
"model;core:names:fsa:scan3"
"model;core:names:fsa:record1"
"model;core:names:object"
"model;core:people:names to people"
"model;core:places:U.S. States"
"model;sl:reports:object"
"model;dossiers:countries:countries"


;; backed up 5/5 10am, etc. 
;; --- no record kept of changes from then
;; through 5/12 -- have to consult the backup records


;; 5/14 (semi back to normal)
"analyzers;FSA:edges1"
"grammar;rules:HA:determiner1"
"grammar;rules:syntax:articles"
"grammar;rules:syntax:possessive"
"grammar;rules:tree-families:pre-head np modifiers"
"model;core:companies:subsidiary1"
"model;core:names:rules"
"model;core:places:city"
"model;core:titles:loader"
"model;core:titles:area of responsibility"
"model;dossiers:loader"

;;  ... didn't record ...5/21

;; 5/22
"objects;rules:rule links:generic1"
"objects;rules:rule links:object2"
"analyzers;DA:index"
"analyzers;DA:arcs"
"analyzers;psp:assess:terminal edges2"
"model;core:collections:obj specific printers"
"model;core:companies:kind of company"
"model;core:companies:names2"
"model;core:companies:printing"
"model;core:names:companies:object"
"model;core:names:citations"
"model;core:names:name words"
"dossiers;new rules"

;; 5/26,28,29  (off launched Everything image)
"objects;model:variables:object1"
"drivers;chart:psp:pts5"
"drivers;inits:switches2"
"grammar;rules:CA:ancilaries"
"grammar;rules:tree-families:loader"
"grammar;rules:tree-families:ditransitive"
"grammar;rules:tree-families:indirect obj pattern"
"model;core:companies:names2"
"model;core:companies:names to companies"
"model;core:names:loader"
"model;core:names:lists"
"model;core:names:fsa:examine"
"model;sl:whos news:job events:loader2"
"model;sl:whos news:job events:
"model;dossiers:co rules"
"model;dossiers:job events"

;;------ backup 5/29 late afternoon

;;; 5/29
"grammar;rules:HA:both ends"
"model;core:names:fsa:classify1"
"model;core:names:fsa:examine"
"model;core:pronouns:ref4"



;;=========== moved files to hd of the new 8100 =============

;; everything load 6/13/95, 14
"init;everything"
"init:versions:v2.3:loaders:logicals"
"objects;model:tree-families:postprocessing"
"objects;traces:debugging"
"analyzers;forest:extract"
"interface;corpus:doc streams"
"interface;corpus:logicals"
"interface;corpus:Who's News logicals"
"interface;workbench:def rule:case setup1"
"interface;workbench:def rule:construct mapping"
"interface;workbench:def rule:field filling1"
"interface;workbench:def rule:globals"
"interface;workbench:def rule:loader"
"interface;workbench:def rule:reference category"
"interface;workbench:def rule:rule population window"
"interface;workbench:def rule:save"
"grammar;rules:CA:extract subj"
"grammar;rules:syntax:categories"
"grammar;rules:tree-families:loader"
"grammar;rules:tree-families:morphology"
"grammar;rules:tree-families:np adjuncts"
"grammar;rules:tree-families:prepositonal phrases"
"model;core:collections:object"
"model;sl:pct:position rules"
"model;sl:whos news:random and hacks"

;;--------- incr backup 6/20 2.0 ----

;; Everything 6/20,21,23
"init;Lisp:grammar-module"
"init;workspaces:workbench"
"objects;chart:categories:lookup1"
"objects;categories:loader2"
"objects;model:categories:lattice point"
"objects;model:tree-families:loader"
"objects;model:tree-families:subrs2"
"objects;rules:cfr:printers1"
"interface;grammar:object dialogs"
"interface;grammar:postprocessing"
"interface;grammar:sort"
"interface;menus:module menu1"
"grammar;rules:syntax:categories"
"grammar;rules:tree-families:verbs taking pps"
"model;dossiers:job events"


;;------ incr backup 6/23

;; Everything 6/26
"objects;model:tree-families:loader"
"objects;model:tree-families:subrs2"
"grammar;rules:sources:loader"
"grammar;rules:sources:CBD"
"grammar;rules:sources:Congress"
"grammar;rules:tree-families:loader"
"grammar;rules:tree-families:postprocessing"
"grammar;rules:tree-families:verbs taking pps"
"model;dossiers:job events"


;;------ incr backup 7/5
"init;scripts:Apple loader"
"objects;traces:psp1"
"objects;chart:words:spaces"
"objects;model:bindings:object1"
"objects;model:categories:lattice point"
"objects;model:individuals:reclaim1"
"objects;model:variables:index1"
"drivers;chart:psp:adjudicators1"
"grammar;rules:FSAs:newlines:blank lines"
"grammar;rules:sources:Congress"
"model;core:collections:operations"
"model;core:names:fsa:do transitions1"
"model;core:names:fsa:examine"
"model;core:people:names1"
"model;core:people:printers"
"model;core:pronouns:ref4"

;;------ incr backup 7/7
"Corpora:Apple Documents:new Reference:Chap4:body4.gml test sets"
"init;everything"
"init;scripts:just dm&p"
"init;versions:v2.3:config:grammars:minimal dm&p grammar"
"init;versions:v2.3:loaders:grammar modules"
"init;versions:v2.3a:loaders:grammar modules"
"init;versions:v2.3g:loaders:grammar modules"
"init;versions:v2.3:config:grammars:public grammar"
"init;versions:v2.3g:config:grammars:public grammar"
"init;versions:v2.3:config:grammars:full grammar"
"init;versions:v2.3a:config:grammars:partial grammar"
"init;versions:v2.3:loaders:grammar"
"init;versions:v2.3a:loaders:grammar"
"init;versions:v2.3g:loaders:grammar"
"init;workspaces:Apple"
"objects;model:tree-families:form"
"objects;model:tree-families:driver"
"objects;traces:completion"
"objects;traces:debugging"
"objects;traces:HA"
"objects;traces:psp"
"analyzers;DM&P:hook"
"analyzers;HA:inter-segment boundaries"
"drivers;chart:psp:scan2"
"drivers;chart:traversal1"
"drivers;sources:doc stream"
"interface;Apple:finding actions"
"interface;corpus:doc streams"
"interface;grammar:loader"
"interface;grammar:etf-driven definitions"
"interface;workbench:autodefining"
"interface;workbench:autodef window"
"interface;workbench:def rule:case setup"
"interface;workbench:def rule:field filling1"
"interface;workbench:def rule:save"
"grammar;rules:DM&P:sort individuals"
"grammar;rules:tree-families:pre-head np modifiers"
"model;core:autodef tableau"
"model;core:companies:kind of company"
"model;core:names:fsa:do transitions1"
"model;core:pronouns:loader2"
"model;dossiers:loader"

;;----- backed up 7/31

;; Everything 8/8,9,10
"init;everything"
"init;Lisp:ddef-logical"
"init;versions:v2.3:updating"
"init;versions:v2.3:config:launch"
"objects;traces:debugging"
"analyzers;CA:anaphora3"
"analyzers;FSA:words2"
"interface;corpus:doc streams"
"interface;corpus:logicals"
"interface;corpus:menu data""interface;corpus:
"interface;grammar:defining verbs"
"interface;grammar:object dialogs"
"interface;workbench:API"
"interface;workbench:def rule:schema selection"
"interface;workbench:edge-view:view"
"grammar;rules:HA:colon header"
"model;core:companies:non-kind co words1"
"model;core:companies:inc terms"
"model;core:companies:subsidiary1"
"model;core:names:fsa:examine"

;; backed up 8/11 ~10.0

;; Everything 8/11 ... 9/5
"init;everything"
"init;versions:v2.3:updating"
"init;versions:v2.3:config:launch"
"init;versions:v2.3:loaders:save routine"
"init;versions:v2.3:workspace:abbreviations"
"objects;chart:edges:object3"
"objects;chart:edge-vectors:object2"
"objects;chart:psp:edges:binary/explicit all keys2"
"objects;traces:debugging"
"analyzers;psp:edges:single-new1"
"drivers;inits:switches2"
"interface;corpus:menu data"
"interface;workbench:API"
"interface;workbench:loader"
"interface;workbench:def rule:control thread"
"interface;workbench:def rule:dossiers"
"interface;workbench:def rule:field filling"
"interface;workbench:def rule:globals"
"interface;workbench:def rule:reference category"
"interface;workbench:def rule:rule population window"
"interface;workbench:def rule:save"
"interface;workbench:def rule:widgits"
"interface;workbench:edge-view:open close"
"interface;workbench:edge-view:populate1"
"interface;workbench:edge-view:view1"
"grammar;rules:FSAs:abbreviations2"
"grammar;rules:tree-families:loader"
"grammar;rules:tree-families:NP"
"grammar;rules:tree-families:np-adjuncts
"grammar;rules:tree-families:adjective phrases"
"grammar;rules:tree-families:postprocessing"
"model;core:numbers:fsa words"
"model;core:time:anaphors1"
"model;sl:whos news:job events:definition widgets"

;; backed up 9/6 3.3

;; Everything load 9/12
"init;Lisp:grammar-module"

"interface;workbench:autodef data"
"grammar;rules:syntax:categories"
"model;core:adjuncts:approx:object"
"model;core:companies:subsidiary1"
"model;core:places:city"
"model;core:places:countries:object1"
"model;core:titles:operations"
"model;sl:whos news:job events:macro"

;;-- backed up 9/13 11.8
"objects;doc:loader"
"objects;doc:html"
"objects;doc:style"
"objects;forms:SGML1"
"objects;model:bindings:object1"
"objects;model:individuals:make"
"objects;model:individuals:object"
"objects;model:variables:object1"
"analyzers;context:manage sections"
"analyzers;traversal:dispatch"
"analyzers;traversal:form"
"drivers;chart:psp:flags"
"interface;corpus:doc streams"
"interface;corpus:logicals"
"interface;corpus:menu data"
"interface;grammar:defining html"
"interface;grammar:loader"
"interface:grammar:sort individuals"
"interface;workbench:autodefining"
"interface;workbench:autodef window"
"grammar;rules:context:article"
"grammar;rules:SGML:action"
"grammar;rules:SGML:categories"
"grammar;rules:SGML:html actions"
"grammar;rules:SGML:loader"
"grammar;rules:SGML:rules"
"grammar;rules:sources:loader"
"grammar;rules:sources:html"
"grammar;rules:traversal:other brackets"
"grammar;rules:traversal:loader"
"grammar;rules:traversal:angle brackets1"
"grammar;rules:traversal:quotations"
"grammar;rules:traversal:parentheses"
"model;core:autodef tableau"
"model;core:names:name words"
"model;core:names:object"
"model;core:time:dates1"
"model;dossiers:loader"
"model;dossiers:html tags"
"model;dossiers:html attributes"
"model;dossiers:html ISO characters"

;;--- backedup 9/21 10.0
"init;versions:v2.3:config:grammars:full grammar"
"init;versions:v2.3:loaders:grammar modules"
"init:versions:v2.3:loaders:logicals"
"init;versions:v2.3:loaders:master-loader"
"model;dossiers:loader"
"model;dossiers:filenames"
"model;dossiers:internet addresses"
"model;dossiers:URLs"


;;  stopped recording changes through 10/18,
;;  almost exclusively working on the scan facility

;; backup made on 10/13

;;------ 10/18
"objects;rules:cfr:dotted5"
"objects;rules:cfr:duplicates"
"objects;rules:cfr:multiplier3"
"objects;rules:scan-patterns:patterns"
"drivers;inits:switches2"
"interface;grammar:object dialogs"
"interface;workbench:def rule:case setup1"
"interface;workbench:def rule:construct mapping"
"interface;workbench:def rule:dossiers"
"interface;workbench:def rule:new category?"
"interface;workbench:def rule:reference category"
"interface;workbench:def rule:field filling"
"interface;workbench:edge-view:populate1"
"grammar;rules:tree-families:loader"
"grammar;rules:tree-families:copula patterns"
"model;core:names:fsa:classify1"
"model;core:people:names1"

;; backed up 10/30 11.5

;;------ 'everything' 11/9
"init;Lisp:grammar-module"
"init;versions:v2.3:loaders:grammar"
"objects;chart:edges:object3"
"drivers;chart:psp:trigger5"
"drivers;forest:trap2"
"interface:grammar:sort individuals"
"interface;workbench:API"
"interface;workbench:autodefining"
"interface;workbench:contents"
"interface;workbench:text view"
"interface;workbench:def rule:reference category"
"interface;workbench:def rule:dossiers"
"interface;workbench:def rule:control thread"
"interface;workbench:def rule:widgits"
"interface;workbench:def rule:rule population window"
"interface;workbench:def rule:save"
"interface;workbench:edge-view:view1"
"grammar;rules:context:loader"
"grammar;rules:context:dateline"
"grammar;rules:HA:determiner"
"grammar;rules:tree-families:np adjuncts"
"grammar;rules:tree-families:pre-head np modifiers"
"model;core:adjuncts:sequence:object"
"model;core:numbers:object1"
"model;core:money:objects"
"model;core:money:printers"
"model;core:pronouns:ref4"
"model;dossiers:loader"
"model;dossiers:approximator rules"
"model;dossiers:person interior rules"

;; backed up 11/19 3.3pm

;; Everything load: 11/28
"init;Lisp:lload"
"init;scripts:compile-everything"
"init;versions:v2.3:loaders:master-loader"
"tools;measurements:line count"
"interface;workbench:def rule:construct mapping"
"interface;workbench:def rule:rule population window"
"interface;workbench:def rule:save"
"interface;workbench:edge-view:find"
"interface;workbench:edge-view:populate1"
"grammar;rules:HA:both ends"
"grammar;rules:tree-families:np adjuncts"
"model;core:names:fsa:examine"
"model;core:people:names1"
"model;core:pronouns:ref4"

;; backed up 12/5 5pm
"init;everything"
"init;versions:v2.3:loaders:grammar"
"init;versions:v2.3:loaders:logicals"
"objects;model:categories:ops structure"
"objects;model:tree-families:driver"
"interface;menus:corpus"
"interface;workbench:autodef window"
"interface;workbench:def rule:control thread"
"interface;workbench:def rule:rule population window"
"interface;workbench:def rule:save"
"grammar;rules:tree-families:adjective phrases"
"grammar;rules:tree-families:morphology"
"grammar;rules:tree-families:postprocessing"
"grammar;rules:tree-families:pre-head np modifiers"
"grammar;tests:timing"
"model;core:autodef tableau"
"model;core:amounts:loader"
"model;core:amounts:amount-change verbs"
"model;core:amounts:object1"
"model;core:companies:inc terms"
"model;sl:ERN:loader"
"model;sl:ERN:financial data"
"model;sl:ERN:per share"
"model;sl:ERN:value of fin-dat"
"model;sl:ERN:earnings report"
"model;core:numbers:loader 2d part"
"model;core:numbers:form2"
"model;core:numbers:fsa digits6"
"model;core:people:names to people"
"model;core:time:fiscal1"
"model;core:titles:loader1"
"model;core:titles:object1"
"model;sl:whos news:job events:test set"
"model;dossiers:loader"
"model;dossiers:change-in-amount verbs"
"model;dossiers:person exterior rules"

;; backed up 12/23 6pm
"init;versions:v2.3:config:grammars:full grammar"
"init;versions:v2.3:config:launch"
"init;versions:v2.3:loaders:grammar modules"
"init;versions:v2.3:loaders:grammar"
"objects;model:individuals:decode"
"analyzers;CA:anaphora3"
"analyzers;forest:treetops"
"analyzers;traversal:dispatch"
"drivers;forest:CA4"
"drivers;forest:trap2"
"interface;corpus:doc streams"
"interface;corpus:logicals"
"interface;workbench:autodefining"
"interface;workbench:def rule:rule population window"
"interface;workbench:def rule:schema selection"
"grammar;rules:DA:loader"
"grammar;rules:DA:stranded comma"
"grammar;rules:paragraphs:section rule2"
"grammar;rules:SGML:action"
"grammar;rules:sources:loader"
"grammar;rules:sources:Knowledge Factory"
"grammar;rules:tree-families:loader"
"grammar;rules:tree-families:postprocessing"
"grammar;rules:tree-families:vp"
"model;core:amounts:loader"
"grammar;model:core:numbers:fsa digits6"
"model;core:names:name words"
"model;core:names:fsa:classify1"
"model;core:names:fsa:embedded parse"
"model;core:names:fsa:examine"
"model;core:titles:operations1"
"model;sl:whos news:job events:definition widgets"

;;--- backed up 1/3/96
"init;versions:v2.3:loaders:grammar"
"objects;chart:edges:object3"
"objects;chart:edges:resource4"
"objects;chart:words:lookup:capitalization"
"objects;model:bindings:hooks"
"objects;model:bindings:make"
"objects;model:bindings:index"
"objects;model:bindings:resource"
"objects;model:categories:index instances1"
"objects;model:individuals:printers"
"objects;rules:cfr:dotted5"
"analyzers;CA:anaphora3"
"analyzers;psp:fill chart:store5"
"drivers;chart:select2"
"drivers;inits:articles2"
"drivers;sinks:core"
"interface;grammar:sort"
"interface;workbench:autodef data"
"grammar;rules:CA:loader2"
"grammar;rules:CA:topic company"
"grammar;rules:paragraphs:section rule2"
"grammar;rules:SGML:categories"
"model;core:autodef tableau"
"model;core:companies:inc terms"
"model;core:companies:printing"
"model;core:finance:loader"
"model;core:finance:per share"
"model;core:finance:elaborations to money"
"model;core:money:rules"
"model;core:names:companies:object"
"model;core:numbers:percentages1"
"model;core:numbers:ordinals1"
"model;core:places:directions"
"model;core:pronouns:ref4"
"model;core:time:fiscal1"
"model;sl:ERN:citations"
"model;sl:ERN:'total' verbs"
"model;sl:ERN:time of fin-dat"
"model;sl:ERN:earnings report"
"model;sl:ERN:company of fin-dat"
"model;sl:ERN:value of fin-dat"
"model;sl:ERN:discourse heuristics"
"model;sl:ERN:change in fin-dat value"
"model;sl:ERN:stream-through driver"
"grammar;model:sl:reports:object"
"grammar;model:sl:reports:rules"
"model;dossiers:loader"
"model;dossiers:known companies"
"grammar;model:dossiers:report verbs"

;; backed up 1/16 5pm

"objects;model:tree-families:subrs2"

"interface;workbench:def rule:case setup2"
"interface;workbench:def rule:field filling2"
"interface;workbench:def rule:mapping2"
"grammar;rules:tree-families:morphology"
"model;core:people:printers"
"model;core:time:fiscal1"
"model;sl:ERN:time of fin-dat"
"model;sl:ERN:
"model;sl:ERN:
"model;sl:ERN:

;;--------------------------------
;;  Resumed some hacking, 3/13

"objects;model:tree-families:subrs2"

"drivers;chart:psp:pts5"

"interface;workbench:def rule:case setup2"
"interface;workbench:def rule:construct mapping"
"interface;workbench:def rule:save"

"grammar;rules:HA:driver"
"grammar;rules:tree-families:pre-head np modifiers"
"grammar;rules:tree-families:np adjuncts"

"model;core:companies:kind of company"
"model;core:names:companies:object"

"model;sl:ERN:change in fin-dat value"




;;----------------------------------
;;  working on Orgin to check things out for a version
;;  to license to JDP   5/27-31, 6/..19

"init;everything"
"init;scripts:compile-everything"
"init;scripts:copy everything"
"init;scripts:no grammar"
"init;scripts:v2.3ag"
"init;versions:v2.3:config:launch"
"init;versions:v2.3:loaders:grammar"
"init;workspaces:Darwin"
"objects;chart:brackets:assignments"
"objects;chart:edges:resource4"
"objects;model:bindings:alloc1"
"analyzers;CA:anaphora3"
"analyzers;psp:edges:loader2"
"analyzers;psp:fill chart:newline"
"analyzers:tokenizer:alphabet"
"analyzers;tokenizer:alphabet fns"
"analyzers:tokenizer:token FSA3"
"drivers;sources:doc stream"
"interface;workbench:loader"
"interface;workbench:adjust"
"interface;workbench:pause"
"interface;workbench:text view"
"interface;workbench:walk"
"interface;workbench:def verb:definition widgets"
"interface;workbench:edge-view:view1"
"grammar;rules:FSAs:newlines:count lines"
"grammar;rules:HA:both ends1"
"grammar;rules:SGML:loader"
"grammar;rules:SGML:sentence"
"grammar;rules:syntax:have"
"grammar;rules:syntax:be"
"grammar;rules:syntax:modal"
"model;core:names:fsa:examine"
"model;sl:whos news:job events:loader2"

;;---------------------------------------------
;;  backed up to Zip 6/25/96

"init;versions:v2.7:config:launch"
"objects;words:section markers"
"analyzers;DM&P:single edge1"
"interface;menus:corpus"
"interface;workbench:def rule:control thread"
"interface;workbench:def rule:case setup"
"interface;workbench:def rule:save"
"grammar;rules:brackets:judgements1"
"grammar;rules:brackets:types"
"grammar;rules:FSAs:hyphen"
"grammar;rules:SGML:sentence"
"model;core:pronouns:cases1"



;;--------------------------------------------
;; changes made after the JDP 6/28/96 release

;; INSO
"grammar;rules:brackets:judgements1"
"model;dossiers:co activity words"

;; "Electronic Book Technologies (EBT)"
"grammar;rules:syntax:parentheses"
"model;core:names:loader2"
"model;core:names:parens after name"

;; dm&p on NIH
"grammar;rules:DM&P:prefixes"
"grammar;rules:DM&P:realizations"
"grammar;rules:DM&P:segments"
"model;core:names:fsa:classify1"

;; for "3T3" (etc.)
"objects;rules:scan-patterns:forms"
"objects;rules:scan-patterns:patterns"
"objects;rules:scan-patterns:states"
"objects;rules:scan-patterns:transitions"
"objects;traces:scan patterns"
"analysers;psp:patterns:accept"
"analysers;psp:patterns:driver"
"analysers;psp:patterns:take transitions"
"drivers;chart:psp:initiate pattern scan"

;; installing corpus of NIH articles
"init;versions:v2.7:loaders:grammar"
"init;versions:v2.7:loaders:logicals"
"init;versions:v2.7:loaders:grammar modules"
"init;versions:v2.7:config:grammars:academic grammar"
"init;versions:v2.7:config:grammars:full grammar"

;; doing some grammar for NIH
"interface;grammar:defining verbs"
"grammar;rules:tree-families:morphology"
<< whole directory:  model;sl:NIH >>>
"model;dossiers:loader"
"dossiers;genes/proteins"


;; extending the autodef facility to be self-inserting
"interface;workbench:autodef data"

;; debugging/tweeking the citations 
"grammar;tests:citations:code:test"
"grammar;tests:citations:cases:new ones"



;; 8/97 Modifications (outside of init) needed to allow the no-model
;; BBN license to include enough machinery to include phrase
;; segmentation
"init;Lisp:lload"
"objects;brackets:form1"
"objects;chart:categories:lookup"
"objects;rules:scan-patterns:transitions"
"analyzers;psp:fill chart:newline"
"drivers;chart:psp:adjudicators"
"drivers;chart:psp:scan3"
"drivers;inits:switches2"
"drivers;inits:sessions:globals1"
"drivers;sources:core1"
"drivers;sinks:core"
"interface;grammar:postprocessing"
"grammar;rules:paragraphs:data"
"grammar;rules:syntax:categories"
"grammar;rules:words:quantifiers"
"model;core:names:fsa:driver"

;; All modifications after the initial delivery on 8/21/97
"init;everything"
"init;Lisp:lload"
"init;scripts:copy BBN"
"init;scripts:compile BBN"
"init;scripts:BBN loader"   ( "Sparser;load Sparser" on delivery )
"Sparser:BBN rules:test context for 8/97 instal"  ;; new

"analyzers;psp:edges:digits"

;; Hacking the special loading context for 'public' grammar files
"init;Lisp:grammar-module"
"init;Lisp:lload"
"init;Lisp:ddef-logical"
"init;versions:v2.7:config:grammar:bbn"
"init:versions:v2.7:loaders:logicals"
"init;versions:v2.3:loaders:master-loader"
"init;versions:v2.7:loaders:grammar"
"init;versions:v2.7:config:grammars:academic grammar"
"init;versions:v2.7:config:grammars:bbn"
"init;versions:v2.7:config:grammars:full grammar"


;; Getting Everything to load
"grammar;rules:syntax:categories"
"objects;chart:categories:lookup"
"model:sl:NIH:site"
"init;versions:v2.7:config:launch"
"init;everything"
"analyzers;psp:referent:unary driver"
"model;dossiers:loader"
"init;images:do the save"


;; Getting lattice points in (11,12/97)
"init;Magi loader"
"init;everything"
"init;versions:v2.7:loaders:master-loader"
"init;versions:v2.7:loaders:grammar"
"objects;model:loader2"  ;; new
"objects;model:categories:loader1"
"objects;model:categories:define1" ;; ditto
"objects;model:tree-families:loader1"
"objects;model:tree-families:object1"
"objects;model:tree-families:form1"
"objects;model:tree-families:driver1"
"objects;model:tree-families:rdata1"
"grammar;rules:tree-families:loader1"
"grammar;rules:tree-families:postprocessing1"
"grammar;rules:tree-families:postprocessing1"
"model;sl:ERN:lp quarter"

;; reinvigorating incr. backup (12/6/97)
"interface;files:backup recent"
"init;everything"
"init;Lisp:lload"
"init:versions:v2.7:config:explicitly-loaded-files"

;; hacking M&M paper 12/30/97
"model;dossiers:job events"
"model;core:time:phrases1"
"grammar;rules:syntax:tense"

;; 2/14/98 through 2/26 continuing with lattice points
"objects;rules:cfr:printers"
"objects;model:tree-families:object1"
"objects;model:tree-families:driver1"
"objects;rules:cfr:object1"
"objects;rules:cfr:form-rule form"
"analyzers;psp:referent:loader3"
"analyzers;psp:referent:new decodings1"
"analyzers;psp:referent:new cases1"

;-- trivial bumps to get new def of cfr-plist through
"objects;rules:cfr:construct1"
"objects;rules:cfr:dotted5"
"interface;grammar:sort"
"interface;grammar:postprocessing"

;--- more lattice point installation 3/3,7
"objects;model:lattice-points:printers"
"objects;model:categories:define1"
"objects;model:lattice-points:loader"
"objects;model:lattice-points:annotation"

;;--- ditto 3/22
"grammar;rules:tree-families:postprocessing1"
"objects;model:loader2"
"init:versions:v2.7:loaders:logicals"
"objects;model:individuals:index"
"objects;model:lattice-points:operations"
"objects;model:lattice-points:annotation"
"analyzers;psp:referent:driver2"
"analyzers;psp:referent:dispatch2"
"analyzers;psp:referent:loader3"

;;--- ditto 4/23
"analyzers;psp:referent:unary driver2"
"analyzers;psp:referent:
"objects;model:lattice-points:traverse"
"objects;model:lattice-points:structure"
"objects;model:lattice-points:annotation"

;;--- ditto 5/5/98
"grammar;rules:tree-families:morphology"
"objects;model:tree-families:object1"
"objects;model:tree-families:form1"
"objects;model:lattice-points:annotation"
"objects;model:lattice-points:printers"
"Sparser:code:s:init:versions:v2.7:salutation"

;;--- ditto 6/30, 7/3,5,7,12,13,14,16, 20, 23/98
"objects;model:categories:define1"
"objects;model:individuals:structure"
"analyzers;psp:referent:dispatch"
"analyzers;psp:referent:unary driver"
"analyzers;psp:referent:dispatch2"
"analyzers;psp:referent:driver2"
"analyzers;psp:edges:digits"
"grammar;rules:CA:stranded VP"
"grammar;rules:tree-families:transitive"
"grammar;model:core:numbers:fsa digits6"
"grammar;model:core:numbers:percentages1"
"model;core:money:loader1"
"model;core:money:objects1"
"model;core:money:rules1"
"objects;model:tree-families:rdata1"
"objects;model:tree-families:driver1"
"objects;model:tree-families:subrs2"
"objects;model:lattice-points:structure"
"objects;model:lattice-points:annotation"
"objects;model:lattice-points:traverse"
"objects;model:lattice-points:structure"
"objects;model:lattice-points:initialize"
"objects;model:lattice-points:extend"
"objects;model:lattice-points:v+v objects"
"objects;model:lattice-points:c+v objects"
"objects;model:lattice-points:psi"
"objects;model:individuals:find1"
"objects;model:individuals:make1"
"objects;traces:loader"
"objects;traces:psi"
"model;sl:ERN:earnings report1"
"model;sl:ERN:value of fin-dat1"
"model;sl:ERN:loader1
"model;dossiers:random and hacks"
"model;dossiers:financial data items"
"grammar;rules:tree-families:pre-head np modifiers"
"interface;workbench:inspector"



1/22/99, 1/23,25,31  2/14,15
"objects;model:tree-families:rdata"
"objects;model:individuals:decode1"
"objects;model:individuals:make1"
"objects;model:individuals:find1"
"objects;model:bindings:object1"
"objects;model:bindings:make1"
"objects;model:variables:object1"
"objects;model:lattice-points:structure"
"objects;model:lattice-points:printers"
"objects;model:lattice-points:v+v objects"
"objects;model:lattice-points:find"
"objects;model:lattice-points:find or make at runtime"
"objects;model:psi:make"
"objects;model:psi:find"
"objects;model:psi:extend"
"interface;grammar:sort"
"model;core:time:weekdays"
"model;core:time:months"
"model;core:places:countries:object"
"model;core:titles:object1"

3/13 on g3
"init;workspaces:Darwin"
"init;scripts:Magi loader"

4/29, 5/11,13 on g3
"init;everything"
init;workspaces:workbench"
"objects;model:lattice-points:annotation"
"interface;files:backup recent"
"interface;menus:backup"

5/18a  Why does the psi-source that's made for #<cent>
come out as an object that error's out when you try 
to print it? --fixed.
5/18b  Why does "cent" come out as a psi when it looks
like all of its bindings get filled in the course of
its definition? --fixed the basics (routine for "cents"
didn't feed bind-variable operations into new objects
which is required when working with psi  --But-- there's
no provision in the code for reworking a psi into an
individual, e.g. there's no detection point anywhere
along the line (maybe in extend-psi-by-binding where
we would notice).
5/18c  Creating an instance of a currency -- blowing up
 in print again as the find loops up through the lattice
 and gets nowhere. We still don't have enough to print.
 We're bailing out of find-variable-in-category/named
 apparently because it isn't recursing correctly.
 --YEP -- it hadn't been reworked for real lattice points 
 But something is still iffy.
"objects;model:psi:loader"
"objects;model:psi:printing"
"objects;model:psi:trace"
"objects;model:psi:make"
"objects;traces:psi"
"objects;model:bindings:make1"
"objects;model:variables:object1"
"model;core:money:objects"

5/30/99
"objects;model:psi:loader" ;; misspelled "traces"

5/30 stubbing a text planner
"g3:mine:NLG:Stra:load Stravinsky"
"Stra;ts-readers;basics:loader"
"basics;numbers"
"basics;money"
"NLG;workspace:United Air" ;; moved out the basics

5/30 making "United Air" parse
"model;core:names:name words"
The reverse link from the name words back to the
name are not beinq set. Trying to look at intermediate
states is overflowing the stack, apparently trying to
print something. 

6/4 getting the rnodes for "10" right. There is a
precompiled rule and a recasting from the fsa, each
yielding a node, but the mechanism to link them
together as the tree forms isn't working. 
"objects;traces:psi"
"objects;model:lattice-points:annotation"

Improving the information supplied to Annotate-individual
so it will know where the daughter edge is if there is one
"analyzers;psp:referent:driver"
"analyzers;psp:referent:unary driver"
"grammar;model:core:numbers:fsa digits"

6/8 connect rnodes for "10" (or "10,100.1") right.
Collecting the daughters of a number while the edge
that spans them is constructed, then marking them in
a subroutine off of Annotate-individual so that their
rnodes are linked to the rnode for the number as a
whole.
"objects;model:lattice-points:structure"
"grammar;rules:edges:digits"
"objects;chart:edges:object3"
"grammar;model:core:numbers:fsa digits6"

6/12  Putting in a proper category for multiplier
so I can record the distribution of the elements of a
compound number in preparation for generating it.

Problem: define-individual doesn't know (from, e.g, the
simplified index specs, that, e.g., all you need to get
an individual for something that's indexed to a name is
that name. Add another case to Make-trivial-saturated-
individual. Fixed.

"model;core:numbers:object1"
"model;core:numbers:categories"
"model;:core:numbers:form2"
"objects;model:individuals:make1"

6/14 Bug: the *edges-to-rnodes* table didn't get an entry 
for the contructed number edge (#1, "110") in "1,110.2".
That step is probably missing. Look up where the others
get entered and do something similar.

6/22 Fixed it. The downward rnode links from the daughters
of the number are nice. The upward links from the number to its
daughters plunks the whole set of them in the head field of the
composite number's rnode, which is fine barring a more refined
notion. 

6/22 illions-distibution individuals don't ahve a nice printed
from, which was initially distracting. And (!) the value of the
illion isn't being spelled out in the binding. 

Added the call to annotate number
"grammar;rules:edges:digits"

Wrote populate-rules-that-are-fsas,
"objects;model:lattice-points:annotation"

Added multipliers for fraction and one.
"dossiers;numbers"

Putting in a workspace for all this.


6/24/99

Pulled the empty '10 million' rule
"grammar;model:core:numbers:rules"

Added standalone rdata assembler to solve timing problems.
"objects;model:tree-families:

Added number-of-quantity.
"grammar;rules:tree-families:pre-head np modifiers"

Added the realization schema for "10 million"
"model;core:numbers:object1"

6/25 The routines that apply etf's to instances don't know to make
substitutions to a :function field. Punting in this instance by
stipulating it in the etf.

6/25 "million" isn't being labeled a multiplier. Presumably
because we're going through the wrong path in making the
individual. See find-or-make/individual

7/3
"objects;model:tree-families:rdata1"
"model;core:numbers:object1"

7/4 finished debugging rdata contruction of multipliers
"model;:core:numbers:form2"
"objects;model:individuals:decode1"

But the multiplier value in the illions-distribution individuals
is still coming out as nil. -- Fixed. rewrote the lookup as
strings rather than symbols so it would match the find call.
"grammar;model:core:numbers:fsa digits6"

Remember to set *index-under-permanent-instances* to t when
we want to keep things like the illions-distributions across
runs. 

7/4/99 Starting Stravinsky's readout routines
"NLG;Stra:load Stravinsky"
"tsro;loader"
"tsro;driver"

7/15,16.  Got the number decoded on the g. side and wrote a few
of the set of phrases etc. Discovered that the values under the
numbers that aren't predefined are integers rather than #<numbers>,
and started examining Make-edge-over-unknown-digit-sequence 
and the fsa code. Fixed 7/24

7/18,23
"grammar;rules:edges:digits"
"grammar;model:core:numbers:fsa digits6"
"model;core:numbers:form2"


Discovered that it may be interference b/w the position structure
in mumble and the one in sparser that creates the printer stack
overflow when looking at some backtraces. Maybe hack it by trapping
the position explicitly w/in mumble::def-type and renaming the
actual choice of structure. Words don't seem to be interfering
but probably should align their pname fields. N.b. redefining the
sparser position structure will let you get through.

7/19/99  Funny-ness. If you run a compound number like 2,101.1 through
twice you get the wrong rnode on the number and you're reusing
the individual that goes with the unknown digit sequence component
(101). Probably incomplete reclaimation or failing to mark it
permanent but writing a rule that caches it. Goes with the change
in getting 'temporary' numbers to use define-number as the
intermediary in order to get the word object saved without writing
special extra code. 

7/27 Bug: It gets through mumble, but the illions analysis or the
presumption about which edge is whitch in the call from the
digits-fsa has it assigning the ones object to the thousands
illion object and visa versa. The fraction object is fine.

8/12 Trying to expose the number-of-quantity schema for
"10 million" but the number fsa for words wants to respan a
bare multiplier as a number, which it should if the word is
by itself. Maybe look for the rule within the fsa ?
   Problem: the rule is there in the list by the cfr lookup
routines won't return it. => multiplier doesn't have the
ids it should. Overridden? Yep. Category file follows the object
file where the rule is defined. ==> fixed 8/13

8/13 fixed problem whereby the function argument in a schema that
doesn't supply an argument to the function (there's only provision
for one argument!) was getting nil as a fill in. Fixed 8/14
"objects;model:tree-families:driver1"

8/15 bug: There are no rdata being laid down for the number-word-
fsa hand-constructed "10 million" number. Presumably we have to
call annotate-individual directly because it doesn't go through the
usual locus, but double check whether there isn't just a problem
such that :function -based referent contructios shouldn't go that
way too.  8/16 Modifying ref/function to fit the pattern of the
other cases where the annotation is folded into the routine that's
been dispatched to. 

8/20/99 In the rdata for "10 million" the head and arg assignments
are reversed. Fixed 8/21

9/1..3  Bad data-setup when evaluating the 1st instance of a
currency individual. Apply-realization-schema-to-individual expects
there to be a designated head in the rdata-schema kept with the 
currency category and there isn't. Dereference-rdata does the
multiple-value return that supplies the head-word, and it is
packaged up by Dereference-and-store?-rdata-schema
  The first question is whether it really needs a head word and
its complaint is legitimate. In this case we're setting up phrases
like "Australian dollars", so there is not going to be a head
word supplied with the realization as there would be with a
verb-realized category.
  Fixed 9/3 [but has to be checked for repurcussions in a reload]
    by putting in a dummy fixed value for heads. 

9/3 When making the psi for "$10 million", the psi that binds just
the referential category (#<money>) is blowing up in the printing
done by the tr in Find-or-make-psi-for-base-category because
nobody appreciates that its type is list of categories rather
than a single category. [Have to double check that a list is the
intended design since the code didn't expect it.]
  Fixed 9/6: "objects;model:psi:object"
9/6,7 That didn't fix (all of) it. It now blows up later in the
printing process. It chokes on that type inside of Climb-lattice-to-top
(called from Category-of-psi) where the expectation is that the
type field will contain a lattice point rather than a list of 
categories (they go into the lattice point instead).
=> Tracking down the place where the type of a psi is assigned.
 9/7 Datum: the type field comes from individual, where it indeed
should be a list of categories. The relevant thing for 
Category-of-psi to call is psi-lattice-point.
=> did that and the lattice point blew up in Climb-lattice-to-top
as being ill-formed because it's not the top yet it doesn't have
parents.

9/12/99 Hit Annotate-site-bound-to, which sets up a c+v record but
there isn't yet an indexing scheme for them. Written.
//needs expression-level accessor.

9/19 oops. Assumed that the realization map could be used
directly to access the fields on the unit, but as given
it's listing categories rather than, e.g., variables. We need
at least to unwind things further, e.g. out through the
bindings. Which really should be done when the etf is done
as part of writing the rules. => 9/19 decided on a notion of
registration whereby symbols can be indicated as functions
to ba applied to the unit and do arbitrary things.

9/20 The number that's made by Apply-multiplier doesn't
have number and illion bindings like the ones made by
the digits fsa do. => fixed.

9/25 "10" won't generate because it's binding structure is funny.
(Dies in the illions-distribution.) It seems like the problem
is original with the point when the number individuals are
created, but it's also possible that it's later when they're
parsed and go through map-out-the-distribution (assuming that
a pre-existing number goes there, which it probably shouldn't
since everything that happens there ought to be redundant.
  9/27 => fixed. Turned out to be inocuous. Numbers have a 
view as an ordinal, where the relationship is to categories
(11th) rather than inviduals, so extending a gofer fixed it.


9/27/99 Design problem. (utter-ts-node ten) loses inside Mumble
because we have the wrong datatype, a phrasal-root, that
blows up in process-slot that expected other stuff.
Maybe look up something in the YS text planner code.

DATES 
  Months (and probably weekdays and such) should be coming up
individuals with simple structures, but they're coming up as 
psi -- maybe give them explicit indexing instructions?
In particular, (find-individual 'month :name "April") doesn't
work and it should. Fixed ~9/30

10/1 Now the problem is with the names of the months. The standard
way of creating them is to include a part-of-speech keyword
at toplevel in the realization. But this doesn't connect the
resulting rule to a schema (e.g. via the schr object that
corresponds to the rule in a regular tree family from which
the rule might otherwise have been instantiated. But so far there
doesn't seem to be a device within the etf to do what the 
other, independent trick does. 
=> 10/18etc. fixed this by writing a shell etf in 
[tree-families;single words] whose individual cases are accessed
from the word-cases in [tree-families;morphology1]. Gradually
putting in cases. Right now doing [rules;words:prepositions] to
add a notion of spatial-orientation (see define-preposition) so
that we can define relative-location cleanly [core;places:object]
on the way to doing Genaro. This will also require a hack into
the etf machinery since we need to define a form rule here rather
than the usual cfr.

11/27 Bug: something is bad with the indexing of compass-points
(or maybe everything with a simplified indexing scheme?) such
that find-individual won't find them and successive definitions
against the same contents yield different objects. 

11/27 Unfinished: we need a single-word treatment for adjectives
of the sort that a predictable from the noun form like those for
compass points ("southeastern") whereby we can specify the ending
("+ern") as part of the realizattion spec. Right now the compass
point adjectives don't have associated schemas.

12/12/99 Parsing "next to the door" fails because "the door" has no
referent and the rules presume there will be one. May as well
create a category for 'kinds' with noun realizations. Can always
serve as a toplevel category when these are given the more
sophisticated treatment akin to what a month or December would get
with categories instantiating more abstract categories, though that
needs some thought and dredging up of old treatments.

12/20 Reloaded after a long time running and blew up in 
define-change-in-amount-verb/up in the dossier for such verbs
(e.g. "climb", "fall"). At first looked to be a shift in the
kind of direction involved since that was rewritten. But after
matching the specialization it's still failing in what should be
a straightforward find-individual. However it looks like the
adjustments to make more kinds of instances into defacto saturated
individuals are not promulgated to find/individual's dispatch.

Doc: New individuals funnel through make/individual, where there
is a dispatch between make-a-simple-individual and make/psi. We get
simple individuals if certain criteria are met. To make connection
with find, make-simple-individual run index/individual, which sets
up two links: funcalling the index operation given with the
category and then index-to-category which handles reclaimation.
The problem is that we don't have indexing information on the
category if it doesn't have an index field, which is true of most
of the newly revised categories that yield simple individuals.
   So we have to hack Prepare-category-operations so that it can
appreciate these new criteria and assemble the appropriate
indexing and finding operations in the category's cat-ops structure.

Steps to take: 
  1. let Prepare-category-operations go through even if there
 isn't an index field
  2. have Decode-rest-of-index-field set values in all cases.
 some definitive (matching category-interior-sufficient simple
 individual determinants) -- these can go to specific indexing
 schemes like hashes. And another that's default since in some
 cases the actual individuals might go in as psi -- it goes to
 simple list.
  3. check the base find routines to be sure that they do clean
 checks before going off on wild goose chases for the default
 cases. 
           done 12/26/99

Doc:
Getting the word defined as part of the definition of a
category with realization, e.g., :realization (:common-noun "kind")
Calling chain:
 define-category/expr
 decode-category-parameter-list
 setup-rdata
 dereference-and-store?-rdata-schema
 make-rules-for-rdata
 make-cn-rules/aux


12/26: Bug -- a kind like "park" is getting labeled as itself
rather than as the category kind, and as a result isn't participating
in the rules for kinds. There's a provision in Make-cn-rules/aux
that ought to handle this since it cares about what the category
actually instantiates, but it appears either that it isn't working
or there's (been?) some kind of timing problem.





Retro-fits:
 --- Redo that number schema as a quantifier -- that takes care
of the lack of determine and non-plurality of the head.
Distinquishes the singular and plural instances of multiplier
words. The singulars, in phrase-final position create quantifier
phrases, and in interior positions are part of compound numbers.
The plurals are taken as kinds "tens of thousands" and are nps
rather than qps. 
 ---  Somethings screwy in the find routine for numbers
(or they're temporary?) and successive runs of "10 million"
don't have eq referents. Fix this at some point after there's
hard-copy to work from.


1/9/00 Working on the realization of a category as the denotation
of the head of an np. Lots of little details to promulgate. 
E.g. can we pass a bare word to mumble?

"objects;model:lattice-points:annotation"
;;     (2/21/00) Tweaked Head-and-ather-edges-of-binary-rule to look for
;;      the keyword :head as well as :head-edge in the descriptors field
;;      of rule schemas. That there are two terms is certainly a historical
;;      artificat, but this is expedient.

2/21 "the park" -- Sort-out-head-vs-arg-rnodes-in-binary-rule has
never before seen a case where one of the edge's referents' wasn't
an individual. Here it's a category and a word.  FIXED 2/26

2/26 The indexing scheme for lattice points is failing to intern
#<lp park . name>. Each run of "the park" has made a new one.
2/29  The reason is that the referent uses Dereference-DefNP which
ends up doing a Dereference-DefNP which is now a brain-dead scheme.

3/21  Setting up for "three companies". Needs a make over of
collections to lattice-points. Feeding a fleshed out treatment
of subtyping starting with make-cn-rules/aux for "companies".
The go with form rule for <number> that binds the number of
the collection. Needs a scheme for holding the multiple 
referents of the individual.  Do fleshing out by making the
subtype's value a general referent that could be fed to 
resolve-referent-expression -- see decode-subtype

3/30 Whilst doing the just above, observed that find-self-node
isn't re-finding something it's already set up.

4/10/00 Annotate-realization-pair expects to be coming in from
a binary rule. When called from inside the collection sub-type
aspect of "companies" we have neither to supply it since we're
calling Ref/instantiate-individual-with-binding without any
special appreciation that it's not itself being called directly
from a binary rule.  Fixed 4/19 (via special signalling arguments)

4/19 we're annotating the lattice-points. Does it matter whether
we annotate the individuals as well? What does the original
theoretical treatment say? What does the generation direction
expect ?  Annotate base-case and individual cross index rnodes
to the individuals. pair should presumably do the same. 
   Where is it recorded that the realization of #<psi company>
was the word "company". => right on the category.

5/3 for "three companies" via a composite. 
The calling sequence up from multiply-edges is check-one-one,
do-single/left, topping out with lookup-the-kind-of-chart-processing-to-do
and ultimately chart-based-analysis to analysis-core to p.

5/5/00 Something's seriously off. Successive runs of "three companies"
creates lattice points for the binding of 'type' that keep adding
that variable to the already existing lp for itself, so something
has confused the lp-being-extended with the new lp
5/18 Hypothesis: the problem is that Find-or-make-next-lp-down-for-variable
misses its second case on the second run because there's something
wrong with find-lattice-point-with-variables1
6/4 what may be wrong is that it's asking for too many variables
(consing a type onto a starting-lattice-point that already includes
a type -- so something wasn't checked earlier and let slip through
the very lp that we're looking for. n.b. by the time it got to
extent-psi-by-binding the parent was the psi we were looking for
(n.b.b. this was the second run through of the text)
6/6 It goes bad via traverse-from-lattice-point-down for when it's
coming in from find-or-make-psi-for-base-category. Whoever is
setting the down-pointers of the top-lattice-point of collection
it setting without checking that there's already one there and
has put the lp that binds both type and collection onto the
down pointers via collection as well as via type.

7/6 All the above is fixed (I think). Now the problem is that
the individual for "three" (#<number "3">) is not in an illions
relationship and fall through distribute-number-illions. 7/7 it wasn't
folded into define-number. Just the digit routines.

8/13 To reverse "second quarter (of 1999)" we have to work out
a technique for picking between multiple etf (or cascading them
when appropriate -- a real job for Stravinsky). Part of the effort
entails adjusting the reverse mapping (reformulate-realization-map) 
so that we can observe the set of variables that the map can handle.
The right way to do that is as a lattice-point so that the comparison
can be immediate (and the map/arity-data is cached for easy lookup).

8/14 There's a problem with #<number 10>. It's in three illions
bindings, two where the value is correct, one where it's just
the bare value 10. There should only be one, but in the  meantime
the upshot is that distribute-number-illions goes around three
times when it shuld only be one, and the wrong one comes out at
the end. 
8/27 Fixed that by rewriting the number code in form2 and basing 
the object on define-individual. But it looks like that code is
working just fine but that no 'bound-in' is being set by the
psi code that sets up the illions-relationship.
8/30 Fixed that by finding another criteria for fully-populating
an individual (the psi code isn't setting bound-in fields because
it's not set up that way, we'd need to start working on the logical
equivalent of them, which would probably be a digression right now.)
  But now it's hung up in an ecase in Process-slot that's been there
since the virtual beginning of time so it's got to be something else
that's wrong.

mid-September -- working bottom up on the whole thing starting with
shares and money, treating them as kinds of measurements and amounts.

mid-December -- got a working treatment of shares.

12/26/00 -- "cents" blows up in annotation. It's now subtyped because
of the treatment of plural, and Referent-from-unary-rule calls 
ref/head which calls annotate-individual with ':globals-bound' which
fails because that entails binding *head-edge*, which we haven't.
Fixed it by passing a flag through the calling chain.

12/26 -- Annotate-site-bound-to has never seen a composite ("cents")
before. Need to remind myself how c+v work. // Decided not to try
since I've forgotten the canonical example that motivates the idea
of composites. Probably should rework it for as simple a thing as
plurals. Hmmm... the canonical example is "three companies". 
12/26 "5 cents per share" hits up against the composite machinery
inside multiply-edges with a case that wasn't done yet.
==> Decided that the analysis should be refined into cases: The best
treatment is probably plural common nouns that head defNPs where we're
going to pass up a collection in hopes that it can be dereferenced
(populated by particular individuals) vs all the others that are just
simple plurals that are probably going to head phrases denoting
quantities, measurements, and the like. 

[[ There's a systematic problem with the use of multiple expansions
of terms within mapping expressions, see, e.g. the currency category.
They hit the 'only one lhs for each rhs' rule so that only the first
of the options takes when more than one (?) term is involved. It's
a cunumdrum. ]]

2/20/01 -- After fixing a glitch in the plural code, hung up on collision
in the schema expansion of proportional measurement with the expansion
of measurement. The proper fix probably entails a modification to
the schemas involved. ...fixed with a change to the mapping so that it 
used a different category in the per-amount case, a category that won't 
make it to the surface in the expected case and could be useful for implicit
context-sensitivity anyway.

2/26 Doing "2 cents", the subtyping needed for the simpler plural is
hung up on the fact that Corresponding-unit-of-subtype stubs the case of
specializing an individual. Need to reference the relevant papers and
follow what they say, probably a change to the individual's type object
by creating an specific specialization object hung off the category's
lattice point. 

10/10/01 (!) Designing the subtyping machinery -- officially these are
derived categories: synthetic types created by taking a natural kind
and adding something that specializes it. This machinery will also be
used by compositionally established tenses (future) and the like (though
maybe future can absorb an adjunct that specifies when in the future
we're referring to).
   Corresponding-unit-of-subtype has nothing in place beyond the
stubs. top-lattice-point has a field called subtypes. There are also
the upward and downward -pointers fields, but I've forgotten how they're
used. A practical question is how 'deep' this subtyping is likely to get.
If it's only ever one item, then an alist in the subtypes field is
enough. If it gets as deep as psi lattices then it's a whole bunch of
machinery. Assuming for now that we're dealing with pro-forma derived
categories (rather than "laid off by IBM") and going with an alist.
The key is the /// oops. Just ran across a subtype-lattice-point defstruct
that I've forgotten about. Time for more research. --> Won't need an
alist if the subtype field exclusively holds subtype lattice points
since the keys are part of those objects. 
   There's a bug someplace, since I'm seeing subtypes of 'collection'
that look arbitrarily deep, like once per run. That stuff is setup
with an alist in the subtype field, so a lot of this has already been
built, but not correctly. // Well maybe just differently. model:
lattice-points:specialize does the construction. First guess is the 
bug is in the find routine. Question is why the operation is going
on.   

---- 3/26/03
Changed:  
  grammar:rules:brackets:judgements1  -- To handle "2003" by itself.
  model:sl:ERN:earnings report2 -- put in the first realization for
    "sales of $93.85 billion"
  model:core:numbers:fsa digits6 -- fixed referent construction for 
    the illions-distribution for "93.85"

 Hmm.. now something about the indexing of one of the bindings on
  is off and it's not being found during deallocate-binding.

---- 4/9
 Following out the binding deallocation problem. It's a matter of
the illions-distribution being setup as a permanent object, while
parts of it (or maybe the composite number since I see it on the
*active-individuals* list) are seen as temporary/to-be-reclaimed.
  Some time ago I couldn't figure out the notion of declaring all
individuals of a given category to be permanent (see function at endo
of "categories:index instances1") and had everything that goes 
through define-individual come out as permanent.
  But make-edge-over-unknown-digit-sequence, while it calls 
construct-temporary-number, will land us in define-number, which takes
us to construct-number, which in turn does a bunch of calls to 
define-individual. Presumably that's where we should cut it off.
  Decided to revert from the policy that was imposed in 2000 and to
let define-individual make its objects permanent or temporary depending
on some higher routines value for the global. Have to reload to test
it though.  
Changed 
   core:numbers:form2 and 
   model:individuals:make1

-- 4/10  Continued sorting it out -- the reload fixed the reclaimation
problem but evaluating the financial for "sales" after the fact took it
to a deallocated-individual, and on the next try (the full phrase and not
just the word) it rewrote the referent of that rule as one of the
numbers, so exposed the dossier and going to reload.

-- 4/11 Getting a complaint in ref/binding to the effect that we were
dealing in the stone age (pre-psi) and it couldn't "convert" because the
body wasn't a psi. Thought about it a bit and finally appreciated that
nothing in the item-of-value tree family was instantiating the ern
category. So copied the tree family to item-of-value1 and added an
instantiate-individual to it -- and everything works.
  models:sl:ERN:earnings report2
  rules:tree-families:of

--- 4/27 Starting in on exporting the ETF
init:versions:v2.7:loaders:master-loader
objects;export:loader
objects;export:common
objects;export:etf


--- 2/2/05 (!!)
Fixing define-sequence to get through (M1)
"objects;model:individuals:make1"
"objects;model:bindings:object1"
"model;core:collections:loader"
"model;core:collections:object1"
"model;core:collections:operations1" ;; bumped
"model;core:names:fsa:subseq ref"

Decided to ignore annotations just now, so commented out various calls
  so we wouldn't get there. 
"analyzers;psp:referent:unary driver"  - & in evening
"objects;model:psi:find or make"

Succeeded on "Auto insurance was overhauled last year"
 => name-word XXX be XX time

Picking up the work of subtyping "cents"
"model;core:names:fsa:classify1"

Second time through (m1) it blew up in Spread-sequence-across-ordinals
because the lookup on the ordinal: nth-ordinal, returned nil, which
appears to be because define-individual returned a psi and didn't index
the name (?) so that (category-named 'first) returned nil.  Ah -- we didn't
bind all the variables in the definition. Have to develop an override for
pre-define cases like this. Created instances-of-this-category-can-be-partial
to do it.

Nth-ordinal is utterly out of sync with current reality since it thinks it's
looking at categories and they're actually individuals.
2/3  cont. w/ sorting out ordinals
"model;core:numbers:loader2"
"model;core:numbers:ordinals3" - bumped

Realized (belatedly, while documenting), that "first" really -should- denote
a psi, so the fix (related to others) is to find the object once we've created
it. 
"objects;model:psi:find or make"

Surprised to see that the ordinal category has an operations field, which
the defaults fill with 'simple-list'.  The result is that within the find
operations, at find/individual, it calls the simple-list operations rather
than go via find-psi.  I have the feeling this is going to be a problem.
Diverting to the psi search (which for large dossiers should be faster)
by including the check that's used in the make direction between 'simple'
individuals and psi.
"objects;model:individuals:find1"
"objects;model:individuals:make1"
"objects;model:lattice-points:find"

Thought I'd got it routed correctly, but the ordinals aren't going down the
make-psi route, and the find is returning nil. Doing some traces.
"objects;traces:psi"
2/4 Hmm... the find worked out of the box for the ordinal.

Spread-sequence-across-ordinals calls define-individual to further saturate
the ordinal by adding the item and sequence. What was I smoking at the time?
Finally found the 'extend' operation, but it needs elaboration and generality.
"objects;model:psi:extend"
"objects;model:individuals:make1"
"objects;model:psi:find or make"
"objects;model:psi:find"

Very confusing. Got the new extension route ready to test and my path
throgh Do-single-word-name isn't being used anymore by M1. Changed it to
"we met Peter Hoe here" and we get to the original sequence index routines
(which aren't loaded, of course), so clearly we're not going through.
=> The problem is the rule that gets created to cache the first time
through -- need to delete/cfr# on it -- has been starting at 1040.
the new lookup routines. 
"model;core:names:object"  -- hooked up to new sequence operations1 routines

2/7
Cleared out the multiple-value-bind in the variable search as clumsy 
"objects;model:psi:make"
"objects;model:psi:find or make"
"objects;model:psi:find"
"objects;model:individuals:decode1"
"objects;model:psi:extend"
   At this point the simple case for "Auto" (in M1) is working - the
item+number+squence object is created.  The indexing is good, but only
goes through one of the lattice paths. I think that theoretically it's
entitled to populate psi in the other paths down to here, but I haven't
yet sussed out an elegant way of doing it.

Working on the subtype bug -- locus is in Corresponding-unit-of-subtype
where the wrong parameter is taken as the root.  It's working off a
reference expression created by Make-cn-rules/aux.
"objects;model:lattice-points:printers"
"objects;model:lattice-points:specialize"

Decided to create a new individual to represent the subtype (for the
case where we're subtypeing an individual). We have to subtype the
it's category so we can get a kosher individual, then we clone the
binding set.  We base the object on a newly created category that
represents the subtyping of the super-category, using the lattice-points
to keep track of what's what.
"objects;rules:cfr:object1"
"objects;model:psi:find or make"
"objects;model:categories:structure"
"objects;model:categories:printing"
"objects;model:individuals:make1"
"objects;model:individuals:resource1"

2/8
"objects;model:individuals:make1"
"tools:basics:syntactic sugar:alists"

Making the derived (subtyped) categories.
"objects;model:categories:define1"
"objects;chart:categories:lookup1" 
"objects;model:lattice-points:initialize"
  
Works now for "two cents", though that phrase doesn't parse.
And also works for "three companies", which also doesn't parse, so the
problem is probably the same -- the forest for three companies is
 [ ones-number company ]
Appears that this was done via composites back in 200 when it last
ran in May of 2000 -- check-one-one

2/9/05
Have to get into multiply edges. Open question whether a 'composite'
data structure is needed for something maybe we can get directly
from psi. Haven't found enough doc around why/how it's formulated.
"analyzers;psp:check:loader1"
"analyzers;psp:check:multiply5"

Changed to something that looks up all the possible categories on
the referents and chains through them. It didn't work out of the
box so adding some traces.
"objects;traces:edges1"
"objects;rules:rule links:generic1"
Got it to work - shocking how simple it is this time. Last time (2000)
I was tearing my hair out and not getting anywhere.

But the result for "three companies" is a collection, which while
nominally correct might not be all that helpful, though perhaps
referent-level combination will continue to work there.

Cleanup 
"objects;model:lattice-points:operations"
"analyzers;psp:referent:composite referent"

Back to ERN stuff
"32 cents per share" correctly goes to amount-per-share
"first quarter" goes to quarter
"first quarter of 1998" goes to quarter. 

The format for a rule symbol is rule::psrNNN

"January 30, 2005" => date

Working on "fiscal quarter"
"analyzers;psp:referent:loader3"
"analyzers;psp:referent:new cases2" -- bumped
"grammar;rules:tree-families:pre-head np modifiers"
"model;core:time:fiscal2"
"objects;model:psi:find or make"

2/10/05
"analyzers;CA:anaphora3"
"objects;model:lattice-points:annotation"
"objects;model:lattice-points:operations"
"model;sl:ERN:financial data2"
"objects;model:individuals:printers"

2/11 -- reviving companies
"model;core:companies:object1"
"model;dossiers:known companies"
"model;core:companies:names2"
"model;core:companies:loader2"
"model;dossiers:loader"
  n.b. There's a stub file, descriptors, for things like
    "(the) Dutch publishing company"
  And the rules file needs to be mined
"model;core:names:fsa:do transitions1"

...Working on (define-company "Apple Computer, Inc.")
It's made a name for the first part that the fsa identifies
("Apple Computer") and it's getting problematic in find/company-with-name
since we're dealing with psi for the name, which is probably unnecessary
if we indicate that it only takes the sequence to intern the object.
Right now we're blowing up within value-of while trying to print
the psi when working through the backtrace at a breakpoint. 
pprint-psi <= print-partially-saturated-individual-structure
Oh -- it's like a recursive call on value-of is fowling things up.
No. It's a bad quote in the macro that's involved.
2/14
"objects;model:individuals:objects"
"analyzers;psp:referent:cases1"
"model;core:companies:inc terms"
"model;core:names:companies:object1" -- bug in chart re-initialization
"objects;chart:positions:array2"
"model;core:collections:operations2"

2/17 Working on "Apple today announced financial results for 
                 its fiscal 2004 third quarter ended June 26, 2004."
"model;core:time:fiscal2"
"grammar;rules:tree-families:np adjuncts"

2/18 Want to get from "Apple" to the company, e.g. with a call
to map-name-words-to-name to set up the bindings. Problem is that
v+v don't invert so nothing ends up in the bound-in field of the
name-word objects

2do: subtype psi need to copy over the accumulated v+v of their source

2do: We need a comma specialist (or re-opening closed edges or something)
since once it got the rule for combining quarter and end-date, it
strands the comma-year:
e3    PRONOUN/INANIMATE       7 "its" 8
e4    FISCAL                  8 "fiscal" 9
e5    YEAR                    9 "2004" 10
e15   QUARTER                 10 "third quarter ended june 26" 15
e19   COMMA-YEAR              15 ", 2004" 17


3/11 -- need a treatment for 'results' and then a variant etf
 for report-verbs (and fix it's interpretation since it doesn't
 instantiate anything useful). Then more for company-s + quarter

e5    SOMEONE-REPORTS         1 "apple today announced" 4
                                 "financial"
                                 "results"
e6                               "for"
e8    COMPANY-S               7 "its" 8
e26   QUARTER                 8 "fiscal 2004 third quarter ended june 26" 15
e24   COMMA-YEAR              15 ", 2004" 17
e23                              "PERIOD"


3/14 -- The CA rule for comma-year works ok, gets the binding state
 correct, but the assimilation of the year to the date doesn't happen.
e5    SOMEONE-REPORTS         1 "apple today announced" 4
                                 "financial"
                                 "results"
e6                               "for"
e27   QUARTER                 7 "its fiscal 2004 third quarter ended june 26 , 2004" 17

;3/30  Need a proper schema for "increase" so can do IGW-98 examples
;   Have to differentiate between the verbs according to their paradigms
; Fixed 4/1

;3/30 Doing the full verb-form on "rise" and the head-word is coming
; up as :foo, because that's the value of the :name on the object,
; So track that down, and figure out the right complex form for
; verb data.
; Fixed 3/31


 "the whole importance of IBM's first quarter was summed up 
with that quote. IBM met estimates with 
earnings of 98 cents a share on sales of $21 billion"

2do: 4/1 Reexamine whole treatment of articles and nps. Coordinate
 the treatment in "grammar;rules:syntax:articles with the etfs.

2do: Examine the situation in polywords vs. regular rules stated
 over words. Otherwise we have to be careful about getting an initial
 edge over a term like "board" before it is allowed to see the "the"
 (via an NP schema) since "the" triggers a polyword search which can't
 tell the difference and ends with an edge creator that doesn't compute
 its referent: Extend-mc-pw calls Make-edge-over-long-span

2do: The new modifier etf aren't cataloged by the postprocessor
(ed-s "grammar;rules:tree-families:postprocessing")

2do: Think about whether looking under the hood shouldn't be a standard
 operation within pts because of the possibility of stranding a
 continuation as it date + comma-year. 


2do: Keep the fixed parts of a relation out of the lattice computation,
e.g. with ordinals we should omit the word and the roman numeral.

Extend Workout-the-relationships-among-the-categories to know about
derived categories.

When Corresponding-unit-of-subtype runs, it makes an individual that
carries the additional, specializing type. We should look to see if
one of these already exists before we make another. (And they should
be indexed to the subtype lattice point!)


--- where things were left on 4/27/03 (here on down)

2do:
-- Create an index from tree-families to the categories that reference
them so we can work regression tests off of it. 

Bug: common-noun realization for financial doesn't appreciate that
   "sales" is already plural


2do: Reversing the analysis

-- Review old Mage code and try to remember the original ploys

-- Set up the {lspec constructor} for numbers
   -- remember  how to drop in word-stream blips / non-space-following
      commas and periods.
   -- repair the rules for digit number-word combinations so there
      will be a schema in evidence there to be inverted.

Triage -- stuff skipped
-- Add the 2 digit forms of years in model;core:time:years2
-- Automatic subtyping. Start with a general verb/relation and have
   some facility notice its adjacency relationships with more specific
   forms and go from that to subtype (change the type) to the 
   more particular case. 

Useful make-overs if there's ever the time.
-- When constructing the mappings in category realizations, make
   a parallel map that takes them into accessors - this would replace
   Reformulate-realization-map, which is a runtime kludge.


Ongoing: 
  (1) Should we / how would we convert saturated psi into  
      regular individuals.
  (2) Continue marching through the dossiers loader to get
      the recalcetrant cases.


"analyzers;psp:referent:unary driver"
"objects;model:lattice-points:annotation"
"drivers;inits:sessions:globals1"
"init;versions:v2.3:config:grammars:minimal dm&p grammar"

;;----------------- notes on "iraqi girl", "Frenceh swans", etc. ---------
2/29/08

There's a nil getting through in person+title (in sl/pct/) in the
call to define-realization. 

3/25
Trying to bring in titles to do "Iraq's health minister". Turns out that
dossiers/titles is a bunch of calls to define-title and hasn't been touched
since 3/94 and is all commented out. The def form is defined in 
core/titles/def-form which isn't even listed in the set of 1991 files
in the titles loader that need to be reviewed and updated.

On the other hand most of the parts of "composite" titles like those given
in titles do have what look like workable definitions, with dated on the
files from 1995. 

This is the edge over "Iraq's"
<edge2 1 country 4> is a structure of type EDGE.  It has these slots:
 CATEGORY           #<ref-category COUNTRY>
 FORM               #<ref-category POSSESSIVE>
 REFERENT           #<country "Iraq" 9>
 STARTS-AT          #<edges starting at 1>
 ENDS-AT            #<edges ending at 4>
 RULE               #<PSR165  {np} -> np apostrophe-s>
 LEFT-DAUGHTER      #<edge0 1 country 2>
 RIGHT-DAUGHTER     #<edge1 2 apostrophe-s 4>
 USED-IN            NIL
 POSITION-IN-RESOURCE-ARRAY  2
 CONSTITUENTS       NIL
 SPANNED-WORDS      NIL

We need it to introduce the same brackets as we get with a determiner:
  ].phrase and .[article -- see define-determiner.

The routine to do this in scan is 
Introduce-{leading/trailing}-brackets-from-edge-form-labels off the 
form label possessive. Unclear as yet what the timing is of that portion
of the scaning and running the Check-special-cases-and-possessive fsa
that's triggered by the define-edge-fsa for apostrophe-s. 

Lots of bracket introducing/assigning code in /analyzers/HA/place-brackets.
The scan routine calls code in there, though it doesn't look like it's
doing it right since the source-is-an-edge? optional argument isn't used.

To get [det ... title] we'll need the *both-ends-of-segment-heuristic*
grammar module in the loader for rules/HA

Assign-brackets is in objects/chart/brackets/


4/24
There are no brackets on a head like "minister" because the title def-form,
define-single-word-title, just creates the individual, and (??) there's no
attempt to introduce brackets using the simple operations that instantiate
the word given the realization spec. 

The  path from define-individuals to the schema interpretation is via
apply-realization-schema-to-individual thence to make-rules-for-rdata and
head-word-rule-construction-dispatch to, e.g., make-cn-rules in rules/
tree-families/morphology1. make-cn-rules/aux actually makes the rules, so
the brackets go here. 

Adverbs -- "despite" takes nominalization. "initially" is a conventional,
goes-in-front-of-the-verb case. Put them in as function words in rules/
words/adverbs without considering a proper semantic analysis.
  Getting a kind created for "despite" because there's no edge over it
when it's the only word in its segment. This prompts moving the def-form
from rules/syntax/adverbs into rules/words/adverbs. But the syntax file
has some nice form rules and the note that they were a good place to allow
form+form rules. The stub of that class (late 1994) is in muliply6 in
analyzers/psp/check, where the other cases in that file were throughly
reworked last August. 
  Before attempting to revive it, need to review how "three swans" works,
and consider how the integration into the driver suite should work. Could
consider just staging it within the inter-segment operations of DM&P with
a last-ditch check for form+form when the label on the edge is a word (for
the adverbs & such), then carefully add it elsewhere. Wouldn't hurt to 
understand how the code in /driver/chart/psp/march-seg5 works too, since
if we did it 'conventionally' it would happen there.
  N.b. Adverbs are really good DM&P information, so giving them really
nice analyses on the stule of "three swans" would be valuable.

6/16

Getting everything into the realization of some category is a
good thing (as opposed to bare rules). Sequencers ("after") and
approximators are folded into time phrases in the relative-time
category of core/time/relative-moments.

Hmmm... the word "A" doesn't have any brackets, so it can't act
as a determiner ("A breach in ..."). We can give it brackets, but
how would that interact with the creation of initials? It's a
question of whether the fsa for detecting initials can get it
before the brackets are planted (which feels right) and can also
deflect the "A"'s bracket introduction in favor of those imposed
by the initials category (which I'm not so sure about at all).


Segment-finished has a conditional over both *do-domain-modeling-and-
population* (original scheme), and the new *do-strong-domain-
modeling*. That calls for coordination at a higher level to force
the 'or'.    Also (!) can reuse this spot / overload it to site the
syntactic facts tabulation since it's going to be independent of the
actual analysis.   Need to write up the alternatives here.  Also have
to write up the fact that conjunction checking is interleaved here.

Trivially-span-current-segment is dependent on the flag
use-segment-edges-as-segment-defaults* -- where else is it used?

Using *new-dm&p* we get both the reification of bounded segments
(which is always good), and the reification of head words as
categories (usually good).   It would be useful to have a switch
setting that separated these operations, leaving off the category
creation while still using all the form information on the heads.

There are specific rules for 'in' plus location (etc.) that keep 
the preposition exposed, whereas if we use, e.g. 'at' we get a
labeling that submerges the preposition and is based on the
spatial-orientation label over the preposition.  These have to be
collapsed to the same labeling.  The treatement of relative-location
is in /core/places/object, and requires the NP to be labeled as
'place' using the content-pp ETF which apparently is set up to
get its head via a form-rule over NP (//// check that since it's
a quite important thing I may well have forgotten).
   We want city-of to do work for us, so there could be a timing
problem on the tt sweep that could trip us up if we supress 'city'
under 'location' (or whatever) too early

Bug: in 'the Kurdish city of Sulaimaniya' -- The edge for capitalized-word
has no form label, so it bombs out in sdm&p.

7/14/08
Modified define-kind-of-location to create categories for the kinds
as well as individuals associated with the words. (Not tested yet
or have any rules, e.g. cardinal + kind-of-location ("9th Ward").

?? I've forgotten about a word-traversal-hook fired from within
word-level-actions (in scan). The hook gets a function from calling
(traversal-action word) and calls the function with the position and
next position. Set up routines are in the file with the hook function
in drivers/chart/traversal. Nobody reads the return value from the
hook.   Also need to document usage of completion actions and generally
what happens in Complete-word/hugin and Complete-edge/hugin, both in
analyzers/psp/complete. ///Where is the edge completer called?

N.b. there's a tr keyword :considering-edge-level-fsas in FSA1 in 
objects/traces.

Stumbled across tracing-keyword? because of a break left in the
bowels of trace-msg. Looks like an unfinished debugging tool.

8/9/08

Taking note of the places that have to be touched to fix the bug
that lets a capitalized function word in sentence-initial position
be misunderstood as part of a proper name. 

If we try (p "An Iraqi girl died on Jan. 17.") we have the confounding
factor that the country after the "An" is also capitalized, so on the
face of it we have two capitalized words in a row, which would be
legitimate if other words were involved.

It dies in create-sequence while it's setting up the (overly grandiose)
indexing of the sequence in spread-sequence-across-ordinals, having 
committed to categorize-and-form-name which is called (via a few
intermediaries by Classify-&-record-span in a process that is started
by pnf/scan-Classify-Record or check-pnf-and-continue depending on
how you mentally factor the process. 

Files /model/core/names/fsa/driver.lisp

;;----
Because "a girl" doesn't parse, we can either change the treatment of
person to engage the determiners, or we can experiment with form + form
rules, which could demand that one side or the other have a rule-driven
interpretation. We could also try making definitive edges on determiners
and have the form rule go that way (which sounds promising actually)


Files for edge-handling
  /drivers/chart/psp/march-seg5.lisp
  /analyzers/psp/check/{one-many, ...}
  /analyzers/psp/check/multiply6.lisp  -- multiply-edges

There's a flag: *allow-pure-syntax-rules* in check-form-form with the
note that it hasn't been checked when the code in multiply was massively
reorganized in August '07. 

Need to review the ETF options for NPs when reconsidering reworking
the treatment of person, since it becomes a model for how we work-up
SDM&P treatments of NP heads. 

8/20/08
"In August 2007" strands the year because (1) there is a ].proper-noun in front
of the year because of its form label, and (2) there's no [ after the proposition,
which is just wacko. The trace says Introduce-leading-brackets-from-edge-form-labels,
and comes in once the first set of edges come in. Hmm... "in" is created by 
define-preposition to have sensible bracketing. Maybe it gets mucked up
by the define-spatial-preposition operation if it doesn't look for an existing
word. Be that as it may, the pair of treetop brackets are on (word-named "in")

Ok. After doing that we get time,time because we still get
in+month before the month can see the year. Hmm... "August" goes
directly to time, not to month.  Maybe the right thing to do is
to make time a form category. "2007" introduces a trailing
np]. and also goes directly to time. We still need "in August" to
come out a a time (or else we're multiplying the time-combination
rules somewhere, which might not be a bad idea since its just
combination with event in a form rule.)  "Monday" goes to weekday, so should
follow the same pattern with the others. 

Now we get time,year -- which suggests a timing problem or an errant bracket. 
(trace-segments)
(trace-brackets)
(trace-edges)
An errant bracket suffices, because there's no close after "in". 

To trace-out how we get realizations expanded start at setup-rdata the dispatch
over single words is in dereference-rdata -- that's for categories. For individuals
and the case of spatial prepositions: apply-realization-schema-to-individual with
Head-word-rule-construction-dispatch -- Hmmm Make-preposition-rules assigns
brackets. And checking the word that's there as "in" shows that it has brackets
too. Why isn't there a segment boundary?

#<brackets for #<word "in">> is a structure of type
BRACKET-ASSIGNMENT.  It has these slots:
 ENDS-BEFORE        #<bracket ].TREETOP >
 BEGINS-BEFORE      NIL
 ENDS-AFTER         NIL
 BEGINS-AFTER       #<bracket TREETOP.[ >
 BACKPOINTER        #<word "in">

(trace-treetops)
(trace-network)

Oh pooh. :introduce-right-side-brackets is only called after "2007" and 
"SOURCE-START", so there's no chance of getting the .[treetop that goes with "in"
and the whole thing is substantially messed up. 


11/12/08
Trying the New Orleans paragraph in the workspace. Dies on a type-mismatch
(gets company-name and expects sequence) on "Army Corps" as its building the
sequence part of a 'company-name' for it. It's going through PSI operations
on the sequence that might well be new territory. Ripping out the sequence-based
indexing would be a horrific disruption (though it bears consideration), 
so allowing the either categories to be compatible (which they are) or somehow
avoiding the check seems best. 

In Spread-sequence-across-ordinals the 's' sequence variable is bound to a
psi whose category is company name -- why isn't it sequence? If we're going in
through create-sequence it.  After putting in the first set of breakpoints
it looks like the fault of PSI operations, but there's a confusion here.
We get through the spread that's called by create, we get to the index call
at the botton of create and we're back in the spread, but this time with 's'
bound t the psi for the company name. Hmmm but we're back in make-company fn
now binding first-word via a call to first-item-of-sequence with all the local
bindings there looking good. The errant psi is the company-name individual.
Ah, the last part of that fn is a call to map-name-words-to-name, which goes
to the call to spread that makes zero sense. Perhaps it's a left over from
an earlier time. That fixed the problem.

11/13/08
In "the St. Bernard/Orleans parish line", PNF hit a break on an unresolved question of
what to do with literals that the scan let through. Commented out the kpush that
was next because that duplicated the literal in the list of items, so presumably
the structure of the loop changed since that kpush was put in. 

The more interesting problem is that it didn't notice the "St." as part of the
sequence (and it doesn't know anything about 'parish' or 'line' as yet)

Next PNF problem is that is saw "AM CST" and hit a trap for the verb 'be' within
a capitalized sequence. Correct fix is to tell it up front about that as 
a time phrase. 

Could consider setting *end-PNF-early* so as to avoid all aspects of PNF other
than delimiting. That gets much farther into the paragraph until it hangs up on a
treetop level operation where "was reported", incorrectly (because it's passive)
rewrites the capitalized-sequence just to its left as a company and its lack of
a referent (because of the *end-PNF-early*) passes a nil on as the thing to be
reconstrued as a company.  The csr is in model/sl/reports/rules and it appears
that "was reported" is covered by the category 'report-verb'. The form is
verb+passive, so the needed information is there, but I don't remember whether
there's any provision for a constraining check on the application of cs (or other
rules), and I doubt it. The rules were put in on 3/11/05, so it's probably not
so back to just flush them. 

11/14/08
Truncating PNF using *end-PNF-early* is only viable if we give the edges real 
referents -- some sort of dummy of type name. Not doing pnf screws subsequent
references to names, but it would be a middle ground. Turning it on and seeing
how we do on section 10.2.6 of Larry's book -- one long paragraph.

Getting a null referent on a form rule associated with 'be' that wants to create
'be-something'. The rule wants to use the referent on the np on the right "a useful
vertebrate model organism", which was created by the determiner-completion-
hueristic, but has nil for a referent. Probably need to turn on dm&p to give
it a plausible referent.

That got us through that spot to another bug where we encountered an edge over
a period that's spanned by :literal-in-a-rule. There's no form value on those
edges, so we fell through an unanticipated case in elevate-head-edge-form-if-needed.

Did a bunch of additions to elevate-segment-edge-form-if-needed, but balked
when it wanted to do it for quantifer, so want to define "as much as" directly
as a polyword quantifier, but fell into an unanticipated case when expanding
it's 'det' form rule. (/// and should consider what we're buying with that
form rule, since it's just sucking up the quantifier without doing anything 
with it.)

=========
3/27/09

Putting in fast-acting abbreviated all-in-one definition facility. But the
semantics-free-verbs dossier file where the instances should go isn't being
loaded so need to wander through the loading process to remember how to set
it all up. 

'fire' is a 'system configuration' built in to everything.lisp. It governs
a grammar configuration named 'fire' (with all the configurations bound up
within a 'version' directory (of which we have just one now that the others
were deemed too old to ever care to go back to).

In that config file, the grammar module for *irregular-verbs* is 'included'
but there's no mention of the semantics-free or semantics-weak verbs. They
aren't mentioned in the 'full-grammar config file either (and the order of
items there is different. Oh -- in 'full' the weak-semantics module is included
but down with syntactic rules rather than up in 'empty definitions for closed-
class words', though in fire the irregular verbs module is there which seems
inconsistent. (versions/v3.1/config/grammars/fire, etc. (and most of these
other configurations are only of academic interest now.)

///Need to rename & reposition the file that defines all the grammar modules
since it's stashed under versions/v3.1/loaders/ as grammar-modules, which
suggests that it loads them when in fact it just defines them. 

The module itself is defined (should have been since dossiers references it)
and was in full-grammar so added it to fire.

The shortcut definitions go in grammar/rules/tree-familes/shortcuts.lisp
The cases for verbs go in grammar/model/dossiers/semantics-free-verbs.lisp


2/3/10
Running (f "/Users/ddm/ws/nlp/corpus/mcl-msg-with-table.lisp")

Weird, troubling phrasing in (trace-brackets) on 
        (p "the lisp heap as being a few percent less")
where it seems like it ought to be closing off segments because of, e.g.,
the ].preposition bracket but it doesn't seem to. ///Review the algorithm
and write it up.
------------
 as
#<word "as"> introduces brackets:
   Placing ].preposition on ends-here of p4
Asking whether there is a ] on p4 because of 'as'
   there is
There is a ].preposition on p4
Ignoring the #<bracket ].preposition > at p4 in front of #<word "as">
   because the left-boundary of the next segment hasn't been established yet.
Asking whether there is a [ on p4 because of 'as'
   no, there isn't
 being
#<word "as"> introduces brackets:
   Placing preposition]. on ends-here of p5
   Placing preposition.[ on starts-here of p5
Asking whether there is a ] on p5 because of 'as'
   there is
There is a preposition]. on p5
Ignoring the #<bracket preposition]. > at p5 in front of #<word "being">
   because the left-boundary of the next segment hasn't been established yet.
Asking whether there is a [ on p5 because of 'as'
   there is
Setting the left segment boundary to p5
   because of the preposition.[ in front of #<word "being">

2/9/10
Yet again it dies for not recognizing proper-noun in elevate-head-edge-form-if-needed
the first time through. I re-evaluated it and it went right through.


3/1/10
Modifying /grammar/rules/brackets/judgements1 to let "very" and "few" to combine
just on the basis of brackets. (Could do it with rules, but hold off on anything
like that until there's some meaning involved.)
;; (d (rs-phrase-boundary (rule-set-for (word-named "few"))))


3/3/10
Another problem in scan. Added (assign-bracket number .[np) in /model/core/
numbers/object1 but not seeing any effect, which suggests that something
is being skipped over.

(trace-brackets)
(trace-network )
(p " has 25 diploid chromosomes and ")

Scanned "25" at p2
Asking whether there is a ] on p2 because of '25'
   no, there isn't
There is no close bracket at p2
Asking whether there is a [ on p2 because of '25'
   no, there isn't
Doing any word-level FSAs for #<word "25"> at p2

Doing word-level actions on "25" at p2
 ;; :actions-on-word -- called from word-level-actions 
 ;; in drivers/chart/psp/scan3

"25" is unknown, looking for property-based terminal edges
[install] "25" does not have a rule set
installed 1 edges over #<word "25">

Doing any edge-level FSAs for the #<edge1 2 digit-sequence 3>
  over #<word "25"> at p2 ;; :considering-edge-level-fsas
         ;; called from analyzers/FSA/edges1
 diploid
Scanned "diploid" at p3



|#
