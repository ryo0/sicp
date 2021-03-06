(define (fib n)
  (fib-iter 1 0 0 1 n)
  )
;;変換を行列にして二乗すれば簡単に示せる
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))
                   (+ (* 2 p q) (* q q))
                   (/ count 2)
                   )
         )
        (else
         (fib-iter (+ (* b q) (* a q) (* a p))
                   (+ (* b p) (* a q))
                   p
                   q
                   (- count 1)
                   )
         )
        )
  )

(print (fib 0))
(print (fib 1))
(print (fib 2))
(print (fib 3))
(print (fib 4))
(print (fib 5))
(print (fib 6))
(print (fib 7))
(print (fib 8))
(print (fib 9))
(print (fib 10))
(print (fib 100))
