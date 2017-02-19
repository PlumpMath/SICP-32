#lang racket

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square a)
  (* a a))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (next a)
  (if (= a 2)
  3
  (+ a 2)))

(prime? 7)


; timed-prime-test

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-milliseconds)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (current-milliseconds) start-time))
      #f))

(define (report-prime elapsed-time)
  (display "***")
  (display elapsed-time))

(define (search-for-primes from to count)
  (if (or (= count 3) (= from to)) (display "END")
      (if (timed-prime-test from)
          (search-for-primes (+ from 1) to (+ count 1))
          (search-for-primes (+ from 1) to count))))

(search-for-primes 100000000 1000000000 0)
