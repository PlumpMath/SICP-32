#lang racket

; ㅋㅋㅋㅋㅋㅋㅋ accumulate 를 더 generalize 한다. 난리났다.
; term 을 range 에서 매번 계산해서 accumulate 하는게 아니라, filter 를 만족할때만 accumulate 한다.

(define (filtered-accumulate combiner null-value term a next b filter)
  (define (iter a result)
    (if (> a b)
        result
        (if (filter a)
            (iter (next a) (combiner result (term a)))
            (iter (next a) result))))
  (iter a null-value))

; =================================================================================
; a. the sum of the squares of the prime numbers in the interval a to b
(define (problem-one a b)
  (filtered-accumulate + 0 square a inc b prime?))
; a 에서 필요한 것들 정의.
(define (square x) (* x x))
(define (inc x) (+ x 1))
(define (prime? num)
  (if (< num 2)
      #false
      (= (smallest-divisor num) num)))
(define (smallest-divisor num)
  (iter-divisors num 2))
(define (iter-divisors num test-divisor)
  (cond ((> (square test-divisor) num) num)
        ((= (remainder num test-divisor) 0) test-divisor)
        (else (iter-divisors num (+ test-divisor 1)))))
; a 테스트
(display "test a: ")
(problem-one 1 10) ; 87

; =================================================================================
; relatively prime to n = n 과 서로소
; 서로소 계산하는 GCD procedure 정의.
(define (problem-two n)
  (define (identity x) x)
  (define (relatively-prime? x)
    (= (gcd n x) 1))
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
  (filtered-accumulate * 1 identity 1 inc (- n 1) relatively-prime?))
; b 테스트
(display "test b: ")
(problem-two 10) ; 189