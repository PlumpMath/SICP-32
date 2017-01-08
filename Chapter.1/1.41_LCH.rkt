#lang racket

(define (inc x) (+ x 1))

(define (double proc)
  (lambda (x) (proc (proc x))))

(((double (double double)) inc) 5) ; 21 인게 신기하다!