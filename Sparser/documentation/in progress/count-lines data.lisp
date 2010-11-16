On 9/18/09 with a "checkpoint" load

sparser> (count-lines-in-system)
; Loading
;    /Users/ddm/ws/nlp/Sparser/code/s/init/versions/v3.1/loaders/master-loader.lisp

;; (format t "~%~A~4,2T~A~10,2T~S"
;;         toplevel-forms line-count raw-namestring)

6   6     "tools;basics:loader"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/tools/basics/loader.lisp

8   8     "sugar;loader"
;     Loading
;        /Users/ddm/ws/nlp/Sparser/code/s/tools/basics/syntactic-sugar/loader.lisp

3   9     "sugar;then-and-else"
5   50    "sugar;strings"
6   53    "sugar;alists"
3   7     "sugar;predicates"
3   69    "sugar;printing"
2   5     "sugar;sorting"
4   29    "sugar;list hacking"
8   66    "basic tools;time"
9   24    "basic tools;no breaks"
7   8     "basic tools;debug stack"
2   14    "basic tools;SFL Clos"
5   5     "kons;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/tools/cons-resource/loader.lisp

3   6     "kons;heap"
26  71    "kons;alloc"
2   8     "kons;init"
6   26    "kons;kons"
3   3     "objects;traces:ops-loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/traces/ops-loader.lisp

17  56    "traces;trace function"
23  48    "traces;globals"
4   25    "rule objs;rule-links:object2"
3   3     "chart;units-labels:loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/chart/units-labels/loader1.lisp

2   3     "chart;units-labels:units"
3   7     "chart;units-labels:labels"
14  19    "chart;words:loader3"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/chart/words/loader3.lisp

18  153   "word-obj;object3"
4   40    "word-obj;def form"
7   33    "word-obj;catalog1"
3   24    "word-obj;whitespace"
7   77    "word-obj;resolve1"
19  147   "word-obj;polywords3"
3   62    "word-obj;polyword form1"
4   72    "word-obj;punctuation"
7   96    "word-obj;spaces"
3   24    "word-obj;whitespace"
2   23    "word-obj;section markers"
2   28    "word-obj;dummy words"
11  11    "lookup words;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/chart/words/lookup/loader1.lisp

13  59    "lookup words;buffer"
2   15    "lookup words;find"
2   27    "lookup words;canonical"
4   21    "lookup words;properties"
34  247   "lookup words;capitalization"
14  77    "lookup words;morphology"
3   22    "lookup words;switch new1"
3   17    "lookup words;constant1"
14  93    "lookup words;new words4"
2   9     "lookup words;testing"
6   11    "chart;categories1:loader2"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/chart/categories1/loader2.lisp

2   6     "cat;object2"
6   32    "cat;printers"
17  121   "cat;lookup1"
3   22    "cat;form1"
5   5     "chart;positions:loader3"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/chart/positions/loader3.lisp

14  80    "positions;positions1"
16  121   "positions;array2"
2   9     "positions;generic"
10  172   "positions;display"
5   5     "chart;edges:loader3"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/chart/edges/loader3.lisp

32  296   "edges;object3"
3   33    "edges;printers"
11  46    "edges;multiplication1"
24  183   "edges;resource4"
6   6     "chart;edge-vectors:loader3"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/chart/edge-vectors/loader3.lisp

3   30    "ev;switch"
16  165   "ev;object2"
7   49    "ev;printers2"
8   73    "ev;vectors2"
9   54    "ev;init2"
17  22    "rule objs;cfr:loader4"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/rules/cfr/loader4.lisp

6   25    "cfr;object1"
24  277   "cfr;dotted5"
6   72    "cfr;polywords1"
22  153   "cfr;printers1"
7   30    "cfr;catalog"
10  171   "cfr;lookup5"
6   91    "cfr;duplicates"
10  125   "cfr;multiplier3"
2   45    "cfr;form6"
3   42    "cfr;construct1"
11  225   "cfr;form-rule form"
5   75    "cfr;syntax rules"
2   17    "cfr;define5"
12  153   "cfr;delete4"
5   52    "cfr;knit in3"
2   2     "rule objs;csr:loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/rules/csr/loader.lisp

