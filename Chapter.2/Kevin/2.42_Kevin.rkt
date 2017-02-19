#lang racket
(define (filter predicate sequence)
  (cond ((null? sequence) null)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high) (if (> low high) null (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq) (accumulate append null (map proc seq)))

;Exercise 2.42

(define (adjoin-position new-row col rest-of-queens)
      (cons (list col new-row) rest-of-queens))

(define empty-board null)

(define (vertical col position)
  (equal? (car position) col))

(define (horizontal row position)
  (equal? (cadr position) row))

(define (diagonal col row position)
  (let ((position-col (car position))
        (position-row (cadr position)))
    (or (equal? (- row position-row) (- col position-col))
        (equal? 0 (+ (- row position-row) (- col position-col))))))
  

(define (safe? col positions)
  (let ((row (car (cdr (car (filter (lambda (position)
                         (equal? (car position) col))
                       positions))))))
    (null? (filter (lambda (other-queen-position)
                     (or (vertical col other-queen-position)
                         (horizontal row other-queen-position)
                         (diagonal col row other-queen-position)))
                   (cdr positions)))))
  
  

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter (lambda (positions) (safe? k positions))
                (flatmap (lambda (rest-of-queens)
                           (map (lambda (new-row)
                                  (adjoin-position new-row k rest-of-queens))
                                (enumerate-interval 1 board-size)))
                         (queen-cols (- k 1))))))
  (queen-cols board-size))

(queens 8)