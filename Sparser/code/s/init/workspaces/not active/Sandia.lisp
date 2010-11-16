;;; -*- Mode:LISP; Syntax:Common-Lisp; Package:SPARSER -*-
;;;
;;;     File:  "workbench"
;;;   Module:  "init;workspaces:"
;;;  version:  May 1995

;; setup as the data came in ...4/12.  4/13 adding load routine
;; for the model and grammar for this.  Added more files to loader
;; 4/17,18 ddm,ys.  4/19 ddm - changed the load order in Load-contracts
;; to put the tree families before the 'Monday' file of rules and
;; category definitions.  4/24 ddm pulled out the last tf from Monday
;; and move the Krisp defs into their own, early-loaded file.
;; 5/4 found some more cases of words that should have been capitalized.
;; 0.1 (5/10) revised the choice of files being loaded to reflect
;;      mon,tues meeting.


(in-package :sparser)

;;;-----------------------------------
;;; loading the requisite new grammar
;;;-----------------------------------

(unless (boundp '*location-of-Sekine-directory*)
  (defparameter *location-of-Sekine-directory*
    "Moby:ddm:projects:Sandia:"))


;; 5/5 flattening (ys)
(sparser::def-logical-pathname "5/5 grammar;"
  (concatenate 'string
               *location-of-Sekine-directory*
               "5/5 grammar:"))

(defun Load-YS-grammar ()
  ;; First load any extensions to the syntactic grammar (such as
  ;; tree families), then load the definitions of the referential
  ;; categories, then load any other phrase structure rules

  (lload "5/5 grammar;ditransitive/prep")
  (lload "5/5 grammar;transitive-pp")
  (lload "5/5 grammar;transitive-pp/passive")
  (lload "5/5 grammar;contract object")
  (lload "5/5 grammar;categories")
  (lload "5/5 grammar;monday 4/17")

  (lload "5/5 grammar;per-title DA rule")
  (lload "5/5 grammar;new contract-verb DA")

  (lload "init;versions:v2.3g:workspace:switch settings"))

(format t "~%~%;; do (load-YS-grammar)~
           ~%;; (ed \"Moby:ddm:projects:Sandia:interesting articles 5/9\")~
           ~%;; (ed \"Moby:ddm:projects:Sandia:corpus:contract-domain\")~
           ~%;; (ed \"Moby:ddm:projects:Sandia:corpus:more-contract-domain\")~
           ~%;; (ed \"Moby:ddm:projects:Sandia:corpus:job-domain\")~
           ~%;; (ed \"Moby:ddm:projects:Sandia:corpus:more-job-domain\")~
          ~%~%")



;;--- my breakout

(sparser::def-logical-pathname "YS tree families;"
  (concatenate 'string
               *location-of-Sekine-directory*
               "5/5 grammar:tree families:"))

(sparser::def-logical-pathname "WOF;"
  (concatenate 'string
               *location-of-Sekine-directory*
               "5/5 grammar:WOF:"))

(sparser::def-logical-pathname "contracts;"
  (concatenate 'string
               *location-of-Sekine-directory*
               "5/5 grammar:contracts:"))

(sparser::def-logical-pathname "Monday;"
  (concatenate 'string
               *location-of-Sekine-directory*
               "5/5 grammar:Monday 4/17:"))
#|
;; goes w/ breakout
(defun Load-YS-grammar ()
  ;; First load any extensions to the syntactic grammar (such as
  ;; tree families), then load the definitions of the referential
  ;; categories, then load any other phrase structure rules

  (lload "YS tree families;ditransitive")
  (lload "YS tree families;ditransitive/prep")
  ;;(lload "YS tree families;ditransitive/passive") ;replaced w/ ddm's
  (lload "YS tree families;transitive-pp")
  (lload "contracts;object")
  ;(lload "contracts;verbs")
  ;(lload "WOF;verbs")
  (lload "Monday;name converters")
  (lload "Monday;comma rules")
  (lload "Monday;other")
  (lload "init;versions:v2.3g:workspace:switch settings")) |#


;;;------------------------------------
;;; 1st set of Who's on First examples
;;;------------------------------------

(defun All/wof ()
  (wof1a) (wof1b) (wof1c) (wof1d) (wof1e) (wof1f) (wof1g) (wof1h) 
  (wof1i) (wof1j) (wof1k) (wof1l) (wof1m) (wof1n) (wof1o) (wof1p) 
  (wof1r) (wof1s) (wof1t) (wof1u) (wof1v) (wof1w))

(defun WOF1a ()
  (p "Legend Corp. of Herndon, Va., appointed Jerre Stead chief 
executive officer."))

(defun WOF1b ()
  (p "CelSci Corp. of Alexandria, Va., named Geert Kersten chief
executive officer."))

(defun WOF1c ()
  (p "The Fairchild Corp. of Chantilly, Va., named Eric Steiner 
president of Fairchild Fasteners, a newly created business sector 
combining worldwide operations."))

(defun WOF1d ()
  (p "The Industry Advisory Council of Vienna, Va., has named 
Mary Ellen Geoffroy executive director."))

(defun WOF1e ()
  (p "W. Glenn Yarborough, formerly of Grumman, has been 
elected corporate vice president of  Vienna, Va.-based Allied 
Research Corp."))

(defun WOF1f ()
  (p "Daniel Gillis was named vice president and general manager at 
Software AG Federal Systems Inc. of Reston, Va."))

(defun WOF1g ()
  (p "Vienna, Va.-based American OnLine has named Miles 
Gilburne senior vice president of corporate development and 
Richard Hanlon vice president of investor relations."))

(defun WOF1h ()
  (p "Redwood City, Calif.-based N.E.T. has appointed Mike 
Schumacher senior vice president of engineering."))

(defun WOF1i ()
  (p "Infodata Systems Inc. of Fairfax, Va., appointed David Van 
Daele senior vice president of marketing and sales."))

(defun WOF1j ()
  (p "Hughes Information Technology Corp. of Reston, Va., named 
Jenanne Murphy vice president and manager of Hughes 
Communications and Data Systems."))

(defun WOF1k ()
  (p "Biospherics Inc. of Beltsville, Md., named Karen Levin vice 
president of corporate communications and Sylvia Williams director 
of information services."))

(defun WOF1l ()
  (p "International Resources Group of Washington, D.C., named 
Malcolm Baldwin vice president and director, Environment and 
Natural Resources Group."))

(defun WOF1m ()
  (p "Smithy Braedon%Oncor International of Washington, D.C., 
has named Alveraze Gonsouland vice president, Retail Services 
group."))

(defun WOF1n ()
  (p "Universal Dynamics Inc. of Woodbridge, Va., appointed 
David Cosner vice president of sales and marketing."))

(defun WOF1o ()
  (p "Los Angeles, Calif.-based DIRECTV, a unit of GM Hughes 
Electronics, has named Steve Cox, formerly with SAIC, vice 
president of business affairs."))

(defun WOF1p ()
  (p "Mountain View, Calif.-based Sun Mycrosystems Inc. has 
appointed Piper Cole the company's first director of public policy."))

(defun WOF1p ()
  (p "Rockwell Defense Electronics of Anaheim, Calif., has named 
Curtis Gray division director of human resources and 
administration."))

(defun WOF1r ()
  (p "SyCom Services Inc. of Dorsey, Md., a subsidiary of Hadron 
Inc., appointed Glen Winemiller director of engineering."))

(defun WOF1s ()
  (p "Performance Engineering Corp. of Fairfax, Va., named John 
Carson senior consultant."))

(defun WOF1t ()
  (p "Spot Image Corp. of Reston, Va., has named John McKeon 
account manager."))

(defun WOF1u ()
  (p "Tamara Abramowitz and Suzanne Bottari have joined 
Bethesda, Md.-based Neumann Marketing as program managers."))

(defun WOF1v ()
  (p "Management Consulting & Research Inc. (MCR), a 
Washington, D.C., professional services firm, has promoted Paul 
Shinderman to director, Enterprise Integration Division, a new 
subsidiary corporation of Management Consulting & Research Inc. 
Shinderman joined MCR in 1993 after working for Delta Research 
Corp., General Research Corp. and the U.S. Army."))

(defun WOF1w ()
  (p "America's Business Phones, a division of Ventura Telephone 
Equipment, has opened a government sales office in Oakton, Va."))




;;;-------------------------------
;;; 1st set of contracts examples
;;;-------------------------------

(defun All/Contracts ()
  (c1a) (c1b) (c1c) (c1d) (c1e) (c1f) (c1g) (c1h) (c1i) (c1j) 
  (c1k) (c1l))

(defun C1a ()
  (p "The U.S. Army awarded a two-year portable microcomputer 
contract potentially worth $ 57 million to Government Technology 
Services Inc. of Chantilly, Va."))

(defun C1b ()
  (p "Naval Sea Systems Command has awarded Raytheon Company a  
$44.6 million contract for transmitters and equipment."))

(defun C1c ()
  (p "Martin Marietta Services Group of Cherry Hill, N.J., will provide 
engineering and support services to the Naval Air Warfare Center 
Aircraft Division under a five-year, $ 20 million contract. Martin and 
Westinghouse also nailed down a two-year, $ 30.5 million  deal 
with the Army to prepare for initial production of the Longbow 
missile."))

(defun C1d ()
  (p "Convex Computer Corp., Richardson, Texas, has netted a three-
year, $ 20 million contract from the Pentagon's Advanced Research 
Projects Agency for research projects related to scalable computing."))

(defun C1e ()
  (p "Analysis & Technology Inc. of North Stonington, Conn., has won 
a contract worth $ 12.9 million from the Naval Surface Warfare 
Center. Under the five-year contract,  A&T will provide acoustical 
analyses for navy ships."))

(defun C1f ()
  (p "Foremost Insurance Group of Grand Rapids, Mich., has awarded a 
five-year, $ 12 million contract to MCI for telecommunications 
services."))

(defun C1g ()
  (p "The Department of Transportation has awarded Loral Federal 
Systems of Manasas, Va., a $ 3.6 million contract for research and 
development services."))

(defun C1h ()
  (p "The Defense Nuclear Agency awarded Federal Systems Corp. of 
Falls Church, Va., a $ 3.2 million contract for defense conversion 
services. Science and Technology Corp. of Hampton, Va., won a $ 
2.5 million engineering contract from NASA."))

(defun C1i ()
  (p "SatCon Technology Corp. of Cambridge, Mass., has been awarded 
three contracts from the Department of Defense totaling $ 1.8 million 
to decrease vibration and increase power and maneuverability in 
helicopters."))

(defun C1j ()
  (p "Rockwell International, Cedar Rapids, Iowa, won a $ 3 million 
contract with the U.K. Ministry of Defense's equivalent to ARPA, 
the United Kingdom Defense Research Agency, for an airborne 
communications systems for helicopters and aircraft."))

(defun C1k ()
  (p "Wang Laboratories Inc., Lowell, Mass., sold $ 1.2 million worth of 
imaging software and professional services to the Korean 
Government to assist construction of a $ 13.4 billion high-speed rail 
project the country plans to have up and running by 2002. Wang 
also netted a $ 2.2 million deal with Hewlett-Packard to provide 
imaging software and professional services to Cerved, the infotech 
arm of Italy's collected Chambers of Commerce. The contract also 
covers telephones and on-site software support and maintenance."))

(defun C1l ()
  (p "Perot System has inked a five-year deal of an undisclosed amount 
with MCI, for the Washington, D.C.-based telecom company to 
provide voice, data, and conference calling and other services."))

