#lang racket
(define (even? n) (= (remainder n 2) 0))
(define (square n) (* n n))

(define (fast-expt b n)
  (fast-expt-iter b n 1))

(define (fast-expt-iter b counter product)
  (cond ((= 0 counter) product)
        ((even? counter) (fast-expt-iter (square b) (/ counter 2) product))
        (else (fast-expt-iter b (- counter 1) (* product b)))))

(fast-expt 2 4)