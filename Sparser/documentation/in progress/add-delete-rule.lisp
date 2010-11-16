
When a rule is created it passes through construct-cfr [//double check
ETF entry point]. Besides making the object, that calls these forms:

    (note-file-location cfr)
    (note-grammar-module cfr :source source)

    (knit-into-psg-tables cfr)
    (catalog/cfr cfr r-symbol)

The call to note-grammar-module causes the rule to be included in this
lists maintained by the *grammar-module-being-loaded*, which itself is
maintained by gate-grammar.

So we should be able to turn the rules in a grammar module off and 
on again ad-lib, which could make for more flexible configurations
without having to create a new grammar configuration file each time.
E.g. we load the entire grammar (all of it that's debugged) and then
turn off as many modules as we need to -- since most modules are parts
of much larger modules that shouldn't take to many statements to do.

The question is turning a rule back on again. Also the matter of what
to do with actions that aren't part of the the rule system such as
those triggered by scanning a word and the FSAs, since the struct for
grammar-module (in /init/Lisp/grammar-module) doesn't include any
slots for recording them. 


The core deletion routine, delete/cfr, returns the old rule. It calls

    (flush-cfr-from-psg-tables cfr)
    (un-catalog/cfr cfr r-symbol)

Binary (n-ary) rules are removed from the multiplier table, unary are
removed from the rule set of the word. 