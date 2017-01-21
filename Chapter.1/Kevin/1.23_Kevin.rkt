#lang racket

;Exercise 1.23
(println "Exercise 1.23")
(println "Define a procedure next that re- turns 3 if its input is equal to 2 and otherwise returns its in- put plus 2.
Modify the smallest-divisor procedure to use (next test-divisor) instead of (+ test-divisor 1).")


(define (square x)
  (* x x))

(define (smallest-divisor n) (find-divisor n 2))
(define (next divisor)
  (if (= divisor 2) 3 (+ divisor 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b) (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))


(println "Using prime?")
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (current-inexact-milliseconds) start-time))
      #f))


(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  #t)

(define (search-for-primes from to count)
  (cond ((or (= count 3) (= from to)) (display "\nEND"))
        ((even? from) (search-for-primes (+ from 1) to count))
        (else (if (timed-prime-test from) (search-for-primes (+ from 2) to (+ count 1))
                  (search-for-primes (+ from 2) to count)))))

(search-for-primes 1000 10000 0)
(search-for-primes 10000 100000 0)
(search-for-primes 100000 1000000 0)
(search-for-primes 1000000 10000000 0)
