(define (even? n)
  (= (remainder n 2) 0)
  )
(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random-integer (- n 1)))
          ))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

(define (km-test-iter a n)
  (if (< a n)
      (cond
       ((= (expmod-revision a (- n 1) n) 1)
           (km-test-iter (+ a 1) n))
       ((= (expmod-revision a (- n 1) n) 0)
        #f)
       )
      #t
      )
  )
(define (expmod-revision base exp m)
    (cond
     ((= exp 0) 1)
     ((even? exp)
      (let ((a (expmod-revision base (/ exp 2) m)))
      (if
       (and (not (= a 1))
            (not (= a (- m 1)))
            (= 1 (remainder (square a) m)))
       0
      (remainder (square a) m))))
      (else
     (remainder (* base (expmod-revision base (- exp 1) m))
                m))
     
    )
  )

(define (fermat-test-revision n)
  (define (try-it a)
    ((expmod-revision a (- n 1) n) 1)
    )
  (if (= (try-it (+1 (random-integer (- n 1)))) 0)
      #f
      (try-it (+1 (random-integer (- n 1))))
      )
  )

(use slib)
(require 'trace)
(set! debug:max-count 100)


(print (km-test-iter 1 561))
(print (km-test-iter 1 1105))
(print (km-test-iter 1 1729))
(print (km-test-iter 1 2465))
(print (km-test-iter 1 2821))
(print (km-test-iter 1 6601))

(print (km-test-iter 1 1009))
(print (km-test-iter 1 1013))
(print (km-test-iter 1 1019))
(print (km-test-iter 1 10007))
(print (km-test-iter 1 10009))
(print (km-test-iter 1 10037))
(print (km-test-iter 1 100003))
(print (km-test-iter 1 100019))
(print (km-test-iter 1 100043))
(print (km-test-iter 1 1000003))
(print (km-test-iter 1 1000033))
(print (km-test-iter 1 1000037))

(print (km-test-iter 1 101))
