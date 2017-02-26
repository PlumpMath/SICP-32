#lang racket
(define (prime? n) (= n (smallest-divisor n)))

(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square n) (* n n))

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
  (newline)
  (display "***")
  (newline)
  (display elapsed-time))

(define (search-for-primes min max count)
  (when (and (< min max) (> count 0))
    (if (timed-prime-test min)
        (search-for-primes (+ min 2) max (- count 1))
        (search-for-primes (+ min 2) max count))))
                          
(search-for-primes 1001 9999 3)
(search-for-primes 10001 99999 3)
(search-for-primes 100001 999999 3)

;1009
;***
;0.33203125
;1013
;***
;0.07080078125
;1019
;***
;0.068115234375
;10007
;***
;0.073974609375
;10009
;***
;0.072021484375
;10037
;***
;0.071044921875
;100003
;***
;0.089111328125
;100019
;***
;0.0869140625
;100043
;***
;0.088134765625
; not be squarted time

  