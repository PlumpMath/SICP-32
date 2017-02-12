#lang racket

;Exercise 2.27

(define (reverse-list list)
  (define (iter list reversed-list)
    (if (null? list)
        reversed-list
        (if (pair? (car list))
            (iter (cdr list) (cons (reverse-list (car list)) reversed-list))
            (iter (cdr list) (cons (car list) reversed-list)))))
  (iter list null))

(reverse-list (list 1 2 3 4 5))


(define x (list (list 1 2) (list 3 4)))
(reverse-list x)
