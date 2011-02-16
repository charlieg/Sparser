;; dribble file 12/6/10
sparser> (setq *annotate-realizations* t)
t

sparser> (p "last month")
last month

                                 source-start
e2    time                    1 "last month" 3
                                 end-of-source

sparser> (ie 2)
#<edge2 1 time 3> is a structure of type edge.  It has these slots:
 category           #<ref-category time>
 form               #<ref-category np>
 referent           #<psi relative-time 83>
 starts-at          #<edges starting at 1>
 ends-at            #<edges ending at 3>
 rule               #<PSR361  time ->  sequencer time-unit>
 left-daughter      #<edge0 1 sequencer 2>
 right-daughter     #<edge1 2 time-unit 3>
 used-in            nil
 position-in-resource-array  2
 constituents       nil
 spanned-words      nil
#<edge2 1 time 3>

sparser> (d (setq i (edge-referent *)))
#<psi relative-time 83> is a structure of type psi.  It has these slots:
 plist              (:uid 83)
 id                 nil
 type               #<lp reference-time relativizer .  341>
 binds              nil
 bound-in           nil
 rnodes             nil
 lp                 #<lp reference-time relativizer .  341>
 v+v
    (#<v+v reference-time + #<"month" 3>  18>
     #<v+v relativizer + #<"last" 1>  16>
     #<Printer Error, obj=#x114fc362: attempt to call `vv-category' which is an undefined function.>)
 downlinks          nil
 source             #<psi relative-time 85>
 path               (#<psi relative-time 85> #<psi relative-time 86>)

sparser> (d (setq lp (psi-lp *)))
#<lp reference-time relativizer .  341> is a structure of type
lattice-point.  It has these slots:
 plist              nil
 index              341
 top-lp             #<top-lp-of relative-time  134>
 variables-bound    (#<variable reference-time> #<variable relativizer>)
 variables-free     nil
 realizations       (#<rnode #<schr np -> modifier np-head >>)
 down-pointers      nil
 upward-pointers    nil

sparser> (d (setq r (car (lp-realizations *))))
#<rnode #<schr np -> modifier np-head >> is a structure of type
realization-node.  It has these slots:
 plist              nil
 lattice-point      #<lp reference-time relativizer .  341>
 head               #<rnode #<schr type -> common-noun >>
 arg                #<rnode #<schr type -> content-word >>
 cfr                #<schr np -> modifier np-head >
 downward-links     nil


sparser> (setq last (edge-referent (e# 0)))
#<sequencer "last" 1>
sparser> (d *)
#<sequencer "last" 1> is a structure of type individual.  It has these
slots:
 plist
    (:rules (#<PSR1636  sequencer ->  "last">) :uid 463 :permanent t)
 id                 1
 type               (#<ref-category sequencer>)
 binds              (#<nil name = #<word "last">>)
 bound-in           nil
 rnodes             (#<rnode #<schr type -> content-word >>)

sparser> (setq month (edge-referent (e# 1)))
#<time-unit "month" 3>
sparser> (d *)
#<time-unit "month" 3> is a structure of type individual.  It has these
slots:
 plist
    (:rules
     (#<PSR1303  time-unit ->  "month">
      #<PSR1304  time-unit ->  "months">)
     :uid 339 :permanent t)
 id                 3
 type               (#<ref-category time-unit>)
 binds              (#<nil name = #<word "month">>)
 bound-in           nil
 rnodes             (#<rnode #<schr type -> common-noun >>)

sparser> (make-an-individual 'relative-time :relativizer last :reference-time month)
#<relative-time 2>
sparser> (d (setq i *))
#<relative-time 2> is a structure of type individual.  It has these
slots:
 plist              (:uid 482)
 id                 2
 type               (#<ref-category relative-time>)
 binds
    (#<304 reference-time = #<time-unit "month" 3>>
     #<305 relativizer = #<sequencer "last" 1>>)
 bound-in           nil
 rnodes             nil ;; Rnodes are on the PSI

;;?? No realizations on the top-lp of the relative-time category.
;;   Should there be?
sparser> (d (setq i *))
#<relative-time 2> is a structure of type individual.  It has these
slots:
 plist              (:uid 482)
 id                 2
 type               (#<ref-category relative-time>)
 binds
    (#<304 reference-time = #<time-unit "month" 3>>
     #<305 relativizer = #<sequencer "last" 1>>)
 bound-in           nil
 rnodes             nil
#<relative-time 2>

sparser> (d (car (indiv-type *)))
#<ref-category relative-time> is a structure of type
referential-category.  It has these slots:
 plist
    (:instances (#<relative-time 2> #<relative-time 1>) :count 2
     :grammar-module #<grammar-module *time*> :file-location
     "/Users/ddm/Sparser/Sparser/code/s/init/scripts/../../../../code/s/grammar/model/core/time/relative-moments.lisp")
 symbol             category::relative-time
 rule-set           nil
 slots              (#<variable relativizer> #<variable reference-time>)
 binds              nil
 realization
    (:schema
     (:no-head-word #<etf modifier-creates-definite-individual>
      ((np . #<ref-category time>)
       (modifier #<ref-category approximator>
        #<ref-category sequencer>)
       (np-head #<ref-category time> #<ref-category time-unit>
                #<ref-category month> #<ref-category weekday>)
       (result-type . #<ref-category relative-time>)
       (individuator . #<variable relativizer>)
       (base-category . #<variable reference-time>))
      nil)
     :rules
     (#<PSR379  weekday ->  hyphen weekday>
      #<PSR378  weekday ->  hyphen month>
      #<PSR377  weekday ->  hyphen time-unit>
      #<PSR376  weekday ->  hyphen time>
      #<PSR375  month ->  hyphen weekday>
      #<PSR374  month ->  hyphen month>
      #<PSR373  month ->  hyphen time-unit>
      #<PSR372  month ->  hyphen time>
      #<PSR371  time-unit ->  hyphen weekday>
      #<PSR370  time-unit ->  hyphen month>
      #<PSR369  time-unit ->  hyphen time-unit>
      #<PSR368  time-unit ->  hyphen time>
      #<PSR367  time ->  hyphen weekday>
      #<PSR366  time ->  hyphen month>
      #<PSR365  time ->  hyphen time-unit>
      #<PSR364  time ->  hyphen time>
      #<PSR363  time ->  sequencer weekday>
      #<PSR362  time ->  sequencer month>
      #<PSR361  time ->  sequencer time-unit>
      #<PSR360  time ->  sequencer time>
      #<PSR359  time ->  approximator weekday>
      #<PSR358  time ->  approximator month>
      #<PSR357  time ->  approximator time-unit>
      #<PSR356  time ->  approximator time>))
 lattice-position   #<top-lp-of relative-time  134>
 operations         #<operations for relative-time>
 mix-ins            nil
 instances
    ((#<time-unit "month" 3>
      (#<sequencer "last" 1> . #<relative-time 2>))
     ((:violation "The type of the individual given as the value,
   #<time-unit \"month\" 3>
does not match the value restriction #<ref-category time>")
      ((:violation "The type of the individual given as the value,
   #<sequencer \"last\" 1>
does not match the value restriction #<ref-category relative-time-adverb>")
       . #<relative-time 1>)))
 rnodes             nil
#<ref-category relative-time>

sparser> (d (setq lp (cat-lattice-position *)))
#<top-lp-of relative-time  134> is a structure of type
top-lattice-point.  It has these slots:
 plist              nil
 index              134
 top-lp             #<top-lp-of relative-time  134>
 variables-bound    nil
 variables-free     (#<variable relativizer> #<variable reference-time>)
 realizations       nil
 down-pointers
    ((#<variable relativizer>
      . #<lp relativizer . reference-time  340>))
 upward-pointers    nil
 category           #<ref-category relative-time>
 super-category     #<ref-category time>
 subtypes           nil
 top-psi            #<psi relative-time 86>
 subnodes
    ((2 #<lp reference-time relativizer .  341>)
     (1 #<lp relativizer . reference-time  340>))
 index-by-variable  nil
 c+v
    ((#<c+v relative-time + reference-time  2>)
     (#<c+v relative-time + relativizer  1>))
 v+v                nil
 indiv-uses         nil

sparser> (d (lp-down-pointers *))
((#<variable relativizer> . #<lp relativizer . reference-time  340>))
is a tenured cons.
((#<variable relativizer> . #<lp relativizer . reference-time  340>))
sparser> (d (cdar *))
#<lp relativizer . reference-time  340> is a structure of type
lattice-point.  It has these slots:
 plist              nil
 index              340
 top-lp             #<top-lp-of relative-time  134>
 variables-bound    (#<variable relativizer>)
 variables-free     (#<variable reference-time>)
 realizations       nil
 down-pointers
    ((#<variable reference-time>
      . #<lp reference-time relativizer .  341>))
 upward-pointers    nil

sparser> (d (cdar (lp-down-pointers *)))
#<lp reference-time relativizer .  341> is a structure of type
lattice-point.  It has these slots:
 plist              nil
 index              341
 top-lp             #<top-lp-of relative-time  134>
 variables-bound    (#<variable reference-time> #<variable relativizer>)
 variables-free     nil
 realizations       (#<rnode #<schr np -> modifier np-head >>)
 down-pointers      nil
 upward-pointers    nil

;; The bottom LP, the one for the phrase as a whole, got a realization,
;; but nothing was passed up -- That's presumably fixable.

sparser> (lp# 341)
#<lp reference-time relativizer .  341>

sparser> (d (setq rnode (car (lp-realizations *))))
#<rnode #<schr np -> modifier np-head >> is a structure of type
realization-node.  It has these slots:
 plist              nil
 lattice-point      #<lp reference-time relativizer .  341>
 head               #<rnode #<schr type -> common-noun >>
 arg                #<rnode #<schr type -> content-word >>
 cfr                #<schr np -> modifier np-head >
 downward-links     nil
#<rnode #<schr np -> modifier np-head >>

sparser> (d (setq schema (rn-cfr *)))
#<schr np -> modifier np-head > is a structure of type schematic-rule.
It has these slots:
 relation           :definite-modifier
 lhs                np
 rhs                (modifier np-head)
 referent
    (:instantiate-individual result-type :binds
     (individuator left-referent base-category right-referent))
 descriptors
    (:length-of-rhs 2 :head-edge right-edge :binding-spec
     (individuator left-edge base-category right-edge)
     :instantiate-individual result-type)
 original-expression
    (:definite-modifier
     (np (modifier np-head) :instantiate-individual result-type :binds
      (individuator left-referent base-category right-referent))
     (:length-of-rhs 2 :head-edge right-edge :binding-spec
      (individuator left-edge base-category right-edge)
      :instantiate-individual result-type))
 tree-family        #<etf modifier-creates-definite-individual>
 form               nil
#<schr np -> modifier np-head >

