#lang racket

;Exercise 1.16
(println "Exercise 1.15")
(define (fast-expt-iter b n)
  (define (iterate a n)
    (cond ((= n 1) a)
          ((even? n) (iterate (* a (fast-expt-iter b (/ n 2))) (/ n 2)))
          (else (iterate (* a b) (- n 1)))))
  (iterate b n))

(fast-expt-iter 3 5)