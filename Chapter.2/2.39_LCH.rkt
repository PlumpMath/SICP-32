#lang racket

(define (reverse sequence)
  (foldr (lambda (x y) (append y (list x))) null sequence))
(define (reverse sequence)
  (foldl (lambda (x y) (cons x y)) null sequence))
