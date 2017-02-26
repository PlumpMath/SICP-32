#lang racket
(define (square a) (* a a))

(define (fast-expt b n)
   (cond ((= n 0) 1)
         ((even? n) (square (fast-expt b (/ n 2))))
         (else (* b (fast-expt b (- n 1))))))

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1 )))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (timed-prime-test n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 10)
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

                  
(search-for-primes 10000 20000 3)
; original expmod는 큰 수를 다루지 않고 successive squaring을 수행하지만 fast-expt procedure를 사용한 expmod는 successive squaring을 수행하면서 점점 더 큰 수를 다루게된다.
; arithmetic with very large numbers is much slower
; That's because the time complexity for arithmetic operations is based on the number of bits in the operands