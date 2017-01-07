#lang racket

; sum 과 product 을 아우르는 더 general 한 combiner 라는 procedure 를 정의.
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))

; sum 을 accumulate 로 표현해보자.
(define (sum term a next b)
  (accumulate + 0 term a next b))
; sum 테스트
(define (cube x) (* x x x))
(define (inc x) (+ x 1))
(sum cube 1 inc 3) ; 36

; product 을 accumulate 로 표현해보자.
(define (product term a next b)
  (accumulate * 1 term a next b))
; product 테스트
(define (identity x) x)
(product identity 1 inc 6) ; 720

; 하아..... 여기서도 iterative 하게 했으면, recursive 로 또 구현하라네.... 귀찮!