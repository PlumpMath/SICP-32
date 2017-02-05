#lang racket

;Exercise 2.23
(define (for-each pred list)
  (define (iter list)
    (cond
      ((null? list) null)
      (else (pred (car list))
            (iter (cdr list)))))
  (iter list))

(for-each (lambda (x)
            (newline)
            (display x))
          (list 1 2 3))