#lang racket

; O(n) 으로 union-set procedure 짜는 문제였다.

(define (union-set set1 set2)
  (define (union-set-iter set1 set2 result)
    (cond ((null? set1) (append result set2))
          ((null? set2) (append result set1))
          (else
           (let ((x1 (car set1)) (x2 (car set2)))
             (cond ((= x1 x2) (union-set-iter (cdr set1) (cdr set2) (append result (list x1))))
                   ((> x1 x2) (union-set-iter set1 (cdr set2) (append result (list x2))))
                   ((< x1 x2) (union-set-iter (cdr set1) set2 (append result (list x1)))))))))
  (union-set-iter set1 set2 '()))