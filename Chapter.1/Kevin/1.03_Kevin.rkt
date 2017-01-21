#lang racket
;square
(define (square x) (* x x))

;Exercise 1.3
(display "Exercise 1.3")
(display "Define a procedure that takes three numbers as arguments and returns the sum
of the squares of the two larger numbers.")
(define (sumOfTwoLargeNumbers a b c)
  (cond ((and (< a b) (< a c)) (+ (square b) (square c)))
        ((and (< b c) (< b a)) (+ (square a) (square c)))
        ((and (< c a) (< c b)) (+ (square a) (square b)))))

(println "sum of two large numbers, 5 3 2")
(sumOfTwoLargeNumbers 5 3 2)