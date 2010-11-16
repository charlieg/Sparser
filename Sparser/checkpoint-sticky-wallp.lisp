
;; checkpoint test after obvious cases of sticky psi have been fixed
;; Friday 8/28/09

Type (in-package :sparser) to use Sparser symbols directly.

t
cl-user> (in-package :sparser)
#<The sparser package>
sparser> (trace-psi-construction)
t
sparser> (checkpoint-regression-test)

Making psi for the category #<ref-category car>
Allocating new psi #100
   made #<psi car 100>
Making psi for the category #<ref-category relative-location>
Allocating new psi #99
   made #<psi relative-location 99>
Need a psi that extends #<psi relative-location 99>
    by binding functor to #<spatial-orientation "in" 10>
  No existing psi binds functor to #<spatial-orientation "in" 10>
  Made the v+v #<v+v functor + #<"in" 10>  1>
Allocating new psi #98
Bound functor to make the more saturated #<psi relative-location 98>
Need a psi that extends #<psi relative-location 98>
    by binding place to #<psi car 100>
  No existing psi binds place to #<psi car 100>
  Made the v+v #<v+v place + #<psi car 100>  2>
Allocating new psi #97
Bound place to make the more saturated #<psi relative-location 97>
Making psi for the category #<ref-category get>
Allocating new psi #96
   made #<psi get 96>
Need a psi that extends #<psi get 96>
    by binding location to #<psi relative-location 97>
  No existing psi binds location to #<psi relative-location 97>
  Made the v+v #<v+v location + #<psi relative-location 97>  3>
Allocating new psi #95
Bound location to make the more saturated #<psi get 95>
Good: "get in the car"


Making psi for the category #<ref-category trunk>
Allocating new psi #94
   made #<psi trunk 94>
Making psi for the category #<ref-category open>
Allocating new psi #93
   made #<psi open 93>
Need a psi that extends #<psi open 93>
    by binding object to #<psi trunk 94>
  No existing psi binds object to #<psi trunk 94>
  Made the v+v #<v+v object + #<psi trunk 94>  4>
Allocating new psi #92
Bound object to make the more saturated #<psi open 92>
Good: "open the trunk"


Making psi for the category #<ref-category with-np>
Allocating new psi #91
   made #<psi with-np 91>
Need a psi that extends #<psi with-np 91>
    by binding content to #<pronoun/male "him" 2>
  No existing psi binds content to #<pronoun/male "him" 2>
  Made the v+v #<v+v content + #<"him" 2>  5>
Allocating new psi #90
Bound content to make the more saturated #<psi with-np 90>
Making psi for the category #<ref-category go>
Allocating new psi #89
   made #<psi go 89>
Need a psi that extends #<psi go 89>
    by binding location to #<deictic-location "over there" 1>
  No existing psi binds location to #<deictic-location "over there" 1>
  Made the v+v #<v+v location + #<"over there" 1>  6>
Allocating new psi #88
Bound location to make the more saturated #<psi go 88>
Need a psi that extends #<psi go 88>
    by binding modifier to #<psi with-np 90>
  No existing psi binds modifier to #<psi with-np 90>
  Made the v+v #<v+v modifier + #<psi with-np 90>  7>
Allocating new psi #87
Bound modifier to make the more saturated #<psi go 87>
Need a psi that extends #<psi go 87>
    by binding modifier to #<ref-category please>
  No existing psi binds modifier to #<ref-category please>
  Made the v+v #<v+v modifier + #<ref-category please>  8>
Allocating new psi #86
Bound modifier to make the more saturated #<psi go 86>
Good: "go over there with him please"


Making psi for the category #<ref-category move/along>
Allocating new psi #85
   made #<psi move/along 85>
Good: "move along"


Making psi for the category #<ref-category trunk>
   found existing #<psi trunk 94>
Need a psi that extends #<psi open 93>
    by binding object to #<psi trunk 94>
  Retrieved #<psi open 92>
    from #<v+v object + #<psi trunk 94>  4>
Need a psi that extends #<psi open 92>
    by binding modifier to #<ref-category please>
  Retrieved #<psi go 86>
    but its v+v were not consistent with
    those on #<psi open 92>
Allocating new psi #84
Bound modifier to make the more saturated #<psi open 84>
 added #<psi open 84> to #<v+v modifier + #<ref-category please>  8>
