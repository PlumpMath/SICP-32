#lang racket

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (square x) (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter-new guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

; (sqrt-iter-new 1.0 2) ; infinite recursion, stack overflow.
#|
 because intepreter is evaluate with applicative-order.
The else-clause is (sqrt-iter (improve guess x) x).
Recursively evaluate sqrt-iter procedure.
|#

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
; (sqrt-iter 1.0 2)

(provide (all-defined-out))