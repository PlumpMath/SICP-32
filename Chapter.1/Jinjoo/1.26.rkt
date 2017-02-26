#lang racket

(define (square a) (* a a))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1 )))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (start-prime-test n start-time)
  (if (fast-prime? n 10)
      (begin
        (newline)
        (display n)
        (report-prime (- (current-inexact-milliseconds) start-time))
        #true)
      #false))

(define (timed-prime-test n)
  (start-prime-test n (current-inexact-milliseconds)))


(define (search-for-primes start end count)
  (when (and (< start end) (< 0 count))
    (if (timed-prime-test start)
        (search-for-primes (+ start 1) end (- count 1))
        (search-for-primes (+ start 1) end count))))


(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))


; O(log n) process
; cause only once when expmod is passed as the single argument to square.

(define (expmod2 base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

 ; cause twice as many calls to expmod.
 ; because each input argument to * will be evaluated separately.

(search-for-primes 1000000 2000000 3)


;1000003 *** 3.052978515625
;1000033 *** 0.112060546875
;1000037 *** 0.10205078125


;1000003 *** 6.14306640625
;1000033 *** 0.136962890625
;1000037 *** 0.116943359375






