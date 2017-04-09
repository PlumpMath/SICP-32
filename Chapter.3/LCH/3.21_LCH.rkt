#lang racket

(require "queue.rkt")

; print-queue 구현
(define (print-queue queue)
  (display (front-ptr q1)))

; queue 준비
(define q1 (make-queue))
(insert-queue! q1 'a)
(insert-queue! q1 'b)
(insert-queue! q1 'c)

; 실습
(display (front-ptr q1))