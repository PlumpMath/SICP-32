#lang racket

(require "table.rkt")
(require "tag.rkt")
(require "complex-number-package.rkt")

; 구현
(define (equ? num1 num2)
  (if (eq? (type-tag num1) (type-tag num2))
      ((get 'equal? (list (type-tag num1) (type-tag num1))) (contents num1) (contents num2))
      #f))

; 테스트
(define z1 (make-complex-from-real-imag 3 4))
(define z2 (make-complex-from-real-imag 3 4))
(equ? z1 z2)
