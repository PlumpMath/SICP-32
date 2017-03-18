#lang racket
(define (square x) (* x x))

(define (sum_square_of_large_twonum a b c)
  (cond ((and (< a b) (< a c)) (+ (square b) (square c)))
         ((and (< b a) (< b c)) (+ (square a) (square c)))
         ((and (< c a) (< c b)) (+ (square a) (square b)))))

(sum_square_of_large_twonum 10 20 4)