3   54    "csr;form"
4   37    "rule objs;rule-links:generic1"
6   6     "pattern-objects;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/rules/scan-patterns/loader.lisp

12  66    "pattern-objects;states"
2   26    "pattern-objects;pattern elements"
18  226   "pattern-objects;transitions"
7   35    "pattern-objects;patterns"
5   53    "pattern-objects;forms"
9   13    "chart;brackets:loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/chart/brackets/loader.lisp

5   28    "bracket;object"
9   61    "bracket;assignments1"
12  138   "bracket;printers1"
2   56    "bracket;catalog"
6   101   "bracket;intern1"
5   25    "bracket;rank"
4   57    "bracket;form1"
3   3     "chart;stack:loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/chart/stack/loader.lisp

7   27    "stack;object"
4   32    "stack;operations"
12  16    "objects;forms:loader7"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/objects/forms/loader7.lisp

2   3     "forms;words"
2   4     "forms;polyword4"
2   3     "forms;spaces1"
2   3     "forms;punctuation1"
2   4     "forms;context variables"
5   35    "forms;categories1"
5   23    "forms;cfrs4"
2   15    "forms;csrs1"
2   15    "forms;style"
3   14    "forms;form rules"
2   6     "forms;pair interiors"
5   5     "objects;chart:generics:loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/chart/generics/loader.lisp

7   79    "chart;generics:resolve1"
4   39    "chart;generics:delete"
12  86    "chart;generics:plist"
2   7     "chart;generics:pname"
9   29    "objects;model:loader2"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/objects/model/loader2.lisp

6   45    "objects;model:categories:structure"
3   18    "objects;model:categories:ops structure"
2   11    "objects;model:individuals:structure"
2   9     "objects;model:bindings:structure"
3   17    "objects;model:variables:structure1"
10  98    "objects;model:lattice-points:structure1"
2   14    "objects;model:psi:structure1"
8   8     "objects;model:bindings:loader2"
;     Loading
;        /Users/ddm/ws/nlp/Sparser/code/s/objects/model/bindings/loader2.lisp

16  221   "bindings;object2"
4   48    "bindings;printers1"
25  323   "bindings;index"
6   65    "bindings;make2"
9   105   "bindings;hooks"
13  86    "bindings;resource"
3   75    "bindings;alloc1"
10  10    "objects;model:individuals:loader2"
;     Loading
;        /Users/ddm/ws/nlp/Sparser/code/s/objects/model/individuals/loader2.lisp

6   34    "individuals;object"
17  202   "individuals;printers"
9   263   "individuals;decode2"
10  110   "individuals;find1"
9   65    "individuals;index"
9   106   "individuals;delete"
17  104   "individuals;resource1"
29  245   "individuals;make2"
26  284   "individuals;reclaim1"
6   6     "objects;model:variables:loader2"
;     Loading
;        /Users/ddm/ws/nlp/Sparser/code/s/objects/model/variables/loader2.lisp

4   21    "variables;object2"
7   46    "variables;printers2"
10  54    "variables;index2"
2   17    "variables;form"
3   30    "variables;make2"
13  13    "objects;model:lattice-points:loader1"
;     Loading
;        /Users/ddm/ws/nlp/Sparser/code/s/objects/model/lattice-points/loader1.lisp

23  166   "lattice-points;v+v objects2"
9   45    "lattice-points;c+v objects"
7   39    "lattice-points;printers"
24  270   "lattice-points;annotation"
6   21    "lattice-points;make1"
6   58    "lattice-points;find1"
3   59    "lattice-points;find or make at runtime1"
12  108   "lattice-points;initialize1"
4   20    "lattice-points;traverse1"
5   82    "lattice-points;specialize"
1   1     "lattice-points;dependent terms"
24  187   "lattice-points;operations1"
8   8     "objects;model:psi:loader1"
;     Loading
;        /Users/ddm/ws/nlp/Sparser/code/s/objects/model/psi/loader1.lisp

