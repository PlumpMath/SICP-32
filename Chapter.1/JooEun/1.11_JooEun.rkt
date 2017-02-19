#lang racket

; recursive process

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

(f 4) ; 25

; iterative process

(define (f2 n)
  (f-iter 2 1 0 n))

(define (f-iter a b c count)
  (cond ((> 0 count) count)
        ((= 0 count) c)
        (else (f-iter (+ a (* 2 b) (* 3 c)) a b (- count 1)))))

(f2 4) ; 25