(use srfi-27)

(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-devisor)
  (cond
   ((> (square test-devisor) n) n)
   ((devides? test-devisor n) test-devisor)
   (else (find-divisor n (+ test-devisor 1)))
   )
  )

(define (devides? a b) (= (remainder b a) 0))

(print (smallest-divisor 199))
(print (smallest-divisor 1999))
(print (smallest-divisor 19999))

(define (even? n) (= (remainder n 2) 0))
(define (square n) (* n n))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m
          )
         )
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m
          )
         )
        )
  )

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random-integer (- n 1))))
  )

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)
        )
  )
