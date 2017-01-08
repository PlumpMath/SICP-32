#lang racket

; product abstraction 을 procedure 로 정의.
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

; factorial 정의
(define (identity x) x)
(define (inc x) (+ x 1))
(define (factorial n)
  (product identity 1 inc n))

; factorial 테스트
(factorial 7) ; 5040

; pi/4 계산하는 sequence 정의
(define (pi-over-4-term-nu x)
  (+ (* (quotient x 2) 2) 2))
(define (pi-over-4-term-deno x)
  (+ (* (quotient (+ x 1) 2) 2) 1))
(define (pi-over-4-term x)
  (/ (pi-over-4-term-nu x) (pi-over-4-term-deno x)))
(define (pi-over-4 n)
  (/ (product pi-over-4-term 1 inc n) 1.0)) ; float 로 만들기 위해서 1.0 으로 나눈다.
(pi-over-4 20000) ; 0.78539816339

; iterative 하게 구현했는데, recursive 하게 또 구현하라고 한다. 근데 귀찮엉.....