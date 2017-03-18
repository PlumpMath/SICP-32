#lang racket
(define (gcd a b)
  (if (= b 0) a
      (gcd b (remainder a b))))

; normal order
; gcd(206 40)
; gcd(40 (remainder 206 40)) remainder++;
; -> remainder ++ -> for if conditioal expression
; gcd((remainder 206 40) (remainder 40 (remainder 206 40))) ....
; count = 18 -> b'cuz of if predicate evaluation


; applicative order
; gcd(206 40)
; remainder ++
; gcd(40 6)
; remainder ++
; gcd(6 4)
; remainder ++ 
; gcd(4, 2)
; remainder ++
; gcd(2, 0)
; return 2
; count = 4