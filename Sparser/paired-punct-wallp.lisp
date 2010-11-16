
(trace-network)
(trace-sections)

sparser> (p "can be \"called back\" to the cell cycle")

Scanned "source-start" at p0
Doing any word-level FSAs for #<word source-start> at p0
Doing word-level actions on "" at p0
Installing any terminal edges over the known word #<word source-start>
[install] "" has a rule set
no edges installed over #<word source-start>
#<word source-start> introduces brackets:
   Placing phrase.[ on starts-here of p1
Asking whether there is a ] on p1 because of ''
   no, there isn't
There is no close bracket at p1
Asking whether there is a [ on p1 because of ''
   there is
Setting the left segment boundary to p1
   because of the phrase.[ in front of nil
can
Scanned "can" at p1
#<word "can"> introduces brackets:
   Placing ].verb on ends-here of p1
   Placing .[modal on starts-here of p1
Asking whether there is a ] on p1 because of 'can'
   there is
There is a ].verb on p1
Segment started at p1 ended at p1 by #<bracket ].verb >
Post-scan characterization of segment between p1 and p1: null-span
No further actions on the segment between p1 and p1
Returning to the word level at p1 from a null span
Asking whether there is a [ on p1 because of 'can'
   there is
Setting the left segment boundary to p1
   because of the .[modal in front of #<word "can">
Doing any word-level FSAs for #<word "can"> at p1
Doing word-level actions on "can" at p1
Installing any terminal edges over the known word #<word "can">
[install] "can" has a rule set
"can" is a literal in some rule/s
"can" is rewritten by 1 rules
Completing #<edge1 1 can 2>
installed 2 edges over #<word "can">
#<ref-category modal> does not introduce any brackets
Doing any edge-level FSAs associated with any of
   (#<edge0 1 "can" 2> #<edge1 1 can 2>)
  over #<word "can"> at p1
#<word "can"> does not introduce any brackets
Asking whether there is a ] on p2 because of 'can'
   no, there isn't
There is no close bracket at p2
Asking whether there is a [ on p2 because of 'can'
   no, there isn't
#<ref-category modal> does not introduce any brackets
 be
Scanned "be" at p2
#<word "be"> introduces brackets:
   Placing ].verb on ends-here of p2
   Placing .[verb on starts-here of p2
Asking whether there is a ] on p2 because of 'be'
   there is
There is a ].verb on p2
].verb does not end the segment at p2
Asking whether there is a [ on p2 because of 'be'
   there is
Ignoring the #<bracket .[verb > at p2 in front of be
   because the left boundary is already in place at p1
Doing any word-level FSAs for #<word "be"> at p2
Doing word-level actions on "be" at p2
Installing any terminal edges over the known word #<word "be">
[install] "be" has a rule set
"be" is rewritten by 1 rules
Completing #<edge2 2 be 3>
installed 1 edges over #<word "be">
#<ref-category verb> does not introduce any brackets
Doing any edge-level FSAs for the #<edge2 2 be 3>
  over #<word "be"> at p2
#<word "be"> introduces brackets:
   Placing aux]. on ends-here of p3
Asking whether there is a ] on p3 because of 'be'
   there is
There is a aux]. on p3
aux]. does not end the segment at p3
Asking whether there is a [ on p3 because of 'be'
   no, there isn't
#<ref-category verb> does not introduce any brackets
 "
Scanned "double-quote" at p3
#<word double-quote> introduces brackets:
   Placing ].phrase on ends-here of p3
Asking whether there is a ] on p3 because of '"'
   there is
There is a ].phrase on p3
Segment started at p1 ended at p3 by #<bracket ].phrase >
Post-scan characterization of segment between p1 and p3: all-contiguous-edges
Completing #<edge3 1 can 3>
Finished running the phrase structure rules over the
  segment between p1 and p3
Segment "can be" extends, scanning the next segment starting at p3
No further actions on the segment between p1 and p3
Figuring out what to do at p3
   which has the status ]-from-word-after-checked
Asking whether there is a [ on p3 because of '"'
   no, there isn't
Doing any word-level FSAs for #<word double-quote> at p3
Doing word-level actions on """ at p3
Installing any terminal edges over the known word #<word double-quote>
[install] """ has a rule set
no edges installed over #<word double-quote>
#<word double-quote> introduces brackets:
   Placing phrase.[ on starts-here of p4
Asking whether there is a ] on p4 because of '"'
   no, there isn't
There is no close bracket at p4
Asking whether there is a [ on p4 because of '"'
   there is
Setting the left segment boundary to p4
   because of the phrase.[ in front of nil
called
Scanned "called" at p4
#<word "called"> introduces brackets:
   Placing ].verb on ends-here of p4
   Placing .[verb on starts-here of p4
Asking whether there is a ] on p4 because of 'called'
   there is
There is a ].verb on p4
Segment started at p4 ended at p4 by #<bracket ].verb >
Post-scan characterization of segment between p4 and p4: null-span
No further actions on the segment between p4 and p4
Returning to the word level at p4 from a null span
Asking whether there is a [ on p4 because of 'called'
   there is
Setting the left segment boundary to p4
   because of the .[verb in front of #<word "called">
Doing any word-level FSAs for #<word "called"> at p4
Doing word-level actions on "called" at p4
Installing any terminal edges over the known word #<word "called">
[install] "called" has a rule set
no edges installed over #<word "called">
#<word "called"> introduces brackets:
   Placing mvb]. on ends-here of p5
   Placing mvb.[ on starts-here of p5
Asking whether there is a ] on p5 because of 'called'
   there is
There is a mvb]. on p5
Segment started at p4 ended at p5 by #<bracket mvb]. >
Post-scan characterization of segment between p4 and p5: no-edges
Segment "called" does not extend
    No edge ending at p5
No further actions on the segment between p4 and p5
Moving to the forest-level starting back from p5 - empty-segment-scanned
    but *do-forest-level* is off
Figuring out what to do at p5
   which has the status ]-from-prior-word-checked
Asking whether there is a [ on p5 because of 'called'
   there is
Setting the left segment boundary to p5
   because of the mvb.[ in front of nil
 back
Scanned "back" at p5
#<word "back"> introduces brackets:
   Placing .[np on starts-here of p5
Asking whether there is a ] on p5 because of 'back'
   no, there isn't
There is no close bracket at p5
Asking whether there is a [ on p5 because of 'back'
   there is
Ignoring the #<bracket .[np > at p5 in front of back
   because the left boundary is already in place at p5
Doing any word-level FSAs for #<word "back"> at p5
Doing word-level actions on "back" at p5
Installing any terminal edges over the known word #<word "back">
[install] "back" has a rule set
"back" is rewritten by 1 rules
Completing #<edge4 5 direction 6>
installed 1 edges over #<word "back">
#<ref-category noun> does not introduce any brackets
Doing any edge-level FSAs for the #<edge4 5 direction 6>
  over #<word "back"> at p5
#<word "back"> does not introduce any brackets
Asking whether there is a ] on p6 because of 'back'
   no, there isn't
There is no close bracket at p6
Asking whether there is a [ on p6 because of 'back'
   no, there isn't
#<ref-category noun> does not introduce any brackets
"
Scanned "double-quote" at p6
#<word double-quote> introduces brackets:
   Placing ].phrase on ends-here of p6
Asking whether there is a ] on p6 because of '"'
   there is
There is a ].phrase on p6
Segment started at p5 ended at p6 by #<bracket ].phrase >
Post-scan characterization of segment between p5 and p6: one-edge-over-entire-segment
Segment "back" extends, scanning the next segment starting at p6
No further actions on the segment between p5 and p6
Figuring out what to do at p6
   which has the status ]-from-word-after-checked
