#lang racket

(define (sum_squares_of_two_larger x y z)
  (cond ((> x y)
         (cond ((> y z) (sum_squares x y))
               ((= y z) (sum_squares x y))
               ((< y z) (sum_squares x z))))
        ((= x y)
         (cond ((> y z) (sum_squares x y))
               ((= y z) (sum_squares x y))
               ((< y z) (sum_squares y z))))
        ((< x y)
         (cond ((> x z) (sum_squares x y))
               ((= x z) (sum_squares x y))
               ((< x z) (sum_squares y z))))))
(define (sum_squares p q)
  (+ (* p p) (* q q)))

(sum_squares_of_two_larger 3 1 2) ; 13