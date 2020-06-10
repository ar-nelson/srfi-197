(define-syntax ->
  (syntax-rules ()
    ((-> x) x)
    ((-> x (fn . args) . rest)
      (-> (fn x . args) . rest))
    ((-> x fn . rest)
      (-> (fn x) . rest))))

(define-syntax ->>
  (syntax-rules ()
    ((->> x) x)
    ((->> x (fn args ...) . rest)
      (->> (fn args ... x) . rest))
    ((->> x fn . rest)
      (->> (fn x) . rest))))

(define-syntax as->
  (syntax-rules ()
    ((as-> x name) x)
    ((as-> x name expr . rest)
      (as-> (let ((name x)) expr) name . rest))))

(define-syntax some->
  (syntax-rules ()
    ((some-> x) x)
    ((some-> x (fn . args) . rest)
      (let ((y (fn x . args)))
        (and y (some-> y . rest))))
    ((some-> x fn . rest)
      (let ((y (fn x)))
        (and y (some-> y . rest))))))

(define-syntax some->>
  (syntax-rules ()
    ((some->> x) x)
    ((some->> x (fn args ...) . rest)
      (let ((y (fn args ... x)))
        (and y (some->> y . rest))))
    ((some->> x fn . rest)
      (let ((y (fn x)))
        (and y (some->> y . rest))))))

(define-syntax cond->
  (syntax-rules ()
    ((cond-> x) x)
    ((cond-> x ((fn . args)) . rest)
      (cond-> (fn x . args) . rest))
    ((cond-> x (fn) . rest)
      (cond-> (fn x) . rest))
    ((cond-> x (guard? (fn . args)) . rest)
      (let ((y (if guard? (fn x . args) x)))
        (cond-> y . rest)))
    ((cond-> x (guard? fn) . rest)
      (let ((y (if guard? (fn x) x)))
        (cond-> y . rest)))))

(define-syntax cond->>
  (syntax-rules ()
    ((cond->> x) x)
    ((cond->> x ((fn args ...)) . rest)
      (cond->> (fn args ... x) . rest))
    ((cond->> x (fn) . rest)
      (cond->> (fn x) . rest))
    ((cond->> x (guard? (fn args ...)) . rest)
      (let ((y (if guard? (fn args ... x) x)))
        (cond->> y . rest)))
    ((cond->> x (guard? fn) . rest)
      (let ((y (if guard? (fn x) x)))
        (cond->> y . rest)))))

(define-syntax lambda->
  (syntax-rules ()
    ((lambda-> . rest)
      (lambda (x) (-> x . rest)))))

(define-syntax lambda->>
  (syntax-rules ()
    ((lambda->> . rest)
      (lambda (x) (->> x . rest)))))
