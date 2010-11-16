;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:(CTI-source LISP) -*-
;;; copyright (c) 1990,1991  Content Technologies Inc.  -- all rights reserved
;;;
;;;     File:  "C&L QA test-set driver"
;;;   Module:  "grammar;tests:"
;;;  version:  1.1  January 1991       v1.7

;; 1.1  (1/12 v1.7)  Revised as needed to fit the changes to the
;;      test set made for v1.7

(in-package :CTI-source)


;;;-------------------
;;; logical pathnames
;;;-------------------

(def-logical-pathname "QA subroutines;"
  "CTI-code;grammar:tests:C&L:data functions:")

(def-logical-pathname "test files;"
  "CTI-code;grammar:tests:C&L:test files:")

;;;---------------------
;;; basic work routines
;;;---------------------

(defun p (string)
  (let ((*initial-region* :text-body))
    (analyze-text-from-string string)))

(defun e ( &key from to )
  (display-chart-edges :stream *standard-output*
                       :from from :to to))

(defun f (&optional (pathname *article*))
  (when *open-stream-of-source-characters*
    (close-character-source-file))
  (let ((*initial-region* :text-body))
    (analyze-text-from-file pathname)))

(defun chart ()
  (display-chart :style :just-terminals))



(defun eta/c (category-symbol topic-symbol)
  (define-association-with-topic category-symbol topic-symbol))

(defun delete/eta (category-symbol topic-symbol)
  (delete-association-of-evidence-with-topic category-symbol
                                             topic-symbol))

; (setq *trace-readout* t)
; (setq *trace-readout* nil)
; (setq *trace-readout/only-real-edges* t)
; (setq *trace-readout/only-real-edges* nil)




;;;-------------------------
;;; composite work routines
;;;-------------------------

(defun p/c/t (string)
  (let ((*trace-readout/only-real-edges* t))
    (p string) (format t "~%~%")
    (chart)    (format t "~%~%")
    (the-edges)))

(defun p/c/chart-edges (string)
  (let ((*trace-readout/only-real-edges* t))
    (p string) (format t "~%~%")
    (chart)    (format t "~%~%")
    (display-chart-edges)))


;;;-------
;;; cases
;;;-------

#| 


;;----- # ??
  The readout algorithm is presently sensitive to the order in which
nodes are added to the chart since it simply looks at which node is in
the top-node field of the edge vector and not whether it is the most
interesting [///or even if it is actually the longest -- the rest of the
algorithm should be proved through to establish that this is indeed
inescapable].  As a result, on nodes only spanning a single word, if there
was both a complete edge and an incomplete one, the complete one could
be missed if it was found before the incomplete, since the most recently
created node is also thereby the topmost in the present algorithm.
   This can be tested simply by running: 

(p/e "Japan")



;;----- #1

(p/c/t ", says Japan blah")


;;----- #2

(load "QA subroutines;OAIR")

(eta/c '<japan>            'japan)
(eta/c '<japan-possessive> 'japan-possessive)
(eta/c '<in-japan>         'in-japan)
(eta/c '<japanese>         'japanese)
(eta/c '<us-and-japan>     'us-and-japan)

(oair)

(delete/eta '<japan> 'japan)
(delete/eta '<japan-possessive> 'japan-possessive)
(delete/eta '<in-japan>         'in-japan)
(delete/eta '<japanese>         'japanese)
(delete/eta '<us-and-japan>     'us-and-japan)


(defun companies-after-the-moment-of-the-problem ()
  (def-cfr <nec> ("NEC"))
  (eta/c '<nec> 'nec)
  (def-cfr <toshiba> ("Toshiba"))
  (eta/c '<toshiba> 'toshiba)
  (def-cfr <Mitsubishi> ("Mitsubishi Electric"))
  (eta/c '<Mitsubishi> 'Mitsubishi)
  (def-cfr <nippon-steel> ("Nippon Steel Corporation"))
  (eta/c '<nippon-steel> 'nippon-steel)
  (def-cfr <ntt> ("Nippon Telegraph and Telephone"))
  (eta/c '<ntt> 'ntt)
  (def-cfr <Nippon> ("Nippon"))
  (eta/c '<Nippon> 'nippon))

