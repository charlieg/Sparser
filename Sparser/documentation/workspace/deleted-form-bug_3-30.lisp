

;; 4/17/10 Fixed it. The category references in elevate-segment-edge-form-if-needed
;; were returning nil. The change was being made at the level where the edges in
;; the segment were being looked at.


;; 3/30/10  running in Fire mode

;; Next trace PTS to see the coverage over "uses"
;; and given that, strategically place breaks to isolate where the field is
;; getting reset.

;; When the edge is laid down by make-completed-unary-edge
#<edge @ #x10dca34a>
--------------------
Class: #<structure-class edge>
category: #<ref-category use>
form: #<ref-category verb+present>
referent: nil
starts-at: #<edges starting at 3>
ends-at: #<edges ending at 4>
rule: #<PSR1154  use ->  "uses">
left-daughter: #<word "uses">
right-daughter: :single-term
used-in: nil
position-in-resource-array: 3
constituents: nil
spanned-words: nil


;; After the dust settles the form field is nil. Maybe it's something
;; that's examining the segment -- the generalization of the head code?
sparser> (p "this method uses function words")
this method uses function words

                                 source-start
e2    method                  1 "this method" 3
e3    use                     3 "uses" 4
e5                               "words"
                                 end-of-source
:done-printing
sparser> (ie 3)
#<edge3 3 use 4> is a structure of type edge.  It has these slots:
 category           #<ref-category use>
 form               nil
 referent           #<ref-category use>
 starts-at          #<edges starting at 3>
 ends-at            #<edges ending at 4>
 rule               #<PSR1154  use ->  "uses">
 left-daughter      #<word "uses">
 right-daughter     :single-term
 used-in            nil
 position-in-resource-array  3
 constituents       nil
 spanned-words      nil


;; (4/17) it as a value at install-preterminal-edge


  5: (break "rule = ~a" #<PSR1154  use ->  "uses">)
  6: (let ((edge (next-edge-from-resource))) ..)
  7: (make-completed-unary-edge #<edges starting at 3> #<edges ending at 4> #<PSR1154  use ->  "uses"> #<word "uses">)
  8: (install-preterminal-edge #<PSR1154  use ->  "uses"> #<word "uses"> #<position3 3 "uses"> #<position4 4 "nil">)
  9: (preterminals/word #<rule-set for #1=#<word "uses">> #1# #<position3 3 "uses"> #<position4 4 "nil">)
 10: (install-terminal-edges #<word "uses"> #<position3 3 "uses"> #<position4 4 "nil">)
 11: (let ((edges (install-terminal-edges word position-before position-after))) ..)
 12: (introduce-terminal-edges #<word "uses"> #<position3 3 "uses"> #<position4 4 "nil">)
 13: (let ((position-after (chart-position-after position-before))) ..)
 14: (word-level-actions #<word "uses"> #<position3 3 "uses">)
 15: (let ((where-fsa-ended (do-word-level-fsas word position-before))) ..)
 16: (cwlft-cont #<word "uses"> #<position3 3 "uses">)
 17: (let ((#1=#:g342648 (pos-capitalization position-before))) ..)
 18: (check-word-level-fsa-trigger #<word "uses"> #<position3 3 "uses">)
 19: (check-for/initiate-scan-patterns #<word "uses"> #<position3 3 "uses">)
 20: (let (([ ([-on-position-because-of-word? position-before word))) ..)
 21: (check-for-[-from-word-after #<word "uses"> #<position3 3 "uses">)
 22: (let ((] (]-on-position-because-of-word? position-before word))) ..)
 23: (check-for-]-from-word-after #<word "uses"> #<position3 3 "uses">)
 24: (let ((word (pos-terminal position))) (introduce-leading-brackets word position) (check-for-]-from-word-after word position))
 25: (scan-next-pos #<position3 3 "uses">)
 26: (let (([ ([-on-position-because-of-word? position-after prior-word))) ..)
 27: (check-for-[-from-prior-word #<position3 3 "uses"> #<word "method">)
 28: (scan-next-segment #<position3 3 "uses">)
 29: (let () ..)
 30: (sdm/analyze-segment :one-edge-over-entire-segment)
 31: (march-back-from-the-right/segment)
 32: (march-back-from-the-right/segment)
 33: (let ((] (]-on-position-because-of-word? position-after prior-word))) ..)
 34: (check-for-]-from-prior-word #<position3 3 "uses"> #<word "method">)
 35: (introduce-right-side-brackets #<word "method"> #<position3 3 "uses">)
 36: (let ((position-after-edge-fsa (do-edge-level-fsas edges position-before))) ..)
 37: (check-edge-fsa-trigger (#<edge1 2 method 3>) #<position2 2 "method"> #<word "method"> #<position3 3 "uses">)
 38: (let ((label (introduce-leading-brackets-from-edge-form-labels edges position-before))) ..)
 39: (check-preterminal-edges (#<edge1 2 method 3>) #<word "method"> #<position2 2 "method"> #<position3 3 "uses">)
 40: (let ((edges (install-terminal-edges word position-before position-after))) ..)
 41: (introduce-terminal-edges #<word "method"> #<position2 2 "method"> #<position3 3 "uses">)
 42: (let ((position-after (chart-position-after position-before))) ..)
 43: (word-level-actions #<word "method"> #<position2 2 "method">)
 44: (let ((where-fsa-ended (do-word-level-fsas word position-before))) ..)
 45: (cwlft-cont #<word "method"> #<position2 2 "method">)
 46: (let ((#:g342601 (pos-capitalization position-before))) ..)
 47: (check-word-level-fsa-trigger #<word "method"> #<position2 2 "method">)
 48: (check-for/initiate-scan-patterns #<word "method"> #<position2 2 "method">)
 49: (let (([ ([-on-position-because-of-word? position-before word))) ..)
 50: (check-for-[-from-word-after #<word "method"> #<position2 2 "method">)
 51: (let ((] (]-on-position-because-of-word? position-before word))) ..)
 52: (check-for-]-from-word-after #<word "method"> #<position2 2 "method">)
 53: (let ((word (pos-terminal position))) (introduce-leading-brackets word position) (check-for-]-from-word-after word position))
 54: (scan-next-pos #<position2 2 "method">)
