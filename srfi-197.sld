(define-library (srfi-197)
  (export chain chain-and chain-when chain-lambda <> <...>)

  (import (scheme base))

  (include "srfi-197.scm")

  (begin
    (define-syntax <>
      (syntax-rules ()
        ((<> . args)
         (syntax-error "invalid use of auxiliary syntax" (<> . args)))))
    (define-syntax <...>
      (syntax-rules ()
        ((<...> . args)
         (syntax-error "invalid use of auxiliary syntax" (<...> . args)))))))
