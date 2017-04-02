#lang racket
(define (p) (p))
(define (test x y)
  (if (= x 0)
      0
      y))
(test 0 (p))

; If an interpreter uses normal-order evaluation, it will first expand like below:
; (if (= 0 0)
;     0
;     (p))
; and then interpreter would check predicate first and return 0.

; If interpreter uses applicative-order evaluation like drRacket,
; it will first try to evaluate the argument (p) first and result in infinite loop.