Good: "please open the trunk"


Making psi for the category #<ref-category come>
Allocating new psi #83
   made #<psi come 83>
Need a psi that extends #<psi come 83>
    by binding location to #<deictic-location "over here" 2>
  No existing psi binds location to #<deictic-location "over here" 2>
  Made the v+v #<v+v location + #<"over here" 2>  9>
Allocating new psi #82
Bound location to make the more saturated #<psi come 82>
Good: "come over here"


Making psi for the category #<ref-category car>
   found existing #<psi car 100>
Need a psi that extends #<psi relative-location 99>
    by binding functor to #<deallocated individual 392>
  No existing psi binds functor to #<deallocated individual 392>
  Made the v+v #<v+v functor + #<deallocated individual 392>  10>
Allocating new psi #81
Bound functor to make the more saturated #<psi relative-location 81>
Need a psi that extends #<psi relative-location 81>
    by binding place to #<psi car 100>
  Retrieved #<psi relative-location 97>
    but its v+v were not consistent with
    those on #<psi relative-location 81>
Allocating new psi #80
Bound place to make the more saturated #<psi relative-location 80>
 added #<psi relative-location 80> to #<v+v place + #<psi car 100>  2>
Need a psi that extends #<psi get 96>
    by binding location to #<psi relative-location 80>
  No existing psi binds location to #<psi relative-location 80>
  Made the v+v #<v+v location + #<psi relative-location 80>  11>
Allocating new psi #79
Bound location to make the more saturated #<psi get 79>
Good: "get out of the car"


Making psi for the category #<ref-category stand>
Allocating new psi #78
   made #<psi stand 78>
Need a psi that extends #<psi stand 78>
    by binding location to #<deictic-location "over there" 1>
  No existing psi binds location to #<deictic-location "over there" 1>
  Made the v+v #<v+v location + #<"over there" 1>  12>
Allocating new psi #77
Bound location to make the more saturated #<psi stand 77>
Good: "stand over there"


Making psi for the category #<ref-category stand/up>
Allocating new psi #76
   made #<psi stand/up 76>
Good: "stand up"


Making psi for the category #<ref-category sit/down>
Allocating new psi #75
   made #<psi sit/down 75>
Good: "sit down"


Need a psi that extends #<psi sit/down 75>
    by binding location to #<deictic-location "over there" 1>
  No existing psi binds location to #<deictic-location "over there" 1>
  Made the v+v #<v+v location + #<"over there" 1>  13>
Allocating new psi #74
Bound location to make the more saturated #<psi sit/down 74>
Bad! for "sit down over there"
  expected (speech_act 
	    (form request)
            (content
             (event
	      (type sit_down)
              (location
	       (type deictic_location)
               (realization over there)))))
  but got (speech_act
	   (form request)
           (content
            (event
	     (type sit_down)
             (location
              (entity ;; <========== extra layer
	       (type deictic_location)
               (realization over there))))))


Need a psi that extends #<psi with-np 91>
    by binding content to #<pronoun/first/singular "me" 2>
  No existing psi binds content to #<pronoun/first/singular "me" 2>
  Made the v+v #<v+v content + #<"me" 2>  14>
Allocating new psi #73
Bound content to make the more saturated #<psi with-np 73>
Need a psi that extends #<psi come 83>
    by binding modifier to #<psi with-np 73>
  No existing psi binds modifier to #<psi with-np 73>
  Made the v+v #<v+v modifier + #<psi with-np 73>  15>
Allocating new psi #72
Bound modifier to make the more saturated #<psi come 72>
Good: "come with me"


Making psi for the category #<ref-category proceed>
Allocating new psi #71
   made #<psi proceed 71>
Need a psi that extends #<psi proceed 71>
    by binding participant to #<pronoun/second "you" 1>
  No existing psi binds participant to #<pronoun/second "you" 1>
  Made the v+v #<v+v participant + #<"you" 1>  16>
Allocating new psi #70
Bound participant to make the more saturated #<psi proceed 70>
Good: "you may proceed"


Need a psi that extends #<psi come 83>
    by binding location to #<deallocated individual 401>
  No existing psi binds location to #<deallocated individual 401>
  Made the v+v #<v+v location + #<deallocated individual 401>  17>
