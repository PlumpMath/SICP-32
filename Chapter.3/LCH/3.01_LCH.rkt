#lang racket

; 구현
(define (make-accumulator sum)
  (define (accumulator addition)
    (begin (set! sum (+ sum addition))
           sum))
  accumulator)

; 테스트
(define A (make-accumulator 5))
(A 10) ;15
(A 10) ;25