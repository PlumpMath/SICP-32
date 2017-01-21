#lang racket

;Exercise 1.18
(println "Exercise 1.18")
(define (double x)
  (+ x x))
(define (halve x)
  (/ x 2))

(define (iter-* a b)
  (define (iterate product multiplier)
    (cond ((= multiplier 1) product)
          ((even? multiplier) (iterate (double product) (halve multiplier)))
          (else (iterate (+ a a) (- b 1)))))
  (iterate a b))

(iter-* 3 8)