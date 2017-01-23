#lang racket

; cdr procedure 정의
(define (cons x y)
  (lambda (m) (m x y)))
(define (cdr z)
  (z (lambda (p q) q)))

; 테스트
(cdr (cons 1 2)) ; 2