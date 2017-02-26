#lang racket

(define (square a) (* a a))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

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

;(search-for-primes 1000000 2000000 3)
;1000003 *** 0.48486328125
;1000033 *** 0.114990234375
;1000037 *** 0.10302734375
                  
;(search-for-primes 100000000 200000000 3)
;100000007 *** 0.403076171875
;100000037 *** 0.123046875
;100000039 *** 0.114013671875

; 얼마 차이나지 않음.
; the expmod procedure has a logarithmic time complexity.