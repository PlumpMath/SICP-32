#lang racket

(provide put get put-coercion get-coercion)

(define *op-table* (make-hash))
(define *coercion-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))
(define (get op type)
  (hash-ref *op-table* (list op type) null))
(define (put-coercion type1 type2 proc)
  (hash-set! *coercion-table* (list type1 type2) proc))
(define (get-coercion type1 type2)
  (hash-ref *coercion-table* (list type1 type2) null))