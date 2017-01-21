#lang racket

;Exercise 1.19
(println "Exercise 1.19")
;p` = p^2 + q^2                                      
;q` = 2pq + q^2

;Euclid's Algorithm
(define (gcd a b) (if (= b 0)
      a
      (gcd b (remainder a b))))
