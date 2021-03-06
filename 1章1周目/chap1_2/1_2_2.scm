 (define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else
         (+ (fib (- n 1))
            (fib (- n 2))
            )
         )
        )
  )

(define (fib n)
  (fib-iter 1 0 n))
(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))
      )
  )


(define (count-change amount) (cc amount 5))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination
                         kinds-of-coins
                         )
                        )
                     kinds-of-coins
                     )
                 ))
        )
  )

(define (first-denomination kinds-of-coins)
  (cond
   ((= kinds-of-coins 1) 1)
   ((= kinds-of-coins 2) 5)
   ((= kinds-of-coins 3) 10)
   ((= kinds-of-coins 4) 25)
   ((= kinds-of-coins 5) 50)))

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))
   )
  )
(print (f 5))

(define (f2 n)
  (f2-iter 2 1 0 n)
  )

(define (f2-iter a b c count)
  (cond
   ((= count 0) 0)
   ((= count 1) 1)
   ((= count 2) a)
   (else
      (f2-iter (+ a (* 2 b) (* 3 c)) a b  (- count 1))
      ))
  )
(print (f 0))
(print (f2 0))
(print (f 1))
(print (f2 1))
(print (f 2))
(print (f2 2))
(print (f 3))
(print (f2 3))
(print (f 4))
(print (f2 4))
(print (f 5))
(print (f2 5))
(print (f 6))
(print (f2 6))

(define (C m n)
  (if (or (= n 1) (= m n))
      1
      (+ (C (- m 1) (- n 1)) (C (- m 1) n))
   )
  )
(use slib)
(require 'trace)
;;(trace C)
(print (C 1 1))
(print (C 2 1))
(print (C 3 1))
(print (C 4 4))
(print (C 5 2))
(print (C 5 3))
(print (C 6 3))
