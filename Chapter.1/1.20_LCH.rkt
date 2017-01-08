#lang racket

; Euclid's Algorithm
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; 잘 모르겠네.... normal 이랑 applicative 랑 if 문을 어떻게 처리하는지?
; Exercise 1.5 와 연계될 것이다.
(gcd 3 2)