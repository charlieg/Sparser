;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1992,1993,1994  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "in progress"
;;;   Module:  "init;versions:v2.3:workspace:"
;;;  version:  2.3 September 29, 1994

(in-package :sparser)


(defun in-progress ())  ;; for meta-point

;(setup-for-sun)

;; 12/14 for SUN
#|(run-SUN-srdb-file "Moby:ddm:projects:SUN:srdb:tagged"
                     "Moby:ddm:projects:SUN:srdb:saved")

(load "Moby:ddm:projects:SUN:srdb:saved")
(declare-all-existing-individuals-permanent)
(resume-srdb-file "Moby:ddm:projects:SUN:srdb:tagged"
                  "Moby:ddm:projects:SUN:srdb:saved" ;; 1613 <-- off by 13
                  (+ 19660
                     2387
                     -30))
                     
|#
;(ccl:dialog-item-enable *smu/mark-it*)
;(ccl:dialog-item-enable *smu/next-phrase*)
;*file-pos/entry-just-started*
;*file-pos/entry-just-finished*


;; 12/13 for SUN
;(dump-smu-annotations-to-file "Moby:ddm:projects:SUN:output")
;(smu/readout-entire-discourse-history *standard-output*)


;; 12/12 for SUN


(defparameter *s1*
  "Moby:ddm:projects:SUN:srdb:tagged")

;; Patching references by Initialize-section-state
(defparameter *root-section-object* nil)
  ;; compensate for not loading all of [rule;context:article]
(defparameter *capitalization-is-uninformative* nil)
  ;; compensate for not loading any of the PNF files



;; 10/17
(lload "sl;Who's News:tests:originals")

;; 7/21, 8/2
;(dm&p-setting)
;(top-edges-setting/ddm)
;*switch-setting*
;(setq *pause-after-each-paragraph* t)
;(setq *pause-after-each-paragraph* nil)
;(reset)

;; 7/18
;(setq *ignore-capitalization* t)
;(setq *ignore-capitalization* nil)
;;  controls *capitalization-is-uninformative*

;; 7/14
;(setq *readout-segments* t)
;(setq *readout-segments* nil)
;(setq *inline-segment-readout* t)
;(setq *inline-segment-readout* nil)

;; 7/12
;(step-dm&p)
;(unstep-dm&p)
;(setq *do-domain-modeling-and-population* t)
;(setq *do-domain-modeling-and-population* nil)
;(setq *do-heuristic-segment-analysis* nil)
;(setq *use-segment-edges-as-segment-defaults* t)
;(setq *use-segment-edges-as-segment-defaults* nil)




;; 6/16
(setq *test-edge-view-coordination* t)
;(setq *test-edge-view-coordination* nil)
;; At about p1600 or so in PowerTalk in the workbench there is a goal
;; of scrolling back to a sequence-start, and its edge isn't in the
;; edge view.  This flag gates the break in Scroll-edges-view/top-edge


;(setq *break-on-duplicate-bracket-sources* t)
;(setq *break-on-duplicate-bracket-sources* nil)

(setq *break-on-new-categories-in-cap-seq* t)
;(setq *break-on-new-categories-in-cap-seq* nil)

;; 6/10
(defun hyper-moby-frequency (name-of-document-stream)
  (let ((*pause-between-articles* nil)
        (*display-word-stream* nil))
    (wf/ds (document-stream-named name-of-document-stream)))
  (establish-kind-of-chart-processing-to-do :new-toplevel-protocol))