13  86    "psi;resource"
5   22    "psi;object1"
4   20    "psi;printing1"
6   72    "psi;make2"
10  148   "psi;find2"
9   102   "psi;find or make2"
3   9     "psi;extend2"
39  177   "psi;traces"
4   4     "objects;model:categories:loader1"
;     Loading
;        /Users/ddm/ws/nlp/Sparser/code/s/objects/model/categories/loader1.lisp

9   31    "categories;printing"
13  161   "categories;index instances1"
10  169   "categories;define1"
6   12    "objects;model:tree-families:loader1"
;     Loading
;        /Users/ddm/ws/nlp/Sparser/code/s/objects/model/tree-families/loader1.lisp

12  85    "tf;object1"
9   198   "tf;form1"
2   3     "tf;def form"
17  427   "tf;driver2"
9   257   "tf;subrs3"
14  293   "tf;rdata1"
3   3     "objects;export:loader"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/objects/export/loader.lisp

10  24    "objects;export:common"
1   2     "objects;export:etf"
1   1     "objects;export:mumble-grammar"
2   3     "objects;import:loader"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/objects/import/loader.lisp

6   6     "init-drivers;loader7"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/drivers/inits/loader7.lisp

34  108   "session-inits;globals1"
6   58    "init-drivers;articles2"
3   19    "init-drivers;runs1"
4   4     "action-drivers;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/drivers/actions/loader1.lisp

4   50    "action-drivers;object"
2   38    "action-drivers;hook1"
3   38    "action-drivers;trigger2"
10  20    "required-words;required1"
8   8     "chars;loader3"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/char-level/loader3.lisp

15  52    "chars;state2"
4   79    "chars;setup-string3"
6   48    "chars;setup-file3"
3   10    "chars;setup-switch1"
11  98    "chars;display1"
7   123   "chars;testing1"
6   22    "chars;testing-file"
16  16    "required-words;spaces"
10  12    "tokens;loader3"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/tokenizer/loader3.lisp

9   86    "tokens;alphabet fns"
6   21    "tokens;state2"
5   120   "tokens;punctuation"
3   47    "tokens;caps fsa"
4   82    "tokens;token FSA3"
2   6     "tokens;lookup2"
2   3     "tokens;next token3"
3   13    "tokens;NL buffer"
19  246   "tokens;testing1"
4   4     "run FSAs;loader4"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/analyzers/FSA/loader4.lisp

5   22    "run FSAs;dispatches"
10  193   "run FSAs;words2"
7   156   "run FSAs;edges1"
3   3     "init chart;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/psp/init/loader1.lisp

4   39    "init chart;init chart1"
2   22    "init chart;printer1"
9   333   "fsa;polywords4"
6   6     "fill chart;loader4"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/psp/fill-chart/loader4.lisp

11  37    "fill chart;globals"
6   65    "fill chart;add5"
4   62    "fill chart;store5"
8   40    "fill chart;newline"
2   29    "fill chart;testing"
3   3     "scan;loader2"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/psp/scan/loader2.lisp

3   37    "scan;scan1"
2   43    "scan;next-word"
4   4     "assess;loader6"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/psp/assess/loader6.lisp

10  215   "assess;terminal edges2"
3   28    "assess;nonterminals1"
3   13    "assess;switch2"
7   7     "check;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/psp/check/loader1.lisp

24  302   "check;multiply6"
1   1     "check;boundaries"
4   43    "check;one-one3"
2   24    "check;many-one1"
4   54    "check;one-many1"
3   40    "check;many-many1"
2   2     "analyzers;psp:threading:loader2"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/psp/threading/loader2.lisp

7   71    "threading;extension"
1   1     "march;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/psp/march/loader.lisp

22  28    "kinds of edges;loader2"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/psp/edges/loader2.lisp

