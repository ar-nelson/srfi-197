; A syntax-case implementation of SRFI 197.
; This should be functionally equivalent to srfi-197.scm,
; but it may be easier to read and understand.

(define (gentemp) (car (generate-temporaries '(x))))

(define-syntax chain
  (lambda (x)
    (syntax-case x ()
      ((_ initial-value) #'initial-value)
      ((_ initial-value (step ...) rest ...)
        (let loop ((vars '()) (out '()) (in #'(step ...)))
          (syntax-case in (<> <...>)
            ((<> . step-rest)
              (let ((chain-var (gentemp)))
                (loop (cons chain-var vars) (cons chain-var out) #'step-rest)))
            ((<...>)
              (let ((chain-rest-var (gentemp)))
                #`(chain (let-values ((#,(if (null? vars)
                                           chain-rest-var
                                           #`(#,@(reverse vars) . #,chain-rest-var))
                                       initial-value))
                           (apply #,@(reverse out) #,chain-rest-var))
                         rest ...)))
            ((<...> . _)
              (syntax-violation 'chain "<...> only allowed at end" #'(step ...)))
            ((x . step-rest)
              (loop vars (cons #'x out) #'step-rest))
            (()
              (with-syntax (((result ...) (reverse out)))
                #`(chain
                    #,(cond
                        ((null? vars)
                          #'(let ((chain-var initial-value)) (result ... chain-var)))
                        ((null? (cdr vars))
                          #`(let ((#,(car vars) initial-value)) (result ...)))
                        (else
                          #`(let-values ((#,(reverse vars) initial-value)) (result ...))))
                    rest ...)))))))))

(define-syntax chain-and
  (lambda (x)
    (syntax-case x ()
      ((_ initial-value) #'initial-value)
      ((_ initial-value (step ...) rest ...)
        (let loop ((var #f) (out '()) (in #'(step ...)))
          (syntax-case in (<>)
            ((<> . step-rest)
              (if var
                (syntax-violation 'chain-and "only one <> allowed per step" #'(step ...))
                (let ((chain-var (gentemp)))
                  (loop chain-var (cons chain-var out) #'step-rest))))
            ((x . step-rest)
              (loop var (cons #'x out) #'step-rest))
            (()
              (with-syntax (((result ...) (reverse out)))
                #`(chain-and
                    #,(if var
                        #`(let ((#,var initial-value))
                            (and #,var (result ...)))
                        #'(let ((chain-var initial-value))
                            (and chain-var (result ... chain-var))))
                    rest ...)))))))))

(define-syntax chain-when
  (lambda (x)
    (syntax-case x ()
      ((_ initial-value) #'initial-value)
      ((_ initial-value (guard? (step ...)) rest ...)
        (let loop ((var #f) (out '()) (in #'(step ...)))
          (syntax-case in (<>)
            ((<> . step-rest)
              (if var
                (syntax-violation 'chain-and "only one <> allowed per step" #'(step ...))
                (let ((chain-var (gentemp)))
                  (loop chain-var (cons chain-var out) #'step-rest))))
            ((x . step-rest)
              (loop var (cons #'x out) #'step-rest))
            (()
              (with-syntax (((result ...) (reverse out)))
                #`(chain-when
                    #,(if var
                        #`(let ((#,var initial-value))
                            (if guard? (result ...) #,var))
                        #'(let ((chain-var initial-value))
                            (if guard? (result ... chain-var) chain-var)))
                    rest ...)))))))))

(define-syntax chain-lambda
  (lambda (x)
    (syntax-case x ()
      ((_ (first-step ...) rest ...)
        (let loop ((vars '()) (out '()) (in #'(first-step ...)))
          (syntax-case in (<> <...>)
            ((<> . step-rest)
              (let ((chain-var (gentemp)))
                (loop (cons chain-var vars) (cons chain-var out) #'step-rest)))
            ((<...>)
              (let ((chain-rest-var (gentemp)))
                #`(lambda #,(if (null? vars)
                              chain-rest-var
                              #`(#,@vars . #,chain-rest-var))
                    (chain (apply #,@(reverse out) #,chain-rest-var) rest ...))))
            ((<...> . _)
              (syntax-violation 'chain-lambda "<...> only allowed at end" #'(first-step ...)))
            ((x . step-rest)
              (loop vars (cons #'x out) #'step-rest))
            (()
              (with-syntax (((result ...) (reverse out)))
                (if (null? vars)
                  #'(lambda (chain-var) (chain (result ... chain-var) rest ...))
                  #`(lambda #,(reverse vars) (chain (result ...) rest ...)))))))))))
