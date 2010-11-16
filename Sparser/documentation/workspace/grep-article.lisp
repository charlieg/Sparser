Last login: Thu Jul 22 18:57:56 on ttys000
/usr/bin/ssh
really got here
David-McDonalds-MacBook-Pro:~ ddm$ cd ws/nlp/Sparser/code/s/
David-McDonalds-MacBook-Pro:s ddm$ grep article **/*.lisp **/**/*.lisp **/**/**/*.lisp **/**/**/**/*.lisp **/**/**/**/**/*.lisp
init/changed-files.lisp:"grammar;rules:syntax:articles"
init/changed-files.lisp:"grammar;rules:context:article"
init/changed-files.lisp:"drivers;inits:articles2"
init/changed-files.lisp:;; installing corpus of NIH articles
init/changed-files.lisp:2do: 4/1 Reexamine whole treatment of articles and nps. Coordinate
init/changed-files.lisp: the treatment in "grammar;rules:syntax:articles with the etfs.
init/changed-files.lisp:  ].phrase and .[article -- see define-determiner.
analyzers/char-level/display1.lisp:;;      rebound during the course of an article.
analyzers/char-level/display1.lisp:(defun write-current-token-to-article-stream (word position)
analyzers/char-level/display1.lisp:(defun write-specific-word-to-article-stream (word position)
analyzers/char-level/state2.lisp:  "As the analyzer procedes through the characters of an article,
analyzers/char-level/state2.lisp:   character-offset into the article of a given character.
analyzers/char-level/testing-file.lisp:;; *Eastern-as-string* to the original article in its
analyzers/char-level/testing-file.lisp:(defparameter *article* (concatenate 'string
analyzers/char-level/testing-file.lisp:                                     "original article"))
analyzers/char-level/testing1.lisp:;; (test_Next-char/whole-article :file *body*)
analyzers/char-level/testing1.lisp:;; (test_Next-char/whole-article :string *multi-buffer-string*)
analyzers/char-level/testing1.lisp:(defun test_Next-char/whole-article (&key string file)
analyzers/context/loader.lisp:   that is germain to the article as a whole, e.g. the article's date,
analyzers/doc/word-freq-(moved).lisp:   across multiple articles.")
analyzers/doc/word-freq-(moved).lisp:(defvar *word-types-at-start-of-article* 0
analyzers/doc/word-freq-(moved).lisp:  "Keeps track of how many new words appear in successive articles
analyzers/doc/word-freq-(moved).lisp:        *word-types-at-start-of-article* 0
analyzers/doc/word-freq-(moved).lisp:              (list (cons *current-article* 1)
analyzers/doc/word-freq-(moved).lisp:  (let ((subentry-for-current-article (cadr entry)))
analyzers/doc/word-freq-(moved).lisp:    (incf (cdr subentry-for-current-article))
analyzers/doc/word-freq-(moved).lisp:    subentry-for-current-article ))
analyzers/doc/word-freq-(moved).lisp:  (let* ((last-time *word-types-at-start-of-article*)
analyzers/doc/word-freq-(moved).lisp:    (setq *word-types-at-start-of-article* *word-types*)))
analyzers/forest/printers.lisp:#| This scheme fails to printout the very last tag in the article,
analyzers/sectionizing/action.lisp:      ;; article as later on.
analyzers/sectionizing/globals.lisp:  ;; called from Per-article-initializations
analyzers/tokenizer/punctuation.lisp:;;      of spaces as a signal to Write-current-token-to-article-stream
drivers/articles/article1.lisp:;;;     File:  "article"
drivers/articles/article1.lisp:;;;   Module:  "drivers;articles:"
drivers/articles/article1.lisp:   establish what full namestring to use when analyzing articles
drivers/articles/article1.lisp:(defvar *article-under-analysis* nil
drivers/articles/article1.lisp:  "Points to the designator (name) of the article presently being
drivers/articles/article1.lisp:(defun do-article (source)
drivers/articles/article1.lisp:  (catch '*abort-article*
drivers/articles/article1.lisp:                    (error "No source file for an article named ~a"
drivers/articles/article1.lisp:      (setq *article-under-analysis* decoded-source)
drivers/articles/article1.lisp:      (when *display-article-name*
drivers/articles/article1.lisp:        (format *standard-output* "~&~%Doing article:~%   ~A~%"
drivers/articles/article1.lisp:      (after-analysis/article decoded-source))))
drivers/articles/batch.lisp:;;;   Module:  "drivers;articles:"
drivers/articles/batch.lisp:  ;(preempt-all-fns-that-stop-execution 'abort-article/batch)
drivers/articles/batch.lisp:(defun abort-article/batch (string &rest args)
drivers/articles/batch.lisp:             ~%  Error/break in article~
drivers/articles/batch.lisp:             ~%" *article-under-analysis*)
drivers/articles/batch.lisp:  (throw '*abort-article* :error/break-occured))
drivers/articles/doc-stream.lisp:;;;   Module:  "drivers;articles:"
drivers/articles/doc-stream.lisp:           (do-articles-in-directory (ds-directory document-stream)))
drivers/articles/doc-stream.lisp:           (do-articles-in-files (ds-file-list document-stream)))
drivers/articles/doc-stream.lisp:(defun do-articles-in-directory (pathname)
drivers/articles/doc-stream.lisp:    (do-articles-in-files files)))
drivers/articles/doc-stream.lisp:(defun do-articles-in-files (list-of-files)
drivers/articles/doc-stream.lisp:    (do-article pathname)))
drivers/articles/loader.lisp:;;;   Module:  "drivers;articles:"
drivers/articles/loader.lisp:;; 0.1 (12/27) flushing [article] & [doc stream] as redundant with what's in
drivers/articles/loader.lisp:(lload "articles;style")
drivers/articles/loader.lisp:;;(lload "articles;batch")
drivers/articles/style.lisp:;;;   Module:  "drivers;articles:"
drivers/articles/style.lisp:;; 0.1 (9/1/94) brought into sync with upgraded Do-article
drivers/articles/style.lisp:#| Sets up per-article operations, interrogating the style object associated
drivers/articles/style.lisp:  ;; called from Do-article. Broken out as a subroutine for the convenience
drivers/articles/style.lisp:    ;; the style is set here and acted on by the Per-article-initializations
drivers/articles/style.lisp:  ;; called from Per-article-initializations as one of the unexplicit
drivers/chart/header-labels.lisp:  (when (cond ((first-item-in-article pos-before) t)
drivers/chart/headers.lisp:    (break/debug "~&Quick-scan-for-TX is being used in an article ~
drivers/chart/select2.lisp:    ;; within an article where the default rules for a text body
drivers/inits/articles2.lisp:;;; $Id: articles2.lisp 249 2009-07-23 17:03:45Z dmcdonal $
drivers/inits/articles2.lisp:;;;     File:  "articles"
drivers/inits/articles2.lisp:(defparameter *per-article-initializations* nil
drivers/inits/articles2.lisp:   Per-article-initializations")
drivers/inits/articles2.lisp:(defun per-article-initializations ()
drivers/inits/articles2.lisp:    (when *recognize-sections-within-articles*
drivers/inits/articles2.lisp:  (when *per-article-initializations*
drivers/inits/articles2.lisp:    (dolist (form *per-article-initializations*)
drivers/inits/articles2.lisp:;;; managing *per-article-initializations*
drivers/inits/articles2.lisp:  (push s-exp *per-article-initializations*)
drivers/inits/articles2.lisp:  (length *per-article-initializations*))
drivers/inits/articles2.lisp:  (let ((initialization-forms *per-article-initializations*))
drivers/inits/articles2.lisp:        (setq *per-article-initializations*
drivers/inits/articles2.lisp:  (pl *per-article-initializations* t))
drivers/inits/loader7.lisp:;; (7/13 v2.3) bumped [setup] to 2.  7/14 [articles] -> 2
drivers/inits/loader7.lisp:(lload "init-drivers;articles2")
drivers/inits/runs1.lisp:  (if (and *recognize-sections-within-articles*
drivers/inits/switches2.lisp:        ;; but since we're running over regular articles rather
drivers/sinks/article-windows.lisp:;;;     File:  "article windows"
drivers/sinks/article-windows.lisp:(defvar *current-article-window* nil)
drivers/sinks/article-windows.lisp:  (let ((w (make-a-new-article-window)))
drivers/sinks/article-windows.lisp:    (setq *current-article-window* w
drivers/sinks/article-windows.lisp:    (fill-article-window/string string w :select t)
drivers/sinks/article-windows.lisp:  ;; called from Do-article
drivers/sinks/article-windows.lisp:                   (error "No source file for an article named ~a"
drivers/sinks/article-windows.lisp:         (w (make-a-new-article-window)))
drivers/sinks/article-windows.lisp:    (setq *current-article-window* w)
drivers/sinks/article-windows.lisp:    (fill-article-window/file decoded-source w :select t)))
drivers/sinks/articles.lisp:;;;     File:  "articles"
drivers/sinks/articles.lisp:(defparameter *articles-with-records* nil)
drivers/sinks/articles.lisp:(defun after-analysis/article (article)
drivers/sinks/articles.lisp:  ;; called from Do-article
drivers/sinks/articles.lisp:  (when *vetted-records-in-article*
drivers/sinks/articles.lisp:    (push (cons article
drivers/sinks/articles.lisp:                *vetted-records-in-article*)
drivers/sinks/articles.lisp:          *articles-with-records*)))
drivers/sinks/core.lisp:  (when *recognize-sections-within-articles*
drivers/sinks/loader1.lisp:;; 1.1 (8/10/94) flushed [article windows] as made redundant by the workbench
drivers/sinks/loader1.lisp:(lload "sink-drivers;articles")
drivers/sources/articles.lisp:;;;     File:  "articles"
drivers/sources/articles.lisp:;; initialized 8/10/94 v2.3.  8/17 Added call to set *current-article* with an arg
drivers/sources/articles.lisp:;; 9/1 added style management.  9/15 move it to [drivers;articles:style]
drivers/sources/articles.lisp:(defun do-article (source-designator &key style)
drivers/sources/articles.lisp:  (set-the-current-article source-designator)
drivers/sources/core1.lisp:;; 1.2 (8/10/94) Redesigned core treatment to emphasize articles as a common
drivers/sources/core1.lisp:      (per-article-initializations))
drivers/sources/core1.lisp:    (string (do-article s))
drivers/sources/core1.lisp:    (pathname (do-article s))))
drivers/sources/doc-stream.lisp:;; 0.4 (8/10) switched final path to Do-article
drivers/sources/doc-stream.lisp:  ;; article vs. sissor file) depends on the style of document
drivers/sources/doc-stream.lisp:    (if *pause-between-articles*
drivers/sources/doc-stream.lisp:      (do-article *current-file*))))
drivers/sources/doc-stream.lisp:  ;; called from *repeat-last-article* item on the Sparser menu, or
drivers/sources/doc-stream.lisp:  ;; from ds/Do-explicit-file-list if the *pause-between-articles* flag
drivers/sources/doc-stream.lisp:    (do-article *current-file*)))
drivers/sources/doc-stream.lisp:  ;; and the call to do-article only occur once.
drivers/sources/doc-stream.lisp:    ;; Do the setup that would normally be done by Do-article
drivers/sources/doc-stream.lisp:    (set-the-current-article ds-designator)
drivers/sources/doc-stream.lisp:    (per-article-initializations)
drivers/sources/loader1.lisp:;; 1.1 (9/24/93 v2.3) broke out articles as their own directory
drivers/sources/loader1.lisp:;; 1.2 (3/28/94) gated it.  8/10 added [articles]
drivers/sources/loader1.lisp:  (lload "source-drivers;articles"))
drivers/sources/state.lisp:;;      3/4 added *pause-between-articles*
drivers/sources/state.lisp:   of an article, and for Repeat-last-file.")
drivers/sources/state.lisp:(defparameter *current-article* nil
drivers/sources/state.lisp:  "Bound by any of the drivers that analyze whole articles.  The
drivers/sources/state.lisp:   value is an article object.")
drivers/sources/state.lisp:(defparameter *pause-between-articles* t
grammar/tests/parsing.lisp:  (per-article-initializations))
grammar/tests/workspace.lisp:  (per-article-initializations)
grammar/tests/workspace.lisp:;;; canonical articles
init/workspaces/med.lisp:(defparameter *location-of-NIH-articles*
init/workspaces/med.lisp:;(ed (concatenate 'string *location-of-NIH-articles* "shc"))
init/workspaces/med.lisp:;(ed (concatenate 'string *location-of-NIH-articles* "pc12"))
init/workspaces/med.lisp:;(ed (concatenate 'string *location-of-NIH-articles* "kaplan"))
init/workspaces/text-segments.lisp:;;   article with a switch to a known article object once the AN
init/workspaces/text-segments.lisp:;;  and Redo-current-article-as-djns
init/workspaces/workbench.lisp:  (pp "In this era of frantic competition for ad dollars, a lot of revenue-desperate magazines are getting pretty cozy with advertisers -- fawning over them in articles and offering pages of advertorial space.")
init/workspaces/workbench.lisp:  (pp "In this era of frantic competition for ad dollars, a lot of revenue-desperate magazines are getting pretty cozy with advertisers -- fawning over them in articles and offering pages of advertorial space.
init/workspaces/workbench.lisp:  (pp "In this era of frantic competition for ad dollars, a lot of revenue-desperate magazines are getting pretty cozy with advertisers -- fawning over them in articles and offering pages of advertorial space.
interface/Apple/workspace.lisp:    (sparser::do-article pathname :style 'apple)))
interface/AssetNet/get-file.lisp:(defun construct-name-of-earnings-article-file ()
interface/AssetNet/get-file.lisp:(defun wait-for-next-article-file ()
interface/AssetNet/get-file.lisp:  (let ((file-name (construct-name-of-earnings-article-file))
interface/AssetNet/get-file.lisp:    (when *testing-Wait-for-next-article-file*
interface/AssetNet/get-file.lisp:        (when *testing-Wait-for-next-article-file*
interface/AssetNet/menus.lisp:                        :menu-item-title "Look for articles"
interface/AssetNet/old-driver.lisp:            (wait-for-next-article-file))
interface/AssetNet/traces.lisp:(defparameter *testing-Wait-for-next-article-file*  t
interface/AssetNet/traces.lisp:  "Called from Wait-for-next-article-file, writes a msg to 
interface/AssetNet/traces.lisp:  "Called from Wait-for-next-article-file, writes ' . ' to
interface/SUN/scan-routine.lisp:  ;; especially within the same article, we'll have seen them before
interface/archive -- interface/loader.lisp:(lload "windows;articles:loader")
interface/archive -- interface/new-menus.lisp:                  :menu-item-title "Belmoral article"
interface/corpus/doc-streams.lisp:;; 0.4 (3/10) uncommented the product announcements and Tipster test articles
interface/corpus/doc-streams.lisp:;;     (9/15) added html  (12/28) added kf-web articles.
interface/corpus/doc-streams.lisp:  (define-document-stream '|Tipster test articles|
interface/corpus/logicals.lisp:  ;; a sample of 11 articles about the international financial farcas
interface/corpus/logicals.lisp:  ;; three longish tnm articles collected at C&L in 1991
interface/corpus/logicals.lisp:                        ;;"tipster;test articles:"
interface/corpus/menu-data.lisp:;; initiated 1/25/94 v2.3. 3/10 added Earnings reports, Tipster test articles
interface/corpus/menu-data.lisp:    ,(document-stream-named '|Tipster test articles|)
interface/grammar/edges.lisp:(defparameter *edges-in-view-of-current-article* nil)
interface/grammar/edges.lisp:          :table-sequence *edges-in-view-of-current-article*
interface/grammar/edges.lisp:                      (select-text-covered-by-edge/current-article ,edge))
interface/grammar/edges.lisp:(defun generate-edge-list-for-current-article ()
interface/grammar/edges.lisp:    (setq *edges-in-view-of-current-article* (nreverse edge-list))
interface/grammar/edges.lisp:    (length *edges-in-view-of-current-article*)))
interface/grammar/edges.lisp:(defun generate-treetop-list-for-current-article ()
interface/menus/Sparser-hacked.lisp:                     *start-corpus* *repeat-last-article* *continue/next*
interface/menus/Sparser.lisp:        (push *repeat-last-article* items)
interface/menus/corpus.lisp:(defparameter *repeat-last-article*
interface/menus/corpus.lisp:    :menu-item-title (if *pause-between-articles*
interface/menus/corpus.lisp:    :menu-item-action (if *pause-between-articles*
interface/menus/corpus.lisp:  (setq *pause-between-articles* nil)
interface/menus/corpus.lisp:  (setq *pause-between-articles* t)
interface/records/driver1.lisp:;;; per-article driver
interface/records/driver1.lisp:          (setq *vetted-records-in-article* nil))
interface/records/driver1.lisp:      (format t "~&~%--- no salient objects in this article -----~%"))))
interface/records/driver1.lisp:(defun write-db-records-for-pending-articles ()
interface/records/driver1.lisp:    (if *articles-with-records*
interface/records/driver1.lisp:        (when (null *articles-with-records*)
interface/records/driver1.lisp:        (setq item (pop *articles-with-records*))
interface/records/driver1.lisp:      (format t "~&No articles: *articles-with-records* is nil~%"))))
interface/records/driver1.lisp:    (let ( article-name write-forms )
interface/records/driver1.lisp:      (setq article-name (first item)
interface/records/driver1.lisp:      (setq *article-under-analysis*
interface/records/driver1.lisp:            (article-name-from-stored-form article-name))
interface/records/driver1.lisp:(defun article-name-from-stored-form (form)
interface/records/driver1.lisp:     (break/debug "New form of article used in the batch storage:~
interface/records/open-file.lisp:  (let ((article *article-under-analysis*))
interface/records/open-file.lisp:     ((stringp article)
interface/records/open-file.lisp:      (when (filename-ends-in ".TXT" article)
interface/records/open-file.lisp:        (setq article (replace-filename-suffix ".TXT" ".REC" article)))
interface/records/open-file.lisp:                   article))
interface/records/open-file.lisp:     (t (break "The article is being represented as something ~
interface/records/open-file.lisp:                other than a string:~%   ~A" article)))))
interface/records/salient-objects.lisp:;;; per-article state
interface/records/salient-objects.lisp:   article that are determined to be salient.")
interface/records/vet-records.lisp:(defvar *vetted-records-in-article* nil
interface/records/vet-records.lisp:   After-analysis/article ")
interface/records/vet-records.lisp:    (push form *vetted-records-in-article*)))
interface/workbench/adjust.lisp:   the master flag when an article is begun
interface/workbench/autodef.lisp:;;;   module:  "interface;windows:articles:"
interface/workbench/edges.lisp:          :table-sequence *edges-in-view-of-current-article*
interface/workbench/edges.lisp:      (update-edge-list-for-current-article)
interface/workbench/edges.lisp:  (generate-treetop-list-for-current-article)
interface/workbench/edges.lisp:(defun update-edge-list-for-current-article ( &optional top-edge )
interface/workbench/edges.lisp:  (generate-treetop-list-for-current-article)
interface/workbench/edges.lisp:                      *edges-in-view-of-current-article*)
interface/workbench/edges.lisp:  (let ((sublist (member e *edges-in-view-of-current-article*)))
interface/workbench/edges.lisp:      (let* ((cell# (- (length *edges-in-view-of-current-article*)
interface/workbench/edges.lisp:    (dolist (item *edges-in-view-of-current-article* nil)
interface/workbench/edges.lisp:      (- (length *edges-in-view-of-current-article*)
interface/workbench/edges.lisp:  (do ((item (car *edges-in-view-of-current-article*)
interface/workbench/edges.lisp:       (rest-of-list *edges-in-view-of-current-article*))
interface/workbench/edges.lisp:  (let ((sublist (member wf *edges-in-view-of-current-article*
interface/workbench/edges.lisp:      (- (length *edges-in-view-of-current-article*)
interface/workbench/edges.lisp:(defun generate-treetop-list-for-current-article ()
interface/workbench/edges.lisp:    (setq *edges-in-view-of-current-article* (nreverse edge-list))
interface/workbench/edges.lisp:    (length *edges-in-view-of-current-article*)))
interface/workbench/edges.lisp:(defun generate-edge-list-for-current-article ()
interface/workbench/edges.lisp:    (setq *edges-in-view-of-current-article* (nreverse edge-list))))
interface/workbench/edges.lisp:         (dolist (item *edges-in-view-of-current-article*
interface/workbench/edges.lisp:  (let* ((edges-cons (member edge *edges-in-view-of-current-article*))
interface/workbench/edges.lisp:  (let ((parent-cons (member parent *edges-in-view-of-current-article*)))
interface/workbench/edges.lisp:                            *edges-in-view-of-current-article*)
interface/workbench/edges.lisp:             (cadr (member edge *edges-in-view-of-current-article*))))
interface/workbench/edges.lisp:                            *edges-in-view-of-current-article*)))))
interface/workbench/edges.lisp:        (sublist (member word-form *edges-in-view-of-current-article*
interface/workbench/edges.lisp:    (let* ((index (- (length *edges-in-view-of-current-article*)
interface/workbench/edges.lisp:                               *edges-in-view-of-current-article*))
interface/workbench/edges.lisp:                      *edges-in-view-of-current-article*))
interface/workbench/edges.lisp:                            *edges-in-view-of-current-article*)
interface/workbench/edges.lisp:                              *edges-in-view-of-current-article*)))
interface/workbench/edges.lisp:        (set-table-sequence *edges-table* *edges-in-view-of-current-article*)
interface/workbench/fill.lisp:;;;   module:  "interface;windows:articles:"
interface/workbench/fill.lisp:  "Accumulates records of significant text segments in the article(s)
interface/workbench/fill.lisp:;;; getting an analyzed text into an article window
interface/workbench/fill.lisp:(defun fill-article-window/string (string
interface/workbench/fill.lisp:(defun fill-article-window/file (file window  &key select)
interface/workbench/globals.lisp:(defparameter *edges-in-view-of-current-article* nil
interface/workbench/initializations.lisp:        *edges-in-view-of-current-article* nil
interface/workbench/object.lisp:;;;   module:  "interface;windows:articles:"
interface/workbench/preferences.lisp:(defparameter *pref/pause-b/w-articles-check-box*
interface/workbench/preferences.lisp:   "pause between articles"
interface/workbench/preferences.lisp:   :CHECK-BOX-CHECKED-P *pause-between-articles* ))
interface/workbench/preferences.lisp:  (if (check-box-checked-p *pref/pause-b/w-articles-check-box*)
interface/workbench/preferences.lisp:    (unless *pause-between-articles*
interface/workbench/preferences.lisp:    (unless (null *pause-between-articles*)
interface/workbench/preferences.lisp:              *pref/pause-b/w-articles-check-box*
interface/workbench/select.lisp:;;;   module:  "interface;windows:articles:"
interface/workbench/select.lisp:    (select-region/article-window
interface/workbench/select.lisp:     start-index end-index *current-article-window* label)
interface/workbench/select.lisp:(defun select-text-covered-by-edge/current-article (e)
interface/workbench/select.lisp:    (select-region/article-window
interface/workbench/select.lisp:     start-index end-index *current-article-window* label)
interface/workbench/select.lisp:(defun select-region/article-window (start end w
interface/workbench/text-view.lisp:  ;; called from write-current-token-to-article-stream by way
interface/workbench/text-view.lisp:        (update-edge-list-for-current-article start-edge)
interface/workbench/text-view.lisp:          (update-edge-list-for-current-article cons)
interface/workbench/window.lisp:  ;; called from write-current-token-to-article-stream by way
interface/workbench/workshop.lisp:;;;   module:  "interface;windows:articles:"
objects/doc/article.lisp:;;;     File:  "article"
objects/doc/article.lisp:(define-per-run-init-form '(set-the-current-article))
objects/doc/article.lisp:(defun set-the-current-article ()
objects/doc/article.lisp:  (setq *current-article*
objects/doc/context.lisp:   germain to the article as a whole, e.g. for the article's date,
objects/doc/doc-stream.lisp:are processed: one file is one article), or a list of explicit file names.
objects/doc/loader.lisp:;; 0.2  (12/7/93 v2.3) added [header label], moved [article] to grammar 12/15
objects/forms/loader7.lisp:(gate-grammar *recognize-sections-within-articles*
analyzers/psp/fill-chart/add5.lisp:      (write-specific-word-to-article-stream word position)
analyzers/psp/fill-chart/add5.lisp:      (write-current-token-to-article-stream word position)))
analyzers/psp/fill-chart/globals.lisp:   article, it is used to implement a circular array.  This flag
analyzers/psp/fill-chart/store5.lisp:   a fixed line length, the original newlines of the article are
analyzers/psp/fill-chart/store5.lisp:      (write-specific-word-to-article-stream word position)
analyzers/psp/fill-chart/store5.lisp:      (write-current-token-to-article-stream word position)))
analyzers/psp/fill-chart/testing.lisp:      (per-article-initializations))
analyzers/psp/init/init-chart1.lisp:  ;; Called with the per-article initializations.
drivers/chart/psp/scan.lisp:;;     (1/5/94) tweeking another detail involving full articles and paragraphs
drivers/chart/psp/scan1.lisp:;;     (1/5/94) tweeking another detail involving full articles and paragraphs
drivers/chart/psp/scan2.lisp:;;     (1/5/94) tweeking another detail involving full articles and paragraphs
drivers/chart/psp/scan3.lisp:;;     (1/5/94) tweeking another detail involving full articles and paragraphs
drivers/inits/sessions/globals1.lisp:(defparameter *display-article-name* t
drivers/inits/sessions/globals1.lisp:   on, the name of the article will be printed to *standard-output*
drivers/inits/sessions/globals1.lisp:  "Flag controlling whether the text of the article appears in a
drivers/inits/sessions/globals1.lisp:   article window.")
drivers/inits/sessions/globals1.lisp:  "Flag controlling whether after an article is analyzed its accumulated
drivers/inits/sessions/globals1.lisp:  "Flag controlling whether after an article is analyzed its accumulated
drivers/timing/Bankruptcy/envelope---everything.lisp:             Christi Harlan contributed to this article.
drivers/timing/Bankruptcy/envelope---everything.lisp:          article.
grammar/model/dossiers/company-name-examples.lisp:Your Oct. 6 article "Japan's Financial Firms Lure Science Graduates" 
grammar/rules/CA/first-item.lisp:;;; begining of the body of a news wire article
grammar/rules/CA/first-item.lisp:(defun first-item-in-article (edge/pos)
grammar/rules/CA/first-item.lisp:      (return-from First-item-in-article nil))
grammar/rules/CA/first-item.lisp:    (left-neighbor-marks-start-of-article left-neighbor)))
grammar/rules/CA/first-item.lisp:(defun left-neighbor-marks-start-of-article (left-neighbor)
grammar/rules/CA/first-item.lisp:    (or (left-neighbor-marks-start-of-article left-neighbor)
grammar/rules/CA/topic-company.lisp: occur with most any article in a given style and must be marked as such
grammar/rules/CA/topic-company.lisp: that are mentioned in the article. |#
grammar/rules/CA/topic-company.lisp:      (try-to-determine-the-articles-topic-company-if-any)))
grammar/rules/CA/topic-company.lisp:(defun try-to-determine-the-articles-topic-company-if-any ()
grammar/rules/CA/topic-company.lisp:         (one-of-the-articles-companies-is-very-frequent)))
grammar/rules/CA/topic-company.lisp:(defun one-of-the-articles-companies-is-very-frequent ()
grammar/rules/FSAs/newline4.lisp:                 (write-specific-word-to-article-stream *newline*))
grammar/rules/FSAs/newline4.lisp:                 (write-specific-word-to-article-stream *newline*))
grammar/rules/HA/loader1.lisp:(gate-grammar *recognize-sections-within-articles*
grammar/rules/SGML/DJNS-WSJ-cases.lisp:  (cond ((DJNS-article?)
grammar/rules/SGML/DJNS-WSJ-cases.lisp:             (redo-current-article-as-djns an)
grammar/rules/SGML/Tipster-cases.lisp: article, with the interpretation that is appropriate to Tipster.
grammar/rules/SGML/Tipster-cases.lisp:      ;; there's no point in spanning the entire article with an
grammar/rules/SGML/Tipster-cases.lisp:;;; field for the article's "source":  <SO>
grammar/rules/SGML/Tipster-cases.lisp:            (analyze-segment-as-article-source interior-start
grammar/rules/SGML/Tipster-cases.lisp:                  category::article-source
grammar/rules/SGML/Tipster-cases.lisp:(defun analyze-segment-as-article-source (start-pos end-pos)
grammar/rules/SGML/Tipster-cases.lisp:;;; field for the article's date: <DD>
grammar/rules/SGML/Tipster-cases.lisp:(define-sgml-tag  "DD" 'article-date
grammar/rules/SGML/Tipster-cases.lisp:  :initiation-action  'start-article-date-segment
grammar/rules/SGML/Tipster-cases.lisp:  :termination-action 'end-article-date-segment )
grammar/rules/SGML/Tipster-cases.lisp:(defun start-article-date-segment (edge &optional pos-before/edge)
grammar/rules/SGML/Tipster-cases.lisp:(defun end-article-date-segment (final-pos/edge
grammar/rules/SGML/Tipster-cases.lisp:            (analyze-segment-as-article-date interior-start
grammar/rules/SGML/Tipster-cases.lisp:                  category::article-date
grammar/rules/SGML/Tipster-cases.lisp:(defun analyze-segment-as-article-date (start-pos end-pos)
grammar/rules/brackets/judgements.lisp:                  (if (eq *bracket-opening-segment* .[article)
grammar/rules/brackets/judgements.lisp:                    (if (np-segment-contains-more-than-article? position)
grammar/rules/brackets/judgements.lisp:(defun np-segment-contains-more-than-article? (position)
grammar/rules/brackets/judgements.lisp:  ;; We are within an np -- probably one started with an article
grammar/rules/brackets/judgements.lisp:  ;; the segment after the article. That comes down to this
grammar/rules/brackets/judgements1.lisp:		     (eq (first *bracket-opening-segment*) .[article )
grammar/rules/brackets/judgements1.lisp:			(eq (first *bracket-opening-segment*) .[article ))
grammar/rules/brackets/judgements1.lisp:		    (if (np-segment-contains-more-than-article? position)
grammar/rules/brackets/judgements1.lisp:			;; ambig. is more than one word away from the article,
grammar/rules/brackets/judgements1.lisp:		     (eq (first *bracket-opening-segment*) .[article ))
grammar/rules/brackets/judgements1.lisp:(defun np-segment-contains-more-than-article? (position)
grammar/rules/brackets/judgements1.lisp:  ;; We are within an np -- probably one started with an article
grammar/rules/brackets/judgements1.lisp:  ;; the segment after the article. That comes down to this
grammar/rules/brackets/types.lisp:;;   6/7 added mvb.].  7/11 added .[article   7/13 added mvb.[   10/19 fixed typo
grammar/rules/brackets/types.lisp:(define-bracket :[  :before  article 1)  ;;  .[article
grammar/rules/context/article.lisp:;;;     File:  "article"
grammar/rules/context/article.lisp:;; -article stub and reviewed Set-the-current-article
grammar/rules/context/article.lisp:(defun set-the-current-article (source-designator)
grammar/rules/context/article.lisp:  ;; called from Do-article
grammar/rules/context/article.lisp:;(define-per-run-init-form '(deallocate-current-article))
grammar/rules/context/article.lisp:(defun deallocate-current-article ()
grammar/rules/context/article.lisp:  ;; since the article individual (and other section individuals)
grammar/rules/context/date.lisp:;;; the date on which an article was written ( "DD" field in DCI )
grammar/rules/context/date.lisp:(define-context-variable *article-date* nil
grammar/rules/context/date.lisp:   Tipster article.  It is a #<date>.")
grammar/rules/context/date.lisp:  ;; called from Analyze-segment-as-article-source and returns what
grammar/rules/context/date.lisp:  ;; edge over the article's source field.
grammar/rules/context/date.lisp:        (setq *article-date* ref)
grammar/rules/context/document-number.lisp:;; (12/27/93) Put in the case for regular DJNS articles (AN field)
grammar/rules/context/document-number.lisp:(define-context-variable *article-number* nil
grammar/rules/context/document-number.lisp:   Tipster article.  It is a #<number/obj> in Tipster.")
grammar/rules/context/document-number.lisp:  ;; called from Analyze-segment-as-article-source and returns what
grammar/rules/context/document-number.lisp:  ;; edge over the article's source field.
grammar/rules/context/document-number.lisp:        (setq *article-number* ref)
grammar/rules/context/loader.lisp:;; (12/15/93 v2.3) added [article]. 5/12/94 added [marker glifs].
grammar/rules/context/loader.lisp:   germain to the article as a whole, e.g. for the article's date,
grammar/rules/context/loader.lisp:(gload "context-rules;article")
grammar/rules/context/source.lisp:;;;  the article's "source" -- the SO field
grammar/rules/context/source.lisp:(define-context-variable  *article-source* nil
grammar/rules/context/source.lisp:   Tipster article.  It is typically a news service.")
grammar/rules/context/source.lisp:  ;; called from Analyze-segment-as-article-source and returns what
grammar/rules/context/source.lisp:  ;; edge over the article's source field.
grammar/rules/context/source.lisp:        (setq *article-source* ref)
grammar/rules/paragraphs/data.lisp:      (break "This article has more lines than were provided for ~
grammar/rules/paragraphs/loader.lisp:(gate-grammar *recognize-sections-within-articles*
grammar/rules/paragraphs/object1.lisp:   article up to and including the current one")
grammar/rules/paragraphs/object1.lisp:(defvar *paragraphs-in-the-article* nil
grammar/rules/paragraphs/object1.lisp:        *paragraphs-in-the-article* nil
grammar/rules/paragraphs/object1.lisp:          ;; paragraph appeared in the article
grammar/rules/paragraphs/object1.lisp:  (dolist (p *paragraphs-in-the-article*)
grammar/rules/paragraphs/object2.lisp:   article up to and including the current one")
grammar/rules/paragraphs/object2.lisp:(defvar *paragraphs-in-the-article* nil
grammar/rules/paragraphs/object2.lisp:        *paragraphs-in-the-article* nil
grammar/rules/paragraphs/object2.lisp:          ;; paragraph appeared in the article
grammar/rules/paragraphs/object2.lisp:  (dolist (p *paragraphs-in-the-article*)
grammar/rules/sectionizing/header1.lisp:;; item-in-the-article, and it is a good notion.
grammar/rules/sectionizing/initial-region1.lisp:  ;; called by Per-article-initializations, permiting this to
grammar/rules/sectionizing/initial-region1.lisp:  ;; vary between articles, rather than just runs -- but that's
grammar/rules/sources/CBD.lisp:;(do-article (probe-file anit) :style (document-style-named 'CBD))
grammar/rules/sources/DJNS-extra-LF.lisp:  ;; The DJNS Who's News articles collected at Sandpoint had
grammar/rules/sources/DJNS.lisp:;; 0.3 (8/19) changed inheriance of the djns-article to text-under-analysis
grammar/rules/sources/DJNS.lisp:  ;; The DJNS Who's News articles collected at Sandpoint had
grammar/rules/sources/DJNS.lisp:  ;; alternative for articles that were typed in or had their
grammar/rules/sources/DJNS.lisp:(defun dJNS-article? ()
grammar/rules/sources/DJNS.lisp:  ;; tests whether the article currently being run is from DJNS,
grammar/rules/sources/DJNS.lisp:(define-category DJNS-article
grammar/rules/sources/DJNS.lisp:(defun redo-current-article-as-djns (an)
grammar/rules/syntax/articles.lisp:;;;     File:  "articles"
grammar/rules/syntax/loader3.lisp:;; 3.1 (10/25) added [articles]
grammar/rules/syntax/loader3.lisp:  (gload "syntax-art;articles"))
grammar/rules/tree-families/NP.lisp:(define-exploded-tree-family  soak-up-indefinite-article
grammar/rules/tree-families/NP.lisp:  :description "Makes form rules that snarf the article without any ~
grammar/rules/tree-families/NP.lisp:;;--- definite articles
grammar/rules/tree-families/NP.lisp: this schema to soak up the definite article, which is presumed to have
grammar/rules/tree-families/NP.lisp:;;--- indefinite articles
grammar/rules/words/determiners.lisp:;; 0.2 (7/11) changed assignment on the, a, & an to .[article from .[np
grammar/rules/words/determiners.lisp:(define-determiner "the"  :brackets '( ].phrase .[article ))
grammar/rules/words/determiners.lisp:(define-determiner "an"   :brackets '( ].phrase .[article ))
grammar/rules/words/determiners.lisp:(define-determiner "a"    :brackets '( ].phrase .[article ))
grammar/rules/words/determiners.lisp:(define-determiner "A"    :brackets '( ].phrase .[article ))
grammar/rules/words/determiners.lisp:;; bracket than 'article' or 'np' will let the close bracket from
grammar/rules/words/frequency.lisp:;; 0.3 (6/9/10) Hacking *current-article* so we can to tf/idf analyses
grammar/rules/words/frequency.lisp:   across multiple articles.")
grammar/rules/words/frequency.lisp:(defvar *word-types-at-start-of-article* 0
grammar/rules/words/frequency.lisp:  "Keeps track of how many new words appear in successive articles
grammar/rules/words/frequency.lisp:        *word-types-at-start-of-article* 0
grammar/rules/words/frequency.lisp: an alist of (<article> . <per-article-count>).  Word objects
grammar/rules/words/frequency.lisp:;; *current-article* is defined in drivers/sources/state.lisp which is 
grammar/rules/words/frequency.lisp:;; one of the frequency drivers. The value is supposed to be an article
grammar/rules/words/frequency.lisp:              (list (cons *current-article* 1)
grammar/rules/words/frequency.lisp:  (let ((subentry-for-current-article 
grammar/rules/words/frequency.lisp:	 (if *current-article*
grammar/rules/words/frequency.lisp:	   (assq *current-article* (cdr entry))
grammar/rules/words/frequency.lisp:    (when *current-article*
grammar/rules/words/frequency.lisp:      (unless subentry-for-current-article
grammar/rules/words/frequency.lisp:	(setq subentry-for-current-article
grammar/rules/words/frequency.lisp:	      `(,*current-article* . 0))
grammar/rules/words/frequency.lisp:	(rplacd entry (cons subentry-for-current-article
grammar/rules/words/frequency.lisp:    (incf (cdr subentry-for-current-article))
grammar/rules/words/frequency.lisp:    subentry-for-current-article ))
grammar/rules/words/frequency.lisp:  (let* ((last-time *word-types-at-start-of-article*)
grammar/rules/words/frequency.lisp:    (setq *word-types-at-start-of-article* *word-types*)))
grammar/rules/words/frequency.lisp:;;; Differential counts by article (baby steps towards tf/idf)
grammar/rules/words/frequency.lisp:;;//// need a structure/class for the article so we can invert
grammar/rules/words/frequency.lisp:  (let ((*current-article*
grammar/rules/words/frequency.lisp:    (declare (special *current-article*))
grammar/tests/C&L/QA-test-set-driver.lisp:(defun f (&optional (pathname *article*))
grammar/tests/C&L/QA-test-set-driver.lisp:; The article this is reported as occurring on is 25-EMEX, which I don't have.
grammar/tests/C&L/QA-test-set-driver.lisp:   ;;n.b. in this article Kawasaki is a person, not an instance
grammar/tests/C&L/QA-test-set-driver.lisp:(iterate-through-articles)
grammar/tests/C&L/testing-the-corpus.lisp:;;; running over articles in C&L's test corpus
grammar/tests/C&L/testing-the-corpus.lisp:(defparameter *C&L-90-article-text-corpus*
grammar/tests/C&L/testing-the-corpus.lisp:(defvar *articles-yet-to-do* nil)
grammar/tests/C&L/testing-the-corpus.lisp:(defvar *articles-done* nil)
grammar/tests/C&L/testing-the-corpus.lisp:(defun iterate-through-articles
grammar/tests/C&L/testing-the-corpus.lisp:       (&optional (article-list *C&L-90-article-text-corpus*)
grammar/tests/C&L/testing-the-corpus.lisp:                  &aux article-form
grammar/tests/C&L/testing-the-corpus.lisp:  (setq *articles-yet-to-do* article-list)
grammar/tests/C&L/testing-the-corpus.lisp:    (setq article-form (pop *articles-yet-to-do*))
grammar/tests/C&L/testing-the-corpus.lisp:    (eval article-form)
grammar/tests/C&L/testing-the-corpus.lisp:    (push article-form *articles-done*)
grammar/tests/C&L/testing-the-corpus.lisp:    (when (null *articles-yet-to-do*)
grammar/tests/C&L/testing-the-corpus.lisp:  (iterate-through-articles))
grammar/tests/archive/psp.lisp:  (per-article-initializations)
grammar/tests/archive/psp.lisp:;;; canonical articles
init/workspaces/not active/Apple.lisp:;(per-article-initializations)
init/workspaces/not active/Apple.lisp:    (do-article pathname :style 'apple)))
init/workspaces/not active/Apple.lisp:    (do-article pathname :style 'apple)))
init/workspaces/not active/Apple.lisp:  (let ((*pause-between-articles* nil)
init/workspaces/not active/Sandia.lisp:           ~%;; (ed \"Moby:ddm:projects:Sandia:interesting articles 5/9\")~
interface/CL/cfr/test-BCY-TNM.lisp:;;; whole articles
interface/CL/cfr/test-BCY-TNM.lisp:  (analyze-text-from-file "C&L;cfr:CFR test articles:9007100013"))
interface/CL/cfr/test-BCY-TNM.lisp:  (analyze-text-from-file "C&L;cfr:CFR test articles:9007110028"))
interface/CL/cfr/test-BCY-TNM.lisp:  (analyze-text-from-file "C&L;cfr:CFR test articles:9007120091"))
interface/CL/eta/dummy-call.lisp:;; paragraph within the article being processed.
interface/CL/eta/testing.lisp:  the global flag that controls whether the text of the article under
interface/CL/eta/testing.lisp:  ;; this hits early in the article
interface/CL/eta/testing.lisp:  ;; this hits quite late in the article
interface/workbench/edge-view/find.lisp:  (let ((sublist (member e *edges-in-view-of-current-article*)))
interface/workbench/edge-view/find.lisp:      (- (length *edges-in-view-of-current-article*)
interface/workbench/edge-view/find.lisp:    (dolist (item *edges-in-view-of-current-article* nil)
interface/workbench/edge-view/find.lisp:      (- (length *edges-in-view-of-current-article*)
interface/workbench/edge-view/find.lisp:  (do ((item (car *edges-in-view-of-current-article*)
interface/workbench/edge-view/find.lisp:       (rest-of-list *edges-in-view-of-current-article*))
interface/workbench/edge-view/find.lisp:  (let ((sublist (member wf *edges-in-view-of-current-article*
interface/workbench/edge-view/find.lisp:      (- (length *edges-in-view-of-current-article*)
interface/workbench/edge-view/find.lisp:    (dolist (item *edges-in-view-of-current-article*)
interface/workbench/edge-view/find.lisp:    (dolist (item *edges-in-view-of-current-article*)
interface/workbench/edge-view/open-close.lisp:         (dolist (item *edges-in-view-of-current-article*
interface/workbench/edge-view/open-close.lisp:  (let* ((edges-cons (member edge *edges-in-view-of-current-article*))
interface/workbench/edge-view/open-close.lisp:  (let ((parent-cons (member parent *edges-in-view-of-current-article*)))
interface/workbench/edge-view/open-close.lisp:                            *edges-in-view-of-current-article*)
interface/workbench/edge-view/open-close.lisp:      (if (eq (car (last *edges-in-view-of-current-article*))
interface/workbench/edge-view/open-close.lisp:            (member parent *edges-in-view-of-current-article*))
interface/workbench/edge-view/open-close.lisp:      ;; changes *edges-in-view-of-current-article*
interface/workbench/edge-view/open-close.lisp:      ;(pl *edges-in-view-of-current-article*)
interface/workbench/edge-view/open-close.lisp:      (set-table-sequence *edges-table* *edges-in-view-of-current-article*)
interface/workbench/edge-view/open-close.lisp:         (member parent *edges-in-view-of-current-article*)))
interface/workbench/edge-view/open-close.lisp:                        *edges-in-view-of-current-article*)))
interface/workbench/edge-view/open-close.lisp:         (cadr (member parent *edges-in-view-of-current-article*))))
interface/workbench/edge-view/open-close.lisp:        (sublist (member word-form *edges-in-view-of-current-article*
interface/workbench/edge-view/open-close.lisp:    (let* ((index (- (length *edges-in-view-of-current-article*)
interface/workbench/edge-view/open-close.lisp:                               *edges-in-view-of-current-article*))
interface/workbench/edge-view/open-close.lisp:                      *edges-in-view-of-current-article*))
interface/workbench/edge-view/open-close.lisp:                            *edges-in-view-of-current-article*)
interface/workbench/edge-view/populate.lisp:(defun generate-treetop-list-for-current-article ()
interface/workbench/edge-view/populate.lisp:    (setq *edges-in-view-of-current-article* (nreverse edge-list))
interface/workbench/edge-view/populate.lisp:    (length *edges-in-view-of-current-article*)))
interface/workbench/edge-view/populate.lisp:(defun generate-edge-list-for-current-article ()
interface/workbench/edge-view/populate.lisp:    (setq *edges-in-view-of-current-article* (nreverse edge-list))))
interface/workbench/edge-view/populate1.lisp:(defun generate-treetop-list-for-current-article ()
interface/workbench/edge-view/populate1.lisp:    (setq *edges-in-view-of-current-article* (nreverse edge-list))
interface/workbench/edge-view/populate1.lisp:    (length *edges-in-view-of-current-article*)))
interface/workbench/edge-view/populate1.lisp:(defun generate-edge-list-for-current-article ()
interface/workbench/edge-view/populate1.lisp:    (setq *edges-in-view-of-current-article* (nreverse edge-list))))
interface/workbench/edge-view/view.lisp:          :table-sequence *edges-in-view-of-current-article*
interface/workbench/edge-view/view.lisp:      (update-edge-list-for-current-article)
interface/workbench/edge-view/view.lisp:  (generate-treetop-list-for-current-article)
interface/workbench/edge-view/view.lisp:(defun update-edge-list-for-current-article ( &optional top-edge )
interface/workbench/edge-view/view.lisp:  (generate-treetop-list-for-current-article)
interface/workbench/edge-view/view.lisp:                      *edges-in-view-of-current-article*)
interface/workbench/edge-view/view1.lisp:          :table-sequence *edges-in-view-of-current-article*
interface/workbench/edge-view/view1.lisp:      (update-edge-list-for-current-article)
interface/workbench/edge-view/view1.lisp:  (generate-treetop-list-for-current-article)
interface/workbench/edge-view/view1.lisp:(defun update-edge-list-for-current-article ( &optional top-edge )
interface/workbench/edge-view/view1.lisp:  (generate-treetop-list-for-current-article)
interface/workbench/edge-view/view1.lisp:                      *edges-in-view-of-current-article*)
objects/model/individuals/reclaim.lisp:  ;; called from Per-article-initializations -- it zeros
objects/model/individuals/reclaim1.lisp:  ;; called from Per-article-initializations -- it zeros
objects/model/individuals/resource.lisp: we might see in the course of a long article, rather than with edges
objects/model/individuals/resource1.lisp: we might see in the course of a long article, rather than with edges
objects/model/psi/resource.lisp:;;//// needs to hook into per-article-initializations via some sort
grammar/model/core/companies/find-cs.lisp:    (index/per-article/company company :from :find-or-make)
grammar/model/core/companies/find-cs.lisp:        (look-for/per-article/company/name1-only name1)
grammar/model/core/companies/find-cs.lisp:      (look-for/per-article/company name-list))))
grammar/model/core/people/particles.lisp:;;;     File:  "particles"
grammar/model/core/time/fiscal1.lisp:;;--- article gets lost //perhaps we're going to np too soon?
grammar/model/core/time/fiscal2.lisp:;;--- article gets lost //perhaps we're going to np too soon?
grammar/model/sl/ERN/discourse-heuristics.lisp:      ;; that there isn't going to be any information in later articles
grammar/model/sl/ERN/discourse-heuristics.lisp:      (unless (member (first fr/dh) *financial-reports-in-article*)
grammar/model/sl/ERN/discourse-heuristics.lisp:        (push fr *financial-reports-in-article*)))
grammar/model/sl/ERN/discourse-heuristics.lisp:          (unless (member fr *financial-reports-in-article*)
grammar/model/sl/ERN/discourse-heuristics.lisp:            (push fr *financial-reports-in-article*)))))
grammar/model/sl/ERN/discourse-heuristics.lisp:    *financial-reports-in-article* ))
grammar/model/sl/ERN/reporter.lisp:(define-context-variable *financial-reports-in-article* nil)
grammar/model/sl/ERN/reporter.lisp:  (when *financial-reports-in-article*
grammar/model/sl/ERN/reporter.lisp:    (dolist (fr *financial-reports-in-article*)
grammar/model/sl/ERN/workspace.lisp:;;; Excerpts from articles
grammar/model/sl/JV/headers.lisp:   the headers of Tipster articles  |#
grammar/model/sl/NIH/association.lisp:#| From article #3 'sch'.  In the text, the sentence is extended with a 'but'.
init/versions/v3.1/config/load.lisp:;;       wierdness in running tts on the Yoshinoya article
init/versions/v3.1/loaders/grammar-modules.lisp:(define-grammar-module  *recognize-sections-within-articles*
init/versions/v3.1/loaders/grammar.lisp:  (gate-grammar *recognize-sections-within-articles*
init/versions/v3.1/loaders/logicals.lisp:;; 9/24 broke out articles from other sources;  9/28 handled hassle with
init/versions/v3.1/loaders/logicals.lisp:(def-logical-pathname "articles;"        "drivers;articles:")
init/versions/v3.1/loaders/master-loader.lisp:;;  [drivers;articles], which was apparently missing before this.
init/versions/v3.1/loaders/master-loader.lisp:(when *recognize-sections-within-articles*
init/versions/v3.1/loaders/master-loader.lisp:(lload "articles;loader")
init/versions/v3.1/loaders/master-loader.lisp:  ;; Loading the set of logicals that define articles in 
init/versions/v3.1/loaders/stubs.lisp:   (unless *recognize-sections-within-articles*
init/versions/v3.1/loaders/stubs.lisp:   (defun do-article (s)
init/versions/v3.1/workspace/abbreviations.lisp:    (setq pathname *article*))
init/versions/v3.1/workspace/basic-tests.lisp:;(test_Next-char/whole-article)
init/versions/v3.1/workspace/basic-tests.lisp:;(batch-run '|Tipster test articles|)
init/versions/v3.1/workspace/basic-tests.lisp:;(batch-run '|WSJ ERN articles|)
init/versions/v3.1/workspace/basic-tests.lisp:;(f (setq *current-article* (pop files)))
init/versions/v3.1/workspace/basic-tests.lisp:;(f *current-article*)
init/versions/v3.1/workspace/basic-tests.lisp:;(preempt-all-fns-that-stop-execution 'abort-article/batch)
init/versions/v3.1/workspace/in-progress.lisp:  ;; compensate for not loading all of [rule;context:article]
init/versions/v3.1/workspace/in-progress.lisp:  (let ((*pause-between-articles* nil)
init/versions/v3.1/workspace/in-progress.lisp:  (pp "In this era of frantic competition for ad dollars, a lot of revenue-desperate magazines are getting pretty cozy with advertisers -- fawning over them in articles and offering pages of advertorial space.")
init/versions/v3.1/workspace/in-progress.lisp:  (pp "In this era of frantic competition for ad dollars, a lot of revenue-desperate magazines are getting pretty cozy with advertisers -- fawning over them in articles and offering pages of advertorial space.
init/versions/v3.1/workspace/in-progress.lisp:  (pp "In this era of frantic competition for ad dollars, a lot of revenue-desperate magazines are getting pretty cozy with advertisers -- fawning over them in articles and offering pages of advertorial space.
init/versions/v3.1/workspace/in-progress.lisp:    ;; since this is a copied djns article and doesn't have
init/versions/v3.1/workspace/in-progress.lisp:  (f *article*))
init/versions/v3.1/workspace/in-progress.lisp:;;   article with a switch to a known article object once the AN
init/versions/v3.1/workspace/in-progress.lisp:;;  and Redo-current-article-as-djns
init/versions/v3.1/workspace/traces.lisp:; *current-article-window*
init/versions/v3.1/workspace/traces.lisp:;  (per-article-initializations)
objects/chart/words/lookup/buffer.lisp:      (error "A word has just been scanned in the current article ~
grammar/model/core/names/fsa/name-creators.lisp:        ;; but it seems unlikely that in one article there would
grammar/model/sl/Who's-News/job-events/records1.lisp:  ;; whole article has been analyzed.
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:(defun f/tts (article)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:  (f article) (tts))
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:;(f/buffer (setq *current-article* (pop files)))
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:;(f/buffer *current-article*)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:;(f/tts *current-article*)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:;(f/tts (setq *current-article* (pop files)))
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:;(f/tts *current-article*)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:;(f (setq *current-article* (pop files)))
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:;(f *current-article*)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:;(r (setq *current-article* (pop files)))
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:;(r *current-article*)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:;(write-db-records-for-pending-articles)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:;(setq *articles-with-records* nil)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:  (let* ((analysis-filename (filename-for-article-analysis filename))
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:          (article-filename
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:           (filename-for-article-source filename)))
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:      (f/tts article-filename))))
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:  (let* ((source-filename (filename-for-article-source filename)))
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:    (do-article source-filename)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:(defparameter *directory-for-article-results*
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:              "CTI;results:article analyses:")
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:(defparameter *directory-for-article-source* "Feb2;")
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:(defun filename-for-article-analysis (article)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:  (typecase article
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:                         *directory-for-article-results* article))
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:     (file-namestring article))
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:     (break/debug "Article has an unexpected data-type: ~A" article)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:(defun filename-for-article-source (article)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:  (typecase article
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:                         *directory-for-article-source* article))
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:    (pathname  article)
grammar/model/sl/Who's-News/tests/Feb91-sp.lisp:     (break/debug "Article has an unexpected data-type: ~A" article)
grammar/model/sl/Who's-News/tests/Feb91.lisp:(defun f/tts (article)
grammar/model/sl/Who's-News/tests/Feb91.lisp:  (f article) (tts))
grammar/model/sl/Who's-News/tests/Feb91.lisp:  (let* ((analysis-filename (filename-for-article-analysis filename))
grammar/model/sl/Who's-News/tests/Feb91.lisp:          (article-filename
grammar/model/sl/Who's-News/tests/Feb91.lisp:           (filename-for-article-source filename)))
grammar/model/sl/Who's-News/tests/Feb91.lisp:      (f/tts article-filename))))
grammar/model/sl/Who's-News/tests/Feb91.lisp:  (let* ((source-filename (filename-for-article-source filename)))
grammar/model/sl/Who's-News/tests/Feb91.lisp:    (do-article source-filename)
grammar/model/sl/Who's-News/tests/Feb91.lisp:      (unless *current-article*
grammar/model/sl/Who's-News/tests/Feb91.lisp:        (setq *current-article* (pop files)))
grammar/model/sl/Who's-News/tests/Feb91.lisp:      (r *current-article*)
grammar/model/sl/Who's-News/tests/Feb91.lisp:      (write-db-records-for-pending-articles)
grammar/model/sl/Who's-News/tests/Feb91.lisp:      (setq *articles-with-records* nil)
grammar/model/sl/Who's-News/tests/Feb91.lisp:      (setq *current-article* (pop files))
grammar/model/sl/Who's-News/tests/Feb91.lisp:;;--- write a .rec file for a single article
grammar/model/sl/Who's-News/tests/Feb91.lisp:  (setq *article-under-analysis* filename)
grammar/model/sl/Who's-News/tests/Feb91.lisp:  (setq *article-under-analysis* filename)
grammar/model/sl/Who's-News/tests/Feb91.lisp:;(f/buffer (setq *current-article* (pop files)))
grammar/model/sl/Who's-News/tests/Feb91.lisp:;(f/buffer *current-article*)
grammar/model/sl/Who's-News/tests/Feb91.lisp:;(f/tts *current-article*)
grammar/model/sl/Who's-News/tests/Feb91.lisp:;(f/tts (setq *current-article* (pop files)))
grammar/model/sl/Who's-News/tests/Feb91.lisp:;(f/tts *current-article*)
grammar/model/sl/Who's-News/tests/Feb91.lisp:;(f (setq *current-article* (pop files)))
grammar/model/sl/Who's-News/tests/Feb91.lisp:;(f *current-article*)
grammar/model/sl/Who's-News/tests/Feb91.lisp:;(r (setq *current-article* (pop files)))
grammar/model/sl/Who's-News/tests/Feb91.lisp:;(r *current-article*)
grammar/model/sl/Who's-News/tests/Feb91.lisp:;(write-db-records-for-pending-articles)
grammar/model/sl/Who's-News/tests/Feb91.lisp:;(setq *articles-with-records* nil)
grammar/model/sl/Who's-News/tests/Feb91.lisp:(defparameter *directory-for-article-results*
grammar/model/sl/Who's-News/tests/Feb91.lisp:              "CTI;results:article analyses:")
grammar/model/sl/Who's-News/tests/Feb91.lisp:(defparameter *directory-for-article-source* "Feb2;")
grammar/model/sl/Who's-News/tests/Feb91.lisp:(defun filename-for-article-analysis (article)
grammar/model/sl/Who's-News/tests/Feb91.lisp:  (typecase article
grammar/model/sl/Who's-News/tests/Feb91.lisp:                         *directory-for-article-results* article))
grammar/model/sl/Who's-News/tests/Feb91.lisp:     (file-namestring article))
grammar/model/sl/Who's-News/tests/Feb91.lisp:     (break/debug "Article has an unexpected data-type: ~A" article)
grammar/model/sl/Who's-News/tests/Feb91.lisp:(defun filename-for-article-source (article)
grammar/model/sl/Who's-News/tests/Feb91.lisp:  (typecase article
grammar/model/sl/Who's-News/tests/Feb91.lisp:                         *directory-for-article-source* article))
grammar/model/sl/Who's-News/tests/Feb91.lisp:    (pathname  article)
grammar/model/sl/Who's-News/tests/Feb91.lisp:     (break/debug "Article has an unexpected data-type: ~A" article)
grammar/model/sl/Who's-News/tests/batch-workspace.lisp:;(f (setq *current-article* (pop files)))
grammar/model/sl/Who's-News/tests/batch-workspace.lisp:;(f *current-article*)
grammar/model/sl/Who's-News/tests/batch-workspace.lisp:;(preempt-all-fns-that-stop-execution 'abort-article/batch)
grammar/model/sl/Who's-News/tests/batch-workspace.lisp:;(batch-run '|Who's News articles - typed|)  ;;all three sets
grammar/model/sl/Who's-News/tests/doc-streams.lisp:(define-document-stream '|Who's News articles - typed|
grammar/model/sl/Who's-News/tests/logicals.lisp:;; flat file of articles now.
grammar/model/sl/Who's-News/tests/originals.lisp:    !!! the *topic-company* of two articles back appeared here as the
grammar/rules/words/archive -- words/basics/sections.lisp:(define-punctuation article-start (code-char 3))
grammar/rules/words/archive -- words/basics/whitespace.lisp:;; on the section of the envelope file or article being analyzed.
init/versions/v3.1/config/grammars/Debris-analysis.lisp:(include-grammar-module  *recognize-sections-within-articles*)
init/versions/v3.1/config/grammars/SUN.lisp:(include-grammar-module  *recognize-sections-within-articles*)
init/versions/v3.1/config/grammars/academic-grammar.lisp:(include-grammar-module  *recognize-sections-within-articles*)
init/versions/v3.1/config/grammars/checkpoint-ops.lisp:;(include-grammar-module  *recognize-sections-within-articles*)
init/versions/v3.1/config/grammars/fire.lisp:(include-grammar-module  *recognize-sections-within-articles*)
init/versions/v3.1/config/grammars/full-grammar.lisp:(include-grammar-module  *recognize-sections-within-articles*)
init/versions/v3.1/config/grammars/just-bracketing.lisp:(include-grammar-module  *recognize-sections-within-articles*)
init/versions/v3.1/config/grammars/minimal-dm&p-grammar.lisp:(include-grammar-module  *recognize-sections-within-articles*)
init/versions/v3.1/config/grammars/partial-grammar.lisp:(include-grammar-module  *recognize-sections-within-articles*)
init/versions/v3.1/config/grammars/poirot.lisp:;(include-grammar-module  *recognize-sections-within-articles*)
init/versions/v3.1/config/grammars/public-grammar.lisp:(include-grammar-module  *recognize-sections-within-articles*)
David-McDonalds-MacBook-Pro:s ddm$ 