4   65    "kinds of edges;single-new1"
3   53    "kinds of edges;binary1"
2   62    "kinds of edges;binary-explicit2"
3   133   "kinds of edges;binary-explicit all keys2"
3   64    "kinds of edges;cs2"
3   45    "kinds of edges;initial-new1"
2   26    "kinds of edges;unknown"
2   33    "kinds of edges;polyw1"
2   38    "kinds of edges;long scan1"
4   46    "kinds of edges;looking under"
3   3     "complete;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/psp/complete/loader1.lisp

8   69    "complete;complete HA3"
4   16    "complete;switch complete"
6   6     "annotation;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/psp/annotation/loader.lisp

8   14    "referent;loader3"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/psp/referent/loader3.lisp

4   16    "referent;composite referent"
20  67    "referent;driver2"
6   45    "referent;dispatch2"
14  210   "referent;decode exp1"
4   89    "referent;unary driver3"
5   105   "referent;cases1"
9   172   "referent;new decodings1"
7   270   "referent;new cases3"
2   4     "analyzers;psp:terminate"
7   7     "forest;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/forest/loader1.lisp

17  139   "forest;treetops"
3   100   "forest;sequence"
28  332   "forest;printers"
3   3     "forest;adjacency"
21  130   "forest;extract"
2   53    "forest;layout"
5   5     "traversal-routines;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/traversal/loader.lisp

3   61    "traversal-routines;form"
7   77    "traversal-routines;forest scan"
5   135   "traversal-routines;dispatch"
3   70    "traversal-routines;interiors1"
6   6     "scan-patterns;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/analyzers/psp/patterns/loader.lisp

6   68    "scan-patterns;take transitions"
1   1     "scan-patterns;start"
36  354   "scan-patterns;driver"
9   79    "scan-patterns;follow-out"
4   38    "scan-patterns;accept"
5   5     "do HA;loader"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/analyzers/HA/loader.lisp

5   75    "do HA;look"
2   2     "do HA;segment"
20  199   "do HA;place brackets1"
6   124   "do HA;inter-segment boundaries"
5   5     "do CA;loader1"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/analyzers/CA/loader1.lisp

6   15    "do CA;actions"
11  71    "do CA;scanners1"
2   44    "do CA;search2"
28  435   "do CA;anaphora3"
3   19    "session-inits;setup3"
41  41    "required-words;punctuation1"
131 413   "tokens;alphabet"
5   5     "required-brackets;required"
28  47    "gr-tests;parsing"
7   9     "source-drivers;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/drivers/sources/loader1.lisp

11  25    "source-drivers;state"
4   17    "source-drivers;core1"
3   5     "source-drivers;string"
4   19    "source-drivers;file1"
3   5     "source-drivers;open file"
10  34    "traces;online hook"
2   2     "articles;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/drivers/articles/loader.lisp

11  79    "articles;style"
6   6     "sink-drivers;loader1"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/drivers/sinks/loader1.lisp

3   9     "sink-drivers;articles"
5   15    "sink-drivers;records"
7   53    "sink-drivers;core"
46  289   "sink-drivers;export"
7   43    "sink-drivers;return-value"
2   2     "drivers;tokens:loader"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/drivers/tokens/loader.lisp

17  94    "drivers;tokens:next-terminal2"
9   9     "chart-drivers;loader"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/drivers/chart/loader.lisp

5   43    "chart-drivers;select2"
8   53    "chart-drivers;scan-all-terminals"
4   28    "chart-drivers;switch"
9   73    "chart-drivers;headers"
3   92    "chart-drivers;header labels"
5   27    "chart-drivers;hidden markup"
16  78    "chart-drivers;annotate last"
10  10    "chart-drivers;psp:loader5"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/drivers/chart/psp/loader5.lisp

39  130   "psp-drivers;flags"
5   78    "psp-drivers;initiate pattern scan"
28  377   "psp-drivers;scan3"
22  287   "psp-drivers;adjudicators1"
19  385   "psp-drivers;pts5"
12  292   "psp-drivers;march-seg5"
12  163   "psp-drivers;march-forest3"
15  163   "psp-drivers;PPTT8"
6   121   "psp-drivers;trigger5"
6   26    "chart-drivers;traversal1"
3   3     "chart-drivers;all-edges:loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/drivers/chart/all-edges/loader1.lisp

