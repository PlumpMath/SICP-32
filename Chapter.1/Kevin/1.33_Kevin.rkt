#lang racket
;Exercise 1.33
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

;filtered-accumulate
(define (filtered-accumulate combiner null-value term a next b filter)
  (if (> a b)
      null-value
      (combiner (if (filter (term a))
                    (term a)
                    null-value)
                (accumulate combiner null-value term (next a) next b filter))))

;The sum of the squares of the prime numbers in the interval a to b
(filtered-accumulate + 0 square a inc b prime?)

;The product of all the positive integers less than n that are relatively prime to n

(filtered-accumulate + 0 identity 1 inc (- n 1) relatively-prime-to-n)

(define (relatively-prime-to-n x)
  (if (= 1 (GCD x n))
      #t
      #f))
