(define (runtime)
    (use srfi-11)
    (let-values (((a b) (sys-gettimeofday)))
      (+ (* a 1000000) b)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime))
  )
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))
      )
  )

(define (timed-prime-test2 n)
  (newline)
  (display n)
  (start-prime-test2 n (runtime))
  )
(define (start-prime-test2 n start-time)
  (if (prime2? n)
      (report-prime n (- (runtime) start-time))
      )
  )


(define (report-prime n elapsed-time)
  (display "***")
  (display elapsed-time)
  )


(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-devisor)
  (cond
   ((> (square test-devisor) n) n)
   ((devides? test-devisor n) test-devisor)
   (else (find-divisor n (+ test-devisor 1)))
   )
  )

(define (smallest-divisor2 n) (find-divisor2 n 2))
(define (find-divisor2 n test-devisor)
  (cond
   ((> (square test-devisor) n) n)
   ((devides? test-devisor n) test-devisor)
   (else (find-divisor2 n (next test-devisor)))
   )
  )

(define (devides? a b) (= (remainder b a) 0))

(define (even? n) (= (remainder n 2) 0))
(define (odd? n) (not (= (remainder n 2) 0)))
(define (square n) (* n n))
(define (next n)
  (if (= n 2)
      (+ n 1)
      (+ n 2)))

(define (prime? n)
  (= n (smallest-divisor n))
  )
(define (prime2? n)
  (= n (smallest-divisor2 n))
  )

(timed-prime-test 1009)
(timed-prime-test2 1009)
(timed-prime-test 1013)
(timed-prime-test2 1013)
(timed-prime-test 1019)
(timed-prime-test2 1019)
(timed-prime-test 10007)
(timed-prime-test2 10007)
(timed-prime-test 10009)
(timed-prime-test2 10009)
(timed-prime-test 10037)
(timed-prime-test2 10037)
(timed-prime-test 100003)
(timed-prime-test2 100003)
(timed-prime-test 100019)
(timed-prime-test2 100019)
(timed-prime-test 100043)
(timed-prime-test2 100043)
(timed-prime-test 1000003)
(timed-prime-test2 1000003)
(timed-prime-test 1000033)
(timed-prime-test2 1000033)
(timed-prime-test 1000037)
(timed-prime-test2 1000037)
(timed-prime-test 100000007)
(timed-prime-test2 100000007)
(timed-prime-test 100000000003)
(timed-prime-test2 100000000003)

;;以上の結果は、一番下のものであってもせいぜい1.5倍程度早くなる
;;という事を示すものだった
;;その理由。
;;(find-divisor 101 2)
;;を考える。
;;まず、再帰を含めたcondの三行を評価するので、
;;行きはそれぞれ3ステップずつ消費しながら、
;;(find-divisor 101 2)　3ステップ
;;(find-divisor 101 3)　3ステップ
;;(find-divisor 101 4)　3ステップ
;;(find-divisor 101 5)　3ステップ
;;(find-divisor 101 6)　3ステップ
;;(find-divisor 101 7)　3ステップ
;;(find-divisor 101 8)　3ステップ
;;(find-divisor 101 9)　3ステップ
;;(find-divisor 101 10)　3ステップ
;;(find-divisor 101 11)　1ステップ
;;ここで第一行の条件に引っかかり、答えの101をそれぞれ上に返していく
;;(find-divisor 101 11) = 101 1ステップ
;;(find-divisor 101 10) = 101 1ステップ
;;(find-divisor 101 9) = 101 1ステップ
;;(find-divisor 101 8) = 101 1ステップ
;;(find-divisor 101 7) = 101 1ステップ
;;(find-divisor 101 6) = 101 1ステップ
;;(find-divisor 101 5) = 101 1ステップ
;;(find-divisor 101 4) = 101 1ステップ
;;(find-divisor 101 3) = 101 1ステップ
;;(find-divisor 101 2) = 101 1ステップ
;;11（ルートnを超える最小の整数）をxとすると、
;;ステップ数はおおよそこう書ける
;;x*3 + x = 4*x
;;一方、find-divisor2では全体のステップ数は
;;数が大きくなればなるほど半分に近くなるが、
;;行きのそれぞれのステップ数は、
;;next内部のifを再帰で下に行くたびに消費するので、
;;それぞれ4ステップになる
;;(find-divisor2 101 2)　4ステップ
;;(find-divisor2 101 3)　4ステップ
;;(find-divisor2 101 5)　4ステップ
;;(find-divisor2 101 7)　4ステップ
;;(find-divisor2 101 9)　4ステップ
;;(find-divisor2 101 11) = 101　1ステップ
;;(find-divisor2 101 9)  = 101　1ステップ
;;(find-divisor2 101 7)  = 101　1ステップ
;;(find-divisor2 101 5)  = 101　1ステップ
;;(find-divisor2 101 3)  = 101　1ステップ
;;(find-divisor2 101 2)  = 101　1ステップ
;;この場合ではそうではないが数が非常に大きくなると、
;;大体2->xの半分程度で再帰の一番奥まで辿り着く。
;;よって、ステップ数はおおよそこう書ける
;;(x/2)*4+(x/2)=2.5x

;;したがってfind-divisor2はfind-divisorの4/2.5倍早いが、
;;この値はおよそ1.6であり、上記の実験結果と一致する。