18  250   "all edges;loops"
4   5     "forest-drivers;loader"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/drivers/forest/loader.lisp

7   45    "forest-drivers;actions1"
4   61    "forest-drivers;trap2"
4   49    "drivers;DA:driver1"
23  288   "init-drivers;switches2"
23  23    "objects;traces:cases-loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/objects/traces/cases-loader1.lisp

3   3     "traces;tokenizer"
24  101   "traces;FSA1"
55  232   "traces;cap seq"
96  104   "traces;edges1"
185 855   "traces;psp1"
14  64    "traces;psp-all-edges"
24  100   "traces;scan patterns"
9   23    "traces;completion"
15  55    "traces;conjunction"
3   6     "traces;treetops"
15  48    "traces;CA"
35  134   "traces;DA"
16  46    "traces;HA"
63  271   "traces;DM&P"
8   17    "traces;discourse"
18  53    "traces;sections"
6   12    "traces;section stack"
8   18    "traces;sgml"
8   25    "traces;paragraphs"
2   3     "traces;readout"
7   30    "traces;debugging"
52  217   "traces;psi"
7   12    "file ops;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/interface/files/loader1.lisp

2   17    "file ops;decoding"
3   20    "file ops;file name"
6   15    "file ops;open-close"
4   13    "file ops;read switch1"
3   24    "file ops;read chars1"
8   45    "workbench;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/interface/workbench/loader.lisp

32  92    "workbench;globals"
13  80    "workbench;adjust"
13  141   "workbench;autodef data"
10  152   "workbench;def rule:save1"
6   11    "grammar-interface;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/interface/grammar/loader.lisp

3   37    "grammar-interface;postprocessing"
28  273   "grammar-interface;sort"
5   49    "grammar-interface;printing"
27  246   "grammar-interface;sort individuals"
4   4     "timing;loader"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/drivers/timing/loader.lisp

3   13    "timing;calculation"
12  125   "timing;presentation"
5   20    "timing;cases"
9   43    "measuring;distance between brackets"
7   71    "measuring;line count"
6   6     "citation-code;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/tests/citations/code/loader.lisp

8   32    "citation-code;object"
11  118   "citation-code;test"
4   23    "citation-code;input-output"
6   111   "citation-code;construction"
2   4     "citation-code;batches"
3   166   "loaders;grammar"
4   97    "grammar edge types;digits"
3   97    "grammar edge types;form rules"
2   50    "grammar edge types;CA"
2   39    "grammar edge types;pnf"
2   27    "grammar edge types;pronouns1"
4   7     "fsa;loader - model1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/rules/FSAs/loader---model1.lisp

11  200   "fsa;abbreviations2"
11  11    "fsa;single quote1"
11  112   "fsa;hyphen"
81  139   "the-categories;categories"
36  52    "brackets;types"
11  248   "brackets;judgements1"
14  30    "words;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/rules/words/loader1.lisp

3   47    "words;fn word routine"
31  31    "words;punctuation bracketing"
4   6     "words;punctuation rules"
10  14    "words;determiners"
18  18    "words;conjunctions"
5   5     "words;interjections"
35  36    "words;pronouns"
4   94    "words;quantifiers1"
36  42    "words;prepositions2"
12  12    "words;WH words"
43  48    "words;aux verbs"
15  15    "words;contractions"
2   5     "words;adjectives"
34  43    "words;adverbs"
2   2     "words;whitespace assignments"
21  21    "tree-families;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/rules/tree-families/loader1.lisp

5   50    "tree-families;single words"
42  628   "tree-families;morphology1"
5   82    "tree-families;postprocessing1"
10  170   "tree-families;NP"
8   76    "tree-families;np adjuncts"
15  132   "tree-families;pre-head np modifiers"
7   68    "tree-families;of"
2   2     "tree-families;dates"
1   9     "tree-families;vp"
5   45    "tree-families;transitive"
3   26    "tree-families;ditransitive"
4   57    "tree-families;indirect obj pattern"
6   117   "tree-families;verbs taking pps"
3   27    "tree-families;copula patterns"
2   25    "tree-families;that comp"
2   16    "tree-families;compounds"
3   18    "tree-families;prepositional phrases"
4   26    "tree-families;adjective phrases"
3   32    "tree-families;adverbs"
16  256   "tree-families;shortcuts"
2   11    "tree-families;interjections"
10  28    "syntax;loader3"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/rules/syntax/loader3.lisp

