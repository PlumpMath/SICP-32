#lang racket

;Exercise 2.18

(define (reverse-list list)
  (define (iter list reversed-list)
    (if (null? list)
        reversed-list
        (iter (cdr list) (cons (car list) reversed-list))))
  (iter list null))

(reverse-list (list 1 2 3 4 5))