#lang racket
;Exercise 2.35
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree)) (enumerate-tree (cdr tree))))))

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(define (count-leaves-acc t)
  (accumulate + 0 (map (lambda (x) (if (null? x)
                                       0
                                       1))
                       (enumerate-tree t))))

(count-leaves (list 1 (list 2 3) 4))
(count-leaves-acc (list 1 (list 2 3) 4))