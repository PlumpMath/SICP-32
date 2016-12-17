#lang racket

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) (/ x 1000)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (square x) (* x x))
(define (cube x) (* x x x))

; test
(define cube-root-of-3 (cube-root-iter 1 3))
(exact->inexact (cube cube-root-of-3))