#lang racket

(define (equal? x y)
  (if (pair? x)
      (if (pair? y)
          (and (eq? (car x) (car y)) (equal? (cdr x) (cdr y)))
          #f)
      (if (pair? y)
          #f
          (eq? x y))))