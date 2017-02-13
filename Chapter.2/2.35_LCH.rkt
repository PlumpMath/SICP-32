#lang racket

; implementation
(define (count-leaves t)
  (foldr + 0 (map
              (lambda (subtree)
                (if (pair? subtree)
                    (+ (count-leaves (cdr subtree)) 1)
                    1))
              t)))
; test
(count-leaves (list 1 (list 2 3) (list 4 5 6)))