# SRFI 197: Expression Chaining Operators

A Scheme library that implements `chain`, an operator based on [Clojure
threading macros][1]. This is the sample imeplementation of [SRFI 197][2].

The implementation (`srfi-197.scm`) consists entirely of `syntax-rules` macros
and should be compatible with all R7RS Schemes. Its only dependency is [SRFI
2][3]. There is also an R7RS library (`srfi-197.sld`) and a test script
(`test.scm`).

This implementation is compatible with at least the following Schemes:

- Chibi: `chibi-scheme test.scm`
- Chicken: `csi -qb test.scm`
- Gauche: `gosh test.scm`
- Guile: `guile test.scm` (requires Guile 3.x)
- Kawa: `kawa test.scm`
- Larceny: `larceny -r7 < test.scm`
- Sagittarius: `sash test.scm`

Note that this is a smaller compatibility list than the last draft. Gambit does
not support full R7RS `syntax-rules` features and Gerbil does not support dotted
pairs in `let*-values` value lists, so these Schemes are no longer supported.

[1]: https://clojure.org/guides/threading_macros
[2]: https://srfi.schemers.org/srfi-197/srfi-197.html
[3]: https://srfi.schemers.org/srfi-2/srfi-2.html
