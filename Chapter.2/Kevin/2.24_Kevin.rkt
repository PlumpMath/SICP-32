#lang racket

;Exercise 2.24
;NEEDS DISCUSSION

;length: 2
;leaf: 4

(define (count-leaves x) (cond ((null? x) 0) ((not (pair? x)) 1) (else (+ (count-leaves (car x)) (count-leaves (cdr x))))))
(define (length items)
  (if (null? items)
      0
     (+ 1 (length (cdr items)))))

(length (list 1 (list 2 (list 3 4))))
(count-leaves (list 1 (list 2 (list 3 4))))


(cdr (list 1 (list 2 (list 3 4))))
(cdr (list 2 (list 3 4)))
(cdr (list 3 4))
(cdr (list 4))