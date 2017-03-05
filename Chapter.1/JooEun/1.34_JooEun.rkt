#lang racket


(define (square n) (* n n))

(define (f g)
  (g 2))

(f f)

; (f f)
; (f 2)
; (2 2) -> application: not a procedure;
