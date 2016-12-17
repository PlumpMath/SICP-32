#lang racket

(define (fast-expt b n)
  (fast-expt-iter b n 1))
(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
        ((even? n) (fast-expt-iter b (/ n 2) (square a)))
        (else (fast-expt-iter b (- n 1) (* b a)))))
(define (even? n)
  (= (remainder n 2) 0))
(define (square n)
  (* n n))

(fast-expt 3 5)