#lang racket

; implementation
(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (subset) (cons (car s) subset)) rest)))))

; test
(subsets (list 1 2 3))