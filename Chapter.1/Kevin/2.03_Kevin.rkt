#lang racket

;Exercise 2.3

;Needs discussion

#|
Implement a representation for rectangles in
a plane. (Hint: You may want to make use of Exercise 2.2.) In
terms of your constructors and selectors, create procedures
that compute the perimeter and the area of a given rectan-
gle. Now implement a different representation for rectan-
gles. Can you design your system with suitable abstraction
barriers, so that the same perimeter and area procedures
will work using either representation?
|#
(define (square x)
  (* x x))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-point x y)
  (cons x y))
(define (x-point point)
  (car point))
(define (y-point point)
  (cdr point))

(define (make-segment a b)
  (cons a b))
(define (start-segment seg)
  (car seg))
(define (end-segment seg)
  (cdr seg))
(define (midpoint-segment seg)
  (define start-point (start-segment seg))
  (define end-point (end-segment seg))
  (make-point (/ (+ (x-point start-point) (x-point end-point)) 2)
              (/ (+ (y-point start-point) (y-point end-point)) 2)))
(define (segment-length seg)
  (define start-point (start-segment seg))
  (define end-point (end-segment seg))
  (sqrt (+ (square (- (x-point end-point) (x-point start-point)))
           (square (- (y-point end-point) (y-point start-point))))))

(define (make-rectangle a b)
  (cons a b))
(define (perimeter rect)
  (* (+ (segment-length (car rect)) (segment-length (cdr rect))) 2))
(define (area rect)
  (* (segment-length (car rect)) (segment-length (cdr rect))))


(define seg1 (make-segment (make-point 0 0) (make-point 2 0)))
(define seg2 (make-segment (make-point 2 0) (make-point 2 6)))

(define rect1 (make-rectangle seg1 seg2))
(perimeter rect1)
(area rect1)