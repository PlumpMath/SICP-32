#lang racket

(define (horner-eval x coefficient-sequence)
  (foldr (lambda (this-coeff higher-terms) (+ (* higher-terms x) this-coeff))
         0
         coefficient-sequence))

; foldr 은 sequence 의 뒤에서부터 reduce 시킨다.
; Lisp 라는 언어의 car / cdr 구현에 따르면 그게 자연스럽다.