#lang racket

(define (square a) (* a a))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

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

(define (search-for-primes start end count)
  (when (and (< start end) (< 0 count))
    (if (timed-prime-test start)
        (search-for-primes (+ start 1) end (- count 1))
        (search-for-primes (+ start 1) end count))))

;(search-for-primes 1000000 2000000 3)

;1000003 *** 0.511962890625
;1000033 *** 0.1611328125
;1000037 *** 0.158203125

;(search-for-primes 10000000 20000000 3)

;10000019 *** 0.622802734375
;10000079 *** 0.429931640625
;10000103 *** 0.510009765625