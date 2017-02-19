#lang racket

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))


;normal-order evaluation  
; (if(= 0 0) 0 (p))  : 0
;applicative-order evaluation; 
; (test 0 (p)) -> (p) : infinite loop