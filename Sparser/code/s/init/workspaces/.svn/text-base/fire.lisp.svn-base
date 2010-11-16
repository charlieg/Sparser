;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(SPARSER COMMON-LISP) -*-
;;; Copyright (c) 2007-2010 BBNT Solutions LLC. All Rights Reserved
;;; $Id$

;; ---------- this file should -not- be loaded -----------------

          Fire -- "Free-text Information and Relation Extraction"
            name thanks to Alice Leung, 1/24/07

;;;     File:  "workspace"
;;;   Module:  fire;
;;;  version:  July 2010

;;  (load "~/ws/nlp/Sparser/code/s/init/scripts/fire.lisp")

;; brackets & sectioning only
;;  (load "~/ws/nlp/Sparser/code/s/init/scripts/no-grammar.lisp")

;; Initiated June 2007.

(in-package :sparser)

cd ws/nlp/Sparser/code/s/
grep XX **/*.lisp **/**/*.lisp **/**/**/*.lisp **/**/**/**/*.lisp **/**/**/**/**/*.lisp

(just-bracketing-setting)
(setq *readout-segments* t)

;; 6/10/10
(load "/Users/ddm/ws/nlp/Sparser/code/s/tools/treebank-reader.lisp")
(clear-treebank-tables)
(harness "/Users/ddm/ws/nlp/corpus/treebank/10s.txt")

(word-frequency-setting)
(initialize-word-frequency-data)
(f/wf "/Users/ddm/ws/nlp/corpus/Halar/extractedText/chapter12.txt") ;; 7/15/10
(f "/Users/ddm/ws/nlp/corpus/Halar/chap11/chap11-all.txt") ;; 6/9/10
(f "/Users/ddm/ws/projects/Vulcan/bio-chap12.txt")  ;; 4/20/10
(readout-frequency-table) 
;; Chap13: either close far further late twice thoroughly double
;; Chap12: again against become near nearly moreover nearby 
;;    neither nor two one ones enough via might toward
;;    gren meanwhile
;; Chap11: across during eventual four latter six ten almost
;;    hundreds thousands throughout enough again (already) second


;; 2/10, 3/12
(top-edges-setting/ddm)
(establish-version-of-next-terminal-to-use :pass-through-all-tokens/NL-buffer)
(trace-paragraphs)
(setq *trace-next-token* t)
(use-newline-fsa/paragraph)
(f "/Users/ddm/ws/nlp/corpus/mcl-msg-with-table.lisp")

;; 3/4/10
(top-edges-setting/ddm)   (fire-setting)
(load "~/ws/nlp/Sparser/code/s/grammar/model/sl/biology/verb.lisp")
;; Needs fix in a parenthesized exp with FSA running at both ends
;;   "(FIGURE 11.18)"
(f "/Users/ddm/ws/nlp/corpus/Halar/Cambell excerpts/62-elaborate-pathways.lisp")

;; INGL
(p "Later that day it made landfall near the Haitian town of Jacmel.")
(p "it remained at that intensity until landfall on the morning of September 1 near Cocodrie, Louisiana.")
(p "By landfall on Monday morning")

;; 3/4/10 example from inTTENSITY slide (was uppercase) ///weak verbs
(p "The Russian government admitted that significant amounts of nuclear material were stolen from a navy nuclear fuel storage facility in Murmansk.")

;; 2/18/10
(word-frequency-setting)
(f "/Users/ddm/ws/nlp/corpus/LarryHunterBioBook/BeingAlive.textsource")
(readout-frequency-table)

;; Extra characters there (at 98% through the document
(p "see John Maynard Smith & Ešrs Szathm‡ry,"


;; 2/10/10  Check for interaction with the period in fire mode
(p "This method simply uses function words and productive 
morphology plus a very small state machine.")


;; the "Purpose" section of a real Comander's Intent
(p "In order to break the current cycle of sectarian violence, we must set the conditions for the ISF to emerge as the dominant security, able to protect the population and provide security in a fair and impartial manner. The operation will be Iraqi-led with Coalition support. Much more than a military operation alone, it must include a combination of military, economic, and political actions")

Militarily, we must interdict accelerants of Baghdad sectarian violence emerging from the Southern Salah ad Din, eastern Diyala, and Western Anbar, exploiting recent successes in these areas to continue the transition to Iraqi security self-reliance and enhance the prospects for the reconciliation. A key will be our ability to neutralize VBIED and EFP networks.

Within Baghdad, we must move deliberately and maintain a robust, combined presence in each administrative district until we have firmly established Joint Security Stations manned by CF alongside ISF that are loyal to the GOI and can provide adequate protection for the population. Our operations must be deliberate, our goals achievable and sustainable. We will only be decisive when security is sustained over time with Iraqis fully in charge.

Economically, we must create a combination of near-term and long-term employment opportunities and improve basic services in order to generate economic growth in poor neighborhoods.

Politically, we must set benchmarks to address the dismantling of Shia militias, deal with de-Baathification, and move towards provincial and local elections.


(top-edges-setting/ddm)
;;10.2.6 Danio rerio
(defun dp ()
(p "Danio rerio, also known to tropical fish fans everywhere as the zebrafish, is a useful vertebrate model organism. It has a clear body and rapid generation time, in addition to a relatively small genome for a vertebrate. One of the reasons for the small size of the genome is that there are very few introns in zebrafish genes, another advantage for molecular biologists. D. rerio has 25 diploid chromosomes and a mitochondrial chromosome. Sequencing of the zebrafish genome is not complete of this writing, but its genome consists of approximately 1,700,000,000 nucleotides, and it may have as many as 37,900 genes. The model organism database is http://zfin.org."))


Many of the Army Corps-built levee failures were reported on
Monday, August 29, 2005, at various times throughout the
day. There were 28 reported levee failures in the first 24
hours[2] and over 50 were reported in the ensuing days. A breach
in the Industrial Canal, near the St. Bernard/Orleans parish
line, occurred at approximately 9:00 AM CST, the day Katrina
hit. Another breach in the Industrial Canal was reported a few
minutes later at Tennessee Street, as well as multiple failures
in the levee system, as well as a pump failure, in the Lower
Ninth Ward, near Florida Avenue.

(fire-setting)
 (p "an Iraqi girl who died on Jan. 17 in the Kurdish city of Sulaimaniya, had bird flu, Iraq's health minister said on Monday, despite the World Health Organisation (WHO) having initially ruled that out.")

  ;; if we start with "An", we end up in PNF and an error where something
  ;; if pulling the wrong field out


(f "~/ws/projects/VRP irad/transcript.text")

(defun trace-psi-operations () ;; (trace-psi-operations)
  (trace-psi)
  (trace-psi-construction)
  (trace-psi/find)
  (trace-bind-open-var))
(setq *do-strong-domain-modeling* t)
(trace-sdm&p)
(define-country "Switzerland" :adjective "Swiss")
(p "Swiss frog")

(trace-edges)
(trace-edge-multiplication)
SPARSER> (category-ids/rightward category::ones-number)
(335872)
SPARSER> (category-ids/leftward category::quantity)
NIL
SPARSER> (category-ids/leftward category::np-head)
(45 . 28)
SPARSER> (multiply-ids 335872 45)
#<PSR215  ones-number -> quantity / ___ np-head>
T



(f "~/ws/nlp/corpus/bird-flu/french-swans/ap.lisp")
(f "~/ws/nlp/corpus/bird-flu/french-swans/bbc.lisp")

;; from the MCCLL Newsletter July 2007.pdf (hand-typed)
(p "Regimental Combat Team 7 (RCT-7) deployed to Iraq as part of I Machine Expeditionary Force (MEF) (Forward) during Operation Iraqi Freedom (OIF) 05-07. Based at Camp Ripper, Al Asad, from January 2006 to February 2007, RCT-7 oversaw counterinsurgency operations of Marines, sailors and soldiers deployed in a vast expanse of territory in Western Al Anbar Province (referred to as the Denver Area of Operations) that was approximately the size of South Carolina. During its deployment, RCT-7 made great strides in gaining the confidence of local Iraqis in the region and developing working relationships with them and the Iraqi Security Forces (ISF).")


;; (switch-settings)
;; (top-edges-setting/ddm)
;; (fire-setting)
;; (ambush-setting)
;; (update-analysis-mode <new-mode>: :no-dm&p, :span-segments, :dm&p

*use-Segment-edges-as-segment-defaults*
;; is called in Trivially-span-current-segment to let us make a 'segment'
;; edge between the brackets when we're running in vanila PTS mode rather
;; than one of the special cases. 

;; in drivers;inits:sessions:globals
*new-dm&p*
 ; Used in i/r/s-make-the-rule to make additional form rules when the
 ; naming conventions within the ETS suggest the possibiity

*do-strong-domain-modeling*
*do-domain-modeling-and-population*

*infer-rewriting-form-rules*

;; another possible place for a hook is
Establish-version-of-Complete
;; which defaults to :psp and complete/psp which doesn't appear to
;; be defined, but with top-edges-setting/ddm it's set to
;; :ca/ha, which is Complete/Hugin

*trace-the-trace-calls*


;;--- for meta-.
Inititate-top-edges-protocol ;; drivers/chart/psp/scan3
SF-action/spanned-segment    ;; drivers/chart/psp/pts5
Move-to-forest-level ;; drivers/chart/psp/PPTT8
March-back-from-the-right/forest ;; drivers/chart/psp/march-forest3
sdm/analyze-segment ;;  analyzers/SDM&P/scan
reify-segment-head-as-a-category


;;;----------------
;;; traces &cetera
;;;----------------

(print-discourse-history)
(discourse-entry <category>)

instance# ( n , symbol-for-category )

;delete-polyword

(display-chart :style :all-edges)
(display-chart-brackets)
(display-bracketed-segments)
(display-current-segment)
(display-chart-edges (:from :to)

(setq *readout-segments* t)
(setq *trace-edge-creation* t)
(setq *trace-paired-punctuation* t)
(setq *trace-completion-hook* t)

(trace-fsas)
(trace-jfp-sections)

;; objects/traces/psp1
(trace-network) ;; for low-level scan
(trace-network-flow) ;; lower
(trace-brackets)

(trace-pnf)
(trace-segments)
(trace-treetops)
(trace-sdm&p)
(trace-ns-sequences)
(trace-edges) ;; = *parse-edges* + (trace-edge-creation) + (trace-edge-check)
(trace-treetops)
(trace-scan-patterns)

(trace-conjunction)
(trace-parentheses)

(trace-psi)
(trace-psi-construction)
(trace-referent-creation)
(trace-bind-open-var)

(no-Sparser-traces)
(defun no-Sparser-traces ()
  (untrace-fsas)
  (untrace-pnf)
  ;(untrace-jfp-sections)
  (untrace-network)
  (untrace-network-flow)
  (untrace-brackets)
  (untrace-segments)
  (untrace-treetops)
  (untrace-edges)
  (untrace-edge-multiplication)
  (untrace-treetops)
  (untrace-scan-patterns)
  (untrace-sdm&p)
  (untrace-ns-sequences)
  (untrace-conjunction)
  (untrace-parentheses)
  (untrace-psi)
  (untrace-psi-construction)
  (untrace-referent-creation)
  (untrace-bind-open-var)
  (setq *readout-segments* nil)
  (setq *trace-edge-creation* nil)
  (setq *trace-paired-punctuation* nil)
  (setq *trace-completion-hook* nil))
  

;; Issues

 "could" and other modals -- nothing is set to remember that they're out there
    and to absorb their meaning into the meaning of the head.
  The same sort of problem comes with "the following Xs" and the like, where we
    want to collect the items that follow (hopefully well delimited) and assign
    them to the category X and/or promote them to be the referent of that segment.

;; 7/6 Bug with handling of "could" -- probaby because it has a subtype
;;  in its referent

SPARSER> (word-named "could")
#<word "could">
SPARSER> (d *)
#<word "could"> is a structure of type WORD.  It has these slots:
 PLIST
    (:FUNCTION-WORD T :GRAMMAR-MODULE
     #<grammar-module *AUXILIARY-VERBS*> :FILE-LOCATION
     "/Users/ddm/ws/nlp/Sparser/code/s/init/../../../code/s/grammar/rules/words/aux-verbs.fasl")
 SYMBOL             WORD::|could|
 RULE-SET           #<rule-set for #<word "could">>
 PNAME              "could"
 MORPHOLOGY         NIL
 CAPITALIZATION     :LOWER-CASE
 CAPITALIZATION-VARIANTS  NIL
#<word "could">
SPARSER> (d (rule-set-for *))
#<rule-set for #<word "could">> is a structure of type RULE-SET.  It
has these slots:
 BACKPOINTER        #<word "could">
 SINGLE-TERM-REWRITES  (#<PSR95  could ->  "could">)
 RIGHT-LOOKING-IDS  NIL
 LEFT-LOOKING-IDS   NIL
 FSA                NIL
 PHRASE-BOUNDARY    #<brackets for #<word "could">>
 COMPLETION-ACTIONS  NIL
 PLIST              NIL
#<rule-set for #<word "could">>
SPARSER> (d (psr# 95))
#<PSR95  could ->  "could"> is a structure of type CFR.  It has these
slots:
 SYMBOL             RULE::PSR95
 CATEGORY           #<mixin COULD>
 RHS                (#<word "could">)
 COMPLETION         NIL
 FORM               #<ref-category MODAL>
 RELATION           NIL
 REFERENT
    ((:HEAD #<mixin BE-ABLE-TO>) (:SUBTYPE #<mixin CONDITIONAL>))
 SCHEMA             NIL
 PLIST
    (:GRAMMAR-MODULE #<grammar-module *DEFAULT-SEMANTICS-FOR-VG*>
     :FILE-LOCATION
     "/Users/ddm/ws/nlp/Sparser/code/s/init/../../../code/s/grammar/rules/syntax/modals.fasl")
#<PSR95  could ->  "could">

;; in Ref/subtype, after we've instantiated the referent of "could"
;;   in Ref/head by calling (find-or-make-psi-for-base-category head)
;;   where 'head' is the mixin-category be-able-to, the referent prints
;;   as #<psi be-able-to 1>
;; Hmmm... doing a d on the top-lattice-position of the be-able-to
;;   mixin-category blew out the lisp!

----------- 2/16/08 -- Fire out of the box
SPARSER> (p "an Iraqi girl who died on Jan. 17 in the Kurdish city of Sulaimaniya, had bird flu, Iraq's health minister said on Monday, despite the World Health Organisation (WHO) having initially ruled that out.")
an Iraqi girl who died on Jan. 17 in the Kurdish city of Sulaimaniya, had bird flu, Iraq's health minister said on Monday, despite the World Health Organisation (WHO) having initially ruled that out.

                                 SOURCE-START
e0                               "an"
e1    COUNTRY                 2 "iraqi" 3
e2    PERSON                  3 "girl" 4
e3    OBLIQUE-PRONOUN         4 "who" 5
e4    DIE                     5 "died" 6
e18   TIME                    6 "on jan . 17" 10
e17   RELATIVE-LOCATION       10 "in the kurdish city" 14
e27   OF-NAME                 14 "of sulaimaniya" 16
e21                              "COMMA"
e22   HAVE                    17 "had" 18
                                 "bird"
                                 "flu"
e23                              "COMMA"
e26   COUNTRY                 21 "iraq ' s" 24
                                 "health"
                                 "minister"
                                 "said"
e32   TIME                    27 "on monday" 29
e31                              "COMMA"
                                 "despite"
e33                              "the"
e34   NAME                    32 "world health organisation" 35
e36   PARENTHESES             35 "( who )" 38
e37   HAVE                    38 "having" 39
                                 "initially"
                                 "ruled"
e38 e39                          "that" :: that, OBLIQUE-PRONOUN
e40                              "out"
e41                              "PERIOD"
                                 END-OF-SOURCE
:DONE-PRINTING

---- After (fire-setting)  // dies in new case over Sulaimaniya
SPARSER> (tts)
                                 SOURCE-START
e7    DIE                     1 "an iraqi girl who died" 6
e8 e9                            "on" :: on, SPATIAL-ORIENTATION
e14   DATE                    7 "jan . 17" 10
e15 e16                          "in" :: in, SPATIAL-ORIENTATION
e20   CITY                    11 "the kurdish city" 14
e21                              "of"
e22   NAME-WORD               15 "sulaimaniya" 16
                                 COMMA


;; 2/22/10 Delimit sentences [where should this go for real?]

(defun period-completion-action (period pos-before pos-after)
  (push-debug `(,pos-before ,pos-after))
  (break "We've got a period"))

(define-completion-action (word-named ".") 'hello 'period-completion-action)


