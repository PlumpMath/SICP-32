#lang racket

(require "2.36_LCH.rkt")

(define (dot-product v w)
  (foldr + 0 (map * v w)))
(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))
(define (transpose mat)
  (accumulate-n cons null mat)) ; foldr 이 sequence 의 마지막 element 부터 reduce 되는걸 기억하자.
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row)) m)))