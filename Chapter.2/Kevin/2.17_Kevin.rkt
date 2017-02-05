#lang racket

;Exercise 2.17

(define (last-pair list)
  (if (or (null? list) (null? (cdr list)))
      null
      (if (null? (cdr (cdr list)))
          list
          (last-pair (cdr list)))))

(last-pair (list 1 2 3 4 5))
      