Allocating new psi #69
Bound location to make the more saturated #<psi come 69>
Good: "come along"


Need a psi that extends #<psi with-np 91>
    by binding content to #<pronoun/first/singular "me" 2>
  Retrieved #<psi with-np 73>
    from #<v+v content + #<"me" 2>  14>
Need a psi that extends #<psi come 83>
    by binding modifier to #<psi with-np 73>
  Retrieved #<psi come 72>
    from #<v+v modifier + #<psi with-np 73>  15>
Need a psi that extends #<psi come 72>
    by binding modifier to #<ref-category please>
  None of the 2 retrieved psi
    were consistent with #<psi come 72>
Allocating new psi #68
Bound modifier to make the more saturated #<psi come 68>
 added #<psi come 68> to #<v+v modifier + #<ref-category please>  8>
Good: "come with me please"


Good: "move along"

Good: "hello"

Good: "yes"


Making psi for the category #<ref-category car>
   found existing #<psi car 100>
Need a psi that extends #<psi with-np 91>
    by binding content to #<pronoun/second "you" 1>
  No existing psi binds content to #<pronoun/second "you" 1>
  Made the v+v #<v+v content + #<"you" 1>  18>
Allocating new psi #67
Bound content to make the more saturated #<psi with-np 67>
Need a psi that extends #<psi relative-location 99>
    by binding functor to #<deallocated individual 397>
  Retrieved #<psi relative-location 98>
    from #<v+v functor + #<deallocated individual 397>  1>
Need a psi that extends #<psi relative-location 98>
    by binding place to #<psi car 100>
  Retrieved #<psi relative-location 97>
    from among the psi associated with #<v+v place + #<psi car 100>  2>
Making psi for the category #<ref-category question>
Allocating new psi #66
   made #<psi question 66>
Need a psi that extends #<psi question 66>
    by binding type to #<ref-category who>
  No existing psi binds type to #<ref-category who>
  Made the v+v #<v+v type + #<ref-category who>  19>
Allocating new psi #65
Bound type to make the more saturated #<psi question 65>
Need a psi that extends #<psi question 65>
    by binding content to #<psi relative-location 97>
  No existing psi binds content to #<psi relative-location 97>
  Made the v+v #<v+v content + #<psi relative-location 97>  20>
Allocating new psi #64
Bound content to make the more saturated #<psi question 64>
Need a psi that extends #<psi question 64>
    by binding modifier to #<psi with-np 67>
  No existing psi binds modifier to #<psi with-np 67>
  Made the v+v #<v+v modifier + #<psi with-np 67>  21>
Allocating new psi #63
Bound modifier to make the more saturated #<psi question 63>
Bad! for "who's in the car with you"
  expected (speech_act 
	    (form question)
            (modifier
	     (type with_np)
             (content
              (entity 
	       (type pronoun_second)
	       (realization you))))
            (content
	     (type relative_location)
             (place
	      (entity (type car)))
             (functor (type spatial_orientation) (realization in)))
            (type who))

  but got (speech_act 
	   (form request) ;; toplevel had been question
           (content
            (event  ;; extra layer?
	     (form question) ;; This looks like the original
             (modifier
	      (type with_np)
              (content
               (entity
		(type pronoun_second)
		(realization you))))
             (content 
	      (type relative_location)
              (place
	       (entity (type car)))
              (functor (type spatial_orientation) (realization in)))
             (type who))))


Need a psi that extends #<psi with-np 91>
    by binding content to #<pronoun/second "you" 1>
  Retrieved #<psi with-np 67>
    from #<v+v content + #<"you" 1>  18>
Need a psi that extends #<psi question 66>
    by binding type to #<ref-category who>
  Retrieved #<psi question 65>
    from #<v+v type + #<ref-category who>  19>
Need a psi that extends #<psi question 65>
    by binding content to #<psi with-np 67>
  No existing psi binds content to #<psi with-np 67>
  Made the v+v #<v+v content + #<psi with-np 67>  22>
Allocating new psi #62
Bound content to make the more saturated #<psi question 62>
Bad! for "who's with you"
  expected (speech_act 
	    (form question)
            (content
	     (type with_np)
             (content
              (entity (type pronoun_second) (realization you))))
            (type who))

  but got (speech_act (form request)
           (content
            (event ;; extra layer again
	     (form question)
             (content
	      (type with_np)
              (content
               (entity (type pronoun_second) (realization you))))
             (type who))))


