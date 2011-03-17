3/14/11

How to realization specifications turn into rules

define-category
  => find-or-make-category-object
  => define-category/expr
      => decode-category-parameter-list
          => setup-rdata  (in tree-families/rdata)
              ... => dereference-and-store?-rdata-schema


define-individual
  => apply-realization-schema-to-individual  (in tree-families/driver)
      => make-rules-for-rdata
          => instantiate-rule-schema  (tree-families/driver)
          => head-word-rule-construction-dispatch  (tree-families/morphology)





