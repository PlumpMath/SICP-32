#lang racket
;Exercise 2.45
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(define (split op1 op2)
  (define (split-operation painter n)
    (if (=n 0)
        painter
        (let ((smaller (split-operation painter (- n 1))))
          (op1 painter (op2 smaller smaller)))))
  split-operation)