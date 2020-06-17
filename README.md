# SRFI 197: Expression Chaining Operators

A Scheme library that implements `chain`, an operator based on [Clojure
threading macros][1]. This is the sample implementation of [SRFI 197][2].

The implementation (`srfi-197.scm`) consists entirely of `syntax-rules` macros
and should be compatible with all R7RS Schemes. Its only dependency is [SRFI
2][3]. There is also an R7RS library (`srfi-197.sld`) and a test script
(`test.scm`).

This implementation is compatible with at least the following Schemes:

- Chez: `chezscheme test-r6rs.scm`
- Chibi: `chibi-scheme test-r7rs.scm`
- Chicken: `csi -qb srfi-197.scm test.scm`
- Gauche: `gosh test-r7rs.scm`
- Guile: `guile test-r6rs.scm`
- Kawa: `kawa test-r7rs.scm`
- Larceny: `larceny -r7 < test-r7rs.scm`
- Sagittarius: `sash test-r7rs.scm`

[1]: https://clojure.org/guides/threading_macros
[2]: https://srfi.schemers.org/srfi-197/srfi-197.html
[3]: https://srfi.schemers.org/srfi-2/srfi-2.html
