#lang racket

(require "2.59_LCH.rkt")

; element-of-set? 의 구현은 그대로이다. O(n)
; intersection-set 의 구현도 그대로다. O(n^2)

; O(1)
(define (adjoin-set x set)
  (cons x set))

; O(1)
(define (union-set set1 set2)
  (append set1 set2))