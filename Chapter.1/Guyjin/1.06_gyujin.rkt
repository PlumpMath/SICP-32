#lang racket

(define (square x)
  (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
 
(define (sqrt x)
 (sqrt-iter 1.0 x))

(sqrt 10000000)

; new-sqrt-iter using new-if 

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (new-sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (new-sqrt-iter (improve guess x)
                     x)))

(define (new-sqrt x)
 (new-sqrt-iter 1.0 x))

(new-sqrt 10000000)

; if is a special form of procedure which does not try to evaluate each argument first.
; On contrary, new-if is just a normal procedure so the applicative-order interpreter will try to evalutae recursive argument
; and will result in an infinite loop.