#lang racket

(define (halve n)
  (/ n 2))
(define (double n)
  (+ n n))
(define (fast-mult a b)
  (cond ((= b 0) 0)
        ((even? b) (double (fast-mult a (halve b))))
        (else (+ a (fast-mult a (- b 1))))))
(define (even? num)
  (= (remainder num 2) 0))

(fast-mult 3 5)