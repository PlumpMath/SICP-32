#lang racket

(define (search-for-primes min max count)
  (when (and (< min max) (> count 0))
    (if (fast-prime? min 3 (current-inexact-milliseconds))
        (search-for-primes (+ min 2) max (- count 1))
        (search-for-primes (+ min 2) max count))))

(define (fast-prime? n times start-time)
  (cond ((= times 0)
         (begin
           (newline)
           (display n)
           (report-prime (- (current-inexact-milliseconds) start-time))
           true))
        ((fermat-test n) (fast-prime? n (- times 1) start-time))
        (else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else
         (remainder (* base (expmod base (- exp 1) m)) m))))

(define (even? n)
  (= (remainder n 2) 0))

(define (square n) (* n n))

(define (report-prime elapsed-time)
  (newline)
  (display "***")
  (newline)
  (display elapsed-time))

(search-for-primes 1001 9999 3)
(search-for-primes 10001 99999 3)
(search-for-primes 100001 999999 3)

;1st ex

;1009
;***
;0.262939453125
;1013
;***
;0.037109375
;1019
;***
;0.033935546875
;10007
;***
;0.0419921875
;10009
;***
;0.0361328125
;10037
;***
;0.035888671875
;100003
;***
;0.0380859375
;100019
;***
;0.037841796875
;100043
;***
;0.037109375

;2nd ex

;1009
;***
;0.53515625
;1013
;***
;0.076171875
;1019
;***
;0.072021484375
;10007
;***
;0.0791015625
;10009
;***
;0.073974609375
;10037
;***
;0.072021484375
;100003
;***
;0.076171875
;100019
;***
;0.072998046875
;100043
;***
;0.073974609375

; The difference of time between the case is too large.
; because of expmod's arg which is ramdom

