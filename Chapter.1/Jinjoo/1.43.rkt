#lang racket

(define (square a) (* a a))

(define (inc b) (+ b 1))

(define (compose f1 f2) (lambda(x) (f1 (f2 x))))

(define (repeated f n)
  (define (repeated-iter f1 f2 n)
    (if (= n 0) (compose f1 f2)
      (repeated-iter f1 f2 (- n 1))))
  (repeated-iter f f n))

 

((repeated square 2) 5)
;625
