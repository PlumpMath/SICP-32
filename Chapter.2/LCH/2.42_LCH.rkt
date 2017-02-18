#lang racket

(require "2.40_LCH.rkt")

(define (flatmap proc seq)
  (foldr append null (map proc seq)))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        ;(list empty-board)
        null
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (safe? k positions) (foldl (lambda (x y) (and x y)) true
                                   (map
                                    (lambda (position)
                                      (and (not (= (+ (car position) (- (cadr positions) (cdr position))) (caar positions)))
                                           (not (= (- (car position) (- (cadr positions) (cdr position))) (caar positions)))))
                                    (cdr positions))))
(define (adjoin-position new-row k rest-of-queens)
  (map (lambda (position) (cons (cons new-row k) position)) rest-of-queens))
()