4   94    "syntax-morph;affix rules"
20  74    "syntax-vg;tense"
13  65    "syntax-vg;have"
26  116   "syntax-vg;be"
57  245   "syntax-vg;modals"
12  34    "syntax-vg;adverbs"
22  65    "syntax-art;articles"
20  271   "syntax-conj;conjunction7"
1   1     "syntax-rel;subject relatives"
8   60    "syntax-poss;possessive"
4   22    "syntax-comp;comparatives"
24  57    "syntax-comp;WH-word-semantics"
21  89    "syntax-comp;questions"
5   13    "adjuncts;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/core/adjuncts/loader.lisp

9   60    "approx;object"
5   28    "frequency;object"
12  34    "frequency;aux rules"
9   52    "sequence;object"
7   17    "places;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/core/places/loader1.lisp

19  90    "places;object"
6   35    "places;directions1"
4   34    "places;compass points"
3   7     "places;directional rules"
4   4     "countries;loader1"
;     Loading
;        /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/core/places/countries/loader1.lisp

5   46    "countries;object1"
5   29    "countries;relation"
4   4     "countries;rules1"
6   105   "places;city"
5   62    "places;U.S. States"
5   49    "places;other"
4   4     "places;rules2"
4   4     "collections;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/core/collections/loader1.lisp

4   20    "collections;object1"
11  262   "collections;operations2"
5   55    "collections;obj specific printers"
10  10    "numbers;loader2"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/core/numbers/loader2.lisp

27  91    "numbers;object1"
12  22    "numbers;categories1"
8   163   "numbers;form2"
25  368   "numbers;fsa digits6"
12  96    "numbers;fsa words"
8   67    "numbers;ordinals3"
4   16    "numbers;percentages1"
7   19    "numbers;rules"
4   14    "numbers;relation"
8   8     "amounts;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/core/amounts/loader1.lisp

4   15    "amounts;unit of measure1"
3   8     "amounts;quantities"
3   26    "amounts;measurements"
2   10    "amounts;object1"
17  135   "amounts;amount-change verbs"
9   47    "amounts;amount-chg relation"
2   4     "amounts;rules1"
2   2     "kinds;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/core/kinds/loader.lisp

5   59    "kinds;object"
2   6     "kinds;np rules"
4   4     "money;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/core/money/loader1.lisp

8   82    "money;objects1"
3   16    "money;printers"
3   7     "money;rules1"
14  14    "core;time:loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/core/time/loader1.lisp

2   4     "time;object"
2   7     "time;units1"
3   31    "time;weekdays1"
3   33    "time;months1"
3   15    "time;years2"
15  34    "time;time-of-day"
4   30    "time;relative moments"
4   28    "time;dates2"
6   33    "time;amounts"
6   30    "time;phrases1"
8   30    "time;anaphors1"
8   26    "time;age1"
25  145   "time;fiscal2"
5   7     "pronouns;loader2"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/core/pronouns/loader2.lisp

10  67    "pronouns;object1"
32  33    "pronouns;cases1"
2   10    "ambush;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/sl/ambush/loader.lisp

11  53    "ambush;call-signs"
8   25    "ambush;protocols"
6   20    "ambush;checkpoints"
2   4     "ambush;contact"
1   1     "ambush;perimeter"
1   1     "ambush;munitions"
1   1     "ambush;casualties"
1   1     "ambush;misc"
2   5     "ckpt;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/sl/checkpoint/loader.lisp

69  253   "ckpt;vocabulary"
8281  8351  "ckpt;adjectives"
54  147   "ckpt;rules"
4   8     "ha;loader1"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/rules/HA/loader1.lisp

