#lang racket

;Exercise 2.29
;NEEDS DISCUSSION
;STAR

(define (make-mobile left right) (list left right))
(define (make-branch length structure) (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr (mobile))))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr (branch))))

(define (weight branch)
  (if (equal? (branch-length branch) 1)
      (branch-structure branch)
      (weight (branch-structure branch))))

(define (total-weight mobile)
  (+ (weight (left-branch mobile))
     (weight (right-branch mobile))))

(define (balanced? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (if (equal? (* (branch-length left) (weight left)) (* (branch-length right) (weight right)))
            #t
            #f)))

;Exercis 2.30
;Suppose we change the representation of mobiles so that the constructors are

;(define (make-mobile left right) (cons left right)) (define (make-branch length structure) (cons length structure))

;How much do you need to change your programs to convert to the new representation?


;Answer: Not very much, because only few procedures are directly related to the implementation details.
            