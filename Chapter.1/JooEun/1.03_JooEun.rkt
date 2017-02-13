#lang racket

(define (square x) (* x x))

(define (sum_squared_values x y) (+ (square x) (square y)))

(define (sum_two_large_squared_value_from_three x y z)
  (cond ((and (<= x y) (<= x z)) (sum_squared_values y z))
        ((and (<= y x) (<= y z)) (sum_squared_values x z))
        ((and (<= z x) (<= z y)) (sum_squared_values x y))
        ))

(sum_two_large_squared_value_from_three 1 2 3)