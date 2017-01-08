#lang racket

; next 라는 procedure 를 정의한다.
(define (next num)
  (if (= num 2)
      3
      (+ num 2)))

; smallest-divisor procedure 를 재정의한다.
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (square x)
  (* x x))

; timed-prime-test 를 재정의한다.
(define (timed-prime-test n)
  (start-prime-test n (current-inexact-milliseconds)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (begin
        (newline)
        (display n)
        (report-prime (- (current-inexact-milliseconds) start-time))
        #true)
      #false))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))
(define (prime? n)
  (= n (smallest-divisor n)))

; Exercise 1.22 에서 찾았던 prime 들로 소요시간 테스트
(timed-prime-test 10000019)
(timed-prime-test 10000079)
(timed-prime-test 10000103)
(timed-prime-test 100000007)
(timed-prime-test 100000037)
(timed-prime-test 100000039)
(timed-prime-test 1000000007)
(timed-prime-test 1000000009)
(timed-prime-test 1000000021)

; 딱히 절반이 되지는 않는다. 시간이 더 길어지는 경우도 있다. 이유가 뭘까?
; 우선 단순 +2 하는것보다, if stmt 가 추가되므로 시간이 길어질 수 있는 요소도 있다.