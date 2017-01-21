#lang racket

;Exercise 1.24
(println "Exercise 1.24")
(display "Modify the timed-prime-test procedure of Exercise 1.22 to use fast-prime? (the Fermat method),
and test each of the 12 primes you found in that exercise. Since the Fermat test has Θ(log n) growth, how would
 you expect the time to test primes near 1,000,000 to compare with the time needed to test primes near 1000?
Do your data bear this out? Can you explain any discrepancy you find?")

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

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m)) m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))


(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))


(println "Using fast-prime?")
(define (start-prime-test n start-time)
  (if (fast-prime? n 4)
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