;(hyper-moby-frequency '|PowerTalk|)
;(hyper-moby-frequency '|Reference|)

;; 6/9
;(setq *pause-after-each-paragraph* t)
;(setq *pause-after-each-paragraph* nil)


;; 5/9
(defun vinken ()
  (setup-for-dci/1989-wsj)
  (pp "<DOC>
<DOCNO>  891102-0193. </DOCNO>
<DD> = 891102 </DD>
<AN> 891102-0193. </AN>
<HL> Who's News:
@  Economist Newspaper Ltd. </HL>
<DD> 11/02/89 </DD>
<SO> WALL STREET JOURNAL (J) </SO>
<CO> WNEWS </CO>
<DATELINE> ECONOMIST NEWSPAPER Ltd. (London)  </DATELINE>
<TXT>
<p>
<s> Pierre Vinken, 61 years old, will join the board as a nonexecutive director Nov. 29. </s>
<s> Mr. Vinken is chairman of Elsevier N.V., the Dutch publishing group. </s>
</p>
</TXT>
</DOC>"))

;; 5/4
(defun dci ()
  (setup-for-dci/1989-wsj)
  (f "Sparser:corpus:WSJ:DCI format:166-193.word"))

;; 5/3
;(boeing)
;(install-after-paragraph-action 'print-paragraph-#)
;(remove-after-paragraph-action 'print-paragraph-#)
;(setq  *trace-sections* t)
;(setq  *trace-sections* nil)
;(setq *trace-paragraphs* t)
;(setq *trace-paragraphs* nil)

;; 5/2
;(setq *default-line-length* 68)
;(setq *adjust-text-to-fixed-line-length* t)
;(setq *adjust-text-to-fixed-line-length* nil)

(defun one-long-line ()
  (pp "In this era of frantic competition for ad dollars, a lot of revenue-desperate magazines are getting pretty cozy with advertisers -- fawning over them in articles and offering pages of advertorial space.")
  )

(defun several-long-lines ()
  (pp "In this era of frantic competition for ad dollars, a lot of revenue-desperate magazines are getting pretty cozy with advertisers -- fawning over them in articles and offering pages of advertorial space.
So can a magazine survive by downright thumbing its nose at major advertisers?
Garbage magazine, billed as \"The Practical Journal for the Environment,\" is about to find out.
Founded by Brooklyn, N.Y., publishing entrepreneur Patricia Poore, Garbage made its debut this fall with the promise to give consumers the straight scoop on the U.S. waste crisis.
"))

(defun several-long-lines-with-extra-lines ()
  (pp "In this era of frantic competition for ad dollars, a lot of revenue-desperate magazines are getting pretty cozy with advertisers -- fawning over them in articles and offering pages of advertorial space.
So can a magazine survive by downright thumbing its nose at major advertisers?


Garbage magazine, billed as \"The Practical Journal for the Environment,\" is about to find out.

Founded by Brooklyn, N.Y., publishing entrepreneur Patricia Poore, Garbage made its debut this fall with the promise to give consumers the straight scoop on the U.S. waste crisis.


"))


;; 3/28
;(setq *do-domain-modeling-and-population* t)
;(setq *do-domain-modeling-and-population* nil)
;(setq *trace-DM&P* t)
;(setq *trace-DM&P* nil)
;(debris-analysis-setting)
;(top-edges-setting)

(defun fire ()
;; Fire ravages London cinema
;; London -- 
  (pp "Fire swept through a private theater in central London
yesterday, killing at least seven people and injuring more 
than 20, fire officials said.  A Fire Brigade spokesman said
about 50 firefighters were at the four-story building, where
the cinema club occupied the top floor.  After three hours
the fire was under control, but not out.  It was not known
how many people were in the building at the time of the fire.  
The cinema was a small private club showing pornographic files,
according to initial reports."))  ;; (Reuters)


;; 3/21 -- titles re. "chief executive" vs. "chief executive officer"
;;  needs either a new analysis not based on polywords or polywords
;;  need to allow multiple rules:
#|(defparameter *polyword-routine*
                :multiple-completions
                ;; :single-completions
                )  |#

;; testing workbench modes 2/28...
;(setq *current-wb-subview-mode* :nothing)
;(setq *current-wb-subview-mode* :edges)

;; for getting through 9/17/92
;(setq *break-on-pattern-outside-coverage?* t)
;(setq *break-on-pattern-outside-coverage?* nil)

;; for "President Bush ... the president"
;(setq *ignore-out-of-pattern-dereferencing* t)
;(setq *ignore-out-of-pattern-dereferencing* nil)

;(install-sparser-menu)
;(menu-install *sparser-menu*)
;(menu-deinstall *sparser-menu*)
;(install-Sparser-menu)
;(launch-the-workbench)
;(launch-the-Autodefine-tableau)
;(setup-autodef-view)
;(point-string *)
;(load "Moby:Applications:MCL 2.0:Interface Tools:make-ift.lisp")
;(ift::load-ift)

;(install-after-paragraph-action 'display-segments-in-paragraph)
;(remove-after-paragraph-action 'display-segments-in-paragraph)

;; the Figure header introduction is looping, guessing its an interaction
;; with the para-marker before it and PNF
#|(set-traces-hook 988 '(*trace-network*
                       *trace-fsas*))
(turn-off-traces-hook)
|#
;; 1/13
(defun newton ()
  (use-Blank-line-NL-fsa)
  (f "Sparser:corpus:Apple:Newton Toolkit"))

;; 1/12
(defun newton/frequency ()
  (establish-kind-of-chart-processing-to-do :just-do-terminals)
  (setup-for-typed/no-headers)
  (f "Sparser:corpus:Apple:Newton Toolkit")
  (establish-kind-of-chart-processing-to-do :new-toplevel-protocol))

;; 1/11
;(setq *display-text-to-special-window* t)
;(setq *display-text-to-special-window* nil)
;(establish-version-of-look-at-terminal :record-word-frequency)
;(establish-version-of-look-at-terminal :no-op)
;(establish-kind-of-chart-processing-to-do :just-do-terminals)
;(establish-kind-of-chart-processing-to-do :new-toplevel-protocol)

;; 1/11
(defun p/br (s)
  (pp s)
  (display-bracketed-segments))

;; (p/br "(J), page b1")
;;   the comma should stand by itself. Consider timing problem
;;   with processing of the parenthesis

;; 1/6
;(setq  *no-referent-calculations* t)
;(setq  *no-referent-calculations* nil)
;;  this isn't thoroughly enough implemented -- kills conjunction heuristic

;(setq *end-PNF-early* t)
;(setq *end-PNF-early* nil)

;; 1/11
(defun b/da ()
  (setup-for-typed/no-headers)
    ;; since this is a copied djns article and doesn't have
    ;; linefeeds
  (f *article*))

;; 12/31, 1/3
(defun b ()
  (use-stack-sensitive-Newline-FSA)
  (initialize-NL-position-stack)
  (pp
"HL        AIRLINES (AIR)
       *  BANKRUPTCIES (BCY)
TX           There's just no pleasing some people; ask Eastern
          Airlines.
             Its promotion promising 100% refunds to dissatisfied
          full-fare passengers has spawned some creative complaining."))
;;
;; for testing NL routines that deduce indentation and paragraphing,
;; See Draw-paragraphing-conclusions


;; 12/30
(defun s ()
  (setup-for-typed/no-headers)
  (f "tipster;JV corpus:0368.372"))
;; a known text with sgml and simple indentation with double spacing
;;   dies instantly with wrong number of args w/in Start-document-start-section

;; 12/30
(defun fw (p)
  (setup-for-DJNS/1990-91)
  (f p))

;(fw "feb0;WSJ021.TXT")
;;  waiting on paragraph operations.
;;  Dies on "NL After Mr. Kennedy", where the preposition needs to
;;   be appreciated as such. 



#|(define-document-stream 'test1
    :file-list '( "feb0;WSJ002.TXT" )
    :style-name 'Dow-Jones-New-Service/1990-91 )  |#
;; 12/28 -- trivial test of running document streams.
;;   Stubs on accessing time from the AN, and on interning a real
;;   article with a switch to a known article object once the AN
;;   information becomes available. 
;; (setq ds *)
;; (analyze-document-stream ds)
;; Stubs return nil in Find-djns-assession-number-in-region
;;  and Redo-current-article-as-djns


;(pp "and")
;  11/24 calls beyond eos and introduces brackets

;(pp *long-string*)
; 11/24 mine it for needed brackets once their display is
;   sorted out


;(p "<SO>     Copyright (c) 1990 Kyodo News Service  </SO>")
; 11/6  calls beyond eos
; 11/24  needs a company out of "Kyodo News Service" in order for the
;   analysis to go through.



;;---------------------------------- old stuff
;;;-------------------------
;;; stuff under development
;;;-------------------------

;;---- 11/10 @ CRL

(defparameter *tipster-corpus-directory* "corpus;Tipster:")

(defun tip (filename-as-number-string)
  (let ((filename (concatenate 'string
                               *tipster-corpus-directory*
                               filename-as-number-string)))
    (f filename)))

;;--- outfile
;(lload "interface;save run:loader")


;;---------------------------------
;;------------ before being at CRL

(defparameter *tipster-corpus-directory* "corpus;Tipster:")

(defun uc ()
  (f "tipster tests;Union Carbide/2d tipster format"))

(defun wsj1 ()
  (f "Who's News DCI;891102-0192"))
(defun wsj2 ()
  (f "Who's News DCI;891102-0193"))

(defun sg ()  ;; for testing Tipster SGML
  (f "tipster tests;0368.372") )

;(f "tipster tests;hacked yoshinoya")
;(f "tipster tests;thrifts.doc")

(defun t1 ()  ;;for testing SGML tags
  (p "<s>\"Clearly, we were shot in the back . . . as we battled 
to protect the taxpayers,\" said William Black, acting 
district counsel for the San Francisco region of 
thrift regulators. </s>"))

(defun t2 ()
  (p "
<so> WALL STREET JOURNAL (J) </so>
"))

;;------------- AssetNet

(defun moby ()
  (f "corpus;earnings reports:analysts pull from Desktop Data"))

