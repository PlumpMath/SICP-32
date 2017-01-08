#lang racket

; 우선 책에 나와있던 sum procedure 를 적는다.
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))
; sum procedure 의 term / next procedure 를 채운다.
; 이를 통해 Simpson's Rule 에 기반한 integral procedure 를 정의.
(define (integral f a b n)
  (define h (/ (- b a) n))
  (define (coeff k)
    (cond ((> k n) 0)
          ((or (= k 0) (= k n)) 1)
          ((= (remainder k 2) 0) 2)
          ((= (remainder k 2) 1) 4)))
  (define (term k)
    (* (coeff k) (f (+ a (* k h)))))
  (define (next k)
    (+ k 1))
  (* (/ h 3) (sum term 0 next n)))

; 테스트를 위해 cube procedure 를 정의.
(define (cube x)
  (* x x x))

; 테스트
(display "n=100일때: ")
(integral cube 0 1 100)
(display "n=1000일때: ")
(integral cube 0 1 1000)