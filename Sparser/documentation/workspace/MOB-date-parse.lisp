sparser> (p "MOB date must be greater than 10 days after today's date")
Unexpected status after PNF returned: [-from-word-after-checked
   [Condition of type excl:simple-break]
;; The capitalized sequence FSA (PNF) is quite brittle. Here's an example. The bug is
;; either in the underlying state space (i.e. this is a reasonable status for
;; the word "MOB" to have after the Proper Name FSA got through with it) or in
;; PNF itself (for over-reaching or not doing enough with this single word 'sequence').
Backtrace:
  0: (swank:invoke-slime-debugger #<excl:simple-break @ #x115d35c2>)
  1: ((:internal swank:swank-debugger-hook 1))
  2: ((:internal (:top-level-form "swank-backend.lisp" 22581) 0) #<Function swank-debugger-hook> #<Closure (:internal swank:swank-debugger-hook 1) @ #x115d3692>)
  3: (swank-backend:call-with-debugger-hook #<Function swank-debugger-hook> #<Closure (:internal swank:swank-debugger-hook 1) @ #x115d3692>)
  4: (swank:swank-debugger-hook #<excl:simple-break @ #x115d35c2> #<Function swank-debugger-hook>)
  5: (break "Unexpected status after PNF returned: ~a" :[-from-word-after-checked)
  6: (continuation-after-pnf-returned-nil #<word "mob"> #<position1 1 "mob">)
  7: (word-level-actions #<word source-start> #<position0 0 "">)
  8: (lookup-


sparser> (p "mob date must be greater than 10 days after today's date")

                                 source-start
                                 "mob"
e0    date                    2 "date" 3
e9    must                    3 "must be" 5
e18   date                    5 "greater than 10 days after today ' s date" 14
                                 end-of-source
:done-printing
sparser> (tree 18)
E18 date                      p5 - p14    rule 698
  E4 comparative              p5 - p7   rule 294
    E3 "greater than"         p5 - p7   rule 293
      "greater"
  E17 date                    p7 - p14    rule 697
    E8 amount-of-time         p7 - p9   rule 694
      E6 number               p7 - p8   number-fsa
        E5 digit-sequence     p7 - p8   rule 382
          "10"
      E7 unit-of-time         p8 - p9   rule 680
        "days"
    E16 relative-date         p9 - p14    rule 696
      E10 sequencer           p9 - p10    rule 457
        "after"
      E15 date                p10 - p14   rule 695
        E13 today             p10 - p13   rule 166
          E11 today           p10 - p11   rule 689
            "today"
          E12 apostrophe-s    p11 - p13   appostrophe-fsa
            "'"
        E14 date              p13 - p14   rule 690
          "date"
#<edge18 5 date 14>

ltml> (today)
#<today 9/11/2009>
ltml> (d *)
#<today 9/11/2009> is an instance of
    #<standard-class ts@TemporalIndexical>:
 The following slots have :instance allocation:
  concept-name            ts@TemporalIndexical
  ltml@myTag              #<ltml@Tag ts@Today>
  ltml@source-component   nil
  top@name                "today"
  ts@date                 #<Wednesday September 11st, 2009>
#<today 9/11/2009>

sparser> (edge-referent (e# 15))
#<Wednesday September 11st, 2009>
sparser> (d *)
#<Wednesday September 11st, 2009> is an instance of
    #<standard-class ltml:ts@Date>:
 The following slots have :instance allocation:
  concept-name            ltml:ts@Date
  ltml@myTag              #<ltml@Tag ts@11/9/2009>
  ltml@source-component   nil
  top@quantity            nil
  top@measuredIn          nil
  top@duration            nil
  top@endinging           nil
  top@starting            nil
  top@eltPosition         11
  top@container           nil
  top@next                nil
  top@previous            nil
  top@name                nil
  ts@members              nil
  ts@month                #<September 2009>
  ts@dayOfTheWeek         #<ts@DayOfWeek ts@Wednesday>
  ts@referenceDay         #<ts@DayOfMonth ts@September11>
#<Wednesday September 11st, 2009>
