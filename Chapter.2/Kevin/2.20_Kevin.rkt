#lang racket

;Exercise 2.20

(define (same-parity first . rest)
  (let ((first%2 (modulo first 2)))
    (define (filterFunc num)
      (if (equal? (modulo num 2) first%2)
          #t
          #f))
  (cons first (filter filterFunc rest))))

(same-parity 1 2 3 4 5 6 7)