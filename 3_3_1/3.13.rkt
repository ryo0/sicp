#lang debug racket
(require sicp)
(require racket/trace)
;20:58->21:01
(define (last-pair x)
  (if (null? (cdr x))
      x
    (last-pair (cdr x)))
  )
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
(define z (make-cycle (list 'a 'b 'c)))
(display z)
(newline)
(trace last-pair
(display (last-pair z))
;無限ループはまあ当たり前