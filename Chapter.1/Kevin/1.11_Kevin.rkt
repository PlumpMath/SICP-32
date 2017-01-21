#lang racket

;Exercise 1.11
(println "Exercise 1.11")
(define (f n)
  (if (< n 3)
      n
     (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

(define (f-iter n)
  (define (iterate large mid small count)
    (cond ((< count 3) count)
          ((= count 3) large)
          ((> count 3) (iterate (+ large (* 2 mid) (* 3 small)) large mid (- count 1)))))
  (iterate 4 2 1 n))

(f 5)
(f-iter 5)