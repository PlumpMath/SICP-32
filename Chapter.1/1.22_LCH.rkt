#lang racket

#|

elapsed time 을 기록하는 개념이 등장하는 exercise.
prime 계산하는 내용이 1.2절 후반부의 핵심이었다.
기억이 잘 안나서 짚고 넘어간다.

|#

; 교재에는 runtime 을 사용하지만, Racket 에서는 current-inexact-milliseconds 이다.
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
; 최대 약수가 자기자신과 같으면, prime 이다.
(define (prime? n)
  (= n (smallest-divisor n)))
; iterative 하게 최대 약수를 찾는다.
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
; 이 번잡한 divides? 랑 square 를 매번 적어줘야하는게 귀찮다.
(define (divides? a b)
  (= (remainder b a) 0))
(define (square x)
  (* x x))



; 정해진 범위의 연속된 odds 의 primality 를 체크하는 compound operation 을 적어야한다.
; 입력이 odd 일거라 가정.

(define (search-for-primes start end how-many)
  (when (and (< start end) (> how-many 0))
    (if (timed-prime-test start)
        (search-for-primes (+ start 2) end (- how-many 1))
        (search-for-primes (+ start 2) end how-many))))

; Exercise 에서 요구한 작업 수행
; 실행시간이 sqrt(n) 에 비례해야하는데, 전혀 그런 양상을 보이지 않는다.

(search-for-primes 9999999 9999999999 3)
(newline)
(search-for-primes 99999999 9999999999 3)
(newline)
(search-for-primes 999999999 9999999999 3)