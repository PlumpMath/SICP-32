#lang racket

; recursive process
(define (f1 n)
  (cond ((< n 3) n)
        (else (+ (f1 (- n 1)) (* 2 (f1 (- n 2))) (* 3 (f1 (- n 3)))))))

(f1 0)
(f1 1)
(f1 2)
(f1 3)
(f1 4)
(f1 5)

; iterative process
(define (f2 n)
  (f-iter 2 1 0 n))

(define (f-iter c b a count)
  (if (= count 0)
      a
      (f-iter (f-compute c b a) c b (- count 1))))

(define (f-compute c b a)
  (+ (* 1 c) (* 2 b) (* 3 a)))

(f2 0)
(f2 1)
(f2 2)
(f2 3)
(f2 4)
(f2 5)