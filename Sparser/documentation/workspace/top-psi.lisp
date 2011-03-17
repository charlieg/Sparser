ddm: 12/14/10
While working on a bug where we get a lattice point in an indiv-type field
where we expect a list. "George Ball resigned as chairmain of Prudential Inc."
The bug is reached by following out bind-v+v, which hadn't yet been vetted
and happens in find-variable-from-individual. 


From define-category, for referential-categories with parameters, we get to
decode-category-parameter-list, which creates the lattice-point for the
category by calling initialize-top-lattice-point (lattice-points/initialize1.lisp).

That creates a new lattice point with no value for its top-psi. Somehow it gets
a value but it's ill-formed (just an lp, not a list of one), which leads to the bug.

When creating a psi via define-individual, we end up in make/psi (psi/make2.lisp)
which wants a 'base-psi', for which it calls find-or-make-psi-for-base-category
with the category as its argument. If there isn't already a top-lp we make one
by calling make-psi-with-just-a-type.

That code looks good, except that it repeats the 'find' part of the find-or-make
pattern that was already done by the caller. So if anything creates a badly
formed top-psi we'll always be using it. ///That's not it. The base-psi is fine,
a derived psi, after we've bound the sequence variable, is bad.

To add a binding, we start with find-or-make-psi-with-binding, which then
calls install-v+v. The install first does a make-and-attach-v+v, and then
calls make-more-saturated-psi with the v+v to create the new psi. That
was where the bug was. 