Making psi for the category #<ref-category truck>
Allocating new psi #61
   made #<psi truck 61>
Need a psi that extends #<psi relative-location 99>
    by binding functor to #<deallocated individual 397>
  Retrieved #<psi relative-location 98>
    from #<v+v functor + #<deallocated individual 397>  1>
Need a psi that extends #<psi relative-location 98>
    by binding place to #<psi truck 61>
  No existing psi binds place to #<psi truck 61>
  Made the v+v #<v+v place + #<psi truck 61>  23>
Allocating new psi #60
Bound place to make the more saturated #<psi relative-location 60>
Need a psi that extends #<psi question 66>
    by binding type to #<ref-category what>
  No existing psi binds type to #<ref-category what>
  Made the v+v #<v+v type + #<ref-category what>  24>
Allocating new psi #59
Bound type to make the more saturated #<psi question 59>
Need a psi that extends #<psi question 59>
    by binding content to #<psi relative-location 60>
  No existing psi binds content to #<psi relative-location 60>
  Made the v+v #<v+v content + #<psi relative-location 60>  25>
Allocating new psi #58
Bound content to make the more saturated #<psi question 58>
Bad! for "what is in the truck"
  expected (speech_act (form question)
            (content (type relative_location)
             (place (entity (type truck)))
             (functor (type spatial_orientation) (realization in)))
            (type what))
    ;; another case of an additional layer
  but got (speech_act (form request)
           (content
            (event (form question)
             (content (type relative_location)
              (place (entity (type truck)))
              (functor (type spatial_orientation) (realization in)))
             (type what))))


Making psi for the category #<ref-category trunk>
   found existing #<psi trunk 94>
Need a psi that extends #<psi relative-location 99>
    by binding functor to #<deallocated individual 397>
  Retrieved #<psi relative-location 98>
    from #<v+v functor + #<deallocated individual 397>  1>
Need a psi that extends #<psi relative-location 98>
    by binding place to #<psi trunk 94>
  No existing psi binds place to #<psi trunk 94>
  Made the v+v #<v+v place + #<psi trunk 94>  26>
Allocating new psi #57
Bound place to make the more saturated #<psi relative-location 57>
Need a psi that extends #<psi question 66>
    by binding type to #<ref-category what>
  Retrieved #<psi question 59>
    from #<v+v type + #<ref-category what>  24>
Need a psi that extends #<psi question 59>
    by binding content to #<psi relative-location 57>
  No existing psi binds content to #<psi relative-location 57>
  Made the v+v #<v+v content + #<psi relative-location 57>  27>
Allocating new psi #56
Bound content to make the more saturated #<psi question 56>
Bad! for "what's in the trunk"
  expected (speech_act (form question)
            (content (type relative_location)
             (place (entity (type trunk)))
             (functor (type spatial_orientation) (realization in)))
            (type what))
    ;; another layer -- looks like a change that didn't get committed?
    ;; (request vs. question)
  but got (speech_act (form request)
           (content
            (event (form question)
             (content (type relative_location)
              (place (entity (type trunk)))
              (functor (type spatial_orientation) (realization in)))
             (type what))))


Need a psi that extends #<psi relative-location 99>
    by binding functor to #<deallocated individual 397>
  Retrieved #<psi relative-location 98>
    from #<v+v functor + #<deallocated individual 397>  1>
Need a psi that extends #<psi relative-location 98>
    by binding place to #<direction "back" 6>
  No existing psi binds place to #<direction "back" 6>
  Made the v+v #<v+v place + #<"back" 6>  28>
Allocating new psi #55
Bound place to make the more saturated #<psi relative-location 55>
Need a psi that extends #<psi question 66>
    by binding type to #<ref-category who>
  Retrieved #<psi question 65>
    from #<v+v type + #<ref-category who>  19>
Need a psi that extends #<psi question 65>
    by binding content to #<psi relative-location 55>
  No existing psi binds content to #<psi relative-location 55>
  Made the v+v #<v+v content + #<psi relative-location 55>  29>
