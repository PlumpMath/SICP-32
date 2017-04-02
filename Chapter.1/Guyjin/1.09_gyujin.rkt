#lang racket

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

(+ 2 3)
(inc (+ 1 3))
(inc (inc (+ 0 3)))
(inc (inc 3))
(inc 4)
5

; Linear recursive process 

(define (add a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

(add 2 3)
(+ 1 4)
(+ 0 5)
5

; Iterative process

