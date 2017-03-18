#lang racket
;Exercise 2.31

(define (tree-map procedure tree)
    (map (lambda (subtree)
           (if (pair? subtree) (tree-map procedure subtree)
               (procedure subtree)))
         tree))


(define (square-tree tree) (tree-map (lambda (x) (* x x)) tree))

(square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
       