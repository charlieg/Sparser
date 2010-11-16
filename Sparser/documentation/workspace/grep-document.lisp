Last login: Sun Jul 18 18:43:48 on console
/usr/bin/ssh
really got here
David-McDonalds-MacBook-Pro:~ ddm$ cd ws/nlp/Sparser/code/s/
David-McDonalds-MacBook-Pro:s ddm$ grep document **/*.lisp **/**/*.lisp **/**/**/*.lisp **/**/**/**/*.lisp **/**/**/**/**/*.lisp
init/changed-files.lisp:Realized (belatedly, while documenting), that "first" really -should- denote
init/changed-files.lisp:hook.   Also need to document usage of completion actions and generally
analyzers/context/manage-sections.lisp:        (when (style-includes-feature :sections-cover-whole-document)
analyzers/context/manage-sections.lisp:          ;; There has to be a prior sibling in some documents
analyzers/context/manage-sections.lisp:          ;; if this is that kind of document
analyzers/context/manage-sections.lisp:             (setup-first-section-of-document sm start-index)
analyzers/context/manage-sections.lisp:;;; first section in the document
analyzers/context/manage-sections.lisp:(defun setup-first-section-of-document (sm start-index)
analyzers/context/manage-sections.lisp:    (tr :first-section-object-in-document so)
analyzers/context/manage-sections.lisp:  (tr :first-section-object-in-document pso)
analyzers/context/manage-sections.lisp:(deftrace :first-section-object-in-document (so)
analyzers/doc/word-freq-(moved).lisp:   when running over document streams)
analyzers/doc/word-freq-(moved).lisp:(defun wf/ds (document-stream)
analyzers/doc/word-freq-(moved).lisp:  (analyze-document-stream document-stream)
analyzers/sectionizing/action.lisp:(defun establish-section-within-document (sm edge pos-before)
drivers/actions/hook1.lisp:       (establish-section-within-document function ;; section-marker
drivers/articles/batch.lisp:(defun batch-run (document-source)
drivers/articles/batch.lisp:  (do-source document-source)
drivers/articles/doc-stream.lisp:(defun do-document-stream (document-stream)
drivers/articles/doc-stream.lisp:  (let ((*current-document-stream* document-stream))
drivers/articles/doc-stream.lisp:    (etypecase document-stream
drivers/articles/doc-stream.lisp:       (unless (setq document-stream
drivers/articles/doc-stream.lisp:                     (document-source-named document-stream))
drivers/articles/doc-stream.lisp:         (error 'The argument must be a document-stream or a symbol ~'
drivers/articles/doc-stream.lisp:      (document-stream ) ;;fall through
drivers/articles/doc-stream.lisp:    ;(setup-context-for-this-run (ds-style document-stream))
drivers/articles/doc-stream.lisp:    (cond ((ds-directory document-stream)
drivers/articles/doc-stream.lisp:           (do-articles-in-directory (ds-directory document-stream)))
drivers/articles/doc-stream.lisp:          ((ds-file-list document-stream)
drivers/articles/doc-stream.lisp:           (do-articles-in-files (ds-file-list document-stream)))
drivers/articles/doc-stream.lisp:          ((ds-substreams document-stream)
drivers/articles/doc-stream.lisp:           (dolist (ds (ds-substreams document-stream))
drivers/articles/doc-stream.lisp:             (do-document-stream ds)))
drivers/articles/doc-stream.lisp:          (t (error 'The document stream ~A has neither a~'
drivers/articles/style.lisp:with the *current-document-stream* if there is one. |#
drivers/articles/style.lisp:            (symbol (document-style-named style))
drivers/articles/style.lisp:            (document-style style)
drivers/articles/style.lisp:             (break "Styles must be indicated by 'document-style' objects.~
drivers/articles/style.lisp:    ;; on the *current-document-stream*, and there isn't any then it sets
drivers/articles/style.lisp:  (let ((ds *current-document-stream*)
drivers/articles/style.lisp:        (tr :no-document-stream)
drivers/articles/style.lisp:               *current-document-stream*)))
drivers/articles/style.lisp:(deftrace :no-document-stream ()
drivers/articles/style.lisp:    (trace-msg "[style] There is no document stream for this run")))
drivers/chart/header-labels.lisp:        ;; Part of what Establish-section-within-document (the completion
drivers/inits/runs1.lisp:;; 1.2 (10/27 v2.0) moved to document-style objects
drivers/inits/runs1.lisp:;;     document sources.
drivers/inits/runs1.lisp:           (boundp '*document-source*))
drivers/inits/runs1.lisp:        (setq source *document-source*))
drivers/inits/runs1.lisp:          (unless (typep source 'document-style)
drivers/inits/switches2.lisp:        ;; than dm&p'ing a whole document explicitly, we use
drivers/sources/articles.lisp:  ;; called from Do-source or one of the leaves of Analyze-document-stream
drivers/sources/core1.lisp:    (document-stream (analyze-document-stream s))
drivers/sources/core1.lisp:    (symbol (analyze-document-stream s))
drivers/sources/doc-stream.lisp:;;     (9/15) tweeking routine that runs a stream as one document
drivers/sources/doc-stream.lisp:;; 0.5 (7/25/95) put in bindings of *current-document-stream* in the routines
drivers/sources/doc-stream.lisp:(defun analyze-document-stream (ds-designator)
drivers/sources/doc-stream.lisp:  ;; article vs. sissor file) depends on the style of document
drivers/sources/doc-stream.lisp:               (symbol (document-stream-named ds-designator))
drivers/sources/doc-stream.lisp:               (document-stream ds-designator))))
drivers/sources/doc-stream.lisp:;;; dispatch on type of document stream
drivers/sources/doc-stream.lisp:  (let ((*current-document-stream* ds))
drivers/sources/doc-stream.lisp:          (t (break "ill-formed document stream: ~A~
drivers/sources/doc-stream.lisp:  (let ((*current-document-stream* *document-stream-to-use*))
drivers/sources/doc-stream.lisp:  :analysis-of-document-stream-finished )
drivers/sources/doc-stream.lisp:    (let ((*current-document-stream* *document-stream-to-use*))
drivers/sources/doc-stream.lisp:  (let ((*current-document-stream* *document-stream-to-use*))
drivers/sources/doc-stream.lisp:(defun do-document-as-stream-of-files (ds-designator)
drivers/sources/doc-stream.lisp:  ;; interpreted as parts of a single document, i.e. initialization
drivers/sources/doc-stream.lisp:  (let ((*current-document-stream* ds-designator)
drivers/sources/doc-stream.lisp:           (error "Cannot treat a recursive document stream as a ~
drivers/sources/doc-stream.lisp:                   single document"))
drivers/sources/doc-stream.lisp:          (t (break "ill-formed document stream: ~A~
drivers/sources/state.lisp:;;      1/11 added *current-superstream*. 1/26 added *document-stream-to-use*
drivers/sources/state.lisp:  "Bound by document-stream drivers. Accessed in compiling a description
drivers/sources/state.lisp:  "Bound by document-stream drivers. Access at various points.")
drivers/sources/state.lisp:(defparameter *current-document-stream* nil
drivers/sources/state.lisp:  "Bound by any of the drivers that do runs over document sources.
drivers/sources/state.lisp:   The value is a document-stream object.")
drivers/sources/state.lisp:(defparameter *document-stream-to-use* nil
init/scripts/Academic-loader.lisp:(defparameter sparser::*Apple-documents-directory*
init/scripts/Academic-loader.lisp:              "Corpora:Apple documents:"  ;; <-- change this or set it to Nil
init/scripts/Academic-loader.lisp:   "The location of a standard set of test documents" )
init/scripts/Apple-loader.lisp:(defparameter sparser::*Apple-documents-directory*
init/scripts/Apple-loader.lisp:              "Corpora:Apple documents:"
init/scripts/Apple-loader.lisp:   "The location of a standard set of test documents" )
init/workspaces/Darwin.lisp:(define-document-style  origin-line-by-line
init/workspaces/Darwin.lisp:;;; document stream
init/workspaces/Darwin.lisp:;;-------- The document stream is only useful when the Corpus facility is running, 
init/workspaces/Darwin.lisp:  (define-document-stream '|Origin of the Species|
init/workspaces/Darwin.lisp:(setq *document-stream-to-use*
init/workspaces/Darwin.lisp:      (document-stream-named '|Origin of the Species|))
init/workspaces/text-segments.lisp:;;   dies instantly with wrong number of args w/in Start-document-start-section
init/workspaces/text-segments.lisp:#|(define-document-stream 'test1
init/workspaces/text-segments.lisp:;; 12/28/93 -- trivial test of running document streams.
init/workspaces/text-segments.lisp:;; (analyze-document-stream ds)
interface/Apple/dis.out-reader1.lisp:(defun run-dis-over-book (document-stream-name)
interface/Apple/dis.out-reader1.lisp:  (let ((ds (sparser::document-stream-named document-stream-name))
interface/Apple/doc-streams.lisp:(unless (boundp '*Apple-documents-directory*)
interface/Apple/doc-streams.lisp:  (defparameter *Apple-documents-directory*
interface/Apple/doc-streams.lisp:                ;;"HitchHiker 120:Apple documents:"
interface/Apple/doc-streams.lisp:                "Macintosh HD:Apple documents:"
interface/Apple/doc-streams.lisp:(define-document-stream '|Documentation|
interface/Apple/doc-streams.lisp:(define-document-stream '|PowerTalk|
interface/Apple/doc-streams.lisp:                             *Apple-documents-directory*
interface/Apple/doc-streams.lisp:(define-document-stream '|Reference|
interface/Apple/doc-streams.lisp:                             *Apple-documents-directory*
interface/Apple/workspace.lisp:define a 'document-stream' for the book like the examples in
interface/Apple/workspace.lisp:(run-dis-over-book  <document-stream-name> )
interface/Apple/workspace.lisp:#|  This is the driver. It takes the name of a document stream as
interface/Apple/workspace.lisp:(defun run-dis-over-book (document-stream-name)
interface/Apple/workspace.lisp:  (let ((ds (sparser::document-stream-named document-stream-name))
interface/Apple/workspace.lisp:#|  Running the .dis interface only defines the words in the document
interface/Apple/workspace.lisp:#|  Having a document analysed is a matter of calling Sparser in any of
interface/Apple/workspace.lisp:the normal ways (by string, by file, by document-stream) while it is in
interface/Apple/workspace.lisp:to the format of the documents and markup.
interface/Apple/workspace.lisp:Since you'll be only working with one task and type of document (for the
interface/Apple/workspace.lisp:(sparser::setup-for-apple)  ;; handles the document format
interface/Apple/workspace.lisp:Running a whole chapter at a time makes sense given how the documents
interface/Apple/workspace.lisp:(defparameter *Apple-documents-directory*
interface/Apple/workspace.lisp:              "Macintosh HD:Apple documents:")
interface/Apple/workspace.lisp:                                  *Apple-documents-directory*
interface/Apple/workspace.lisp:This driver is the Sparser function Do-document-as-stream-of-files.
interface/Apple/workspace.lisp:It takes a document stream as its input. Here is a copy of what is
interface/Apple/workspace.lisp:(defparameter MacRef/gml/document-stream
interface/Apple/workspace.lisp:  (define-document-stream  'MacRef/gml-files
interface/Apple/workspace.lisp:                             *Apple-documents-directory*
interface/Apple/workspace.lisp:(do-document-as-stream-of-files MacRef/gml/document-stream)
interface/AssetNet/ff-interface-to-ISSA.lisp:;; values, each one being a string.  I suspect from your documentation
interface/archive -- interface/new-menus.lisp:    :window-type :document-with-zoom
interface/corpus/doc-streams.lisp:(defun document-streams ())  ;; for meta-point
interface/corpus/doc-streams.lisp:  (define-document-stream '|sample of Web pages|
interface/corpus/doc-streams.lisp:  (define-document-stream '|financial panic 9/17/92|
interface/corpus/doc-streams.lisp:  (define-document-stream '|2 product announcements|
interface/corpus/doc-streams.lisp:  (define-document-stream '|Tipster test articles|
interface/corpus/doc-streams.lisp:  (define-document-stream '|Who's News|
interface/corpus/doc-streams.lisp:  (define-document-stream  '|1st 15 of Who's News test|
interface/corpus/doc-streams.lisp:  (define-document-stream '|small test set|
interface/corpus/doc-streams.lisp:  (define-document-stream '|December 1990|
interface/corpus/doc-streams.lisp:  (define-document-stream '|1st December batch|
interface/corpus/doc-streams.lisp:  (define-document-stream '|2d December batch|
interface/corpus/doc-streams.lisp:  (define-document-stream '|3d December batch|
interface/corpus/doc-streams.lisp:  (define-document-stream '|4th December batch|
interface/corpus/doc-streams.lisp:  (define-document-stream '|February 1991|
interface/corpus/doc-streams.lisp:  (define-document-stream '|Feb91 part 1|
interface/corpus/doc-streams.lisp:  (define-document-stream '|Feb91 part 2|
interface/corpus/doc-streams.lisp:  (define-document-stream '|Feb91 part 3|
interface/corpus/doc-streams.lisp:  (block  :ern-document-streams
interface/corpus/doc-streams.lisp:    (define-document-stream '|Earnings Reports|
interface/corpus/doc-streams.lisp:    (define-document-stream '|WSJ 1990|
interface/corpus/doc-streams.lisp:    (define-document-stream '|London Stock Exchange 1990|
interface/corpus/doc-streams.lisp:    (define-document-stream '|Web pages from Knowledge Factory|
interface/corpus/doc-streams.lisp:    (define-document-stream '|from Knowledge Factory|
interface/corpus/doc-streams.lisp:    (define-document-stream '|2d set from Knowledge Factory|
interface/corpus/doc-streams.lisp:  (define-document-stream '|Tenders Mergers & Acquisitions|
interface/corpus/doc-streams.lisp:  (define-document-stream '|3 long tnm|
interface/corpus/doc-streams.lisp:  (block :oil-document-streams
interface/corpus/doc-streams.lisp:    (define-document-stream '|oil|
interface/corpus/doc-streams.lisp:    (define-document-stream '|by publication|
interface/corpus/doc-streams.lisp:    (define-document-stream '|by topic|
interface/corpus/doc-streams.lisp:    (define-document-stream '|business development|
interface/corpus/doc-streams.lisp:    (define-document-stream '|computer hardware|
interface/corpus/doc-streams.lisp:    (define-document-stream '|computer software|
interface/corpus/doc-streams.lisp:    (define-document-stream '|exploration projects|
interface/corpus/doc-streams.lisp:    (define-document-stream '|exploration technology|
interface/corpus/doc-streams.lisp:    (define-document-stream '|financial data|
interface/corpus/doc-streams.lisp:    (define-document-stream '|Byte|
interface/corpus/doc-streams.lisp:    (define-document-stream '|Dow Jones News Service|
interface/corpus/doc-streams.lisp:    (define-document-stream '|Houston Business Journal|
interface/corpus/doc-streams.lisp:    (define-document-stream '|Oil and Gas Journal|
interface/corpus/doc-streams.lisp:    (define-document-stream '|Oil Week|
interface/corpus/doc-streams.lisp:    (define-document-stream '|Platts Oilgram News|
interface/corpus/doc-streams.lisp:    (define-document-stream '|scanned in by hand|
interface/corpus/doc-streams.lisp:    (define-document-stream '|Wall Street Journal|
interface/corpus/doc-streams.lisp:    (define-document-stream '|Washington Post|
interface/corpus/doc-streams.lisp:    (define-document-stream '|World Oil|
interface/corpus/menu-data.lisp:#| We spell out here which document streams should go onto the corpus menu
interface/corpus/menu-data.lisp:  ;; where only the terminals are document streams, the others are
interface/corpus/menu-data.lisp:      (,(document-stream-named '|small test set|)
interface/corpus/menu-data.lisp:       #+:full-corpus,(document-stream-named '|December 1990|)
interface/corpus/menu-data.lisp:       #+:full-corpus,(document-stream-named '|February 1991|)))
interface/corpus/menu-data.lisp:    ,(document-stream-named '|sample of Web pages|)
interface/corpus/menu-data.lisp:    ,(document-stream-named '|financial panic 9/17/92|)
interface/corpus/menu-data.lisp:      (,(document-stream-named '|WSJ 1990|)
interface/corpus/menu-data.lisp:       ,(document-stream-named '|London Stock Exchange 1990|)
interface/corpus/menu-data.lisp:       ,(document-stream-named '|from Knowledge Factory|)
interface/corpus/menu-data.lisp:       ,(document-stream-named '|2d set from Knowledge Factory|)
interface/corpus/menu-data.lisp:       ,(document-stream-named '|Web pages from Knowledge Factory|)
interface/corpus/menu-data.lisp:    ,(document-stream-named '|Tipster test articles|)
interface/corpus/menu-data.lisp:    ,(document-stream-named '|2 product announcements|)
interface/corpus/menu-data.lisp:    ,(document-stream-named '|3 long tnm|)
interface/grammar/defining-html.lisp:  :description "For parsing purposes, html tags are divided into two groups. Some tags will appear in begin-end pairs and enclose a region of the document; the end tag uses the same name but preceded with a slash.  Other tags are 'empty' and stand by themselves."
interface/grammar/defining-html.lisp:  :description "These tags come in begin-end pairs and enclose some part of the document. The slash on the end-tag is handled automatically."
interface/grammar/object-dialogs.lisp:            :window-type :document-with-grow
interface/grammar/object-dialogs.lisp:            :window-type :document   ;;-with-grow
interface/grammar/object-dialogs.lisp:            :window-type :document  ;;-with-grow
interface/grammar/test-menus,-etc.lisp:      :window-type  :document-with-grow
interface/menus/corpus.lisp:      ;; configuration of document streams and labled lists of them.
interface/menus/corpus.lisp:   to run it in the MCL 2.0 documentation
interface/menus/corpus.lisp:;;; converting document streams to menu items
interface/menus/corpus.lisp:(defparameter *str-of-document-stream-menu-items* nil)
interface/menus/corpus.lisp:    (setq *str-of-document-stream-menu-items*
interface/menus/corpus.lisp:  ;; an entry is either a document stream or a list.
interface/menus/corpus.lisp:      (document-stream
interface/menus/corpus.lisp:  ((document-stream :initarg :stream
interface/menus/corpus.lisp:    (if (eq ds *document-stream-to-use*)
interface/menus/corpus.lisp:  ;; called when a document stream is selected on the corpus menu
interface/menus/corpus.lisp:      ;; document-stream.
interface/menus/corpus.lisp:        (setq *document-stream-to-use* nil)
interface/menus/corpus.lisp:        (setq *document-stream-to-use* ds)
interface/menus/corpus.lisp:  (eval-enqueue '(analyze-document-stream *document-stream-to-use*))
interface/menus/corpus.lisp:  (if *document-stream-to-use*
interface/workbench/API.lisp:            :window-type :document      ;;-with-grow
interface/workbench/autodefining.lisp:      (if *show-document-edges?*
interface/workbench/edges.lisp:  (when *show-document-edges?*
interface/workbench/edges.lisp:  (when *show-document-edges?*
interface/workbench/edges.lisp:  (when *show-document-edges?*
interface/workbench/edges.lisp:      ;; newly-exposed edges (the documentation doesn't suggest
interface/workbench/edges.lisp:  (when *show-document-edges?*
interface/workbench/globals.lisp:(defparameter *show-document-edges?* nil
interface/workbench/globals.lisp:(defparameter *show-document-referents?* nil
interface/workbench/globals.lisp:(defparameter *show-document-segmentation?* nil
interface/workbench/globals.lisp:   number of lines in the document as recorded by the NL-fsa.)
interface/workbench/independent-contents.lisp:        (when *show-document-edges?*
interface/workbench/inspector.lisp:            :window-type :document
interface/workbench/object.lisp:    :window-type :document-with-grow
interface/workbench/swapping-modes.lisp:       (when (or *show-document-edges?*
interface/workbench/swapping-modes.lisp:       (setq *show-document-edges?* nil
interface/workbench/swapping-modes.lisp:  (setq *show-document-edges?* t)
interface/workbench/swapping-modes.lisp:       (when *show-document-edges?*
interface/workbench/swapping-modes.lisp:       (setq *show-document-edges?* nil
interface/workbench/swapping-modes.lisp:       (setq *show-document-edges?* t)
interface/workbench/swapping-modes.lisp:        *show-document-edges?* nil))
interface/workbench/swapping-modes.lisp:      (setq *show-document-edges?* t)
interface/workbench/swapping-modes.lisp:  *show-document-referents?* )
interface/workbench/swapping-modes.lisp:  *show-document-segmentation?* )  
interface/workbench/text-view-scrolling.lisp:   to by looking at the character number stored in the *documents-
interface/workbench/text-view.lisp:      (when *show-document-edges?*
interface/workbench/text-view.lisp:    (when *show-document-edges?*
interface/workbench/walk.lisp:    (when *show-document-edges?*
interface/workbench/workbench.lisp:            :window-type :document  ;;-with-grow
objects/doc/article.lisp:(define-category/expr  document
objects/doc/article.lisp:#| Every run is with respect to a document, though not every
objects/doc/article.lisp:   "document" reflects something that we would intuitively think
objects/doc/article.lisp:       Here we instantiate a document unit, but we don't index it
objects/doc/article.lisp:        (def-individual/no-indexing 'document)))
objects/doc/doc-stream.lisp:(defstruct (document-stream
objects/doc/doc-stream.lisp:            (:print-function print-document-stream-structure))
objects/doc/doc-stream.lisp:  substreams  ;; a list of document streams
objects/doc/doc-stream.lisp:documents so that they can be analyzed as a body in a single, uninterrupted
objects/doc/doc-stream.lisp:   A "document stream" can be given as the argument to Analyze-all-
objects/doc/doc-stream.lisp: logical formdocuments-in-stored-source .
objects/doc/doc-stream.lisp:(defun print-document-stream-structure (obj stream depth)
objects/doc/doc-stream.lisp:(defvar *document-streams* nil
objects/doc/doc-stream.lisp:  "An accumulator of all the document streams defined.")
objects/doc/doc-stream.lisp:(defun document-stream-named (symbol)
objects/doc/doc-stream.lisp:    (find symbol *document-streams* :test #'eq :key #'ds-name)))
objects/doc/doc-stream.lisp:(defun delete/document-stream (ds)
objects/doc/doc-stream.lisp:            (symbol (or (document-stream-named ds)
objects/doc/doc-stream.lisp:                        (format t "~&There is no document stream ~
objects/doc/doc-stream.lisp:            (document-stream ds)))
objects/doc/doc-stream.lisp:    (setq *document-streams*
objects/doc/doc-stream.lisp:          (delete symbol *document-streams*
objects/doc/doc-stream.lisp:(defun define-document-stream (symbol
objects/doc/doc-stream.lisp:    (error "A document stream can have EITHER a directory, another ~
objects/doc/doc-stream.lisp:            document stream,~
objects/doc/doc-stream.lisp:    (error "There is no content to the document stream ~A~
objects/doc/doc-stream.lisp:            ~%You must give either a directory, a list of document streams, ~
objects/doc/doc-stream.lisp:           (error "The name of a document stream must be a symbol~
objects/doc/doc-stream.lisp:           (or (document-stream-named substream-of)
objects/doc/doc-stream.lisp:               (else (format t "When defining a document stream as a ~
objects/doc/doc-stream.lisp:                     (return-from define-document-stream)))))
objects/doc/doc-stream.lisp:                   (document-style-named style-name))
objects/doc/doc-stream.lisp:                   (error "A style must be specified for the document ~
objects/doc/doc-stream.lisp:        (document-streams (when doc-streams
objects/doc/doc-stream.lisp:                                (return-from define-document-stream))))
objects/doc/doc-stream.lisp:        (setq object (document-stream-named symbol))
objects/doc/doc-stream.lisp:          (setq object (make-document-stream :name symbol)))
objects/doc/doc-stream.lisp:            (push object *document-streams*))
objects/doc/doc-stream.lisp:            (push object *document-streams*)))
objects/doc/doc-stream.lisp:            (error "There is no document style named ~A" style-name)))
objects/doc/doc-stream.lisp:        (setf (ds-substreams object) document-streams)
objects/doc/doc-stream.lisp:        (format t "~&~%The document stream ~A~
objects/doc/doc-stream.lisp:      (if (setq doc-stream (document-stream-named stream-name))
objects/doc/doc-stream.lisp:        (format t "~%There is no document stream named ~A" stream-name)))
objects/doc/doc-stream.lisp:           (format t "~%The directory the document source is to use,~
objects/doc/doc-stream.lisp:             (format t "~%One of the explicit files the document source is ~
objects/doc/style.lisp:(defstruct (document-style
objects/doc/style.lisp:            (:print-function print-document-style-structure))
objects/doc/style.lisp:(defun print-document-style-structure (obj stream depth)
objects/doc/style.lisp:(defparameter *document-styles* nil)
objects/doc/style.lisp:(defun make-a-document-style (symbol)
objects/doc/style.lisp:  (let ((style (make-document-style :name symbol)))
objects/doc/style.lisp:    (push style *document-styles*)
objects/doc/style.lisp:(defun document-style-named (symbol)
objects/doc/style.lisp:    (find symbol *document-styles* :test #'eq :key #'style-name)))
objects/doc/style.lisp:(defun delete/document-style (ds)
objects/doc/style.lisp:                  (document-style ds)
objects/doc/style.lisp:                  (symbol (or (document-style-named ds)
objects/doc/style.lisp:                              (format t "~&~%There is no document style ~
objects/doc/style.lisp:    (setq *document-styles*
objects/doc/style.lisp:          (delete symbol *document-styles*
objects/doc/style.lisp:(defun list-document-styles ()
objects/doc/style.lisp:  (pl *document-styles*))
objects/doc/style.lisp:          (break "There is no *current-style* for this document"))
objects/doc/style.lisp:(defun define-document-style/expr (style-name rules init-fn features)
objects/doc/style.lisp:  ;; called from define-document-style
objects/doc/style.lisp:  (let ((style (or (document-style-named style-name)
objects/doc/style.lisp:                   (make-a-document-style style-name))))
objects/forms/style.lisp:(defmacro define-document-style (style-name
objects/forms/style.lisp:  `(define-document-style/expr ',style-name ',rules
objects/traces/sections.lisp:  ;; called from Establish-section-within-document
objects/traces/sections.lisp:  ;; called from Establish-section-within-document
objects/traces/sections.lisp:  ;; called from Establish-section-within-document
objects/traces/trace-function.lisp:(defmacro def-trace-parameter (symbol string documentation)
objects/traces/trace-function.lisp:  `(def-trace-parameter/expr ',symbol ,string ,documentation))
objects/traces/trace-function.lisp:(defun def-trace-parameter/expr (symbol string documentation)
objects/traces/trace-function.lisp:          `(defparameter ,symbol nil ,documentation)))
analyzers/psp/edges/initial-new1.lisp:;;     (9/12/92 v2.3) improved the documentation
drivers/inits/sessions/globals1.lisp:  "Looked for during runs over document streams.  If the flag is
drivers/inits/sessions/globals1.lisp:  "A parameter to be used in document styles that controls what
drivers/inits/sessions/globals1.lisp:   documents with that style.")
drivers/timing/Bankruptcy/envelope---everything.lisp:          the (offering) documents together based on information put
drivers/timing/Bankruptcy/envelope---everything.lisp:          he had pored over documents and even visited the thriving
drivers/timing/Bankruptcy/envelope---everything.lisp:             In documents filed with the U.S. bankruptcy court in
grammar/rules/SGML/DCI-cases.lisp:;;; field for the "document number"  <s>
grammar/rules/SGML/DJNS-WSJ-cases.lisp:;; the category is defined in [rules;context:document number]
grammar/rules/SGML/DJNS-WSJ-cases.lisp:  ;; if called from Establish-section-within-document (which
grammar/rules/SGML/Tipster-cases.lisp:;; (12/28 v2.3) added another case to Analyze-segment-as-document-number
grammar/rules/SGML/Tipster-cases.lisp:;;; field for the document start  <doc>
grammar/rules/SGML/Tipster-cases.lisp:(define-sgml-tag  "doc" 'document-start
grammar/rules/SGML/Tipster-cases.lisp:  :initiation-action  'start-document-start-section
grammar/rules/SGML/Tipster-cases.lisp:  :termination-action 'end-document-start-section )
grammar/rules/SGML/Tipster-cases.lisp:(defun start-document-start-section (edge &optional pos-before/edge)
grammar/rules/SGML/Tipster-cases.lisp:(defun end-document-start-section (final-pos/edge
grammar/rules/SGML/Tipster-cases.lisp:    :document-start_ended ))
grammar/rules/SGML/Tipster-cases.lisp:;;; field for the "document number"  <DOCNO>
grammar/rules/SGML/Tipster-cases.lisp:(define-sgml-tag  "DOCNO" 'document-number
grammar/rules/SGML/Tipster-cases.lisp:  :initiation-action  'start-document-number-section
grammar/rules/SGML/Tipster-cases.lisp:  :termination-action 'end-document-number-section )
grammar/rules/SGML/Tipster-cases.lisp:(defun start-document-number-section (edge &optional pos-before/edge)
grammar/rules/SGML/Tipster-cases.lisp:(defun end-document-number-section (final-pos/edge
grammar/rules/SGML/Tipster-cases.lisp:            (analyze-segment-as-document-number interior-start
grammar/rules/SGML/Tipster-cases.lisp:                  category::document-number
grammar/rules/SGML/Tipster-cases.lisp:(defun analyze-segment-as-document-number (start-pos end-pos)
grammar/rules/SGML/Tipster-cases.lisp:       (pull-out-document-number-from-edge
grammar/rules/SGML/Tipster-cases.lisp:       (pull-document-number-out-of-edge-sequence
grammar/rules/SGML/defining-html.lisp:  :description "For parsing purposes, html tags are divided into two groups. Some tags will appear in begin-end pairs and enclose a region of the document; the end tag uses the same name but preceded with a slash.  Other tags are 'empty' and stand by themselves."
grammar/rules/SGML/defining-html.lisp:  :description "These tags come in begin-end pairs and enclose some part of the document. The slash on the end-tag is handled automatically."
grammar/rules/SGML/html-actions.lisp:        (break "Unbalanced document? The most recent open tag~
grammar/rules/context/article.lisp:#| Every run is with respect to a document, even though not every
grammar/rules/context/article.lisp:   "document" reflects something that we would intuitively think
grammar/rules/context/article.lisp:       Here we instantiate a document unit, but we don't index it
grammar/rules/context/article.lisp:                          (document-stream source-designator))))
grammar/rules/context/article.lisp:                         (document-stream source-designator)
grammar/rules/context/document-number.lisp:;;;     File:  "document number"
grammar/rules/context/document-number.lisp:;;; The "number" of the document -- the DOCNO field
grammar/rules/context/document-number.lisp:(defun pull-document-number-out-of-edge-sequence (start-pos end-pos)
grammar/rules/context/document-number.lisp:(defun pull-out-document-number-from-edge (edge)
grammar/rules/context/document-number.lisp:      :no-referent-computed-for-document-number-edge)))
grammar/rules/context/loader.lisp:(gload "context-rules;document number")
grammar/rules/paragraphs/data.lisp:;; 9/6 tweeked the def of Make-document-lines-structure
grammar/rules/paragraphs/data.lisp:;;; tracking information about the lines in a document
grammar/rules/paragraphs/data.lisp:(unless (boundp '*maximum-number-of-lines-in-document*)
grammar/rules/paragraphs/data.lisp:  (defparameter *maximum-number-of-lines-in-document* 2000))
grammar/rules/paragraphs/data.lisp:(defun make-document-lines-structure (&optional n)
grammar/rules/paragraphs/data.lisp:    (when (> n *maximum-number-of-lines-in-document*)
grammar/rules/paragraphs/data.lisp:      (setq *maximum-number-of-lines-in-document* n)))
grammar/rules/paragraphs/data.lisp:  (setq *documents-lines*
grammar/rules/paragraphs/data.lisp:                        *maximum-number-of-lines-in-document*)))
grammar/rules/paragraphs/data.lisp:      *maximum-number-of-lines-in-document*))
grammar/rules/paragraphs/data.lisp:(defparameter *documents-lines* nil)
grammar/rules/paragraphs/data.lisp:  (unless *documents-lines*
grammar/rules/paragraphs/data.lisp:    (make-document-lines-structure))
grammar/rules/paragraphs/data.lisp:  (let ((line-array *documents-lines*))
grammar/rules/paragraphs/data.lisp:    (break "The document does not have a line ~A (yet)" i))
grammar/rules/paragraphs/data.lisp:  (elt *documents-lines* i))
grammar/rules/paragraphs/data.lisp:  (setf (elt *documents-lines*
grammar/rules/paragraphs/data.lisp:    (when (>= *line-count* *maximum-number-of-lines-in-document*)
grammar/rules/paragraphs/data.lisp:          ~%Reset this limit by calling Make-document-lines-structure~
grammar/rules/paragraphs/data.lisp:             *maximum-number-of-lines-in-document*))
grammar/rules/paragraphs/data.lisp:        (setf (elt *documents-lines* line-index) nl-char))
grammar/rules/paragraphs/section-rule1.lisp:  ;; document or by Draw-paragraphing-conclusions, in which case we'll
grammar/rules/paragraphs/section-rule2.lisp:  ;; document or by Draw-paragraphing-conclusions, in which case we'll
grammar/rules/sources/Apple.lisp:(define-document-style  Apple
grammar/rules/sources/Apple.lisp:  :features ( :sections-cover-whole-document ))
grammar/rules/sources/CBD.lisp:(define-document-style  CBD
grammar/rules/sources/CBD.lisp:;;; document stream
grammar/rules/sources/CBD.lisp:        (define-document-stream  '|Commerce Business Daily|
grammar/rules/sources/CBD.lisp:;(do-article (probe-file anit) :style (document-style-named 'CBD))
grammar/rules/sources/Congress.lisp:(define-document-style  appropriations-bill
grammar/rules/sources/Congress.lisp:;;; document stream
grammar/rules/sources/Congress.lisp:        (define-document-stream  '|Congressional Appropriations|
grammar/rules/sources/DCI-wsj.lisp:(define-document-style  Data-collection-initiative/1989-wsj
grammar/rules/sources/DJNS-extra-LF.lisp:(define-document-style  Dow-Jones-New-Service/1990-91
grammar/rules/sources/DJNS.lisp:(define-document-style  Dow-Jones-News-Service/1990-91
grammar/rules/sources/DJNS.lisp:(define-document-style  Dow-Jones-News-Service/9-17-92
grammar/rules/sources/DJNS.lisp:      (document-style-named 'Dow-Jones-New-Service/1990-91)))
grammar/rules/sources/DJNS.lisp:;;; the document type
grammar/rules/sources/Knowledge-Factory.lisp:(define-document-style  KF/web-page
grammar/rules/sources/Knowledge-Factory.lisp:(define-document-style  KF/just-ascii
grammar/rules/sources/Who's-News-typed.lisp:(define-document-style  'Whos-News/typed
grammar/rules/sources/Who's-News-typed.lisp:(defun establish-Whos-News/typed-as-document-style ()
grammar/rules/sources/Who's-News-wsj-hoover.lisp:(defun establish-document-source/Whos-News/wsj/hoover ()
grammar/rules/sources/html.lisp:(define-document-style  web-page
grammar/rules/sources/typed-no-headers.lisp:(define-document-style  Hand-typed/no-headers
grammar/rules/sources/wsj-djns-sissor.lisp:(defun establish-WSJ/DJNW/sissor-as-document-source ()
grammar/rules/syntax/possessive.lisp:  (:documentation This is the default relationship created by 
grammar/rules/words/frequency.lisp:;;     printers. 7/15/10 implementing tracking freq in different documents.
grammar/rules/words/frequency.lisp:   when running over document streams")
grammar/rules/words/frequency.lisp:	   (cadr entry)))) ;; only makes sense on a single-document run
grammar/rules/words/frequency.lisp:  "All entries in all documents in the set that has been scanned"
grammar/rules/words/frequency.lisp:   and not comparing word frequencies across documents"
grammar/rules/words/frequency.lisp:               accumulator))             ;; per-document
grammar/rules/words/frequency.lisp:(defun readout-table-into-document-list (&optional (table
grammar/rules/words/frequency.lisp:(defun wf/ds (document-stream)
grammar/rules/words/frequency.lisp:  (analyze-document-stream document-stream)
init/workspaces/not active/Apple.lisp:;(do-document-as-stream-of-files MacRef/gml/document-stream)
init/workspaces/not active/Apple.lisp:;(do-document-as-stream-of-files PowerTalk/gml/document-stream)
init/workspaces/not active/Apple.lisp:(unless (boundp '*Apple-documents-directory*)
init/workspaces/not active/Apple.lisp:  (defparameter *Apple-documents-directory*
init/workspaces/not active/Apple.lisp:                                  *Apple-documents-directory*
init/workspaces/not active/Apple.lisp:                                  *Apple-documents-directory*
init/workspaces/not active/Apple.lisp:;;--- document streams
init/workspaces/not active/Apple.lisp:(defparameter MacRef/gml/document-stream
init/workspaces/not active/Apple.lisp:  (define-document-stream  'MacRef/gml-files
init/workspaces/not active/Apple.lisp:                             *Apple-documents-directory*
init/workspaces/not active/Apple.lisp:(defparameter PowerTalk/gml/document-stream
init/workspaces/not active/Apple.lisp:  (define-document-stream  'PowerTalk/gml-files
init/workspaces/not active/Apple.lisp:                             *Apple-documents-directory*
init/workspaces/not active/Apple.lisp:(defun Test-dis (document-stream-name)
init/workspaces/not active/Apple.lisp:  (let ((ds (document-stream-named document-stream-name))
init/workspaces/not active/Apple.lisp:               *Apple-documents-directory*
init/workspaces/not active/Apple.lisp:(defun hyper-moby-frequency (name-of-document-stream)
init/workspaces/not active/Apple.lisp:    (wf/ds (document-stream-named name-of-document-stream)))
init/workspaces/not active/Apple.lisp:     "Macintosh HD:Apple documents:Reference:Chap4:body4.engdis.out")
init/workspaces/not active/SUN1.lisp:  (let ((*current-style* (document-style-named 'SUN-glossary)))
init/workspaces/not active/SUN1.lisp:(define-document-style  SUN-glossary
init/workspaces/not active/SUN2.lisp:  (let ((*current-style* (document-style-named 'SUN-glossary)))
init/workspaces/not active/SUN2.lisp:(define-document-style  SUN-glossary
interface/workbench/edge-view/find.lisp:  (when *show-document-edges?*
interface/workbench/edge-view/open-close.lisp:      ;; newly-exposed edges (the documentation doesn't suggest
interface/workbench/edge-view/open-close.lisp:  (when *show-document-edges?*
interface/workbench/edge-view/select.lisp:  (when *show-document-edges?*
interface/workbench/edge-view/view.lisp:  (when *show-document-edges?*
interface/workbench/edge-view/view1.lisp:  (when *show-document-edges?*
objects/chart/categories1/form1.lisp:;;       categories for representation, and added documentation to the other
objects/chart/edges/resource3.lisp:;; 3.1 (4/7/93) changed name to Make-the-edge-resource for ease of documentation
objects/chart/edges/resource3.lisp:    (break 'Releasing an edge for an undocumented reason.~
objects/chart/edges/resource4.lisp:;; 3.1 (4/7/93) changed name to Make-the-edge-resource for ease of documentation
objects/chart/edges/resource4.lisp:    (break 'Releasing an edge for an undocumented reason.~
objects/model/bindings/alloc1.lisp:    (document-stream )
objects/model/individuals/make1.lisp:    (break "Call to make/individual with force-new? set -- document why"))
objects/model/individuals/make2.lisp:    (break "Call to make/individual with force-new? set -- document why"))
objects/rules/cfr/duplicates.lisp:;;      more documentation 
objects/rules/cfr/lookup5.lisp:;; 5.2 (8/27) added find/cfr because it was in the documentation and
tools/basics/syntactic-sugar/then-and-else.lisp:  Helps make `if' forms self-documenting when they get
tools/basics/syntactic-sugar/then-and-else.lisp:  Helps make `if' forms self-documenting when they get
grammar/model/core/numbers/fsa-digits6.lisp:;; 6.6 (10/13/97) Added documentation for how we get here. Factored model-based
grammar/model/sl/ERN/workspace.lisp:IMG SRC="/fact-images/document.gif" border=0></TD>  
grammar/model/sl/ERN/workspace.lisp:IMG SRC="/fact-images/document.gif" border=0></TD>  
grammar/model/sl/ERN/workspace.lisp:SRC="/fact-images/document.gif" border=0></TD>  
grammar/model/sl/ERN/workspace.lisp:TABLE WIDTH=100%><TR><TD ROWSPAN=2><IMG SRC=/fact-images/document.gif
grammar/model/sl/ERN/workspace.lisp:images/document.gif border=0></TD>  
grammar/model/sl/ERN/workspace.lisp:/fact-images/document.gif border=0></TD>  
grammar/model/sl/ERN/workspace.lisp:ROWSPAN=2><IMG SRC="/fact-images/document.gif" border=0></TD>  
grammar/model/sl/ERN/workspace.lisp:document.gif border=0></TD>  
grammar/model/sl/ERN/workspace.lisp:TD ROWSPAN=2><IMG SRC="/fact-images/document.gif" border=0></TD>  
grammar/model/sl/ERN/workspace.lisp:ROWSPAN=2><IMG SRC="/fact-images/document.gif" border=0></TD>  
grammar/model/sl/ERN/workspace.lisp:ROWSPAN=2><IMG SRC="/fact-images/document.gif" border=0></TD>  
grammar/model/sl/checkpoint/adjectives.lisp:(define-adjective/null "documentary")
grammar/model/sl/checkpoint/adjectives.lisp:(define-adjective/null "undocumented")
grammar/model/sl/poirot/ad-hoc-annotation.lisp:  (:documentation The question is what field does the object fill in
grammar/model/sl/poirot/ad-hoc-annotation.lisp:  (:documentation The variable can be used to access a particular value
grammar/model/sl/poirot/special-forms.lisp:  (:documentation Returns something that can be handled by
init/versions/v3.1/loaders/stubs.lisp:   (defun do-document-stream (s)
init/versions/v3.1/workspace/basic-tests.lisp:;(establish-document-source-type :WSJ/DJNW/sissor)
init/versions/v3.1/workspace/in-progress.lisp:(defun hyper-moby-frequency (name-of-document-stream)
init/versions/v3.1/workspace/in-progress.lisp:    (wf/ds (document-stream-named name-of-document-stream)))
init/versions/v3.1/workspace/in-progress.lisp:;;   dies instantly with wrong number of args w/in Start-document-start-section
init/versions/v3.1/workspace/in-progress.lisp:#|(define-document-stream 'test1
init/versions/v3.1/workspace/in-progress.lisp:;; 12/28 -- trivial test of running document streams.
init/versions/v3.1/workspace/in-progress.lisp:;; (analyze-document-stream ds)
init/versions/v3.1/workspace/switch-settings.lisp:(establish-document-source-type :WSJ/DJNW/sissor)
init/versions/v3.1/workspace/switch-settings.lisp:(establish-document-source-type :Whos-News/typed)
init/versions/v3.1/workspace/traces.lisp:; *document-source*
grammar/model/core/names/fsa/examine-backup-copy.lisp:       ;; While working on the Apple documentation, there was a check made
grammar/model/core/names/fsa/examine.lisp:                ;; While working on the Apple documentation, there was a check made
grammar/model/sl/Who's-News/tests/doc-streams.lisp:(define-document-stream '|Who's News articles - typed|
grammar/model/sl/Who's-News/tests/doc-streams.lisp:(define-document-stream '|typed #1|
grammar/model/sl/Who's-News/tests/doc-streams.lisp:(define-document-stream '|WSJ batch #1|
grammar/model/sl/Who's-News/tests/doc-streams.lisp:(define-document-stream '|1st December batch|
grammar/model/sl/Who's-News/tests/doc-streams.lisp:(define-document-stream '|2d December batch|
