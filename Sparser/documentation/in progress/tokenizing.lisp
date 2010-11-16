;; $Id$
;; 3/12/10

The place to start for understanding this is add-terminal-to-chart ()
in /analyzers/psp/fill-chart/

It calls (next-terminal) and then adds it to the chart.

The next-terminal function is one of the ones that we parameterize by
setting its symbol-function. The initialzing routine is
  establish-version-of-next-terminal-to-use (keyword &optional function)
in /drivers/tokens/next-terminal2.lisp

The usual call (see uncontroversial-settings in /drivers/inits/switches2.lisp)
is to next-terminal/pass-through-all-tokens.
   There is a :no-whitespace option that I don't remember
   And a next-terminal/pass-through-all-tokens/buffered which would appear
     to work with the 'indentation' NL-fsa, which hasn't been touched since
     the early 1990. See /analyzers/tokenizer/NL-buffer.lisp
   It also can take an arbitrary function. I've forgotten what the motive
     is there, but at the end of that file is a tokenizing routine that
     isn't on a keyword: only-tokenize-on-whitespace-or-punctuation that
     appears to never have been finished.

The next-terminal/pass-through-all-tokens function just call (next-token)
which is in /analyzers/tokenizer/next-token3.lisp and all it does
is call (run-token-fsa)


The token fsa is in /analyzers/tokenizer/token-FSA3.lisp. It works one
character at a time by getting an 'entry' off the *character-buffer-in-use*
array indexed on *index-of-next-character* which is bumps before using.

If (car entry) is :punctuation it returns via do-punctuation(cdr entry).
Otherwise it kcons' the cdr of the entry onto a  list that it passes
to continue-token. The *category-of-accumulating-token* global is set
on this first access.

In continue-token we look for punctuation or a shift in the character
type which demarcate the token. *pending-entry* is set if we switched
character type and gets piked up on the next call to run-token-fsa.
Otherwise we recurse on continue-token.

Out-of-range characters are trapped here as well.

When we're done with the token (because we've detected a shift in
type) we call finish-token. It loops over the klist of accumulated
entries and pushes them into the interning-array (a pointer to the
global *word-lookup-buffer*), while calling the capitaliziation-fsa
to work out the capitalization-state, which at the end is cleaned up
and stashed on *capitalization-of-current-token*. 

We end with a call to find-word(char-type) in /analyzers/tokenizer/
lookup2.lisp. It does a lookup-word-symbol which is where the global
lives along with lots of operations over it. It's in /objects/chart/
words/lookup/buffer.lisp. 

The lookup-word-symbol uses the lisp symbol table to do its hashing
for it via find-symbol. Word symbols are in the *word-package*.

If the word is new, then we call establish-unknown-word. It too is
a parameterized function set by what-to-do-with-unknown-words(keyword)
in /objects/chart/words/lookup/switch-new1.lisp. The global that
records the setting is *unknown-word-policy* and the usual value is
:capitalization-digits-&-morphology which corresponds to the function
 make-word/all-properties(character-type), which is in /objects/chart/
words/lookup/new-words4.lisp. It gets its hands on the characters of
the new word via (make-word-symbol) which uses the lookup buffer.

If the global *introduce-brackets-for-unknown-words-from-their-suffixes*
is on, then right then and there we put the brackets in using 
introduce-morph-brackets-from-unknown-word. The global is in /drivers/
inits/sessions/globals1 and off by default. The code that introduces
the brackets is in /grammar/rules/syntax/affix-rules.lisp. It uses
the chart globals to know where things go. For exampl 
(chart-position *number-of-next-position*) is the position where the
word will appear.



 5: (break "nl/p") ;; at the top of the function
