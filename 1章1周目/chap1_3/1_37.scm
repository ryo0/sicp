(define (cont-frac n d k)
  (define (iter i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (iter (+ i 1)))))
    )
  (iter 1)
  )

(define (cont-frac2 n d k)
  (define (iter i result)
    (if (= i 1)
        (/ (n i) (+ (d i) result))
        (iter (- i 1) (/ (n i) (+ (d i) result))))
    )
  (iter k 0)
  )


(print (cont-frac (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  10))


(print (cont-frac2 (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  10))

(print (cont-frac (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  8))


(print (cont-frac2 (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  8))

