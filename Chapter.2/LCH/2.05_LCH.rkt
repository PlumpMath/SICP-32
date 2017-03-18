#lang racket

; 거듭제곱 계산 procedure
(define (pow base exp)
  (pow-iter base exp 1))
(define (pow-iter base exp result)
  (if (= exp 0)
      result
      (pow-iter base (- exp 1) (* result base))))
; cons / car / cdr
(define (cons x y)
  (* (pow 2 x) (pow 3 y)))
(define (car z)
  (car-iter z 0))
(define (car-iter z result)
  (if (= (remainder z 2) 0)
      (car-iter (/ z 2) (+ result 1))
      result))
(define (cdr z)
  (cdr-iter z 0))
(define (cdr-iter z result)
  (if (= (remainder z 3) 0)
      (car-iter (/ z 3) (+ result 1))
      result))

; 테스트
(define z (cons 3 4))
(car z) ; 3
(cdr z) ; 4