;; The position passed in is p48, and this is it's state
sparser> (d (p# 48))
#<position48 48 "nil"> is a structure of type position.  It has these
slots:
 array-index        48
 character-index    nil
 display-char-index  nil
 token-index        48
 ends-here          #<edges ending at 48>
 starts-here        #<edges starting at 48>
 terminal           nil
 preceding-whitespace  #<word newline>
 capitalization     nil
 assessed?          :[-from-prior-word-checked

;; Notice that the position has an assessment and that the newline
;; that triggered the fsa has already been incorporated into the
;; position. 


  6: (let ((word-after (next-terminal))) ..)
  7: (newline-fsa/paragraph #<position48 48 "nil">)
  8: (let ((word-after (next-terminal))) ..)
  9: (newline-fsa/paragraph #<position48 48 "nil">)
 10: (add-terminal-to-chart)
 11: (scan-next-position)
 12: (scan-next-pos #<position48 48 "nil">)
 13: (let (([ ([-on-position-because-of-word? position-after prior-word))) ..)
 14: (check-for-[-from-prior-word #<position48 48 "nil"> #<word period>)
 15: (scan-next-segment #<position48 48 "nil">)
 16: (let ((] (]-on-position-because-of-word? position-after prior-word))) ..)
 17: (check-for-]-from-prior-word #<position48 48 "nil"> #<word period>)
 18: (introduce-right-side-brackets #<word period> #<position48 48 "nil">)
 19: (let ((position-after-edge-fsa (do-edge-level-fsas edges position-before))) ..)
 20: (check-edge-fsa-trigger (#<edge46 47 period 48>) #<position47 47 "."> #<word period> #<position48 48 "nil">)
 21: (let ((label (introduce-leading-brackets-from-edge-form-labels edges position-before))) ..)
 22: (check-preterminal-edges (#<edge46 47 period 48>) #<word period> #<position47 47 "."> #<position48 48 "nil">)
 23: (let ((edges (install-terminal-edges word position-before position-after))) ..)
 24: (introduce-terminal-edges #<word period> #<position47 47 "."> #<position48 48 "nil">)
 25: (let ((position-after (chart-position-after position-before))) ..)
 26: (word-level-actions #<word period> #<position47 47 ".">)
 27: (let ((where-fsa-ended (do-word-level-fsas word position-before))) ..)
 28: (cwlft-cont #<word period> #<position47 47 ".">)
 29: (let ((#:g376615 (pos-capitalization position-before))) ..)
 30: (check-word-level-fsa-trigger #<word period> #<position47 47 ".">)
 31: (let ((state/s (scan-pattern-starting-pair position-before word))) (if state/s (let (#) (if pos-reached # #)) (check-word-level-fsa-trigger word position-before)))
 32: (check-for/initiate-scan-patterns #<word period> #<position47 47 ".">)
 33: (let (([ ([-on-position-because-of-word? position-before word))) ..)
 34: (check-for-[-from-word-after #<word period> #<position47 47 ".">)
 35: (let ((] (]-on-position-because-of-word? position-before word))) ..)
 36: (check-for-]-from-word-after #<word period> #<position47 47 ".">)
 37: (let ((word (pos-terminal position))) (introduce-leading-brackets word position) (check-for-]-from-word-after word position))
 38: (scan-next-pos #<position47 47 ".">)
 39: (let (([ ([-on-position-because-of-word? position-after prior-word))) ..)
 40: (check-for-[-from-prior-word #<position47 47 "."> #<word "previously">)
 41: (let ((] (]-on-position-because-of-word? position-after prior-word))) ..)
 42: (check-for-]-from-prior-word #<position47 47 "."> #<word "previously">)
 43: (introduce-right-side-brackets #<word "previously"> #<position47 47 ".">)
 44: (let ((position-after-edge-fsa (do-edge-level-fsas edges position-before))) ..)
 45: (check-edge-fsa-trigger (#<edge45 46 anonymous-adverb 47>) #<position46 46 "previously"> #<word "previously"> #<position47 47 ".">)
 46: (let ((label (introduce-leading-brackets-from-edge-form-labels edges position-before))) ..)
 47: (check-preterminal-edges (#<edge45 46 anonymous-adverb 47>) #<word "previously"> #<position46 46 "previously"> #<position47 47 ".">)
 48: (let ((edges (install-terminal-edges word position-before position-after))) ..)
 49: (introduce-terminal-edges #<word "previously"> #<position46 46 "previously"> #<position47 47 ".">)
 50: (let ((position-after (chart-position-after position-before))) ..)
 51: (word-level-actions #<word "previously"> #<position46 46 "previously">)
 5: (break "nl/p")
  6: (let ((word-after (next-terminal))) ..)
  7: (newline-fsa/paragraph #<position48 48 "nil">)
  8: (let ((word-after (next-terminal))) ..)
  9: (newline-fsa/paragraph #<position48 48 "nil">)
 10: (add-terminal-to-chart)
 11: (scan-next-position)
 12: (scan-next-pos #<position48 48 "nil">)
 13: (let (([ ([-on-position-because-of-word? position-after prior-word))) ..)
 14: (check-for-[-from-prior-word #<position48 48 "nil"> #<word period>)
 15: (scan-next-segment #<position48 48 "nil">)
 16: (let ((] (]-on-position-because-of-word? position-after prior-word))) ..)
 17: (check-for-]-from-prior-word #<position48 48 "nil"> #<word period>)
 18: (introduce-right-side-brackets #<word period> #<position48 48 "nil">)
 19: (let ((position-after-edge-fsa (do-edge-level-fsas edges position-before))) ..)
 20: (check-edge-fsa-trigger (#<edge46 47 period 48>) #<position47 47 "."> #<word period> #<position48 48 "nil">)
 21: (let ((label (introduce-leading-brackets-from-edge-form-labels edges position-before))) ..)
 22: (check-preterminal-edges (#<edge46 47 period 48>) #<word period> #<position47 47 "."> #<position48 48 "nil">)
 23: (let ((edges (install-terminal-edges word position-before position-after))) ..)
 24: (introduce-terminal-edges #<word period> #<position47 47 "."> #<position48 48 "nil">)
 25: (let ((position-after (chart-position-after position-before))) ..)
 26: (word-level-actions #<word period> #<position47 47 ".">)
 27: (let ((where-fsa-ended (do-word-level-fsas word position-before))) ..)
 28: (cwlft-cont #<word period> #<position47 47 ".">)
 29: (let ((#:g376615 (pos-capitalization position-before))) ..)
 30: (check-word-level-fsa-trigger #<word period> #<position47 47 ".">)
 31: (let ((state/s (scan-pattern-starting-pair position-before word))) (if state/s (let (#) (if pos-reached # #)) (check-word-level-fsa-trigger word position-before)))
 32: (check-for/initiate-scan-patterns #<word period> #<position47 47 ".">)
 33: (let (([ ([-on-position-because-of-word? position-before word))) ..)
 34: (check-for-[-from-word-after #<word period> #<position47 47 ".">)
 35: (let ((] (]-on-position-because-of-word? position-before word))) ..)
 36: (check-for-]-from-word-after #<word period> #<position47 47 ".">)
 37: (let ((word (pos-terminal position))) (introduce-leading-brackets word position) (check-for-]-from-word-after word position))
 38: (scan-next-pos #<position47 47 ".">)
 39: (let (([ ([-on-position-because-of-word? position-after prior-word))) ..)
 40: (check-for-[-from-prior-word #<position47 47 "."> #<word "previously">)
 41: (let ((] (]-on-position-because-of-word? position-after prior-word))) ..)
 42: (check-for-]-from-prior-word #<position47 47 "."> #<word "previously">)
 43: (introduce-right-side-brackets #<word "previously"> #<position47 47 ".">)
 44: (let ((position-after-edge-fsa (do-edge-level-fsas edges position-before))) ..)
 45: (check-edge-fsa-trigger (#<edge45 46 anonymous-adverb 47>) #<position46 46 "previously"> #<word "previously"> #<position47 47 ".">)
 46: (let ((label (introduce-leading-brackets-from-edge-form-labels edges position-before))) ..)
 47: (check-preterminal-edges (#<edge45 46 anonymous-adverb 47>) #<word "previously"> #<position46 46 "previously"> #<position47 47 ".">)
 48: (let ((edges (install-terminal-edges word position-before position-after))) ..)
 49: (introduce-terminal-edges #<word "previously"> #<position46 46 "previously"> #<position47 47 ".">)
 50: (let ((position-after (chart-position-after position-before))) ..)
 51: (word-level-actions #<word "previously"> #<position46 46 "previously">)
(word-level-actions #<word "previously"> #<position46 46 "previously">)
 52: (let ((where-fsa-ended (do-word-level-fsas word position-before))) ..)
 53: (cwlft-cont #<word "previously"> #<position46 46 "previously">)
 54: (let ((#:g376588 (pos-capitalization position-before))) ..)
 55: (check-word-level-fsa-trigger #<word "previously"> #<position46 46 "previously">)
 56: (check-for/initiate-scan-patterns #<word "previously"> #<position46 46 "previously">)
 57: (let (([ ([-on-position-because-of-word? position-before word))) ..)
 58: (check-for-[-from-word-after #<word "previously"> #<position46 46 "previously">)
 59: (let ((] (]-on-position-because-of-word? position-before word))) ..)
 60: (check-for-]-from-word-after #<word "previously"> #<position46 46 "previously">)
 61: (let ((word (pos-terminal position))) (introduce-leading-brackets word position) (check-for-]-from-word-after word position))
 62: (scan-next-pos #<position46 46 "previously">)
 63: (let (([ ([-on-position-because-of-word? position-after prior-word))) ..)
 64: (check-for-[-from-prior-word #<position46 46 "previously"> #<word "did">)
 65: (scan-next-segment #<position46 46 "previously">)
 66: (let ((] (]-on-position-because-of-word? position-after prior-word))) ..)
 67: (check-for-]-from-prior-word #<position46 46 "previously"> #<word "did">)
 68: (introduce-right-side-brackets #<word "did"> #<position46 46 "previously">)
 69: (let ((position-after-edge-fsa (do-edge-level-fsas edges position-before))) ..)
 70: (check-edge-fsa-trigger (#<edge44 45 do 46>) #<position45 45 "did"> #<word "did"> #<position46 46 "previously">)
 71: (let ((label (introduce-leading-brackets-from-edge-form-labels edges position-before))) ..)
 72: (check-preterminal-edges (#<edge44 45 do 46>) #<word "did"> #<position45 45 "did"> #<position46 46 "previously">)
 73: (let ((edges (install-terminal-edges word position-before position-after))) ..)
 74: (introduce-terminal-edges #<word "did"> #<position45 45 "did"> #<position46 46 "previously">)
 75: (let ((position-after (chart-position-after position-before))) ..)
 76: (word-level-actions #<word "did"> #<position45 45 "did">)
 77: (let ((where-fsa-ended (do-word-level-fsas word position-before))) ..)
 78: (cwlft-cont #<word "did"> #<position45 45 "did">)
 79: (let ((#:g376560 (pos-capitalization position-before))) ..)
 80: (check-word-level-fsa-trigger #<word "did"> #<position45 45 "did">)
 81: (check-for/initiate-scan-patterns #<word "did"> #<position45 45 "did">)
 82: (let (([ ([-on-position-because-of-word? position-before word))) ..)
 83: (check-for-[-from-word-after #<word "did"> #<position45 45 "did">)
 84: (let ((] (]-on-position-because-of-word? position-before word))) ..)
 85: (check-for-]-from-word-after #<word "did"> #<position45 45 "did">)
 86: (let ((word (pos-terminal position))) (introduce-leading-brackets word position) (check-for-]-from-word-after word position))
 87: (scan-next-pos #<position45 45 "did">)
 88: (let (([ ([-on-position-because-of-word? position-after prior-word))) ..)
 89: (check-for-[-from-prior-word #<position45 45 "did"> #<word "it">)
 90: (scan-next-segment #<position45 45 "did">)
 91: (let ((] (]-on-position-because-of-word? position-after prior-word))) ..)
 92: (check-for-]-from-prior-word #<position45 45 "did"> #<word "it">)
 93: (introduce-right-side-brackets #<word "it"> #<position45 45 "did">)
 94: (let ((position-after-edge-fsa (do-edge-level-fsas edges position-before))) ..)
 95: (check-edge-fsa-trigger (#<edge43 44 pronoun/inanimate 45>) #<position44 44 "it"> #<word "it"> #<position45 45 "did">)
 96: (let ((label (introduce-leading-brackets-from-edge-form-labels edges position-before))) ..)
 97: (check-preterminal-edges (#<edge43 44 pronoun/inanimate 45>) #<word "it"> #<position44 44 "it"> #<position45 45 "did">)
 98: (let ((edges (install-terminal-edges word position-before position-after))) ..)
 99: (introduce-terminal-edges #<word "it"> #<position44 44 "it"> #<position45 45 "did">)
 100: (let ((position-after (chart-position-after position-before))) ..)
 101: (word-level-actions #<word "it"> #<position44 44 "it">)
 102: (let ((where-fsa-ended (do-word-level-fsas word position-before))) ..)
 103: (cwlft-cont #<word "it"> #<position44 44 "it">)
 104: (let ((#:g376529 (pos-capitalization position-before))) ..)
 105: (check-word-level-fsa-trigger #<word "it"> #<position44 44 "it">)
 106: (check-for/initiate-scan-patterns #<word "it"> #<position44 44 "it">)
 107: (let (([ ([-on-position-because-of-word? position-before word))) ..)
 108: (check-for-[-from-word-after #<word "it"> #<position44 44 "it">)
 109: (let ((] (]-on-position-because-of-word? position-before word))) ..)
 110: (check-for-]-from-word-after #<word "it"> #<position44 44 "it">)
 111: (let ((word (pos-terminal position))) (introduce-leading-brackets word position) (check-for-]-from-word-after word position))
 112: (scan-next-pos #<position44 44 "it">)
 113: (let (([ ([-on-position-because-of-word? position-after prior-word))) ..)
 114: (check-for-[-from-prior-word #<position44 44 "it"> #<word "as">)
 115: (let ((] (]-on-position-because-of-word? position-after prior-word))) ..)
 116: (check-for-]-from-prior-word #<position44 44 "it"> #<word "as">)
 117: (introduce-right-side-brackets #<word "as"> #<position44 44 "it">)
 118: (let ((position-after-edge-fsa (do-edge-level-fsas edges position-before))) ..)
 119: (check-edge-fsa-trigger (#<edge42 43 "as" 44>) #<position43 43 "as"> #<word "as"> #<position44 44 "it">)
 120: (let ((label (introduce-leading-brackets-from-edge-form-labels edges position-before))) ..)
 121: (check-preterminal-edges (#<edge42 43 "as" 44>) #<word "as"> #<position43 43 "as"> #<position44 44 "it">)
 122: (let ((edges (install-terminal-edges word position-before position-after))) ..)
 123: (introduce-terminal-edges #<word "as"> #<position43 43 "as"> #<position44 44 "it">)
 124: (let ((position-after (chart-position-after position-before))) ..)
 125: (word-level-actions #<word "as"> #<position43 43 "as">)
 126: (let ((where-fsa-ended (do-word-level-fsas word position-before))) ..)
 127: (cwlft-cont #<word "as"> #<position43 43 "as">)
 128: (let ((#:g376509 (pos-capitalization position-before))) ..)
 129: (check-word-level-fsa-trigger #<word "as"> #<position43 43 "as">)
 130: (check-for/initiate-scan-patterns #<word "as"> #<position43 43 "as">)
 131: (let (([ ([-on-position-because-of-word? position-before word))) ..)
 132: (check-for-[-from-word-after #<word "as"> #<position43 43 "as">)
 133: (scan-next-segment #<position43 43 "as">)
 134: (march-back-from-the-right/segment)
 135: (march-back-from-the-right/segment)
 136: (march-back-from-the-right/segment)
 137: (let ((] (]-on-position-because-of-word? position-before word))) ..)
 138: (check-for-]-from-word-after #<word "as"> #<position43 43 "as">)
 139: (let ((word (pos-terminal position))) (introduce-leading-brackets word position) (check-for-]-from-word-after word position))
 140: (scan-next-pos #<position43 43 "as">)
 141: (let (([ ([-on-position-because-of-word? position-after prior-word))) ..)
 142: (check-for-[-from-prior-word #<position43 43 "as"> #<word "mb">)
 143: (let ((] (]-on-position-because-of-word? position-after prior-word))) ..)
 144: (check-for-]-from-prior-word #<position43 43 "as"> #<word "mb">)
 145: (introduce-right-side-brackets #<word "mb"> #<position43 43 "as">)
 146: (let ((edges (install-terminal-edges word position-before position-after))) ..)
 147: (introduce-terminal-edges #<word "mb"> #<position42 42 "mb"> #<position43 43 "as">)
 148: (let ((position-after (chart-position-after position-before))) ..)
 149: (word-level-actions #<word "mb"> #<position42 42 "mb">)
 150: (let ((where-fsa-ended (do-word-level-fsas word position-before))) ..)
 151: (cwlft-cont #<word "mb"> #<position42 42 "mb">)
 152: (let () ..)
 153: (let ((status (pos-assessed? position-before))) ..)
 154: (continuation-after-pnf-returned-nil #<word "mb"> #<position42 42 "mb">)
 155: (let ((where-caps-fsa-ended (pnf position-before))) (if where-caps-fsa-ended (adjudicate-after-pnf where-caps-fsa-ended) (continuation-after-pnf-returned-nil word position-before)))
 156: (check-PNF-and-continue #<word "mb"> #<position42 42 "mb">)
 157: (let ((#:g376462 (pos-capitalization position-before))) ..)
 158: (check-word-level-fsa-trigger #<word "mb"> #<position42 42 "mb">)
 159: (let ((state/s (scan-pattern-starting-pair position-before word))) (if state/s (let (#) (if pos-reached # #)) (check-word-level-fsa-trigger word position-before)))
 160: (check-for/initiate-scan-patterns #<word "mb"> #<position42 42 "mb">)
 161: (let (([ ([-on-position-because-of-word? position-before word))) ..)
 162: (check-for-[-from-word-after #<word "mb"> #<position42 42 "mb">)
 163: (let ((] (]-on-position-because-of-word? position-before word))) ..)
 164: (check-for-]-from-word-after #<word "mb"> #<position42 42 "mb">)
 165: (let ((word (pos-terminal position))) (introduce-leading-brackets word position) (check-for-]-from-word-after word position))
 166: (scan-next-pos #<position42 42 "mb">)
 167: (let ((position-after-edge-fsa (do-edge-level-fsas edges position-before))) ..)
 168: (check-edge-fsa-trigger (#<edge38 41 digit-sequence 42>) #<position41 41 "100"> #<word "100"> #<position42 42 "mb">)
 169: (let ((] (]-on-position-because-of-word? position-before label))) ..)
 170: (check-for-]-from-edge-after (#<edge38 41 digit-sequence 42>) #<word "100"> #<position41 41 "100"> #<position42 42 "mb"> #<ref-category number>)
 171: (let ((label (introduce-leading-brackets-from-edge-form-labels edges position-before))) ..)
 172: (check-preterminal-edges (#<edge38 41 digit-sequence 42>) #<word "100"> #<position41 41 "100"> #<position42 42 "mb">)
 173: (let ((edges (install-terminal-edges word position-before position-after))) ..)
 174: (introduce-terminal-edges #<word "100"> #<position41 41 "100"> #<position42 42 "mb">)
 175: (let ((position-after (chart-position-after position-before))) ..)
 176: (word-level-actions #<word "100"> #<position41 41 "100">)
 177: (let ((where-fsa-ended (do-word-level-fsas word position-before))) ..)
 178: (cwlft-cont #<word "100"> #<position41 41 "100">)
 179: (let ((#:g376363 (pos-capitalization position-before))) ..)
 --more--
