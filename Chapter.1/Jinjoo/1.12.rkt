#lang racket

(define (pascal row col)
  (if (or (= row col) (= col 1))
      1
      (+ (pascal (- row 1) (- col 1)) (pascal (- row 1) col))))

(pascal 5 3)

  