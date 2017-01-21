#lang racket
;Exercise 1.8
(println "Exercise 1.8")

(define (square x)
  (* x x))

(define (cube x)
  (cube-iter 1.0 x))

(define (cube-iter guess x)
  (if (cube-good-enough? guess x)
      guess
      (cube-iter (cube-improve guess x) x)))

(define (cube-good-enough? guess x)
  (< (abs (- (cube-improve guess x) guess)) 
     (* guess .001))) 
  
(define (cube-improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(cube 27)