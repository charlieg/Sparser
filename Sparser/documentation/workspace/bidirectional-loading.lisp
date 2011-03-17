;; 12/22/10 Notes while checking on loading both :mumble and :sparser packages

The package for a file should correspond to the package used by the bulk of its functions. The tricky case is the file holding the routines that convert, e.g., Sparser's realization nodes to Mumble's derivation trees. It belongs in the :mumble package, but it refers to types that are only defined after (most of) Sparser's code has been loaded.

It's simplest to keep the systems separate, but that means that the onus is now on the load-nlp file to get everything loaded in the right order. 

The realization-for methods for Sparser types is in /interface/mumble/interface.lisp and any other Sparser-centric helpers or procedures for generation are going to be put in that same directory. It's loaded as part of loading Sparser. 

The derivation-tree machinery is in /mumble/derivation-trees/. The purely :mumble parts of that machinery are loaded as part of Mumble. The parts that have methods that refer to types in :sparser are loaded after Sparser is loaded.


