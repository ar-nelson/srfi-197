(define (syntax-violation who msg irr)
  (error msg (cons who irr)))

(include "./srfi-197-syntax-case.scm")
(include "./test.scm")
