#lang racket
(define (compose f g) (lambda (x) (f (g x))))
(define (square x) (* x x))
(define (inc x) (+ x 1))

(define (repeated f n)
  (define (repeated-iter g n)
    (if (= n 1)
        g
        (repeated-iter (compose f g) (- n 1))))
  (if (<= n 0)
      #false
  (repeated-iter f n)))

((repeated square 2) 5);625
((repeated inc 4) 5);9
((repeated inc 0) 5);false
