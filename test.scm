(include "./threading-macros.scm")

(define (exclamation x) (string-append x "!"))
(define (heading x) (newline) (newline) (display x) (newline))

(heading  "->:")

(display "Expected \"foobarbaz!\", got ")
(write (-> ""
           (string-append "foo")
           (string-append "bar")
           (string-append "baz")
           exclamation))

(heading "->>:")

(display "Expected \"bazbarfoo!\", got ")
(write (->> ""
            (string-append "foo")
            (string-append "bar")
            (string-append "baz")
            exclamation))

(heading "as->:")

(display "Expected \"barfoobaz\", got ")
(write (as-> "" x
             (string-append x "foo")
             (string-append "bar" x)
             (string-append x "baz")))

(heading "some->:")

(display "Expected \"foobarbaz!\", got ")
(write (some-> ""
               (string-append "foo")
               (string-append "bar")
               (string-append "baz")
               exclamation))
(newline)
(display "Expected #f, got ")
(write (some-> ""
               (string-append "foo")
               (equal? "bar")
               (string-append "baz")
               exclamation))


(heading "some->>:")

(display "Expected \"bazbarfoo!\", got ")
(write (some->> ""
                (string-append "foo")
                (string-append "bar")
                (string-append "baz")
                exclamation))
(newline)
(display "Expected #f, got ")
(write (some->> ""
                (string-append "foo")
                (equal? "bar")
                (string-append "baz")
                exclamation))

(heading  "cond->:")

(display "Expected \"foobaz!\", got ")
(write (cond-> ""
               ((= (+ 2 2) 4) (string-append "foo"))
               ((= (+ 2 2) 5) (string-append "bar"))
               ((string-append "baz"))
               (exclamation)))

(heading "cond->>:")

(display "Expected \"bazfoo!\", got ")
(write (cond->> ""
                ((= (+ 2 2) 4) (string-append "foo"))
                ((= (+ 2 2) 5) (string-append "bar"))
                ((string-append "baz"))
                (exclamation)))

(heading "lambda->:")

(display "Expected \"quxfoobarbaz!\", got ")
(write ((lambda-> (string-append "foo")
                  (string-append "bar")
                  (string-append "baz")
                  exclamation)
        "qux"))

(heading "lambda->>:")

(display "Expected \"bazbarfooqux!\", got ")
(write ((lambda->> (string-append "foo")
                   (string-append "bar")
                   (string-append "baz")
                   exclamation)
        "qux"))

(heading "Tests are done!")
(display "(There is no error message on failure. Check the strings yourself!)")
(newline)
(newline)
