#lang racket

(define (square a) (* a a))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (next x)
  (if (= x 2) 3 (+ x 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

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

;(search-for-primes 10000000000 20000000000 3)

;10000000019 *** 5.68798828125
;10000000033 *** 5.423828125
;10000000061 *** 5.343994140625

; 1.22

;10000000019 *** 15.10205078125
;10000000033 *** 9.780029296875
;10000000061 *** 9.491943359375

; running approximately 1.85 times as fast