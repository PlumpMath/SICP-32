#lang racket

(require "table.rkt")
(require "tag.rkt")
(require "apply-generic.rkt")

; tag.rkt 를 수정했다.

; install-scheme-number-package procedure 를 수정한다.
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
  'done)

; 수정한 install-scheme-number-package procedure 를 install 한다.
(install-scheme-number-package)

; 테스트를 위한 procedure 들을 선언한다.
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))
(define (add x y) (apply-generic 'add x y))

; 테스트를 위한 인자들을 준비한다.
(define x (make-scheme-number 3.0))
(define y (make-scheme-number 4.0))

; 테스트
(define result (add x y))
(if (= result 7.0)
    (print "Test passed: 2.78")
    (error "Unexpected result: 2.78"))