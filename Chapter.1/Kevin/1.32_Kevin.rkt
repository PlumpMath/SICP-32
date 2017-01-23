#lang racket
;Exercise 1.32
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))


;Product
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

;accumulate
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))


(define (inc x)
  (+ x 1))

(define (double x)
  (* x 2))

(define (identity x)
  x)

(accumulate + 0 double 0 inc 10)
(accumulate * 1 identity 1 inc 10)
