#lang racket

; 1.29 에서 정의한 sum procedure 는 recursive 했다.
; iterative 하게 새로 정의하는게 이번 exercise.

; iterative 하게 sum procedure 재정의
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

; 테스트: 1부터 3까지 세제곱 합
(define (cube x) (* x x x))
(define (inc x) (+ x 1))
(sum cube 1 inc 3) ; 36 이어야 한다.