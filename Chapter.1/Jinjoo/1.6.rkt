#lang racket

(define (square x) (* x x))

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))
  
(sqrt 9)

; new-if 프로시저로 제곱근을 구한 결과, stack overflow
; application order evaluation이기 때문에 (sqrt-iter(improve guess x) x)이 계속 stack에 쌓인다.
; if는  special form 