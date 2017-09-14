#lang racket
(require racket/trace)
(require sicp)
; 9:39->9:54
(define (square x) (* x x))
(define (scale-tree tree factor)
  (cond
    ((null? tree) nil)
    ((not (pair? tree)) (* tree factor))
    (else (cons (scale-tree (car tree) factor) (scale-tree (cdr tree) factor)))
    ))
(define (scale-tree2 tree factor)
  (map (lambda (sub-tree)
               (if (pair? sub-tree)
                 (scale-tree2 sub-tree factor)
                 (* sub-tree factor)))
       tree))

(define (square-tree tree)
  (cond
    ((null? tree) nil)
    ((not (pair? tree)) (* tree tree))
    (else (cons (square-tree (car tree)) (square-tree (cdr tree)))
    )))
(define (square-tree2 tree)
  (map (lambda (tree)
               (if (pair? tree)
                 (square-tree2 tree)
                 (* tree tree)))
       tree)
  )
(define (tree-map f tree)
  (cond
    ((null? tree) nil)
    ((not (pair? tree)) (f tree))
    (else (cons (tree-map f (car tree)) (tree-map f (cdr tree))))
    )
  )
(define (tree-map2 f tree)
  (map (lambda (tree)
               (if (pair? tree)
                 (tree-map2 f tree)
                 (f tree)))
       tree))

(define tree (list 1 (list 2 (list 3 4) 5) (list 6 7) 10))
(display (tree-map square tree))
(newline)
(display (tree-map2 square tree))