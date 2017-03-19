#lang racket

; rectangular / polar package 를 install 한다.
; real-part, imag-part, magnitude, angle procedure 를 apply-generic 으로 선언한다.
; real-part, imag-part, magnitude, angle operation 을 complex type 에 대해서 put 한다.

(require "apply-generic.rkt")
(require "complex-number-package.rkt")

; 테스트를 위한 magnitude procedure 선언
(define (magnitude z) (apply-generic 'magnitude z))

; 테스트
(magnitude (make-complex-from-real-imag 3 4))

; 참고로 z 는 ('complex ('rectangular (3 4))) 로 구성된 상태이다.
; (magnitude z)
; (apply-generic 'magnitude z)
; (apply (get 'magnitude (map type-tag (list z))) (map contents (list z)))
; (apply (get 'magnitude '(complex)) (list (cons 'rectangular (cons 3 4))))
; ((get 'magnitude '(complex)) (cons 'rectangular (cons 3 4)))
; (apply-generic 'magnitude (cons 'rectangular (cons 3 4)))
; (apply (get 'magnitude '(rectangular)) (list (cons 3 4)))
; type-tag 를 하나씩 떼면서 procedure 를 fetch 한다.