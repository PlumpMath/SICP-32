#lang racket

(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (good-enough? guess x)
  (< (abs (- (* guess guess guess) x)) 0.0000000000001))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (cuberoot-iter guess x)
  (if (good-enough? guess x)
      guess
      (cuberoot-iter (improve guess x) x)))

(define (cuberoot x)
  (cuberoot-iter 1.0 x))

(cuberoot 100)

(* (cuberoot 100) (cuberoot 100) (cuberoot 100))
  
