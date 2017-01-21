#lang racket
;Exercise 1.5
(println "Exercise 1.5")
(define (p) (p))
(define (test x y) (if (= x 0) 0 y))

(display "
Exercise 1.5
 In applicative order (test 0 (p)) never terminates,
 because in trying to evaluate (p) first and then apply 'test' procedure,
 (p) does not end.

 However, in normal order evaluation, it is first expanded like this,
 (test 0 (p))
 (if (= 0 0) 0 (p))
 (if #t 0 (p))

 and then start evaluating, which will return 0
")