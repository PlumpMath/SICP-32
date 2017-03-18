#lang racket

(define (p) (p))

(define (test x y) (if (= x 0) 0 y))

(test 0 (p)) ; applicative order eval = infinity loop -> this order call 'p' procedure repeatly before applicating test procedure

(if (= 0 0) 0 (p)) ; normal order eval = 0
