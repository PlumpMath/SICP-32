#lang racket

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(gcd 206 40)

; normal-order evaluation.
; (gcd 206 40)
; if a = 206
; else
; (gcd 40 (remainder 206 40))
; if a = (remainder 206 40)
; else = (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))
; ...
; 2
; remainder is performed 18 times.


; applicative-order evaluation.
; (gcd 206 40)
; if a = 206
; else b = 
; (gcd 40 remainder(206 40)) = (gcd 40 6)
; (gcd 6 reaminder(40 6)) = (gcd 6 4)
; (gcd 4 remainder(6 4)) = (gcd 4 2)
; (gcd 2 remainder(4 2)) = (gcd 2 0)
; 2
; remainder is only performed 4 times.
