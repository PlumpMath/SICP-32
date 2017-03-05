#lang racket

(define (square a) (* a a))

(define (inc b) (+ b 1))

(define (compose f1 f2) (lambda(x) (f1 (f2 x))))

((compose square inc) 6)

; 49