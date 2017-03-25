#lang racket

; Exercise 2.78 에서 scheme number 에는 type tag 를 굳이 달지않도록 하는 수정이 있었다.
; Exercise 2.80 에서 =zero? 를 install procedure 에 추가하는 작업이 있었다.

(require "table.rkt")

(provide make-scheme-number)

; install procedure 선언
(define (install-scheme-number-package)
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (+ x y)))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (- x y)))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (* x y)))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (/ x y)))
  (put 'make 'scheme-number (lambda (x) x))
  (put 'equal? '(scheme-number scheme-number)
       (lambda (x y) (equal? x y)))
  (put '=zero? '(scheme-number)
       (lambda (x) (= x 0)))
  'done)

; install
(install-scheme-number-package)

; constructor 를 외부에 공개
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))
