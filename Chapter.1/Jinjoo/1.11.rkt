#lang racket

; recursive process

(define (func a)
  (if (< a  3 ) a
    (+ (func(- a 1)) (* 2 (func(- a 2))) (* 3 (func(- a 3))))))

;(func 4) -> 11

; iterative process

(define (func2 n)
  (f-iter 2 1 0 n))

(define (f-iter a b c count)
  (cond ((> 0 count) count)
        ((= 0 count) c)
        (else (f-iter (+ a (* 2 b) (* 3 c)) a b (- count 1)))))

(func2 4) ; 11
