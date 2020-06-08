(define-library (threading-macros)
  (export -> ->> as->
          some-> some->>
          cond-> cond->>
          lambda-> lambda->>)

  (import (scheme base))

  (include "threading-macros.scm"))
