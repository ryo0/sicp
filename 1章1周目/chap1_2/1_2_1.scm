>;;15:48->16:46

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))
      )
  )
(define (factorial2 n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1)
              )
        )
    )
  (iter 1 1)
  )

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b)
      )
  )
 (+ 4 5)
 = (inc (+ (dec 4) 5))
 = (inc (+ 3 5))
 = (inc (inc (+ (dec 3) 5)))
 = (inc (inc (+ 2 5)))
 = (inc (inc (inc (+ (dec 2) 5))))
 = (inc (inc (inc (+ 1 5))))
 = (inc (inc (inc (inc (+ (dec 1) 5)))))
 = (inc (inc (inc (inc (+ 0 5)))))
 = (inc (inc (inc (inc 5))))
 = (inc (inc (inc 6)))
 = (inc (inc 7))
 = (inc 8)
 = 9
 ;;再帰プロセスである

 (define (+ a b)
   (if (= a 0)
       b
       (+ (dec a) (inc a))
       )
   )

 (+ 4 5)
 = (+ (dec 4) (inc 5))
 = (+ 3 6)
 = (+ (dec 3) (inc 6))
 = (+ 2 7)
 = (+ (dec 1) (inc 8))
 = (+ 0 9)
 = 9
 ;;反復プロセスである

 (define (A x y)
   (cond
    ((= y 0) 0)
    ((= x 0) (* 2 y))
    ((= y 1) 2)
    (else
     (A (- x 1) (A x (- y 1)))
     )
    )
   )
 (A 1 10)
 = (A 0 (A 1 9))
 = (A 0 (A 0 (A 1 8)))
 = (A 0 (A 0 (A 0 (A 1 7))))
 = …
 = (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
 = (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
 = (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
;;0の数だけ2をかける
 = 1024


 (A 2 4)
 = (A 1 (A 2 3))
 = (A 1 (A 1 (A 2 2)))
 = (A 1 (A 1 (A 1 (A 2 1))))
 = (A 1 (A 1 (A 1 2)))
 = (A 1 (A 1 (A 0 (A 1 1))))
 = (A 1 (A 1 (A 0 2)))
 = (A 1 (A 1 4))
 = (A 1 (A 0 (A 1 3)))
 = (A 1 (A 0 (A 0 (A 1 2))))
 = (A 1 (A 0 (A 0 (A 0 (A 1 1)))))
 = (A 1 (A 0 (A 0 (A 0 2))))
 = (A 1 (A 0 (A 0 4)))
 = (A 1 (A 0 8))
 = (A 1 16)
 = (A 0 (A 1 15))
 = 2 * (A 1 15)
 = 2 * 2^15
 = 2^16

 (A 1 (A 1 (A 1 (A 2 1))))
 = (A 1 (A 1 (A 1 2)))
 = (A 1 (A 1 2^2))
 = (A 1 2^2^2)
 = 2^2^2^2


 (A 3 3)
 = (A 2 (A 3 2))
 = (A 2 (A 2 (A 3 1)))
 = (A 2 (A 2 2))
 = (A 2 (A 2 2))
 = (A 2 2^2)
 = (A 2 4)
 = 2^2^2^2
 = 2^16

 (A 0 n)
 = 2 * n

 (A 1 n)
 = (A 0 (A 1 (- n 1)))
 = (A 0 (A 0 (A 0 (- (- n 1) 1))))
 = (A 0 (A 0 (A 0 1)))
 = (A 0 (A 0 2))
 =
 ;;nの数だけ再帰が行われ、
 ;;再帰が行われた数だけ2がかけられるので、
 ;;(A 1 n) = 2^n

 (A 2 n)
 = (A 1 (A 2 (- n 1)))
 = (A 1 (A 1 (A 1 (A 2 (- n 3)))))
 ;; (= (- n 3) 1)
 = (A 1 (A 1 (A 1 2)))
 = (A 1 (A 1 2^2))
 = (A 1 (A 1 4))
 = (A 1 2^4)
 = 2^(2^4)
;;(A 2 n) = 2^2^2^2…^2(高さn)
