#lang racket

;Exercise 2.19

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount (except-first-denomination coin-values))
            (cc (- amount (first-denomination coin-values)) coin-values)))))

(define (except-first-denomination coin-list)
  (cdr coin-list))

(define (first-denomination coin-list)
  (car coin-list))

(define (no-more? coin-list)
  (null? coin-list))


(define us-coins (list 25 10 50 1 5))
(define uk-coins (list 100 20 50 10 5 2 1 0.5))

(cc 100 uk-coins)