#lang racket

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

(define (cube x) (* x x x))

(define (inc n) (+ n 1))

(sum cube 1 inc 3)

     