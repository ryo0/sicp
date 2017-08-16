#lang racket
(require racket/trace)
(require sicp)
; 18:52->19:03
; 19:08->19:39
; 19:46->20:11
; 20:17->20:42
; 20:57->21:07
(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))

(define (left-branch branch) (cadr branch))
(define (right-branch branch) (cddr branch))
(define (branch-length branch) (car branch))
(define (branch-structure branch) (cdr branch))

 ;aのテスト
;(define _b1 (make-branch 5 2))
;(define _b2 (make-branch 2 1))
;(define _m (make-mobile _b1 _b2))
;(define _b (make-branch 3 _m))
;(display _b)
;(newline)
;(display (car _b))
;(newline)
;(display (cdr _b))
;(newline)
;(display (car (cdr _b)))
;(newline)
;(display (cdr (cdr _b)))
;(newline)
;(display (car (cdr (cdr _b))))
;(newline)
;(display (cdr (cdr (cdr _b))))
;(newline)
;(display m)
;(newline)
;(display b)
;(newline)
;(display (car m))
;(newline)
;(display (cdr m))
;(display (left-branch b))
;(newline)
;(display (right-branch b))
;(newline)
;(display (branch-length b))
;(newline)
;(display (branch-structure b))
;(newline)
(define (total-weight branch)
  (if (not (pair? (branch-structure branch)))
    (branch-structure branch)
    (let ((left (left-branch branch))
          (right (right-branch branch)))
      (let ((leftlen (branch-length left))
            (rightlen (branch-length right))
            (leftst (branch-structure left))
            (rightst (branch-structure right)))
        (cond
          ((and (not (pair? leftst)) (not (pair? rightst)))
           (+ leftst rightst))
          ((not (pair? leftst)) (+ leftst (total-weight right)))
          ((not (pair? rightst)) (+ (total-weight left) rightst))
          (else
           (+ (total-weight left) (total-weight right))
           )
          )
        )
      ))
  )
; bのテスト
(define m1 (make-branch 4 4))
(define m2 (make-branch 2 2))
(define m12 (make-mobile m1 m2))
(define b12 (make-branch 3 m12))
(display (total-weight b12))
(newline)
(define b5 (make-branch 10 5))
(define b4 (make-branch 10 4))
(define b3 (make-branch 10 3))
(define m54 (make-mobile b5 b4))
(define b54 (make-branch 10 m54))
(define m543 (make-mobile b54 b3))
(define b543 (make-branch 10 m543))
(display b543)
(newline)
(display (total-weight b543))
(newline)
(display (total-weight b5))
(newline)

(define (calc-torque branch)
  (if (not (pair? (branch-structure branch)))
    0
    (let ((left (left-branch branch))
          (right (right-branch branch)))
      (let ((leftlen (branch-length left))
            (rightlen (branch-length right))
            (leftst (branch-structure left))
            (rightst (branch-structure right)))
        (cond
          ((and (not (pair? leftst)) (not (pair? rightst)))
           (- (* leftlen leftst) (* rightlen rightst)))
          ((not (pair? leftst)) (- (* leftlen leftst) (* rightlen (total-weight right))))
          ((not (pair? rightst)) (- (* leftlen (total-weight left)) (* rightlen rightst)))
          (else
           (- (* leftlen (total-weight left)) (* rightlen (total-weight right)))
           )
          )
        )
      ))
  )
(define (is_balanced branch)
  (if (not (pair? (branch-structure branch)))
    true
    (let ((left (left-branch branch))
          (right (right-branch branch)))
      (and (= 0 (calc-torque branch)) (is_balanced left) (is_balanced right))
      )))
(display (calc-torque b12))
(newline)
(display (calc-torque b543))
(newline)
(display (is_balanced b12))
(newline)
(display (is_balanced b543))
(newline)
;(display (calc-torque (4 4)))
;(newline)
;(display (calc-torque (2 2)))
;(newline)
(define br4 (make-branch 2 5))
(define br2 (make-branch 5 2))
(define mb24 (make-mobile br4 br2))
(define br3 (make-branch 4 mb24))

(define br2_ (make-branch 5 2))
(define br5 (make-branch 2 5))
(define mb25 (make-mobile br2_ br5))
(define br6 (make-branch 4 mb25))

(define br (make-branch 10 (make-mobile br3 br6)))

(display (is_balanced br))