4   82    "ha;driver"
3   43    "ha;both ends1"
2   28    "ha;determiner1"
2   83    "cat-prefs;category preferences"
44  281   "words;frequency"
30  128   "dossiers;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/model/dossiers/loader.lisp

0   0     "dossiers;irregular verbs"
2   2     "dossiers;semantics-free verbs"
2   2     "dossiers;new content words"
11  11    "dossiers;comparatives"
3   7     "dossiers;rules comparatives"
2   41    "dossiers;numbers"
2   33    "dossiers;ordinals"
5   5     "dossiers;time units"
8   8     "dossiers;deictic times"
8   8     "dossiers;weekdays"
13  13    "dossiers;months"
62  62    "dossiers;years"
39  39    "dossiers;time of day"
51  51    "dossiers;timezones"
6   6     "dossiers;approximations"
2   4     "dossiers;approximator rules"
9   9     "dossiers;frequency adverbs"
7   7     "dossiers;sequencers"
0   0     "dossiers;kinds"
2   2     "dossiers;location descriptions"
7   7     "dossiers;location kinds"
16  16    "dossiers;directions"
13  13    "dossiers;compass points"
22  22    "dossiers;spatial prepositions"
14  20    "dossiers;countries"
2   2     "dossiers;cities"
7   49    "dossiers;city rules"
52  99    "dossiers;U.S. States"
2   4     "dossiers;U.S. State rules"
2   2     "dossiers;regions"
5   5     "dossiers;units of measure"
2   2     "dossiers;quantities"
6   10    "dossiers;denominations of money"
5   9     "dossiers;currencies"
0   0     "dossiers;semantics-weak verbs"
apreq has 3 instances
ainrn has 2 instances
attributive has 3 instances
gradable has 21 instances
predicative has 2 instances
null-adj has 5 instances
greeting has 4 instances
acknowledgement has 3 instances
call-word has 1 instances
pronoun/plural has 5 instances
pronoun/inanimate has 3 instances
pronoun/female has 3 instances
pronoun/male has 4 instances
pronoun/first/plural has 5 instances
pronoun/first/singular has 5 instances
calculated-time has 2 instances
relative-time-noun has 1 instances
relative-time-adverb has 1 instances
year has 61 instances
month has 12 instances
weekday has 7 instances
time-unit has 4 instances
currency has 4 instances
fractional-denomination/money has 2 instances
denomination/money has 3 instances
unit-of-measure has 4 instances
ordinal has 31 instances
illions-distribution has 33 instances
multiplier has 7 instances
region has 1 instances
US-state has 51 instances
city has 2 instances
country has 13 instances
compass-point has 12 instances
direction has 15 instances
kind-of-location has 6 instances
sequencer has 6 instances
frequency-of-event has 8 instances
approximator has 5 instances
quantifier has 20 instances
6   6     "grammar;tests:loader"
;   Loading /Users/ddm/ws/nlp/Sparser/code/s/grammar/tests/loader.lisp

18  72    "gr-tests;workspace"
1   1     "gr-tests;rule deletion"
13  28    "gr-tests;edge resource"
8   8     "gr-tests;timing"
1   1     "gr-tests;edge-tests"
3   3     "citations;loader"
;   Loading
;      /Users/ddm/ws/nlp/Sparser/code/s/grammar/tests/citations/cases/loader.lisp

18  41    "citations;systematically organized"
9   26    "citations;new ones"Identical rules found:
#<PSR311  time-unit ->  hyphen time-unit>
#<PSR293  time-unit ->  hyphen time-unit>

-------------------------------------------
 163  Referential categories
 74   Syntactic form categories
 19   Mixin categories
 71   non-terminal categories
 100  dotted categories
-------------------------------------------
31  105   "version;workspace:abbreviations"
2   3     "version;workspace:traces"
39  39    "version;workspace:switch settings"
2   9     "version;workspace:basic tests"


-----------------------------------------
  601 files
  47026 lines of code
  14338 toplevel forms
-----------------------------------------
nil
sparser> 