#lang racket
(define (compose f g) (lambda (x) (f (g x))))
(define (square x) (* x x))

(define (repeated f n)
  (cond ((<= n 0) #false)
        ((= n 1) f)
        (else (repeated (compose f f) (- n 1)))
        ))

((repeated square 2) 5)
