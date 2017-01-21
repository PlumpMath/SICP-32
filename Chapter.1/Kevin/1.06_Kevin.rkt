#lang racket
;Exercise 1.6
;square
(define (square x) (* x x))

(display "Exercise 1.6")
(define (sqrt-iter guess x)
  (if (good-enough? guess x) guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) (/ (+ x y) 2))

(define (good-enough? guess x)
  (display "guess\n")
  (display guess)
  (display "\n\n")
  (display "(square guess)\n")
  (display (square guess))
  (display "\n\n")
  (display "x\n")
  (display x)
  (display "\n\n")
  (display "- x (square guess)))\n")
  (display (- x (square guess)))
  (display "\n\n")
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x) (sqrt-iter 1.0 x))

(define (new-if predicate then-clause else-clause) (cond (predicate then-clause)
(else else-clause)))

;(define (sqrt-iter guess x) (new-if (good-enough? guess x)
;               guess
;               (sqrt-iter (improve guess x) x)))

(display "
Since Lisp uses applicative-order evaluation, the new-if procedure(different from if, if is a special form)
would need to perform the evaluation of '(sqrt-iter (improve guess x) x)' before evaluating the whole procedure,
which would end up being a recursive, non-ending procedure.
")