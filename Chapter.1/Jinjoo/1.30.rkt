#lang racket

(define (identity a) a)
(define (inc b) (+ b 1))

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
    (iter a 0))

(sum identity 0 inc 3)