Allocating new psi #54
Bound content to make the more saturated #<psi question 54>

Bad! for "who's in back"
  expected (speech_act (form question)
            (content (type relative_location)
             (place (entity (type direction) (realization back)))
             (functor (type spatial_orientation) (realization in)))
            (type who))
    ;; ditto
  but got (speech_act (form request)
           (content
            (event (form question)
             (content (type relative_location)
              (place (entity (type direction) (realization back)))
              (functor (type spatial_orientation) (realization in)))
             (type who))))


Need a psi that extends #<psi question 66>
    by binding type to #<ref-category why>
  No existing psi binds type to #<ref-category why>
  Made the v+v #<v+v type + #<ref-category why>  30>
Allocating new psi #53
Bound type to make the more saturated #<psi question 53>
Need a psi that extends #<psi question 53>
    by binding participant to #<pronoun/second "you" 1>
  No existing psi binds participant to #<pronoun/second "you" 1>
  Made the v+v #<v+v participant + #<"you" 1>  31>
Allocating new psi #52
Bound participant to make the more saturated #<psi question 52>
Need a psi that extends #<psi question 52>
    by binding location to #<deallocated individual 386>
  No existing psi binds location to #<deallocated individual 386>
  Made the v+v #<v+v location + #<deallocated individual 386>  32>
Allocating new psi #51
Bound location to make the more saturated #<psi question 51>
Need a psi that extends #<psi question 51>
    by binding time to #<calculated-day "today" 1>
  No existing psi binds time to #<calculated-day "today" 1>
  Made the v+v #<v+v time + #<"today" 1>  33>
Allocating new psi #50
Bound time to make the more saturated #<psi question 50>
Bad! for "why are you out today"
  expected (speech_act (form question)
            (time (entity (type calculated_day) (realization today)))
            (location
             (entity (type spatial_orientation) (realization out)))
            (participant
             (entity (type pronoun_second) (realization you)))
            (type why))
    ;; ditto
  but got (speech_act (form request)
           (content
            (event (form question)
             (time (entity (type calculated_day) (realization today)))
             (location
              (entity (type spatial_orientation) (realization out)))
             (participant
              (entity (type pronoun_second) (realization you)))
             (type why))))



Making psi for the category #<ref-category car>
   found existing #<psi car 100>
Need a psi that extends #<psi relative-location 99>
    by binding functor to #<deallocated individual 397>
  Retrieved #<psi relative-location 98>
    from #<v+v functor + #<deallocated individual 397>  1>
Need a psi that extends #<psi relative-location 98>
    by binding place to #<psi car 100>
  Retrieved #<psi relative-location 97>
    from among the psi associated with #<v+v place + #<psi car 100>  2>
Need a psi that extends #<psi question 66>
    by binding type to #<ref-category who>
  Retrieved #<psi question 65>
    from #<v+v type + #<ref-category who>  19>
Need a psi that extends #<psi question 65>
    by binding content to #<psi relative-location 97>
  Retrieved #<psi question 64>
    from #<v+v content + #<psi relative-location 97>  20>
Bad! for "who's in the car"
  expected (speech_act (form question)
            (content (type relative_location)
             (place (entity (type car)))
             (functor (type spatial_orientation) (realization in)))
            (type who))
     ;; ditto
  but got (speech_act (form request)
           (content
            (event (form question)
             (content (type relative_location)
              (place (entity (type car)))
              (functor (type spatial_orientation) (realization in)))
             (type who))))



Need a psi that extends #<psi question 66>
    by binding type to #<ref-category where>
  No existing psi binds type to #<ref-category where>
  Made the v+v #<v+v type + #<ref-category where>  34>
Allocating new psi #49
Bound type to make the more saturated #<psi question 49>
Need a psi that extends #<psi question 49>
    by binding participant to #<pronoun/second "you" 1>
  Retrieved #<psi question 52>
    but its v+v were not consistent with
    those on #<psi question 49>
Allocating new psi #48
Bound participant to make the more saturated #<psi question 48>
 added #<psi question 48> to #<v+v participant + #<"you" 1>  31>
Need a psi that extends #<psi question 48>
    by binding location to #<prep-location "from" 1>
  No existing psi binds location to #<prep-location "from" 1>
  Made the v+v #<v+v location + #<"from" 1>  35>
