#lang racket

; positive / negative 를 모두 수용하도록 make-rat procedure 를 수정한다.
(define (make-rat n d)
  (if (< (* n d) 0)
      (cons (- (abs n)) (abs d))
      (cons (abs n) (abs d))))
(define (numer x) (car x))
(define (denom x) (cdr x))
(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

; 테스트: +1/-3 을 만들어서 출력해본다.
(define minus-one-third (make-rat 1 -3))
(print-rat minus-one-third)
  