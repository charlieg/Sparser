
/Sparser/Documentation/in progress/tests-and-results.lisp
9/18/09

Lists the location and occasionally the results of all the test files
and particularly salient tests that are scattered about the code base.


/grammar/tests/
   timing  
      -- Defines a set of strings of various lengths that are to be
         used to test specific amounts of effort on the part of the parser
         e.g. *1k-a-vice-president*
   parsing
      -- more specific test phrases and strings to probe different
         aspects of the parser's operations and state-space
   workspace
      -- cases and setups circa 6/95. Included canonial articles of the time
   edge-resource
   edge-tests
   left-slash-example

/analyzers/tokenizer/
   testing1
       -- Defines some canonical strings like *100-the* or *multi-buffer-string*
          Tests like test_tokenizer, test-speed-of-Token-fsa, 
                (test-word-lookup-speed) looking up "the" = 357,142.8  tokens/second

/analyzers/char-level/
    testing1
       -- Basics like test_max-testing-speed and tests over the character buffer. 
                (= loop speed:  120,481.9  iterations per second)


/drivers/timing/
    presentation
       -- Basic harnesses for testing arbitrary strings such as run-string-for-timing
          and an all-in-one that tries to decode the standard return from (time <form>)
    cases
       -- More strings e.g. *100-iraqi-girl*
    calculation
       -- Just start-timer and stop-timer based on (get-internal-real-time). 
          Moderately elegant.

/tools/timing/
     distance-between-brackets
     size-of-edge-vectors
     multiply
        -- with alternative version of multiply-edges for count of successful vs. not
     line-count
        -- an alternative system loader that produces a report of lines/files/forms for
           the currently loaded system.


Ad-hoc

   (length *words-defined*) = 951       ;; checkpoint load 9/18/09
   (length *categories-defined*) = 426  ;; dito
