;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;; copyright (c) 1995  David D. McDonald  -- all rights reserved
;;;
;;;     File:  "Apple"
;;;   Module:  "init;workspaces:"
;;;  version:  July 1995

;; broken out from [init;versions:v2.3a:workspace:in progress] 1/25/95.
;; Updated to current locations and independent operation 7/6

(in-package :sparser)

;;;----------
;;; packages
;;;----------

(unless (find-package :apple-interface)
  (make-package :apple-interface  :nicknames '(:apple)))

(unless (find-package :lingsoft)
  (make-package :lingsoft  :nicknames '(:ls)))

(unless (find-package "<DER")
  (make-package "<DER"))


;;;---------------------------------------
;;; override/introduce stand-in functions
;;;---------------------------------------

(defun Verb-category-name ()
  'lingsoft::v )

(defun Noun-category-name ()
  'lingsoft::n )

(defun Word-stem (word)
  (cadr (member :ls-stem (unit-plist word))))



;;;-------------------------
;;; pending bad/to-do cases
;;;-------------------------

;; 10/31
;(p "16-bit sound yields high quality")
;;    goes to a 'one-word-segment'

;; 10/20
;(pp "To listen to the sound you recorded, click Play.")
;;   1st infinitive doesn't form

#|(pp "</para> You can select the source for sound playback 
by following these instructions: </epara>")
;;   nice simple example for a lot of the next things to do:
;;    'you can ...' as a recognized 'help' relation
;;    'by <Xing>' as a pattern for 'how to'
;;    "following these instructions"  understand it as content  |#

;(pp "</item itemno=8>  Close the control panel. </eitem>"
;;  Case for induction





;;----------------------------------------------------------------
;(dm&p-setting)
;(top-edges-setting/ddm)
;*switch-setting*

;(lload "interface;Apple:markup1")  ;; just the tag definitions
;(lload "interface;Apple:loader")
;(apple-preprocessing)

;;--- compensate for bugs:
#|(define-individual-for-term/verb
  word::|shown| word::|show| category::verb+ed)
(define-individual-for-term/verb word::|record| word::|record|)
|#

;;--- Standard test sets

;(run-gml-file/ref "1")  (run-gml-file/ref "2")  (run-gml-file/ref "3")
;(run-gml-file/ref "4")  (run-gml-file/ref "5")  (run-gml-file/ref "6")
;(run-gml-file/ref "B")  (run-gml-file/ref "C")
;(run-book/Ref/gml '("1" "2" "3" "4" "5" "6" "B" "C"))

(load "Corpora:Apple Documents:new Reference:Chap4:body4.gml test sets")
;(ed "Corpora:Apple Documents:new Reference:Chap4:body4.gml test sets")                               ;; /// file got lost in the transfers
#| (c1)  (s2)  (s3)  (s4)  (s5)  (s6)  (s7)  (s8)  (s9)  (s10)
   (s11)  (s12)  (s13)  (s14)  (s15)
 (s1-5)  |#

;(run-gml-file/PT "1")  (run-gml-file/PT "2")  (run-gml-file/PT "3")
;(run-gml-file/PT "4")  (run-gml-file/PT "5")  (run-gml-file/PT "6")
;(run-gml-file/PT "7")  (run-gml-file/PT "8")  (run-gml-file/PT "A")
;(run-gml-file/PT "B")

;(do-document-as-stream-of-files MacRef/gml/document-stream)
;(do-document-as-stream-of-files PowerTalk/gml/document-stream)



;;---- Reading out segments, etc.
;(setq *readout-segments* t)
;(setq *readout-segments* nil)
;(setq *stream-for-segment-trace* t)  ;; Listener
;(setq *stream-for-segment-trace* (fred))
;(setq *inline-treetop-readout* t)
;(setq *inline-treetop-readout* nil)
;(setq *stream-to-readout-treetops-to* t)
;(setq *stream-to-readout-treetops-to* (fred))
;(setq *inline-readout-function* 'readout-segments) ;; special purpose
;(setq *inline-readout-function* 'print-treetops)   ;; 'tts'



;;--- Stubbing the nasty cases (loads as 'nil')
;(setq *break-on-pattern-outside-coverage?* t)
;(setq *break-on-pattern-outside-coverage?* nil)



;;;-------
;;; setup
;;;-------

(defun Apple-preprocessing ()
  (apple::run-dis-over-book '|Reference|)
  (apple::run-dis-over-book '|PowerTalk|)
  (break "~&~%---------------------------------------~
          ~%        check 'shown' and 'record'  !!!  ~
          ~%---------------------------------------~%~%")
  (apple::render.dis-data-into-Sparser-information))

;(apple::setq *trace-.dis-interface* t)
;(apple::setq *trace-.dis-interface* nil)



;;;--------------------------------------------------
;;; compensations for items in the 'everything' load
;;;--------------------------------------------------

; 6/95 this was fixed, so it shouldn't be needed anymore
;(define-bracket :] :after verb 1) ;; verb].
  ;; this is defined ad-hoc in [random & hacks] to get around a problem
  ;; and that file isn't loaded in a pure dm&p run



;;;-------------------------------------------------
;;; various alternatives for switches or conditions
;;;-------------------------------------------------

;(setq *allow-pure-syntax-rules* t)
;(setq *allow-pure-syntax-rules* nil)


#| (setq *segment-scan/forest-level-transition-protocol*
         :move-when-segment-can-never-extend-rightwards)
   (setq *segment-scan/forest-level-transition-protocol*
         :move-only-at-significant-boundary)  |#
;(setq *do-forest-level* t)
;(setq *do-forest-level* nil)
;(setq *forest-level-protocol* 'parse-forest-and-do-treetops)
;(setq *forest-level-protocol* 'dm&p-forest-level)
;(setq *dm&p-forest-protocol* 'no-forest-level-operations)
;(setq *dm&p-forest-protocol* 'parse-forest-and-do-treetops)
;(establish-pnf-routine :scan-classify-record)
;(establish-pnf-routine :scan/ignore-boundaries)
;*pnf-routine*
;(setq *ignore-capitalization* t)
;(setq *ignore-capitalization* nil)
;(setq *cap-seq-edge-data-routine* 'dm&p-cap-seq-data)
;(setq *cap-seq-edge-data-routine* 'cap-seq-no-referent)


;; 6/16
;(setq *test-edge-view-coordination* t)
;(setq *test-edge-view-coordination* nil)
;; At about p1600 or so in PowerTalk in the workbench there is a goal
;; of scrolling back to a sequence-start, and its edge isn't in the
;; edge view.  This flag gates the break in Scroll-edges-view/top-edge


;(setq *checkout-new-cases-of-single-edge-segements* t)
;(setq *checkout-new-cases-of-single-edge-segements* nil)
;(setq *pause-after-each-paragraph* t)
;(setq *pause-after-each-paragraph* nil)


;; 6/9
;(setq *pause-after-each-paragraph* t)
;(setq *pause-after-each-paragraph* nil)

;(setq *check-out-unclassified-<>-interiors* t)
;(setq *check-out-unclassified-<>-interiors* nil)

;; 5/17
;(keep-sentence-tags-out-of-terminal-stream)
;(establish-version-of-next-terminal-to-use :pass-through-all-tokens)



;;;------------------------------
;;; debugging the blowup in size
;;;------------------------------
;(zero-the-model)              ;(zero)

;(gc) (room nil)
;(length *next-individual*)
;(length *active-individuals*)
;(length *next-binding*)
;(length *active-bindings*)
;(length *next-cons-cell*)

;(initialize-cons-resource)
;(defparameter *objects-in-the-discourse* (make-hash-table :test #'eq))
;(per-article-initializations)


;(report-active-count/interesting-categories)

;(trace allocate-individual deallocate-individual)
;(trace allocate-binding deallocate-binding)
;(untrace)
;(trace-binding-indexing)  (untrace-binding-indexing)
;(trace-reclaimation)  (untrace-reclaimation)
;(trace-terms)  (untrace-terms)
;(trace-dm&p)  (untrace-dm&p)



;;;----------------
;;; Ad-hoc drivers
;;;----------------

(unless (boundp '*Apple-documents-directory*)
  (defparameter *Apple-documents-directory*
                "Corpora:Apple Documents:"  ;; ddm's 8100
                ))

(defun Run-gml-file/Ref (n)
  (let* ((namestring (concatenate 'string
                                  *Apple-documents-directory*
                                  "new Reference:Chap"
                                  n
                                  ":body"
                                  n
                                  ".gml"))
         (pathname (pathname namestring)))

    (unless (probe-file namestring)
      (break "Bad concatenation formula:~%there is no file named ~
              ~A" namestring))
    
    (do-article pathname :style 'apple)))


(defun Run-gml-file/PT (n)
  (let* ((namestring (concatenate 'string
                                  *Apple-documents-directory*
                                  "new PowerTalk:Chap"   ;; for instance
                                  n
                                  ":body"
                                  n
                                  ".gml"))
         (pathname (pathname namestring)))

    (unless (probe-file namestring)
      (break "Bad concatenation formula:~%there is no file named ~
              ~A" namestring))

    (do-article pathname :style 'apple)))



;;--- document streams

(defparameter MacRef/gml/document-stream
  (define-document-stream  'MacRef/gml-files
    :style-name 'apple
    :file-list
    (mapcar #'(lambda (n)
                (concatenate 'string
                             *Apple-documents-directory*
                             "new Reference:Chap"
                             n
                             ":body"
                             n
                             ".gml"))
            '("1" "2" "3" "4" "5" "6" "B" "C"))))

(defparameter PowerTalk/gml/document-stream
  (define-document-stream  'PowerTalk/gml-files
    :style-name 'apple
    :file-list
    (mapcar #'(lambda (n)
                (concatenate 'string
                             *Apple-documents-directory*
                             "new PowerTalk:Chap"   ;; for instance
                             n
                             ":body"
                             n
                             ".gml"))
            '("1" "2" "3" "4" "5" "6" "7" "8" "A" "B"))))





;;;-----------------------------------------------------------------
;;; testing the interleaving of pos tags and words -- 'merge' files
;;;-----------------------------------------------------------------

(defun syn-test ()
  (setup-for-apple)
  (p "This</syn @DN> chapter</syn @SUBJ> 
describes</syn @+FMAINV> how</syn @ADVL>"))

(defun face-test ()
  (setup-for-apple)
  (p "choose </bold> control panels </ebold> from the menu"))

(defun face-test2 ()  ;; starts in PNF
  (setup-for-apple)
  (p "Choose </bold> Control Panels </ebold> from the menu"))

;; 6/3
;(allow-invisible-markup)
;(make-the-invisible-markup-trie)
;(initialize-the-invisible-markup-trie)
;(print-char-trie (trie-network *invisible-markup-trie*))


(defun syn ()
  (setup-for-apple)
  (pp 
"</para> This </syn @DN>> chapter </syn @SUBJ> describes </syn @+FMAINV> how
</syn @ADVL> to </syn @INFMARK>> use </syn @-FMAINV> the </syn @DN>> sound
</syn @OBJ> , color </syn @OBJ @APP> , and </syn @CC> video </syn @-FMAINV
@next @OBJ @APP @NN>> options </syn @OBJ @APP> on </syn @<NOM @ADVL> your
</syn @GN>> computer </syn @<P> . </epara>

</section> Setting </syn @NPHR @-FMAINV> the </syn @DN>> alert </syn @AN>>
sound </syn @NPHR @OBJ> </esection>

</para> Many </syn @QN>> programs </syn @SUBJ> have </syn @+FMAINV> the </syn
@DN>> computer </syn @SUBJ @OBJ> make </syn @-FMAINV @next @+FMAINV> a </syn
@DN>> sound </syn @OBJ> , called </syn @PCOMPL-S @PCOMPL-O @APP @<NOM-FMAINV
@-FMAINV> an </syn @DN>> alert </syn @AN>> sound </syn @SUBJ @next @SUBJ> ,
when </syn @ADVL> your </syn @GN>> attention </syn @SUBJ> is </syn @+FAUXV>
required </syn @-FMAINV> or </syn @CC> when </syn @ADVL> you </syn @SUBJ> 're
</syn @+FMAINV @+FAUXV> attempting </syn @-FMAINV> an </syn @DN>> action
</syn @OBJ> that </syn @CS @next @OBJ @PCOMPL-S @PCOMPL-O> the </syn @DN>>
computer </syn @SUBJ> cannot </syn @+FAUXV> perform </syn @-FMAINV> at </syn
@ADVL> that </syn @DN>> time </syn @<P> . </epara>

</para> You </syn @SUBJ> can </syn @+FAUXV> choose </syn @-FMAINV> the </syn
@DN>> type </syn @OBJ> of </syn @<NOM-OF> alert </syn @AN>> sound </syn @<P>
that </syn @CS @next @SUBJ @OBJ> you </syn @SUBJ> want </syn @+FMAINV> your
</syn @GN>> computer </syn @OBJ> to </syn @INFMARK>> make </syn @-FMAINV
@<NOM-FMAINV> . You </syn @SUBJ> can </syn @+FAUXV> also </syn @ADVL> set
</syn @-FMAINV> the </syn @DN>> sound's </syn @GN>> volume </syn @OBJ> .
</epara>

</sequence> </item itemno=1> </bold> Choose </syn @+FMAINV> Control </syn
@OBJ @NN>> Panels </syn @OBJ @PCOMPL-O> from </syn @<NOM @ADVL> the </syn
@DN>> Apple </syn @<P> ( &apple </syn @APP> ) menu </syn @APP> . </ebold>
</eitem> </item itemno=2> </bold> Open </syn @+FMAINV> the </syn @DN>> Sound
</syn @NN>> control </syn @NN>> panel </syn @OBJ> . </ebold>

</para> The </syn @DN>> Sound </syn @NN>> control </syn @NN>> panel </syn
@ADVL> the </syn @DN>> model </syn @<P> of </syn @<NOM-OF> computer </syn
@<P> you </syn @SUBJ> have </syn @+FMAINV> , your </syn @GN>> Sound </syn
@OBJ @APP @NN> @<P> control </syn @OBJ @APP @NN> @<P> panel </syn @SUBJ> may
</syn @+FAUXV> look </syn @-FMAINV> slightly </syn @ADVL @AD-A>> different
</syn @PCOMPL-S> from </syn @<NOM @ADVL> the </syn @DN>> one </syn @<P @QN>
@ADVL @next @<P> shown </syn @-FMAINV> here </syn @ADVL> . </epara> </fig>
</efig> </eitem> </item itemno=3> </bold> Click </syn @+FMAINV> the </syn
@DN>> alert </syn @AN>> sound </syn @OBJ> that </syn @CS @next @OBJ> you
</syn @SUBJ> want </syn @+FMAINV> the </syn @DN>> computer </syn @OBJ> to
</syn @INFMARK>> use </syn @-FMAINV @<NOM-FMAINV> . </ebold> </eitem> </item
itemno=4> </bold> Drag </syn @+FMAINV> the </syn @DN>> slider </syn @OBJ> up
</syn @ADVL> or </syn @CC> down </syn @ADVL> to </syn @INFMARK>> set </syn 
@-FMAINV> the </syn @DN>> volume </syn @OBJ @I-OBJ @NN>> level </syn @OBJ @next
@<NOM> . </ebold>

</para> If </syn @CS> you </syn @SUBJ> do </syn @+FAUXV> n't </syn @NEG> want
</syn @-FMAINV> to </syn @INFMARK>> hear </syn @-FMAINV> an </syn @DN>> alert
</syn @AN>> sound </syn @OBJ @next @OBJ @<NOM> , drag </syn @+FMAINV> the
</syn @DN>> slider </syn @OBJ> all </syn @QN>> the </syn @DN>> way </syn
@OBJ> to </syn @<NOM @ADVL> the </syn @DN>> bottom </syn @<P> of </syn 
@<NOM-OF @ADVL> the </syn @DN>> scale </syn @<P> . Instead=of </syn @ADVL> 
hearing </syn @<P-FMAINV> an </syn @DN>> alert </syn @AN>> sound </syn @OBJ @next
@OBJ @<NOM> , you </syn @SUBJ> 'll </syn @+FAUXV> see </syn @-FMAINV> the
</syn @DN>> menu </syn @OBJ @NN>> bar </syn @-FMAINV @next @+FMAINV @next
@OBJ @NN>> flash </syn @OBJ> . </epara> </eitem> </item itemno=5> </bold>
Close </syn @+FMAINV> the </syn @DN>> Sound </syn @NN>> control </syn @NN>>
panel </syn @OBJ> . </ebold> </eitem> </esequence>"))



;;;--------------------------
;;; testing invisible markup
;;;--------------------------

(defun Test-interiors ()
  (pp "</sequence>
</item itemno=1> </bold> Quit the program if it's open, and then click the
program's icon to select it. </ebold>
</eitem>
</item itemno=2> </bold> Choose Get Info from the File menu. </ebold>
</eitem>
</item itemno=3> </bold> Type the new number. </ebold>
</fig> </efig>
</para> If the program frequently runs out of memory, increase both the
preferred size and the minimum size. </epara>
</para> If you want to be able to open more programs, decrease the minimum
size. But if you type a size smaller than \"Suggested size,\" the program may
work more slowly, show other performance problems, or not work at all.
</epara>
</eitem>
</item itemno=4> </bold> Close the Info window. </ebold>
</para> If you make the memory size smaller than suggested, you'll see a
message asking you to confirm your decision.  </epara>
</eitem>
</esequence>"))





;;;----------------------------------------------
;;; tracing .dis runs over LingSoft output files
;;;----------------------------------------------

;;--- whole books at once

(defun Test-dis (document-stream-name)
  (let ((ds (document-stream-named document-stream-name))
        dis-name )
    (dolist (gml-name (ds-file-list ds))
      (setq dis-name
            (concatenate
             'string (subseq gml-name
                             0 (position #\. gml-name :from-end t))
             ".engdis.out"))
      (apple::assimilate-dis.out dis-name))))
;(test-dis '|Reference|)
;(test-dis '|PowerTalk|)


;;--- single files
(defparameter c4dis
  (concatenate 'string
               *Apple-documents-directory*
               "New Reference:Chap4:body4¶.engsyn.out"))

(defun dis (namestring)
  (apple::assimilate-dis.out namestring))
;(dis sparser::c4dis)

;apple::*words-in-.dis-run*
;(setq apple::*trace-.dis-interface* t)
;(setq apple::*trace-.dis-interface* nil)
;(setq apple::*trace-.dis-interface/track-words* t)
;(setq apple::*trace-.dis-interface/track-words* nil)
;  apple::*act-on-.dis-pos-data-online*
;apple::*idioms-found*
;(setq f (open c4dis :direction :input))
;(close f)


;;;----------------
;;; word frequency
;;;----------------

(defun hyper-moby-frequency (name-of-document-stream)
  (let ((*pause-between-articles* nil)
        (*display-word-stream* nil))
    (wf/ds (document-stream-named name-of-document-stream)))
  (establish-kind-of-chart-processing-to-do :new-toplevel-protocol))
;(hyper-moby-frequency '|PowerTalk|)
;(hyper-moby-frequency '|Reference|)


;;;--------------------
;;; Re-initializations
;;;--------------------

(defun dm&p-re-initializations ()
  ;; Operates over all of the .dis information that has been 
  ;; accumulated up to the point when it is run
  (let ((apple::*trace-.dis-interface* t))
    (apple::post-run-analysis/part-of-speech)
    (apple::install-unambiguous-verbs-as-such)
    (apple::process-lingsoft-multitokens)))


(defun dm&p-re-initializations ()
  ;; designed to be run many times as part of zeroing the model
  ;; and then repopulating it, as well as for the first analysis
  (let ((apple::*trace-.dis-interface* t))
    (lload "interface;Apple:pseudo characters1")
    (apple::assimilate-dis.out
     "Macintosh HD:Apple documents:Reference:Chap4:body4.engdis.out")
    (apple::post-run-analysis/part-of-speech)
    (apple::install-unambiguous-verbs-as-such)
    (apple::process-lingsoft-multitokens)
    ))


(defun reset ()
  ;; ///have to delete all the segment objects when starting a run
  (clear-special-text-display-window) ;; gets all the views
  (when nil ;;(y-or-n-p "save the new terms?")
    (declare-all-new-instances-permanent (category-named 'term))))


(defun Brutally-expunge-segments ()
  (let ((segment (category-named 'segment)))
    (reset-category-count segment)
    (setf (getf (unit-plist segment) :instances) nil)
    (setf (cat-instances segment) nil)))

(defun expunge-non-permanent-terms ()
  (reclaim-all-instances (category-named 'term)))



(defun Zero-the-model ()
  (delete-cfrs-of-permanent-terms)

  (setq *next-binding* :not-initialized
        *active-bindings* nil
        *binding-allocation-count* 0)
  (establish-binding-resource)
  
  (setq *next-individual* :not-initialized
        *active-individuals* nil
        *individual-allocation-count* 0)
  (initialize-individuals-resource)

  (let ( vars )
    (maphash #'(lambda (symbol variable)
                 (declare (ignore symbol))
                 (push variable vars))
             *name-to-variable-index*)
    (dolist (v vars)
      (if (consp v)
        (dolist (v-with-same-name v)
          (clear-instances/variable v-with-same-name))
      (clear-instances/variable v))))

  (dolist (c *referential-categories*)
    (zero-category-index c nil t)))




(defun Delete-cfrs-of-permanent-terms ()
  (let ( cfr  word  cfr-bindings )  ;; 
    (dolist (term (cadr (member :instances ;;:permanent-individuals
                                (unit-plist (category-named 'term))
                                :test #'eq)))
      (setq cfr-bindings
            (all-bindings-such-that
             (indiv-binds term)
             :variable-is (lambda-variable-named 'rewrite-rule)))

      (dolist (b cfr-bindings)
        (setq cfr (binding-value b))
        (setq word (first (cfr-rhs cfr)))
        ;(etypecase word
        ;  (word (delete/word word))
        ;  (polyword (delete/polyword word)))
        (delete/cfr cfr)))))


(defun zero ()
  (untrace)
  (zero-the-model)
  (dm&p-re-initializations)
  (declare-all-existing-individuals-permanent))