(defun delete-companies ()
  (delete/eta '<nec> 'nec) 
  (delete/eta '<toshiba> 'toshiba)
  (delete/eta '<Mitsubishi> 'Mitsubishi)
  (delete/eta '<nippon-steel> 'nippon-steel)
  (delete/eta '<ntt> 'ntt)
  (delete/eta '<Nippon> 'nippon))


; (companies-after-the-moment-of-the-problem)
; (delete-companies)


;  tests the threading bug involving the scanning of unknown words
;(p/e "huge Nippon Telegraph and Telephone")
;(p/e "the huge Nippon Telegraph and Telephone")


;;----- #3

(p/c/t "Tokyo Stock Exchange")



;;----- #4

(f "test files;90mondb34-OFILL24")


(eta/c '<us-and-japan>     'us-and-japan)

(p/c/t "foreign missions, including those of Japan,
Britain, and the US, have told their diplomats in Kuwait to stay put.
")

(p/c/t "The European Commission already has such a study under way. But it is not
certain whether the US, Canada, and Japan will join this group, or whether
a separate study will be launched.
")

(delete/eta '<us-and-japan>     'us-and-japan)


;;----- #4, cont.  (formerly #5)

; The article this is reported as occurring on is 25-EMEX, which I don't have.
; These are the excerpts from the qa5.lisp test file.  If the reported bug
; were to occur, it appears that it would report us-and-japan in the second
; excerpt.  In general this test is just looking for dropout in the echo and
; presuming that that would be indicative of the reported offsets.

(eta/c '<us-and-japan>     'us-and-japan)

(p "But positive forecasts are equally credible. Increased trade will benefit
both countries, and heightened economic activity in Mexico will gradually
curb Mexicans' urge to migrate to the US. For the US, a free-trade association
would formalize the high level of economic integration that already exists.
It would also be a long-term investment in stability on the southern border.
For Salinas, an agreement could ensure the longevity of his reforms. Neither
a change of heart in Washington, nor a new administration in Mexico city,
could easily wriggle free of a formal pact. With a free-trade agreement
in hand, along with added investment commitments from Japan, Mexico's reformist
leader could rest easier.")

(p "without US forces in the next decade.
Cheney's trip is in preparation for a report to Congress, due by April,
that will suggest ways of reducing the expense of ``forward deployment''
of US forces in Korea and Japan.")

(p "Rather, MITI's bureaucrats are worried by two disturbing trends: increasing
alienation of Japanese workers and isolation of Japan from other nations.
Both could adversely effect industry in the future, and the MITI vision
aims to head off trouble.
``We have to recognize clearly that Japanese society in the past used to
be a corporation-oriented society,'' Kunio Morikiyo, director of MITI's
po")

(delete/eta '<us-and-japan>     'us-and-japan)


;;----- #6

;; Character offset tests

(def-cfr <Takashimaya> ("Takashimaya Co."))
(def-cfr <Takashimaya> ("Takashimaya"))
(def-cfr <Kawasaki> ("Kawasaki"))
   ;;n.b. in this article Kawasaki is a person, not an instance
   ;; of Kawasaki Heavy Industries
(def-cfr <the-japanese-capital> ("TOKYO"))

(eta/c '<Takashimaya> 'Takashimaya)
(eta/c '<Kawasaki> 'Kawasaki)
(eta/c '<the-japanese-capital> 'tokyo)

(f "test files;test suite:90mondb37-ptok")    ;;fixed


;(setq *trace-character-buffer-filling* t)
;(setq *trace-character-buffer-filling* nil)

(f "test files;test suite:90mondb34-oarmy")   ;; "Japan's"
(f "test files;test suite:90mondb37-eoka")    ;; nothing at the site
(f "test files;test suite:8/89-kay.syn")      ;; 11991-12997
(f "test files;test suite:7/90-schneider.lo") ;; nothing at the site

(def-cfr <Nikko> ("Nikko"))
  ;;again, this is "the city of Nikko", rather than the target
  ;;Nikko Securities Co.
(eta/c '<nikko> 'nikko)
(f "test files;test suite:5/89-hedrick.syn")  ;; fixed

(f "test files;test suite:5/90-herve.syn")    ;; 15985 - 16998


;;----- #7

;; lower case version of the word defined first:
(def-cfr <bulgarian> ("bulgarian"))
(def-cfr <bulgarian> ("Bulgarian"))

;; capitalized version first
(def-cfr <peasant> ("Peasant"))
(def-cfr <peasant> ("peasant"))

(def-cfr <bulgarian-peasant> (<bulgarian> <peasant>))

(eta/c '<bulgarian-peasant> 'bulgarian-peasant)

(p "the bulgarian peasant went to lunch")
(p "The Bulgarian Peasant went to lunch")
(p "the bulgarian Peasant went to lunch")
(p "The Bulgarian Peasant went to lunch")

(delete/eta '<bulgarian-peasant> 'bulgarian-peasant)


;;----- #8

(eta/c '<japanese> 'japanese)

(p/c/t "Japanese")
(p/c/t "Japanese")

(delete/eta '<japanese> 'japanese)



;;----- #9

(p/c/chart-edges "the Japanese media")


;;----- #10

;; version in the QA file
(def-cfr/multiple-rhs  |<ambassador to japan michael armacost>|
  (("Armacost")
   ("ambassador to japan Armacost")
   ("Ambassador To Japan Armacost")
   ("ambassador to japan Michael Armacost")
   ("Ambassador To Japan Michael Armacost")
   ("Michael Armacost")))

;; alternative version with better ordering
(def-cfr/multiple-rhs  |<ambassador to japan michael armacost>|
  (("Armacost")
   ("Michael Armacost")
   ("ambassador to japan Armacost")
   ("Ambassador To Japan Armacost")
   ("ambassador to japan Michael Armacost")
   ("Ambassador To Japan Michael Armacost")))

(eta/c '|<ambassador to japan michael armacost>| 'amacost)

(p/c/t "Armacost")
(p/c/t "ambassador to japan Armacost")
(p/c/t "Ambassador To Japan Armacost")
(p/c/t "ambassador to japan Michael Armacost")
(p/c/t "Ambassador To Japan Michael Armacost")
(p/c/t "Michael Armacost")

(delete/eta '|<ambassador to japan michael armacost>| 'amacost)


;;-- experiment on an analogous case
(def-cfr <foo> ("Foo Fo Co."))
(def-cfr <bar> ("Bar Ba Co."))
(def-cfr <car> ("Car Ca Co."))

(p/c/t <foo> ("Foo Fo Co."))
(p/c/t <bar> ("Bar Ba Co."))
(p/c/t <car> ("Car Ca Co."))

(def-cfr <Company> ("Co."))
;; assuming everything was done in the order given here, this
;; last rule will effectively disable the parsing of the <bar>
;; and <car> cases.



;;----- getting through a large corpus (#11)

  Assumes that "load prw grammar" was used, thereby defining the
  needed lists and functions

(iterate-through-articles)


;;----- #13 - 16

(f "CTI-code;xx non-CTI:C&L:QA:12/20:qa13.txt")
(f "CTI-code;xx non-CTI:C&L:QA:12/20:qa14.txt")
(f "CTI-code;xx non-CTI:C&L:QA:12/20:qa15.txt")
(f "CTI-code;xx non-CTI:C&L:QA:12/20:qa16.txt")


;;----- #18

(def-cfr <the-biltmore> ("the-biltmore"))
(def-cfr <the-biltmore> ("the biltmore"))

(eta/c '<the-biltmore> 'the-biltmore)

(p/c/t "the biltmore")
(p/c/t "the-biltmore")
(p/c/t "the-biltmore")

(delete/eta '<the-biltmore> 'the-biltmore)


;;----- #19


;;----- #20

(def-cfr <rude-boys> ("rude" "boys"))
(def-cfr <boys-club> ("boys" "club"))

(eta/c '<rude-boys> 'rude-boys)
(eta/c '<boys-club> 'boys-club)

(p/c/t "the rude boys went")
(p/c/t "the boys club is")
(p/c/t "the rude boys club is")


(def-cfr <women> ("women"))
(def-cfr <wicked-women> ("wicked" <women>))
(def-cfr <women-unite>  (<women> "unite"))

(p/c/t "the wicked women")
(p/c/t "if woman unite, it")
(p/c/t "if wicked women unite, then")



(def-cfr <x> ("x"))
(def-cfr <y> ("y"))
(def-cfr <z> ("z"))
(def-cfr <x-y-z> ("x y z"))
(def-cfr <x-y> ("x y"))
(def-cfr <y-z> ("y z"))

(p/c/t "x y z") ; should recognize <x-y-z>
(p/c/t "x y")
(p/c/t "y z")
|#
