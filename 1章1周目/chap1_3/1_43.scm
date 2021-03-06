(define (square x) (* x x))

(define (compose f g)
  (lambda (x) (f (g x)))
  )
(define (repeated f n)
  (define (iter n)
    (if (= n 1)
        (lambda (a) (f a))
        (compose f (iter (- n 1))))
    )
  (iter n)
  )
(print ((repeated square 2) 5))

(print ((repeated square 3) 5))



(print ((repeated (lambda (x) (+ x 1)) 3) 9))
