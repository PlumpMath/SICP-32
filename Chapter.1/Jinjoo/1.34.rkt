#lang racket
(define (square a) (* a a))

(define (f g)
  (g 2))

;(f square)
; 4

;(f (lambda (z) (* z (+ z 1))))
; 6

(f f)
;(f 2)
;(2 2)
; application: not a procedure;
; expected a procedure that can be applied to arguments
;  given: 2
;  arguments...: