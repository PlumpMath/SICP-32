#lang racket

(require "apply-generic.rkt")
(require "complex-number-package.rkt")
(require "rational-number-package.rkt")
(require "scheme-number-package.rkt")
(require "table.rkt")
(require "tag.rkt")

; 구현
(define (=zero? num) (apply-generic '=zero? num))

; 테스트 준비
(define zero-scheme-number 0)
(define zero-rational (make-rational 0 1))
(define zero-complex-from-real-imag (make-complex-from-real-imag 0 0))
(define zero-complex-from-mag-ang (make-complex-from-mag-ang 0 (/ pi 4)))

; 테스트
(=zero? zero-scheme-number)
(=zero? zero-rational)
(=zero? zero-complex-from-real-imag)
(=zero? zero-complex-from-mag-ang)