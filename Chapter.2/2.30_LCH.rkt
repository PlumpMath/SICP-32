#lang racket

; implementation
(define (square-tree-direct tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (* tree tree))
        (else (cons (square-tree-direct (car tree))
                    (square-tree-direct (cdr tree))))))
(define (square-tree-map tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-map sub-tree)
             (* sub-tree sub-tree)))
       tree))

; test
(square-tree-direct
 (list 1
       (list 2 (list 3 4 ) 5)
       (list 6 7)))