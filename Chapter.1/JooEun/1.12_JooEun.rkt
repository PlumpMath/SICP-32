#lang racket

(define (ptree x y)
  (cond ((or (= x y)(= y 1)) 1)
        (else (+ (ptree (- x 1) (- y 1)) (ptree (- x 1) y)))))

(ptree 3 2)



