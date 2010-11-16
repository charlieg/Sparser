David-McDonalds-MacBook-Pro:s ddm$ grep set-status **/*.lisp **/**/*.lisp **/**/**/*.lisp **/**/**/**/*.lisp **/**/**/**/**/*.lisp
analyzers/FSA/edges1.lisp:  (set-status :edge-fsas-done position-scanned)
analyzers/FSA/words2.lisp:  (set-status :word-fsas-done position)

analyzers/HA/place-brackets1.lisp:  (set-status :boundaries-introduced position-before)
analyzers/HA/place-brackets1.lisp:    (set-status :brackets-from-prior-edge-introduced position-after)
analyzers/HA/place-brackets1.lisp:    (set-status :brackets-from-prior-word-introduced position-after))
analyzers/HA/place-brackets1.lisp:    (set-status :brackets-from-edge-introduced position-before)
analyzers/HA/place-brackets1.lisp:    (set-status :brackets-from-word-introduced position-before))

analyzers/psp/assess/terminal-edges2.lisp:        (set-status :preterminals-installed position-scanned)
analyzers/psp/scan/scan1.lisp:    (set-status :scanned position)

drivers/chart/psp/adjudicators1.lisp:    (set-status :]-from-edge-after-checked pos-before)
drivers/chart/psp/adjudicators1.lisp:    (set-status :[-from-edge-after-checked pos-before)
drivers/chart/psp/adjudicators1.lisp:    (set-status :]-from-edge-before-checked pos-after)
drivers/chart/psp/adjudicators1.lisp:    (set-status :[-from-edge-before-checked pos-after)

drivers/chart/psp/scan.lisp:    (set-status :]-checked position-before)
drivers/chart/psp/scan.lisp:    (set-status :[-checked position-before)
drivers/chart/psp/scan.lisp:          (set-status :word-fsas-done position-before)
drivers/chart/psp/scan.lisp:    (set-status :word-actions-done position-before)
drivers/chart/psp/scan.lisp:    (set-status :[-checked pos-after)
drivers/chart/psp/scan1.lisp:    (set-status :]-checked position-before)
drivers/chart/psp/scan1.lisp:    (set-status :[-checked position-before)
drivers/chart/psp/scan1.lisp:    (set-status :[-checked pos-after)
drivers/chart/psp/scan2.lisp:    (set-status :]-from-word-after-checked position-before)
drivers/chart/psp/scan2.lisp:    (set-status :[-from-word-after-checked position-before)
drivers/chart/psp/scan2.lisp:    (set-status :]-from-edge-after-checked position-before)
drivers/chart/psp/scan2.lisp:    (set-status :]-from-prior-word-checked position-after)
drivers/chart/psp/scan2.lisp:    (set-status :[-from-prior-word-checked position-after)
drivers/chart/psp/scan3.lisp:    (set-status :]-from-word-after-checked position-before)
drivers/chart/psp/scan3.lisp:    (set-status :[-from-word-after-checked position-before)
drivers/chart/psp/scan3.lisp:    (set-status :]-from-edge-after-checked position-before)
drivers/chart/psp/scan3.lisp:    (set-status :]-from-prior-word-checked position-after)
drivers/chart/psp/scan3.lisp:    (set-status :[-from-prior-word-checked position-after)

objects/chart/positions/positions1.lisp:(defun set-status (keyword p)

grammar/model/core/names/fsa/driver.lisp:  (set-status :pnf-checked starting-position) ;; move below when coordinated
grammar/model/core/names/fsa/driver.lisp:          ;;(set-status :PNF-checked starting-position)
grammar/model/core/names/fsa/driver.lisp:  (set-status :pnf-checked starting-position)
grammar/model/core/names/fsa/driver.lisp:  (set-status :pnf-checked starting-position)
