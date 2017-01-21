#lang racket
;Exercise 1.4
(println "Exercise 1.4")
(println "operators can be compound expressions")
(define (a-plus-abs-b a b) ((if (> b 0) + -) a b))
(a-plus-abs-b 3 -5)