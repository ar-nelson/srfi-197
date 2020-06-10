# SRFI 197: Threading Macros

Scheme implementation of [Clojure threading macros][1]. This is the sample
imeplementation of [SRFI 197][2].

The implementation (`srfi-197.scm`) consists entirely of simple `syntax-rules`
macros and should be compatible with R5RS and up. There is also an R7RS library
(`srfi-197.sld`) and a test script (`test.scm`).

This implementation is compatible with at least the following Schemes:

- Chibi: `chibi-scheme -m'(scheme base)' test.scm`
- Chicken: `csi -qb test.scm`
- Gambit: `gsi test.scm`
- Gauche: `gosh test.scm`
- Gerbil: `gxi test.scm`
- Guile: `guile test.scm`
- Kawa: `kawa test.scm`
- Larceny: `echo '(import (scheme write) (scheme process-context)) (include "test.scm")' | larceny -r7`
- Sagittarius: `sash -e'(import (scheme base) (scheme write))' test.scm`

[1]: https://clojure.org/guides/threading_macros
[2]: https://srfi.schemers.org/srfi-197/srfi-197.html
