#lang racket

;Exercise 1.14
(println "Exercise 1.14")
(define (square x)
  (* x x))

;Exponentiation
(define (expt b n) (if (= n 0)
      1
      (* b (expt b (- n 1)))))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (even? n)
(= (remainder n 2) 0))