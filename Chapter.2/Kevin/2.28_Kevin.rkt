#lang racket

;Exercise 2.28
;NEEDS DISCUSSION
;STAR

(define (fringe tree)
  (define (iter tree answer)
    (if (null? tree)
        answer
        (if (pair? (car tree))
            (iter (cdr tree) (iter (car tree) answer))
            (iter (cdr tree) (append answer (list (car tree)))))))
  (iter tree null))

(define x (list (list 1 2) (list 3 4)))
(fringe x)