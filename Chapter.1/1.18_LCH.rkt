#lang racket

(define (fast-mult a b)
  (fast-mult-iter a b 0))
(define (fast-mult-iter a b mult)
  (cond ((= b 0) mult)
        ((even? b) (fast-mult-iter a (halve b) (double mult)))
        (else (fast-mult-iter a (- b 1) (+ mult a)))))
(define (even? num)
  (= (remainder num 2) 0))
(define (halve num)
  (/ num 2))
(define (double num)
  (+ num num))

(fast-mult 3 5)