Allocating new psi #47
Bound location to make the more saturated #<psi question 47>
Bad! for "where are you from"
  expected (speech_act (form question)
            (location 
	     (entity (type prep_location) (realization from)))
            (participant
             (entity (type pronoun_second) (realization you)))
            (type where))
     ;; ditto
  but got (speech_act (form request)
           (content
            (event (form question)
             (location
              (entity (type prep_location) (realization from)))
             (participant
              (entity (type pronoun_second) (realization you)))
             (type where))))



Need a psi that extends #<psi go 89>
    by binding participant to #<pronoun/second "you" 1>
  Retrieved #<psi proceed 70>
    from #<v+v participant + #<"you" 1>  16>
Need a psi that extends #<psi question 66>
    by binding type to #<ref-category where>
  Retrieved #<psi question 49>
    from #<v+v type + #<ref-category where>  34>
Need a psi that extends #<psi question 49>
    by binding content to #<psi proceed 70>
  No existing psi binds content to #<psi proceed 70>
  Made the v+v #<v+v content + #<psi proceed 70>  36>
Allocating new psi #46
Bound content to make the more saturated #<psi question 46>
Bad! for "where are you going"
  expected (speech_act (form question)
            (content
             (event (type go)
              (participant
               (entity (type pronoun_second) (realization you)))))
            (type where))
    ;; Extra layer, plus 'go' => 'proceed'
  but got (speech_act (form request)
           (content
            (event (form question)
             (content
              (event (type proceed)
               (participant
                (entity (type pronoun_second) (realization you)))))
             (type where))))


Need a psi that extends #<psi go 89>
    by binding participant to #<pronoun/second "you" 1>
  Retrieved #<psi proceed 70>
    from #<v+v participant + #<"you" 1>  16>
Need a psi that extends #<psi question 66>
    by binding type to #<word "where">
  No existing psi binds type to #<word "where">
  Made the v+v #<v+v type + #<word "where">  37>
Allocating new psi #45
Bound type to make the more saturated #<psi question 45>
Need a psi that extends #<psi question 45>
    by binding content to #<psi proceed 70>
  Retrieved #<psi question 46>
    but its v+v were not consistent with
    those on #<psi question 45>
Allocating new psi #44
Bound content to make the more saturated #<psi question 44>
 added #<psi question 44> to #<v+v content + #<psi proceed 70>  36>
Need a psi that extends #<psi question 66>
    by binding type to #<ref-category where>
  Retrieved #<psi question 49>
    from #<v+v type + #<ref-category where>  34>
Need a psi that extends #<psi question 49>
    by binding content to #<psi proceed 70>
  Retrieved #<psi question 46>
    from among the psi associated with #<v+v content + #<psi proceed 70>  36>
Bad! for "where you going"
  expected (speech_act (form question)
            (content
             (event (type go)
              (participant
               (entity (type pronoun_second) (realization you)))))
            (type where))
    ;; Extra layer, plus 'go' => 'proceed'
  but got (speech_act (form request)
           (content
            (event (form question)
             (content
              (event (type proceed)
               (participant
                (entity (type pronoun_second) (realization you)))))
             (type where))))



Making psi for the category #<ref-category live>
Allocating new psi #43
   made #<psi live 43>
Need a psi that extends #<psi live 43>
    by binding participant to #<pronoun/second "you" 1>
  Retrieved #<psi proceed 70>
    from #<v+v participant + #<"you" 1>  16>
Need a psi that extends #<psi question 66>
    by binding type to #<ref-category where>
  Retrieved #<psi question 49>
    from #<v+v type + #<ref-category where>  34>
Need a psi that extends #<psi question 49>
    by binding content to #<psi proceed 70>
  Retrieved #<psi question 46>
    from among the psi associated with #<v+v content + #<psi proceed 70>  36>

Bad! for "where do you live"
  expected (speech_act (form question)
            (content
             (event (type live)
              (participant
               (entity (type pronoun_second) (realization you)))))
            (type where))
   ;; 'live' => 'proceed' looks like evidence for stickiness
  but got (speech_act (form request)
           (content
            (event (form question)
             (content
              (event (type proceed)
               (participant
                (entity (type pronoun_second) (realization you)))))
             (type where))))
:done
sparser> 