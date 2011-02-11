(in-package :sparser)
(cfg-setting)

;; utils

(defun de (edge)
  (d (e# edge)))

(defun der (edge)
  (d (edge-referent (e# edge))))

(defun med-all ()
  (p "Will Medtronic's pulse quicken?

Medical device giant Medtronic (MDT), the leader in
defibrillators and pacemakers, has been a market laggard. The stock
slumped from 60 in January to 49.19 on May 17. But some investors say
it may beat analysts' consensus forecast of 62 cents a share when it
reports earnings for its fiscal fourth quarter on May 23. Among the
few bulls: Investment firm Harris Nesbitt's Joanne Wuensch, who
continues to rate it \"outperform,\" with a 12-month target of 62.
Still, some worry Medtronic may deliver bad news. Not only has growth
slowed in the cardiology market, but rival St. Jude Medical (SJM) also
missed its quarterly sales forecast. Wuensch counters that Medtronic
is \"more insulated from the implantable-device market sways than its
brethren.\" It generates 27% of revenues from them, vs. St. Jude's
36%. Wuensch sees Medtronic earning $2.09 a share on sales of $11.3
billion this year, and $2.38 on $12.6 billion in 2007. David Sowerby,
portfolio manager at investment firm Loomis Sayles, which owns shares,
says the stock is \"compelling\" near its 10-year low, especially as
he expects Medtronic to gain market share and show double-digit
earnings growth in 2007.")
)

;; stock ticker symbol

(define-category stock-symbol
  :binds ((ticker)))

(def-cfr stock-symbol (name close-paren)
  :form noun
  :referent (:instantiate-individual stock-symbol
	     :with (ticker left-edge)))

;; duplicated because of how rules are made for  names & name-words
(def-cfr stock-symbol (name-word close-paren)
  :form noun
  :referent (:instantiate-individual stock-symbol
	     :with (ticker left-edge)))

(def-cfr stock-symbol (open-paren stock-symbol)
  :form noun
  :referent (:head right-edge))

(define-category market-leader
  :binds ((market)))

(def-cfr market-leader ("leader" dual-relative-location)
  :form np
  :referent (:instantiate-individual market-leader
	     :with (market right-edge)))

(define-category dual-relative-location
  :specializes relative-location
  :instantiates :self
  :binds ((place2)))

(def-cfr and-np ("and" np)
  :referent (:daughter right-edge))

(def-cfr dual-relative-location (relative-location and-np)
  :form np
  :referent (:instantiate-individual dual-relative-location
	     :head left-edge
	     :bind (place2 . right-edge)))

#| didn't work as an n-ary rule, etypecase error
(def-cfr stock-symbol (open-paren name close-paren)
  :form noun
  :referent (:instantiate-individual stock-symbol
	     :with (ticker second)))

(def-cfr compound-noun (np "and" np)
  :form np
  :referent (:instantiate-individual compound-noun
	     :with (thing1 first
		    thing2 third)))
|#

;; (p "The stock slumped from 60 in January to 49.19 on May 17.")

;; ranges of datapoints composed of a value & time

(define-category range
  :binds ((start)
	  (end)
	  (delta)))

(define-category datapoint
  :binds ((value)
	  (time)))

(def-cfr datapoint (number time)
  :form np
  :referent (:instantiate-individual datapoint
	     :with (value left-edge
		    time right-edge)))

(def-cfr start-range ("from" datapoint)
  :form pp
  :referent (:head right-edge))

(def-cfr end-range ("to" datapoint)
  :form pp
  :referent (:head right-edge))

(def-cfr range (start-range end-range)
  :form pp
  :referent (:instantiate-individual range
	     :with (start left-edge
		    end right-edge)))

;; stock price change events

(define-category stock-price-change
  :specializes event
  :binds ((mode)
	  (range)))

(define-category slump
  :specializes event)

(def-cfr stock-symbol ("stock")
  :form noun
  :referent (:instantiate-individual stock-symbol))

(def-cfr slump ("slumped")
  :form verb+ed
  :referent (:instantiate-individual slump))

(def-cfr stock-price-change (stock-symbol slump)
  :form s
  :referent (:instantiate-individual stock-price-change
	     :with (mode right-edge)))

(def-cfr stock-price-change (stock-price-change range)
  :form s
  :referent (:head left-edge
	     :bind (mode . right-edge)))
