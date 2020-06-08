; Just enough of SRFI 64 (unit tests) to run test.scm.

(define *test-failures* '())

(define (test-begin name)
  (newline)
  (display "Test group: ")
  (display name)
  (newline)
  (newline))

(define (test-end name)
  (newline)
  (cond
    ((null? *test-failures*)
      (display "All tests passed!")
      (newline)
      (newline)
      (exit 0))
    (else
      (write (length *test-failures*))
      (display " TEST(S) FAILED:")
      (newline)
      (for-each (lambda (x) (x)) (reverse *test-failures*))
      (newline)
      (exit 1))))

(define (test-equal name expected actual)
  (cond
    ((equal? expected actual)
      (display "PASS: "))
    (else
      (set! *test-failures*
            (cons
              (lambda ()
                (display name)
                (display ": Expected ")
                (write expected)
                (display ", got ")
                (write actual)
                (newline))
              *test-failures*))
      (display "FAIL: ")))
  (display name)
  (newline))
