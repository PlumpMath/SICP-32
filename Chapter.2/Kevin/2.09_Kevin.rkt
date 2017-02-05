#lang racket

;Exercise 2.9

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
(mul-interval
x
(make-interval (/ 1.0 (upper-bound y))
(/ 1.0 (lower-bound y)))))

(define (make-interval a b) (cons a b))


(define (upper-bound interval)
  (if (>= (car interval) (cdr interval))
      (car interval)
      (cdr interval)))

(define (lower-bound interval)
  (if (<= (car interval) (cdr interval))
      (car interval)
      (cdr interval)))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y)) (- (upper-bound x) (lower-bound y))))


#|
The width of an interval is half of the differ-
ence between its upper and lower bounds. The width is a
measure of the uncertainty of the number specified by the
interval. For some arithmetic operations the width of the
result of combining two intervals is a function only of the
widths of the argument intervals, whereas for others the
width of the combination is not a function of the widths of
the argument intervals. Show that the width of the sum (or
difference) of two intervals is a function only of the widths
of the intervals being added (or subtracted). Give examples
to show that this is not true for multiplication or division.
|#

(define (width-interval interval)
  (- (upper-bound interval) (lower-bound interval)))

(define intervalA (make-interval 1.0 3.5))
(define intervalB (make-interval 2.7 4.7))

(println "===============================================")
(println "width-interval of A")
(width-interval intervalA)
(println "width-interval of B")
(width-interval intervalB)
(println "===============================================")


(println "===============================================")
(define added-interval (add-interval intervalA intervalB))
(println "lower-bound of added-interval")
(lower-bound added-interval)
(println "upper-bound of added-interval")
(upper-bound added-interval)
(println "width-interval of added-interval")
(width-interval added-interval)
(println "===============================================")

(println "===============================================")
(define subtracted-interval (sub-interval intervalA intervalB))
(println "lower-bound of subtracted-interval")
(lower-bound subtracted-interval)
(println "upper-bound of subtracted-interval")
(upper-bound subtracted-interval)
(println "width-interval of subtracted-interval")
(width-interval subtracted-interval)
(println "===============================================")

(println "===============================================")
(define multiplied-interval (mul-interval intervalA intervalB))
(println "lower-bound of multiplied-interval")
(lower-bound multiplied-interval)
(println "upper-bound of multiplied-interval")
(upper-bound multiplied-interval)
(println "width-interval of multiplied-interval")
(width-interval multiplied-interval)
(println "===============================================")

(println "===============================================")
(define divided-interval (div-interval intervalA intervalB))
(println "lower-bound of divided-interval")
(lower-bound divided-interval)
(println "upper-bound of divided-interval")
(upper-bound divided-interval)
(println "width-interval of divided-interval")
(width-interval divided-interval)
(println "===============================================")
