#lang racket
;Exercise 2.38
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest)) (cdr rest))))
  (iter initial sequence))

(define (fold-right op initial sequence)
  (accumulate op initial sequence))

(fold-left / 1 (list 1 2 3))
(fold-right / 1 (list 1 2 3))

(fold-right list null (list 1 2 3))
(fold-left list null (list 1 2 3))