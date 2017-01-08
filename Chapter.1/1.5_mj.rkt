#lang racket

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

;(print (test 0 (p))) ; This expression never ends.

(print (if (= 0 0)
 0
 p))

#|

 applicative order evaluation
(test 0 (p))
0 -> 0
(p) -> (p) -> (p) -> (p) -> ...

evaluation never ends in argument (p)

 normal-order evaluation
(test 0 (p))
(if (= 0 0)
 0
 p))
0

maybe interpreter evaluate consequent expr after conditional expr..

|#