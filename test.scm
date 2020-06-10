(include "./srfi-64-minimal.scm")
(include "./srfi-197.scm")

(define (exclamation x) (string-append x "!"))

(test-begin "Threading Macros")

(test-equal "->" "foobarbaz!"
  (-> ""
      (string-append "foo")
      (string-append "bar")
      (string-append "baz")
      exclamation))

(test-equal "->>" "bazbarfoo!"
  (->> ""
       (string-append "foo")
       (string-append "bar")
       (string-append "baz")
       exclamation))

(test-equal "as->" "barfoobaz"
  (as-> "" x
        (string-append x "foo")
        (string-append "bar" x)
        (string-append x "baz")))

(test-equal "some->" "foobarbaz!"
  (some-> ""
          (string-append "foo")
          (string-append "bar")
          (string-append "baz")
          exclamation))

(test-equal "some-> short-circuit" #f
  (some-> ""
          (string-append "foo")
          (equal? "bar")
          (string-append "baz")
          exclamation))


(test-equal "some->>" "bazbarfoo!"
  (some->> ""
           (string-append "foo")
           (string-append "bar")
           (string-append "baz")
           exclamation))

(test-equal "some->> short-circuit" #f
  (some->> ""
           (string-append "foo")
           (equal? "bar")
           (string-append "baz")
           exclamation))

(test-equal "cond->" "foobaz!"
  (cond-> ""
          ((= (+ 2 2) 4) (string-append "foo"))
          ((= (+ 2 2) 5) (string-append "bar"))
          ((string-append "baz"))
          (exclamation)))

(test-equal "cond->>" "bazfoo!"
  (cond->> ""
           ((= (+ 2 2) 4) (string-append "foo"))
           ((= (+ 2 2) 5) (string-append "bar"))
           ((string-append "baz"))
           (exclamation)))

(test-equal "lambda->" "quxfoobarbaz!"
  ((lambda-> (string-append "foo")
             (string-append "bar")
             (string-append "baz")
             exclamation)
   "qux"))

(test-equal "lambda->>" "bazbarfooqux!"
  ((lambda->> (string-append "foo")
              (string-append "bar")
              (string-append "baz")
              exclamation)
   "qux"))

(test-end "Threading Macros")
