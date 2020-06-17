(include "./srfi-64-minimal.scm")

(define (exclamation x) (string-append x "!"))

(define (foo+bar x) (values (string-append x "foo") (string-append x "bar")))

(test-begin "Expression Chaining Operators")

(test-equal "chain" "bazbarfoo!"
  (chain ""
         (string-append "foo")
         (string-append "bar")
         (string-append "baz")
         (exclamation)))

(test-equal "chain <>" "barfoobaz"
  (chain ""
         (string-append <> "foo")
         (string-append "bar" <>)
         (string-append <> "baz")))

(test-equal "chain multiple <>" "quxfoo/quxbar"
  (chain "qux"
         (foo+bar)
         (string-append <> "/" <>)))

(test-equal "chain <...>" "bazquxfooquxbar"
  (chain "qux"
         (foo+bar)
         (string-append "baz" <...>)))

(test-equal "chain <> <...>" "quxfoobazquxbar"
  (chain "qux"
         (foo+bar)
         (string-append <> "baz" <...>)))

(test-equal "chain-and" "bazbarfoo!"
  (chain-and ""
             (string-append "foo")
             (string-append "bar")
             (string-append "baz")
             (exclamation)))

(test-equal "chain-and <>" "barfoobaz"
  (chain-and ""
             (string-append <> "foo")
             (string-append "bar" <>)
             (string-append <> "baz")))

(test-equal "chain-and short-circuit" #f
  (chain-and ""
             (string-append "foo")
             (equal? "bar")
             (string-append "baz")
             (exclamation)))

(test-equal "chain-when" "bazfoo"
  (chain-when ""
              ((= (+ 2 2) 4) (string-append "foo"))
              ((= (+ 2 2) 5) (string-append "bar"))
              (#t (string-append "baz"))))

(test-equal "chain-when <>" "barfooqux"
  (chain-when ""
              (#t (string-append <> "foo"))
              (#t (string-append "bar" <>))
              (#f (string-append <> "baz"))
              (#t (string-append <> "qux"))))

(test-equal "chain-lambda" "bazbarfoo!"
  ((chain-lambda (string-append "foo")
                 (string-append "bar")
                 (string-append "baz")
                 (exclamation))
   ""))

(test-equal "chain-lambda one step" "foobar"
  ((chain-lambda (string-append "foo")) "bar"))

(test-equal "chain-lambda <>" "barfoobaz"
  ((chain-lambda (string-append <> "foo")
                 (string-append "bar" <>)
                 (string-append <> "baz"))
   ""))

(test-equal "chain-lambda multiple <>" "foobarbazqux"
  ((chain-lambda (string-append <> "bar" <>)
                 (string-append <> "qux"))
   "foo"
   "baz"))

(test-equal "chain-lambda <...>" "foobarbazqux"
  ((chain-lambda (string-append "foo" <...>)
                 (string-append <> "qux"))
   "bar"
   "baz"))

(test-equal "chain-lambda <> <...>" "foobarbazquxquux"
  ((chain-lambda (string-append <> "bar" <...>)
                 (string-append <> "quux"))
   "foo"
   "baz"
   "qux"))

(test-end "Expression Chaining Operators")
