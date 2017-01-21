#lang racket

;Exercies 1.17
(println "Exercise 1.17")
(define (double x)
  (+ x x))

(define (halve x)
  (/ x 2))

(define (fast-* a b)
  (cond ((= b 0) 0)
        ((even? b) (fast-* (double a) (halve b)))
        (else (+ a (fast-* a (- b 1))))))

(fast-* 5 3)