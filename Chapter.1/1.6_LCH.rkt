#lang racket

(define (new-if predicate then-clause else-caluse)
  (cond (predicate then-clause)
        (else else-caluse)))

;(new-if (= 2 3) 0 5)
;(new-if (= 1 1) 0 5)

; define good-enough predicate
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
; define improve iteration
(define (improve guess x)
  (average guess (/ x guess)))
; define average operation
(define (average x y)
  (/ (+ x y) 2))
; define square operation
(define (square x) (* x x))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

(sqrt-iter 1 2)

; sqrt-iter 은 끝나지 않고 영원히 실행된다.
; new-if 가 special-form 이 아니므로 applicative-order evaluation 에 따라,
; predicate 와 then-clause, else-clause 를 먼저 evaluation 하려고 시도한다.
; 그러므로 good-enough? 를 통과한 뒤에도 바로 guess 를 반환하지 않고 계속해서 sqrt-iter 시도한다.
; Java 의 경우 short-circuiting 기법으로 이러한 문제를 다룬다. predicate 가 true 라면 else-caluse 를
; 아예 evaluation 하지 않는다.