Asking whether there is a [ on p6 because of '"'
   no, there isn't
Doing any word-level FSAs for #<word double-quote> at p6
Doing word-level actions on """ at p6
Looking at the interior of quotation-marks between p4 and p6


" ;; block extra quotation mark so the font changes back

;; sparser> (display-chart)
 0 source-start 1 "can" 2 "be" 3 double-quote 4 "called" 5 "back" 6 double-quote

sparser> (tts)
                                 source-start
e3    can                     1 "can be" 3
                                 double-quote
                                 "called"
e4    direction               5 "back" 6
                                 double-quote


nil fell through a etypecase form.  The valid cases were word,

sparser> (p "can be \"called back\" to the cell cycle")

Scanned "source-start" at p0
Doing any word-level FSAs for #<word source-start> at p0
Doing word-level actions on "" at p0
Installing any terminal edges over the known word #<word source-start>
[install] "" has a rule set
no edges installed over #<word source-start>
#<word source-start> introduces brackets:
   Placing phrase.[ on starts-here of p1
Asking whether there is a ] on p1 because of ''
   no, there isn't
There is no close bracket at p1
Asking whether there is a [ on p1 because of ''
   there is
Setting the left segment boundary to p1
   because of the phrase.[ in front of nil
can
Scanned "can" at p1
#<word "can"> introduces brackets:
   Placing ].verb on ends-here of p1
   Placing .[modal on starts-here of p1
Asking whether there is a ] on p1 because of 'can'
   there is
There is a ].verb on p1
Segment started at p1 ended at p1 by #<bracket ].verb >
Post-scan characterization of segment between p1 and p1: null-span
No further actions on the segment between p1 and p1
Returning to the word level at p1 from a null span
Asking whether there is a [ on p1 because of 'can'
   there is
Setting the left segment boundary to p1
   because of the .[modal in front of #<word "can">
Doing any word-level FSAs for #<word "can"> at p1
Doing word-level actions on "can" at p1
Installing any terminal edges over the known word #<word "can">
[install] "can" has a rule set
"can" is a literal in some rule/s
"can" is rewritten by 1 rules
Completing #<edge1 1 can 2>
installed 2 edges over #<word "can">
#<ref-category modal> does not introduce any brackets
Doing any edge-level FSAs associated with any of
   (#<edge0 1 "can" 2> #<edge1 1 can 2>)
  over #<word "can"> at p1
#<word "can"> does not introduce any brackets
Asking whether there is a ] on p2 because of 'can'
   no, there isn't
There is no close bracket at p2
Asking whether there is a [ on p2 because of 'can'
   no, there isn't
#<ref-category modal> does not introduce any brackets
 be
Scanned "be" at p2
#<word "be"> introduces brackets:
   Placing ].verb on ends-here of p2
   Placing .[verb on starts-here of p2
Asking whether there is a ] on p2 because of 'be'
   there is
There is a ].verb on p2
].verb does not end the segment at p2
Asking whether there is a [ on p2 because of 'be'
   there is
Ignoring the #<bracket .[verb > at p2 in front of be
   because the left boundary is already in place at p1
Doing any word-level FSAs for #<word "be"> at p2
Doing word-level actions on "be" at p2
Installing any terminal edges over the known word #<word "be">
[install] "be" has a rule set
"be" is rewritten by 1 rules
Completing #<edge2 2 be 3>
installed 1 edges over #<word "be">
#<ref-category verb> does not introduce any brackets
Doing any edge-level FSAs for the #<edge2 2 be 3>
  over #<word "be"> at p2
#<word "be"> introduces brackets:
   Placing aux]. on ends-here of p3
Asking whether there is a ] on p3 because of 'be'
   there is
There is a aux]. on p3
aux]. does not end the segment at p3
Asking whether there is a [ on p3 because of 'be'
   no, there isn't
#<ref-category verb> does not introduce any brackets
 "
Scanned "double-quote" at p3
#<word double-quote> introduces brackets:
   Placing ].phrase on ends-here of p3
Asking whether there is a ] on p3 because of '"'
   there is
There is a ].phrase on p3
Segment started at p1 ended at p3 by #<bracket ].phrase >
Post-scan characterization of segment between p1 and p3: all-contiguous-edges
Completing #<edge3 1 can 3>
Finished running the phrase structure rules over the
  segment between p1 and p3
Segment "can be" extends, scanning the next segment starting at p3
No further actions on the segment between p1 and p3
Figuring out what to do at p3
   which has the status ]-from-word-after-checked
Asking whether there is a [ on p3 because of '"'
   no, there isn't
Doing any word-level FSAs for #<word double-quote> at p3
Doing word-level actions on """ at p3
Installing any terminal edges over the known word #<word double-quote>
[install] """ has a rule set
no edges installed over #<word double-quote>
#<word double-quote> introduces brackets:
   Placing phrase.[ on starts-here of p4
Asking whether there is a ] on p4 because of '"'
   no, there isn't
There is no close bracket at p4
Asking whether there is a [ on p4 because of '"'
   there is
Setting the left segment boundary to p4
   because of the phrase.[ in front of nil
called
Scanned "called" at p4
#<word "called"> introduces brackets:
   Placing ].verb on ends-here of p4
   Placing .[verb on starts-here of p4
Asking whether there is a ] on p4 because of 'called'
   there is
There is a ].verb on p4
Segment started at p4 ended at p4 by #<bracket ].verb >
Post-scan characterization of segment between p4 and p4: null-span
No further actions on the segment between p4 and p4
Returning to the word level at p4 from a null span
Asking whether there is a [ on p4 because of 'called'
   there is
Setting the left segment boundary to p4
   because of the .[verb in front of #<word "called">
Doing any word-level FSAs for #<word "called"> at p4
Doing word-level actions on "called" at p4
Installing any terminal edges over the known word #<word "called">
[install] "called" has a rule set
no edges installed over #<word "called">
#<word "called"> introduces brackets:
   Placing mvb]. on ends-here of p5
   Placing mvb.[ on starts-here of p5
Asking whether there is a ] on p5 because of 'called'
   there is
There is a mvb]. on p5
Segment started at p4 ended at p5 by #<bracket mvb]. >
Post-scan characterization of segment between p4 and p5: no-edges
Segment "called" does not extend
    No edge ending at p5
No further actions on the segment between p4 and p5
Moving to the forest-level starting back from p5 - empty-segment-scanned
    but *do-forest-level* is off
Figuring out what to do at p5
   which has the status ]-from-prior-word-checked
Asking whether there is a [ on p5 because of 'called'
   there is
Setting the left segment boundary to p5
   because of the mvb.[ in front of nil
 back
Scanned "back" at p5
#<word "back"> introduces brackets:
   Placing .[np on starts-here of p5
Asking whether there is a ] on p5 because of 'back'
   no, there isn't
There is no close bracket at p5
Asking whether there is a [ on p5 because of 'back'
   there is
Ignoring the #<bracket .[np > at p5 in front of back
   because the left boundary is already in place at p5
Doing any word-level FSAs for #<word "back"> at p5
Doing word-level actions on "back" at p5
Installing any terminal edges over the known word #<word "back">
[install] "back" has a rule set
"back" is rewritten by 1 rules
Completing #<edge4 5 direction 6>
installed 1 edges over #<word "back">
#<ref-category noun> does not introduce any brackets
Doing any edge-level FSAs for the #<edge4 5 direction 6>
  over #<word "back"> at p5
#<word "back"> does not introduce any brackets
Asking whether there is a ] on p6 because of 'back'
   no, there isn't
There is no close bracket at p6
Asking whether there is a [ on p6 because of 'back'
   no, there isn't
#<ref-category noun> does not introduce any brackets
"
Scanned "double-quote" at p6
#<word double-quote> introduces brackets:
   Placing ].phrase on ends-here of p6
Asking whether there is a ] on p6 because of '"'
   there is
There is a ].phrase on p6
Segment started at p5 ended at p6 by #<bracket ].phrase >
Post-scan characterization of segment between p5 and p6: one-edge-over-entire-segment
Segment "back" extends, scanning the next segment starting at p6
No further actions on the segment between p5 and p6
Figuring out what to do at p6
   which has the status ]-from-word-after-checked
Asking whether there is a [ on p6 because of '"'
   no, there isn't
Doing any word-level FSAs for #<word double-quote> at p6
Doing word-level actions on """ at p6
Looking at the interior of quotation-marks between p4 and p6
; Evaluation aborted. "


sparser> (display-chart)
 0 source-start 1 "can" 2 "be" 3 double-quote 4 "called" 5 "back" 6 double-quote
nil
sparser> (tts)
                                 source-start
e3    can                     1 "can be" 3
                                 double-quote
                                 "called"
e4    direction               5 "back" 6
                                 double-quote
:done-printing


(or category referential-category mixin-category), cfr,
polyword, and individual.
   [Condition of type excl:case-failure]

Restarts:
 0: [retry] Retry SLIME REPL evaluation request.
 1: [abort] Return to SLIME's top level.
 2: [abort] Abort entirely from this (lisp) process.

Backtrace:
  0: (swank:invoke-slime-debugger #<excl:case-failure @ #x10e8962a>)
  1: ((:internal swank:swank-debugger-hook 1))
  2: ((:internal (:top-level-form "swank-backend.lisp" 22581) 0) #<Function swank-debugger-hook> #<Closure (:internal swank:swank-debugger-hook 1) @ #x10e8965a>)
  3: (swank-backend:call-with-debugger-hook #<Function swank-debugger-hook> #<Closure (:internal swank:swank-debugger-hook 1) @ #x10e8965a>)
  4: (swank:swank-debugger-hook #<excl:case-failure @ #x10e8962a> #<Function swank-debugger-hook>)
  5: (error excl:case-failure :name etypecase :datum nil ...)
  6: (plist-for nil)
  7: (let ((hook (when first-edge #))) (if hook (then (tr :paired-punct-hook hook) (if # # #)) (else (let # edge))))
      Locals:
        excl::x = (((hook (when first-edge #))) ..)
        pos-before-open = #<position3 3 """>
        pos-after-open = #<position4 4 "called">
        first-edge = #<word "called">
        layout = :contiguous-edges
        type = :quotation-marks
        pos-before-close = #<position6 6 """>
        pos-after-close = #<position7 7 "nil">

  8: (let ((layout (analyze-segment-layout pos-after-open pos-before-close)) (first-edge (right-treetop-at/edge pos-after-open))) ..)
  9: (do-paired-punctuation-interior :quotation-marks #<position3 3 "#1=""> #<position4 4 "called"> #<position6 6 "#1#"> #<position7 7 "nil">)
 10: (let ((pos-before-start-quote (car *pending-double-quote*)) (pos-after-start-quote (cdr *pending-double-quote*))) ..)
 11: (span-quotation #<position6 6 """> #<position7 7 "nil">)
      Locals:
        pos-before-end-quote = #<position6 6 """>
        pos-after-end-quote = #<position7 7 "nil">
 12: (check-quotation #<position6 6 """> #<position7 7 "nil">)
 13: (word-level-actions #<word double-quote> #<position6 6 """>)
 14: (introduce-terminal-edges #<word "back"> #<position5 5 "back"> #<position6 6 """>)
 15: (word-level-actions #<word "back"> #<position5 5 "back">)
 16: (word-level-actions #<word "called"> #<position4 4 "called">)
 17: (word-level-actions #<word double-quote> #<position3 3 """>)
 18: (march-back-from-the-right/segment)
 19: (march-back-from-the-right/segment)
 20: (introduce-terminal-edges #<word "be"> #<position2 2 "be"> #<position3 3 """>)
 21: (word-level-actions #<word "be"> #<position2 2 "be">)
 22: (introduce-terminal-edges #<word "can"> #<position1 1 "can"> #<position2 2 "be">)
 23: (word-level-actions #<word "can"> #<position1 1 "can">)
 24: (word-level-actions #<word source-start> #<position0 0 "">)
 25: (let () ..)
 26: (let ((#:g342398 chart-protocol)) ..)
 27: (let ((chart-protocol *kind-of-chart-processing-to-do*)) ..)
 28: (catch 'change-kind-of-chart-processing ..)
 29: (lookup-the-kind-of-chart-processing-to-do)
 30: (catch 'terminating-chart-processing (lookup-the-kind-of-chart-processing-to-do))
 31: (chart-based-analysis)
 32: (catch :analysis-core ..)
 33: (analysis-core)
 34: (pp "can be \"called back\" to the cell cycle")
 35: (p "can be \"called back\" to the cell cycle")
 36: (eval (p "can be \"called back\" to the cell cycle"))
 37: (swank::eval-region "(p \"can be \\"called back\\" to the cell cycle\")\n")
 38: ((:internal (:internal (:internal swank::repl-eval 0) 0) 0))
 39: (swank::track-package #<Closure (:internal (:internal # 0) 0) @ #x10f77f3a>)
 40: ((:internal (:internal swank::repl-eval 0) 0))
 41: (swank::call-with-retry-restart "Retry SLIME REPL evaluation request." #<Closure (:internal (:internal swank::repl-eval 0) 0) @ #x10f77f6a>)
 42: ((:internal swank::repl-eval 0))
 43: ((:internal (:top-level-form "swank-allegro.lisp" 2017) 0) #<Closure (:internal swank::repl-eval 0) @ #x10f77f9a>)
 44: (swank-backend:call-with-syntax-hooks #<Closure (:internal swank::repl-eval 0) @ #x10f77f9a>)
 45: (swank::call-with-buffer-syntax nil #<Closure (:internal swank::repl-eval 0) @ #x10f77f9a>)
 46: (swank::repl-eval "(p \"can be \\"called back\\" to the cell cycle\")\n")
 47: (swank:listener-eval "(p \"can be \\"called back\\" to the cell cycle\")\n")
 48: (eval (swank:listener-eval "(p \"can be \\"called back\\" to the cell cycle\")\n"))
 49: (swank::eval-for-emacs (swank:listener-eval "(p \"can be \\"called back\\" to the cell cycle\")\n") "sparser" 66)
 50: (swank::process-requests nil)
 51: ((:internal swank::handle-requests 0))
 52: ((:internal (:top-level-form "swank-backend.lisp" 22581) 0) #<Function swank-debugger-hook> #<Closure (:internal swank::handle-requests 0) [nil] @ #x10f7804a>)
 53: (swank-backend:call-with-debugger-hook #<Function swank-debugger-hook> #<Closure (:internal swank::handle-requests 0) [nil] @ #x10f7804a>)
 54: ((:internal swank::call-with-connection 2))
 55: (swank::call-with-bindings ..)
 56: (swank::call-with-connection #<swank::connection @ #x10402012> #<Closure (:internal swank::handle-requests 0) [nil] @ #x10f7804a>)
 57: (swank::handle-requests #<swank::connection @ #x10402012>)
 58: (swank::repl-loop #<swank::connection @ #x10402012>)
 59: ((:internal (:internal swank::spawn-repl-thread 0) 0))
 --more--


=============================================
sparser> (p "dubbed the \"restriction point\" in mammalian cells")

Scanned "source-start" at p0
Doing any word-level FSAs for #<word source-start> at p0
Doing word-level actions on "" at p0
Installing any terminal edges over the known word #<word source-start>
[install] "" has a rule set
no edges installed over #<word source-start>
#<word source-start> introduces brackets:
   Placing phrase.[ on starts-here of p1
Asking whether there is a ] on p1 because of ''
   no, there isn't
There is no close bracket at p1
Asking whether there is a [ on p1 because of ''
   there is
Setting the left segment boundary to p1
   because of the phrase.[ in front of nil
dubbed
Scanned "dubbed" at p1
#<word "dubbed"> introduces brackets:
   Placing ].verb on ends-here of p1
   Placing .[verb on starts-here of p1
Asking whether there is a ] on p1 because of 'dubbed'
   there is
There is a ].verb on p1
Segment started at p1 ended at p1 by #<bracket ].verb >
Post-scan characterization of segment between p1 and p1: null-span
No further actions on the segment between p1 and p1
Returning to the word level at p1 from a null span
Asking whether there is a [ on p1 because of 'dubbed'
   there is
Setting the left segment boundary to p1
   because of the .[verb in front of #<word "dubbed">
Doing any word-level FSAs for #<word "dubbed"> at p1
Doing word-level actions on "dubbed" at p1
Installing any terminal edges over the known word #<word "dubbed">
[install] "dubbed" has a rule set
no edges installed over #<word "dubbed">
#<word "dubbed"> introduces brackets:
   Placing mvb]. on ends-here of p2
   Placing mvb.[ on starts-here of p2
Asking whether there is a ] on p2 because of 'dubbed'
   there is
There is a mvb]. on p2
Segment started at p1 ended at p2 by #<bracket mvb]. >
Post-scan characterization of segment between p1 and p2: no-edges
Segment "dubbed" does not extend
    No edge ending at p2
No further actions on the segment between p1 and p2
Moving to the forest-level starting back from p2 - empty-segment-scanned
    but *do-forest-level* is off
Figuring out what to do at p2
   which has the status ]-from-prior-word-checked
Asking whether there is a [ on p2 because of 'dubbed'
   there is
Setting the left segment boundary to p2
   because of the mvb.[ in front of nil
 the
Scanned "the" at p2
#<word "the"> introduces brackets:
   Placing ].phrase on ends-here of p2
   Placing .[article on starts-here of p2
Asking whether there is a ] on p2 because of 'the'
   there is
There is a ].phrase on p2
Segment started at p2 ended at p2 by #<bracket ].phrase >
Post-scan characterization of segment between p2 and p2: null-span
No further actions on the segment between p2 and p2
Returning to the word level at p2 from a null span
Asking whether there is a [ on p2 because of 'the'
   there is
Setting the left segment boundary to p2
   because of the .[article in front of #<word "the">
Doing any word-level FSAs for #<word "the"> at p2
 "
Scanned "double-quote" at p3
Doing word-level actions on "the" at p2
Installing any terminal edges over the known word #<word "the">
[install] "the" has a rule set
"the" is a literal in some rule/s
installed 1 edges over #<word "the">
Doing any edge-level FSAs for the #<edge0 2 "the" 3>
  over #<word "the"> at p2
#<word "the"> does not introduce any brackets
Asking whether there is a ] on p3 because of 'the'
   no, there isn't
There is no close bracket at p3
Asking whether there is a [ on p3 because of 'the'
   no, there isn't
#<word double-quote> introduces brackets:
   Placing ].phrase on ends-here of p3
Asking whether there is a ] on p3 because of '"'
   there is
There is a ].phrase on p3
Segment started at p2 ended at p3 by #<bracket ].phrase >
Post-scan characterization of segment between p2 and p3: one-edge-over-entire-segment
Segment "the" extends, scanning the next segment starting at p3
No further actions on the segment between p2 and p3
Figuring out what to do at p3
   which has the status ]-from-word-after-checked
Asking whether there is a [ on p3 because of '"'
   no, there isn't
Doing any word-level FSAs for #<word double-quote> at p3
Doing word-level actions on """ at p3
Installing any terminal edges over the known word #<word double-quote>
[install] """ has a rule set
no edges installed over #<word double-quote>
#<word double-quote> introduces brackets:
   Placing phrase.[ on starts-here of p4
Asking whether there is a ] on p4 because of '"'
   no, there isn't
There is no close bracket at p4
Asking whether there is a [ on p4 because of '"'
   there is
Setting the left segment boundary to p4
   because of the phrase.[ in front of nil
restriction
Scanned "restriction" at p4
Asking whether there is a ] on p4 because of 'restriction'
   no, there isn't
There is no close bracket at p4
Asking whether there is a [ on p4 because of 'restriction'
   no, there isn't
Doing any word-level FSAs for #<word "restriction"> at p4
Doing word-level actions on "restriction" at p4
"restriction" is unknown, looking for property-based terminal edges
[install] "restriction" does not have a rule set
no edges installed over #<word "restriction">
Asking whether there is a ] on p5 because of 'restriction'
   no, there isn't
There is no close bracket at p5
Asking whether there is a [ on p5 because of 'restriction'
   no, there isn't
 point
Scanned "point" at p5
Asking whether there is a ] on p5 because of 'point'
   no, there isn't
There is no close bracket at p5
Asking whether there is a [ on p5 because of 'point'
   no, there isn't
Doing any word-level FSAs for #<word "point"> at p5
Doing word-level actions on "point" at p5
"point" is unknown, looking for property-based terminal edges
[install] "point" does not have a rule set
no edges installed over #<word "point">
Asking whether there is a ] on p6 because of 'point'
   no, there isn't
There is no close bracket at p6
Asking whether there is a [ on p6 because of 'point'
   no, there isn't
"
Scanned "double-quote" at p6
#<word double-quote> introduces brackets:
   Placing ].phrase on ends-here of p6
Asking whether there is a ] on p6 because of '"'
   there is
There is a ].phrase on p6
Segment started at p4 ended at p6 by #<bracket ].phrase >
Post-scan characterization of segment between p4 and p6: no-edges
Segment "restriction point" does not extend
    No edge ending at p6
No further actions on the segment between p4 and p6
Moving to the forest-level starting back from p6 - empty-segment-scanned
    but *do-forest-level* is off
Figuring out what to do at p6
   which has the status ]-from-word-after-checked
Asking whether there is a [ on p6 because of '"'
   no, there isn't
Doing any word-level FSAs for #<word double-quote> at p6
Doing word-level actions on """ at p6
Looking at the interior of quotation-marks between p4 and p6
Completing #<edge1 3 quotation 7>
Installing any terminal edges over the known word #<word double-quote>
[install] """ is already spanned
#<word double-quote> introduces brackets:
   Placing phrase.[ on starts-here of p7
Asking whether there is a ] on p7 because of '"'
   no, there isn't
There is no close bracket at p7
Asking whether there is a [ on p7 because of '"'
   there is
Setting the left segment boundary to p7
   because of the phrase.[ in front of nil
 in
Scanned "in" at p7
#<word "in"> introduces brackets:
   Placing ].treetop on ends-here of p7
Asking whether there is a ] on p7 because of 'in'
   there is
There is a ].treetop on p7
Segment started at p7 ended at p7 by #<bracket ].treetop >
Post-scan characterization of segment between p7 and p7: null-span
No further actions on the segment between p7 and p7
Returning to the word level at p7 from a null span
Asking whether there is a [ on p7 because of 'in'
   no, there isn't
Doing any word-level FSAs for #<word "in"> at p7
 mammalian
Scanned "mammalian" at p8
Doing word-level actions on "in" at p7
Installing any terminal edges over the known word #<word "in">
[install] "in" has a rule set
[install] "in" has variations that are capitalized
[install] The actual capitalization of p7 is lower-case
"in" is a literal in some rule/s
"in" is rewritten by 1 rules
Completing #<edge3 7 spatial-orientation 8>
installed 2 edges over #<word "in">
Doing any edge-level FSAs associated with any of
   (#<edge2 7 "in" 8> #<edge3 7 spatial-orientation 8>)
  over #<word "in"> at p7
#<word "in"> introduces brackets:
   Placing treetop.[ on starts-here of p8
Asking whether there is a ] on p8 because of 'in'
   no, there isn't
There is no close bracket at p8
Asking whether there is a [ on p8 because of 'in'
   there is
Setting the left segment boundary to p8
   because of the treetop.[ in front of #<word "mammalian">
Asking whether there is a ] on p8 because of 'mammalian'
   no, there isn't
There is no close bracket at p8
Asking whether there is a [ on p8 because of 'mammalian'
   no, there isn't
Doing any word-level FSAs for #<word "mammalian"> at p8
Doing word-level actions on "mammalian" at p8
"mammalian" is unknown, looking for property-based terminal edges
[install] "mammalian" does not have a rule set
no edges installed over #<word "mammalian">
Asking whether there is a ] on p9 because of 'mammalian'
   no, there isn't
There is no close bracket at p9
Asking whether there is a [ on p9 because of 'mammalian'
   no, there isn't
 cells
Scanned "cells" at p9
Asking whether there is a ] on p9 because of 'cells'
   no, there isn't
There is no close bracket at p9
Asking whether there is a [ on p9 because of 'cells'
   no, there isn't
Doing any word-level FSAs for #<word "cells"> at p9
Doing word-level actions on "cells" at p9
"cells" is unknown, looking for property-based terminal edges
[install] "cells" does not have a rule set
no edges installed over #<word "cells">
Asking whether there is a ] on p10 because of 'cells'
   no, there isn't
There is no close bracket at p10
Asking whether there is a [ on p10 because of 'cells'
   no, there isn't

Scanned "end-of-source" at p10
#<word end-of-source> introduces brackets:
   Placing ].phrase on ends-here of p10
Asking whether there is a ] on p10 because of ''
   there is
There is a ].phrase on p10
Segment started at p8 ended at p10 by #<bracket ].phrase >
Post-scan characterization of segment between p8 and p10: no-edges
Segment "mammalian cells" does not extend
    No edge ending at p10
No further actions on the segment between p8 and p10
Moving to the forest-level starting back from p10 - empty-segment-scanned
    but *do-forest-level* is off
Figuring out what to do at p10
   which has the status ]-from-word-after-checked
Chart-level processing terminated


                                 source-start
                                 "dubbed"
e0                               "the"
e1    quotation               3 "\" restriction point \"" 7
e2 e3                            "in" :: in, spatial-orientation
                                 "mammalian"
                                 "cells"
                                 end-of-source
:done-printing
sparser>   (display-chart)
 0 source-start 1 "dubbed" 2 "the" 3 double-quote 4 "restriction" 5 "point" 6 double-quote 7 "in" 8 "mammalian" 9 "cells" 10 end-of-source


















======================================
(trace-network-flow)

sparser> (p "the \"restriction point\" in")
[scan] Inititate-top-edges-protocol

Scanned "source-start" at p0
[scan] check-word-level-fsa-trigger #<position0 0 "">
[scan] cwlft-cont #<position0 0 "">
Doing any word-level FSAs for #<word source-start> at p0
[scan] word-level-actions #<word source-start>
Doing word-level actions on "" at p0
[scan] introduce-terminal-edges #<word source-start>
Installing any terminal edges over the known word #<word source-start>
[install] "" has a rule set
no edges installed over #<word source-start>
[scan] introduce-right-side-brackets: "#<word source-start>"
[scan] introduce-trailing-brackets "#<word source-start>"
#<word source-start> introduces brackets:
   Placing phrase.[ on starts-here of p1
[scan] check-for-]-from-prior-word: p1
Asking whether there is a ] on p1 because of ''
   no, there isn't
There is no close bracket at p1
[scan] check-for-[-from-prior-word: p1
Asking whether there is a [ on p1 because of ''
   there is
[scan] adjudicate-new-open-bracket phrase.[
Setting the left segment boundary to p1
   because of the phrase.[ in front of nil
[scan] scan-next-pos #<position1 1 "nil">
the
Scanned "the" at p1
[scan] introduce-leading-brackets "the"
#<word "the"> introduces brackets:
   Placing ].phrase on ends-here of p1
   Placing .[article on starts-here of p1
[scan] check-for-]-from-word-after p1 "the"
[scan] Trailing-hidden-markup-check #<position1 1 "the">
[scan] Trailing-hidden-annotation-check #<position1 1 "the">
Asking whether there is a ] on p1 because of 'the'
   there is
There is a ].phrase on p1
[scan] bracket-ends-the-segment? ].phrase
Segment started at p1 ended at p1 by #<bracket ].phrase >
[scan] pts
Post-scan characterization of segment between p1 and p1: null-span
[scan] segment-finished: p1 to p1
[scan] return-to-scan-level-from-null-span: p1
No further actions on the segment between p1 and p1
Returning to the word level at p1 from a null span
[scan] check-for-[-from-word-after p1 "the"
[scan] check for end of source #<position1 1 "the">
Asking whether there is a [ on p1 because of 'the'
   there is
[scan] adjudicate-new-open-bracket .[article
Setting the left segment boundary to p1
   because of the .[article in front of #<word "the">
[scan] Leading-hidden-markup-check #<position1 1 "the">
[scan] scan-patterns check: p1
[scan] no whitespace at p1. Initiating scan-pattern check.
[scan] check-word-level-fsa-trigger #<position1 1 "the">
[scan] cwlft-cont #<position1 1 "the">
Doing any word-level FSAs for #<word "the"> at p1
 "
Scanned "double-quote" at p2
[scan] word-level-actions #<word "the">
Doing word-level actions on "the" at p1
[scan] introduce-terminal-edges #<word "the">
Installing any terminal edges over the known word #<word "the">
[install] "the" has a rule set
"the" is a literal in some rule/s
installed 1 edges over #<word "the">
[scan] Check-preterminal-edges #<position1 1 "the">
[scan] Introduce-leading-brackets-from-edge-form-labels #<position1 1 "the">
[scan] check-edge-fsa-trigger the at p1
Doing any edge-level FSAs for the #<edge0 1 "the" 2>
  over #<word "the"> at p1
[scan] introduce-right-side-brackets: "#<word "the">"
[scan] introduce-trailing-brackets "#<word "the">"
#<word "the"> does not introduce any brackets
[scan] check-for-]-from-prior-word: p2
Asking whether there is a ] on p2 because of 'the'
   no, there isn't
There is no close bracket at p2
[scan] check-for-[-from-prior-word: p2
Asking whether there is a [ on p2 because of 'the'
   no, there isn't
[scan] Introduce-trailing-brackets-from-edge-form-labels #<position2 2 """>
[scan] scan-next-pos #<position2 2 """>
[scan] introduce-leading-brackets """
#<word double-quote> introduces brackets:
   Placing ].phrase on ends-here of p2
[scan] check-for-]-from-word-after p2 """
[scan] Trailing-hidden-markup-check #<position2 2 """>
[scan] Trailing-hidden-annotation-check #<position2 2 """>
Asking whether there is a ] on p2 because of '"'
   there is
There is a ].phrase on p2
[scan] bracket-ends-the-segment? ].phrase
Segment started at p1 ended at p2 by #<bracket ].phrase >
[scan] pts
Post-scan characterization of segment between p1 and p2: one-edge-over-entire-segment
[scan] segment-finished: p1 to p2
Segment "the" extends, scanning the next segment starting at p2
No further actions on the segment between p1 and p2
[scan] scan-next-segment #<position2 2 """>
[scan] figure-out-where-to-start #<position2 2 """>
Figuring out what to do at p2
   which has the status ]-from-word-after-checked
[scan] check-for-[-from-word-after p2 """
[scan] check for end of source #<position2 2 """>
Asking whether there is a [ on p2 because of '"'
   no, there isn't
[scan] Leading-hidden-markup-check #<position2 2 """>
[scan] scan-patterns check: p2
[scan] check-word-level-fsa-trigger #<position2 2 """>
[scan] cwlft-cont #<position2 2 """>
Doing any word-level FSAs for #<word double-quote> at p2
[scan] word-level-actions #<word double-quote>
Doing word-level actions on """ at p2
[scan] introduce-terminal-edges #<word double-quote>
Installing any terminal edges over the known word #<word double-quote>
[install] """ has a rule set
no edges installed over #<word double-quote>
[scan] introduce-right-side-brackets: "#<word double-quote>"
[scan] introduce-trailing-brackets "#<word double-quote>"
#<word double-quote> introduces brackets:
   Placing phrase.[ on starts-here of p3
[scan] check-for-]-from-prior-word: p3
Asking whether there is a ] on p3 because of '"'
   no, there isn't
There is no close bracket at p3
[scan] check-for-[-from-prior-word: p3
Asking whether there is a [ on p3 because of '"'
   there is
[scan] adjudicate-new-open-bracket phrase.[
Setting the left segment boundary to p3
   because of the phrase.[ in front of nil
[scan] scan-next-pos #<position3 3 "nil">
restriction
Scanned "restriction" at p3
[scan] introduce-leading-brackets "restriction"
[scan] check-for-]-from-word-after p3 "restriction"
[scan] Trailing-hidden-markup-check #<position3 3 "restriction">
[scan] Trailing-hidden-annotation-check #<position3 3 "restriction">
Asking whether there is a ] on p3 because of 'restriction'
   no, there isn't
There is no close bracket at p3
[scan] check-for-[-from-word-after p3 "restriction"
[scan] check for end of source #<position3 3 "restriction">
Asking whether there is a [ on p3 because of 'restriction'
   no, there isn't
[scan] Leading-hidden-markup-check #<position3 3 "restriction">
[scan] scan-patterns check: p3
[scan] no whitespace at p3. Initiating scan-pattern check.
[1st ns] At p3, checking """ and "restriction"
[1st ns] """ starts nil
[scan] check-word-level-fsa-trigger #<position3 3 "restriction">
[scan] cwlft-cont #<position3 3 "restriction">
Doing any word-level FSAs for #<word "restriction"> at p3
[scan] word-level-actions #<word "restriction">
Doing word-level actions on "restriction" at p3
[scan] introduce-terminal-edges #<word "restriction">
"restriction" is unknown, looking for property-based terminal edges
[install] "restriction" does not have a rule set
no edges installed over #<word "restriction">
[scan] introduce-right-side-brackets: "#<word "restriction">"
[scan] introduce-trailing-brackets "#<word "restriction">"
[scan] check-for-]-from-prior-word: p4
Asking whether there is a ] on p4 because of 'restriction'
   no, there isn't
There is no close bracket at p4
[scan] check-for-[-from-prior-word: p4
Asking whether there is a [ on p4 because of 'restriction'
   no, there isn't
[scan] scan-next-pos #<position4 4 "nil">
 point
Scanned "point" at p4
[scan] introduce-leading-brackets "point"
[scan] check-for-]-from-word-after p4 "point"
[scan] Trailing-hidden-markup-check #<position4 4 "point">
[scan] Trailing-hidden-annotation-check #<position4 4 "point">
Asking whether there is a ] on p4 because of 'point'
   no, there isn't
There is no close bracket at p4
[scan] check-for-[-from-word-after p4 "point"
[scan] check for end of source #<position4 4 "point">
Asking whether there is a [ on p4 because of 'point'
   no, there isn't
[scan] Leading-hidden-markup-check #<position4 4 "point">
[scan] scan-patterns check: p4
[scan] check-word-level-fsa-trigger #<position4 4 "point">
[scan] cwlft-cont #<position4 4 "point">
Doing any word-level FSAs for #<word "point"> at p4
[scan] word-level-actions #<word "point">
Doing word-level actions on "point" at p4
[scan] introduce-terminal-edges #<word "point">
"point" is unknown, looking for property-based terminal edges
[install] "point" does not have a rule set
no edges installed over #<word "point">
[scan] introduce-right-side-brackets: "#<word "point">"
[scan] introduce-trailing-brackets "#<word "point">"
[scan] check-for-]-from-prior-word: p5
Asking whether there is a ] on p5 because of 'point'
   no, there isn't
There is no close bracket at p5
[scan] check-for-[-from-prior-word: p5
Asking whether there is a [ on p5 because of 'point'
   no, there isn't
[scan] scan-next-pos #<position5 5 "nil">
"
Scanned "double-quote" at p5
[scan] introduce-leading-brackets """
#<word double-quote> introduces brackets:
   Placing ].phrase on ends-here of p5
[scan] check-for-]-from-word-after p5 """
[scan] Trailing-hidden-markup-check #<position5 5 """>
[scan] Trailing-hidden-annotation-check #<position5 5 """>
Asking whether there is a ] on p5 because of '"'
   there is
There is a ].phrase on p5
[scan] bracket-ends-the-segment? ].phrase
Segment started at p3 ended at p5 by #<bracket ].phrase >
[scan] pts
Post-scan characterization of segment between p3 and p5: no-edges
[scan] segment-finished: p3 to p5
Segment "restriction point" does not extend
    No edge ending at p5
No further actions on the segment between p3 and p5
[scan] moved-to-forest-level: p5
Moving to the forest-level starting back from p5 - empty-segment-scanned
    but *do-forest-level* is off
[scan] scan-next-segment #<position5 5 """>
[scan] figure-out-where-to-start #<position5 5 """>
Figuring out what to do at p5
   which has the status ]-from-word-after-checked
[scan] check-for-[-from-word-after p5 """
[scan] check for end of source #<position5 5 """>
Asking whether there is a [ on p5 because of '"'
   no, there isn't
[scan] Leading-hidden-markup-check #<position5 5 """>
[scan] scan-patterns check: p5
[scan] no whitespace at p5. Initiating scan-pattern check.
[1st ns] At p5, checking "point" and """
[1st ns] "point" starts nil
[scan] check-word-level-fsa-trigger #<position5 5 """>
[scan] cwlft-cont #<position5 5 """> ;; " <====== A
Doing any word-level FSAs for #<word double-quote> at p5
[scan] word-level-actions #<word double-quote>
Doing word-level actions on """ at p5
Looking at the interior of quotation-marks between p3 and p5  ;; <=======================
Completing #<edge1 2 quotation 6>
[scan] introduce-terminal-edges #<word double-quote>
Installing any terminal edges over the known word #<word double-quote>
[install] """ is already spanned  ;; <=== different here
[scan] introduce-right-side-brackets: "#<word double-quote>"
[scan] introduce-trailing-brackets "#<word double-quote>"
#<word double-quote> introduces brackets:
   Placing phrase.[ on starts-here of p6
[scan] check-for-]-from-prior-word: p6
Asking whether there is a ] on p6 because of '"'
   no, there isn't
There is no close bracket at p6
[scan] check-for-[-from-prior-word: p6
Asking whether there is a [ on p6 because of '"'
   there is
[scan] adjudicate-new-open-bracket phrase.[
Setting the left segment boundary to p6
   because of the phrase.[ in front of nil
[scan] scan-next-pos #<position6 6 "nil">
 in
Scanned "in" at p6
[scan] introduce-leading-brackets "in"
#<word "in"> introduces brackets:
   Placing ].treetop on ends-here of p6
[scan] check-for-]-from-word-after p6 "in"
[scan] Trailing-hidden-markup-check #<position6 6 "in">
[scan] Trailing-hidden-annotation-check #<position6 6 "in">
Asking whether there is a ] on p6 because of 'in'
   there is
There is a ].treetop on p6
[scan] bracket-ends-the-segment? ].treetop
Segment started at p6 ended at p6 by #<bracket ].treetop >
[scan] pts
Post-scan characterization of segment between p6 and p6: null-span
[scan] segment-finished: p6 to p6
[scan] return-to-scan-level-from-null-span: p6
No further actions on the segment between p6 and p6
Returning to the word level at p6 from a null span
[scan] check-for-[-from-word-after p6 "in"
[scan] check for end of source #<position6 6 "in">
Asking whether there is a [ on p6 because of 'in'
   no, there isn't
[scan] Leading-hidden-markup-check #<position6 6 "in">
[scan] scan-patterns check: p6
[scan] check-word-level-fsa-trigger #<position6 6 "in">
[scan] cwlft-cont #<position6 6 "in">
Doing any word-level FSAs for #<word "in"> at p6

Scanned "end-of-source" at p7
[scan] word-level-actions #<word "in">
Doing word-level actions on "in" at p6
[scan] introduce-terminal-edges #<word "in">
Installing any terminal edges over the known word #<word "in">
[install] "in" has a rule set
[install] "in" has variations that are capitalized
[install] The actual capitalization of p6 is lower-case
"in" is a literal in some rule/s
"in" is rewritten by 1 rules
Completing #<edge3 6 spatial-orientation 7>
installed 2 edges over #<word "in">
[scan] Check-preterminal-edges #<position6 6 "in">
[scan] Introduce-leading-brackets-from-edge-form-labels #<position6 6 "in">
[scan] introduce-leading-brackets "preposition"
[scan] check-edge-fsa-trigger in at p6
Doing any edge-level FSAs associated with any of
   (#<edge2 6 "in" 7> #<edge3 6 spatial-orientation 7>)
  over #<word "in"> at p6
[scan] introduce-right-side-brackets: "#<word "in">"
[scan] introduce-trailing-brackets "#<word "in">"
#<word "in"> introduces brackets:
   Placing treetop.[ on starts-here of p7
[scan] check-for-]-from-prior-word: p7
Asking whether there is a ] on p7 because of 'in'
   no, there isn't
There is no close bracket at p7
[scan] check-for-[-from-prior-word: p7
Asking whether there is a [ on p7 because of 'in'
   there is
[scan] adjudicate-new-open-bracket treetop.[
Setting the left segment boundary to p7
   because of the treetop.[ in front of #<word end-of-source>
[scan] scan-next-pos #<position7 7 "">
[scan] introduce-leading-brackets ""
#<word end-of-source> introduces brackets:
   Placing ].phrase on ends-here of p7
[scan] check-for-]-from-word-after p7 ""
[scan] Trailing-hidden-markup-check #<position7 7 "">
[scan] Trailing-hidden-annotation-check #<position7 7 "">
Asking whether there is a ] on p7 because of ''
   there is
There is a ].phrase on p7
[scan] bracket-ends-the-segment? ].phrase
Segment started at p7 ended at p7 by #<bracket ].phrase >
[scan] pts
Post-scan characterization of segment between p7 and p7: null-span
[scan] segment-finished: p7 to p7
[scan] return-to-scan-level-from-null-span: p7
No further actions on the segment between p7 and p7
Returning to the word level at p7 from a null span
[scan] check-for-[-from-word-after p7 ""
[scan] check for end of source #<position7 7 "">
Chart-level processing terminated


                                 source-start
e0                               "the"
e1    quotation               2 "\" restriction point \"" 6
e2 e3                            "in" :: in, spatial-orientation
                                 end-of-source
:done-printing
sparser> 


============
sparser> (p "can be \"called back\" to")
[scan] Inititate-top-edges-protocol

Scanned "source-start" at p0
[scan] check-word-level-fsa-trigger #<position0 0 "">
[scan] cwlft-cont #<position0 0 "">
Doing any word-level FSAs for #<word source-start> at p0
[scan] word-level-actions #<word source-start>
Doing word-level actions on "" at p0
[scan] introduce-terminal-edges #<word source-start>
Installing any terminal edges over the known word #<word source-start>
[install] "" has a rule set
no edges installed over #<word source-start>
[scan] introduce-right-side-brackets: "#<word source-start>"
[scan] introduce-trailing-brackets "#<word source-start>"
#<word source-start> introduces brackets:
   Placing phrase.[ on starts-here of p1
[scan] check-for-]-from-prior-word: p1
Asking whether there is a ] on p1 because of ''
   no, there isn't
There is no close bracket at p1
[scan] check-for-[-from-prior-word: p1
Asking whether there is a [ on p1 because of ''
   there is
[scan] adjudicate-new-open-bracket phrase.[
Setting the left segment boundary to p1
   because of the phrase.[ in front of nil
[scan] scan-next-pos #<position1 1 "nil">
can
Scanned "can" at p1
[scan] introduce-leading-brackets "can"
#<word "can"> introduces brackets:
   Placing ].verb on ends-here of p1
   Placing .[modal on starts-here of p1
[scan] check-for-]-from-word-after p1 "can"
[scan] Trailing-hidden-markup-check #<position1 1 "can">
[scan] Trailing-hidden-annotation-check #<position1 1 "can">
Asking whether there is a ] on p1 because of 'can'
   there is
There is a ].verb on p1
[scan] bracket-ends-the-segment? ].verb
Segment started at p1 ended at p1 by #<bracket ].verb >
[scan] pts
Post-scan characterization of segment between p1 and p1: null-span
[scan] segment-finished: p1 to p1
[scan] return-to-scan-level-from-null-span: p1
No further actions on the segment between p1 and p1
Returning to the word level at p1 from a null span
[scan] check-for-[-from-word-after p1 "can"
[scan] check for end of source #<position1 1 "can">
Asking whether there is a [ on p1 because of 'can'
   there is
[scan] adjudicate-new-open-bracket .[modal
Setting the left segment boundary to p1
   because of the .[modal in front of #<word "can">
[scan] Leading-hidden-markup-check #<position1 1 "can">
[scan] scan-patterns check: p1
[scan] no whitespace at p1. Initiating scan-pattern check.
[scan] check-word-level-fsa-trigger #<position1 1 "can">
[scan] cwlft-cont #<position1 1 "can">
Doing any word-level FSAs for #<word "can"> at p1
[scan] word-level-actions #<word "can">
Doing word-level actions on "can" at p1
[scan] introduce-terminal-edges #<word "can">
Installing any terminal edges over the known word #<word "can">
[install] "can" has a rule set
"can" is a literal in some rule/s
"can" is rewritten by 1 rules
Completing #<edge1 1 can 2>
installed 2 edges over #<word "can">
[scan] Check-preterminal-edges #<position1 1 "can">
[scan] Introduce-leading-brackets-from-edge-form-labels #<position1 1 "can">
[scan] introduce-leading-brackets "modal"
#<ref-category modal> does not introduce any brackets
[scan] check-edge-fsa-trigger can at p1
Doing any edge-level FSAs associated with any of
   (#<edge0 1 "can" 2> #<edge1 1 can 2>)
  over #<word "can"> at p1
[scan] introduce-right-side-brackets: "#<word "can">"
[scan] introduce-trailing-brackets "#<word "can">"
#<word "can"> does not introduce any brackets
[scan] check-for-]-from-prior-word: p2
Asking whether there is a ] on p2 because of 'can'
   no, there isn't
There is no close bracket at p2
[scan] check-for-[-from-prior-word: p2
Asking whether there is a [ on p2 because of 'can'
   no, there isn't
[scan] Introduce-trailing-brackets-from-edge-form-labels #<position2 2 "nil">
[scan] introduce-trailing-brackets "#<ref-category modal>"
#<ref-category modal> does not introduce any brackets
[scan] scan-next-pos #<position2 2 "nil">
 be
Scanned "be" at p2
[scan] introduce-leading-brackets "be"
#<word "be"> introduces brackets:
   Placing ].verb on ends-here of p2
   Placing .[verb on starts-here of p2
[scan] check-for-]-from-word-after p2 "be"
[scan] Trailing-hidden-markup-check #<position2 2 "be">
[scan] Trailing-hidden-annotation-check #<position2 2 "be">
Asking whether there is a ] on p2 because of 'be'
   there is
There is a ].verb on p2
[scan] bracket-ends-the-segment? ].verb
].verb does not end the segment at p2
[scan] check-for-[-from-word-after p2 "be"
[scan] check for end of source #<position2 2 "be">
Asking whether there is a [ on p2 because of 'be'
   there is
[scan] adjudicate-new-open-bracket .[verb
Ignoring the #<bracket .[verb > at p2 in front of be
   because the left boundary is already in place at p1
[scan] Leading-hidden-markup-check #<position2 2 "be">
[scan] scan-patterns check: p2
[scan] check-word-level-fsa-trigger #<position2 2 "be">
[scan] cwlft-cont #<position2 2 "be">
Doing any word-level FSAs for #<word "be"> at p2
[scan] word-level-actions #<word "be">
Doing word-level actions on "be" at p2
[scan] introduce-terminal-edges #<word "be">
Installing any terminal edges over the known word #<word "be">
[install] "be" has a rule set
"be" is rewritten by 1 rules
Completing #<edge2 2 be 3>
installed 1 edges over #<word "be">
[scan] Check-preterminal-edges #<position2 2 "be">
[scan] Introduce-leading-brackets-from-edge-form-labels #<position2 2 "be">
[scan] introduce-leading-brackets "verb"
#<ref-category verb> does not introduce any brackets
[scan] check-edge-fsa-trigger be at p2
Doing any edge-level FSAs for the #<edge2 2 be 3>
  over #<word "be"> at p2
[scan] introduce-right-side-brackets: "#<word "be">"
[scan] introduce-trailing-brackets "#<word "be">"
#<word "be"> introduces brackets:
   Placing aux]. on ends-here of p3
[scan] check-for-]-from-prior-word: p3
Asking whether there is a ] on p3 because of 'be'
   there is
There is a aux]. on p3
[scan] bracket-ends-the-segment? aux].
aux]. does not end the segment at p3
[scan] check-for-[-from-prior-word: p3
Asking whether there is a [ on p3 because of 'be'
   no, there isn't
[scan] Introduce-trailing-brackets-from-edge-form-labels #<position3 3 "nil">
[scan] introduce-trailing-brackets "#<ref-category verb>"
#<ref-category verb> does not introduce any brackets
[scan] scan-next-pos #<position3 3 "nil">
 "
Scanned "double-quote" at p3
[scan] introduce-leading-brackets """
#<word double-quote> introduces brackets:
   Placing ].phrase on ends-here of p3
[scan] check-for-]-from-word-after p3 """
[scan] Trailing-hidden-markup-check #<position3 3 """>
[scan] Trailing-hidden-annotation-check #<position3 3 """>
Asking whether there is a ] on p3 because of '"'
   there is
There is a ].phrase on p3
[scan] bracket-ends-the-segment? ].phrase
Segment started at p1 ended at p3 by #<bracket ].phrase >
[scan] pts
Post-scan characterization of segment between p1 and p3: all-contiguous-edges
[scan] parse-at-the-segment-level: p3
Completing #<edge3 1 can 3>
Finished running the phrase structure rules over the
  segment between p1 and p3
[scan] segment-finished: p1 to p3
Segment "can be" extends, scanning the next segment starting at p3
No further actions on the segment between p1 and p3
[scan] scan-next-segment #<position3 3 """>
[scan] figure-out-where-to-start #<position3 3 """>
Figuring out what to do at p3
   which has the status ]-from-word-after-checked
[scan] check-for-[-from-word-after p3 """
[scan] check for end of source #<position3 3 """>
Asking whether there is a [ on p3 because of '"'
   no, there isn't
[scan] Leading-hidden-markup-check #<position3 3 """>
[scan] scan-patterns check: p3
[scan] check-word-level-fsa-trigger #<position3 3 """>
[scan] cwlft-cont #<position3 3 """>  ;; <====== A
Doing any word-level FSAs for #<word double-quote> at p3
[scan] word-level-actions #<word double-quote>
Doing word-level actions on """ at p3
 ";; >>> The 'looking at the interior or quotation-marks' would have been here <<<<
[scan] introduce-terminal-edges #<word double-quote>
Installing any terminal edges over the known word #<word double-quote>
[install] "\"" has a rule set  ;; <=== different here
no edges installed over #<word double-quote>

=== Stack
nil fell through a etypecase form.  The valid cases were word,
(or category referential-category mixin-category), cfr,
polyword, and individual.
   [Condition of type excl:case-failure]

Restarts:
 0: [retry] Retry SLIME REPL evaluation request.
 1: [abort] Return to SLIME's top level.
 2: [abort] Abort entirely from this (lisp) process.

Backtrace:
  0: (swank:invoke-slime-debugger #<excl:case-failure @ #x10fb29ea>)
  1: ((:internal swank:swank-debugger-hook 1))
  2: ((:internal (:top-level-form "swank-backend.lisp" 22581) 0) #<Function swank-debugger-hook> #<Closure (:internal swank:swank-debugger-hook 1) @ #x10fb2a1a>)
  3: (swank-backend:call-with-debugger-hook #<Function swank-debugger-hook> #<Closure (:internal swank:swank-debugger-hook 1) @ #x10fb2a1a>)
  4: (swank:swank-debugger-hook #<excl:case-failure @ #x10fb29ea> #<Function swank-debugger-hook>)
  5: (error excl:case-failure :name etypecase :datum nil ...)
  6: (plist-for nil)
  7: (let ((hook (when first-edge #))) (if hook (then (tr :paired-punct-hook hook) (if # # #)) (else (let # edge))))
  8: (let ((layout (analyze-segment-layout pos-after-open pos-before-close)) (first-edge (right-treetop-at/edge pos-after-open))) ..)
  9: (do-paired-punctuation-interior :quotation-marks #<position3 3 "#1=""> #<position4 4 "called"> #<position6 6 "#1#"> #<position7 7 "nil">)
 10: (let ((pos-before-start-quote (car *pending-double-quote*)) (pos-after-start-quote (cdr *pending-double-quote*))) ..)
 11: (span-quotation #<position6 6 """> #<position7 7 "nil">)
 12: (check-quotation #<position6 6 """> #<position7 7 "nil">)
 13: (word-level-actions #<word double-quote> #<position6 6 """>)
 14: (introduce-terminal-edges #<word "back"> #<position5 5 "back"> #<position6 6 """>)
 15: (word-level-actions #<word "back"> #<position5 5 "back">)
 16: (word-level-actions #<word "called"> #<position4 4 "called">)
 17: (word-level-actions #<word double-quote> #<position3 3 """>)
 18: (march-back-from-the-right/segment)
 19: (march-back-from-the-right/segment)
 20: (introduce-terminal-edges #<word "be"> #<position2 2 "be"> #<position3 3 """>)
 21: (word-level-actions #<word "be"> #<position2 2 "be">)
 22: (introduce-terminal-edges #<word "can"> #<position1 1 "can"> #<position2 2 "be">)
 23: (word-level-actions #<word "can"> #<position1 1 "can">)
 24: (word-level-actions #<word source-start> #<position0 0 "">)
 25: (let () ..)
 26: (let ((#:g343128 chart-protocol)) ..)
 27: (let ((chart-protocol *kind-of-chart-processing-to-do*)) ..)
 28: (catch 'change-kind-of-chart-processing ..)
 29: (lookup-the-kind-of-chart-processing-to-do)
 30: (catch 'terminating-chart-processing (lookup-the-kind-of-chart-processing-to-do))
 31: (chart-based-analysis)
 32: (catch :analysis-core ..)
 33: (analysis-core)
 34: (pp "can be \"called back\" to")
 35: (p "can be \"called back\" to")
 36: (eval (p "can be \"called back\" to"))
 37: (swank::eval-region "(p \"can be \\"called back\\" to\")\n")
 38: ((:internal (:internal (:internal swank::repl-eval 0) 0) 0))
 39: (swank::track-package #<Closure (:internal (:internal # 0) 0) @ #x10e5f342>)
 40: ((:internal (:internal swank::repl-eval 0) 0))
 41: (swank::call-with-retry-restart "Retry SLIME REPL evaluation request." #<Closure (:internal (:internal swank::repl-eval 0) 0) @ #x10e5f362>)
 42: ((:internal swank::repl-eval 0))
 43: ((:internal (:top-level-form "swank-allegro.lisp" 2017) 0) #<Closure (:internal swank::repl-eval 0) @ #x10e5f382>)
 44: (swank-backend:call-with-syntax-hooks #<Closure (:internal swank::repl-eval 0) @ #x10e5f382>)
 45: (swank::call-with-buffer-syntax nil #<Closure (:internal swank::repl-eval 0) @ #x10e5f382>)
 46: (swank::repl-eval "(p \"can be \\"called back\\" to\")\n")
 47: (swank:listener-eval "(p \"can be \\"called back\\" to\")\n")
 48: (eval (swank:listener-eval "(p \"can be \\"called back\\" to\")\n"))
 49: (swank::eval-for-emacs (swank:listener-eval "(p \"can be \\"called back\\" to\")\n") "sparser" 325)
 50: (swank::process-requests nil)
 51: ((:internal swank::handle-requests 0))
 52: ((:internal (:top-level-form "swank-backend.lisp" 22581) 0) #<Function swank-debugger-hook> #<Closure (:internal swank::handle-requests 0) [nil] @ #x10e45212>)
 53: (swank-backend:call-with-debugger-hook #<Function swank-debugger-hook> #<Closure (:internal swank::handle-requests 0) [nil] @ #x10e45212>)
 54: ((:internal swank::call-with-connection 2))
 55: (swank::call-with-bindings ..)
 56: (swank::call-with-connection #<swank::connection @ #x10402012> #<Closure (:internal swank::handle-requests 0) [nil] @ #x10e45212>)
 57: (swank::handle-requests #<swank::connection @ #x10402012>)
 58: (swank::repl-loop #<swank::connection @ #x10402012>)
 59: ((:internal (:internal swank::spawn-repl-thread 0) 0))
 --more--
