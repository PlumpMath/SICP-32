#lang racket

;Exercise 2.2
#|
Consider the problem of representing line
segments in a plane. Each segment is represented as a pair
of points: a starting point and an ending point. Define a
constructor make-segment and selectors start-segment and
end-segment that define the representation of segments in
terms of points. Furthermore, a point can be represented
as a pair of numbers: the x coordinate and the y coordi-
nate. Accordingly, specify a constructor make-point and
selectors x-point and y-point that define this representa-
tion. Finally, using your selectors and constructors, define a
procedure midpoint-segment that takes a line segment as
argument and returns its midpoint (the point whose coor-
dinates are the average of the coordinates of the endpoints).
To try your procedures, you’ll need a way to print points
|#
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


(define p1 (make-point 0 0))
(define p2 (make-point 2 2))

(print-point p1)
(print-point p2)

(define seg (make-segment p1 p2))
(start-segment seg)
(end-segment seg)
(midpoint-segment seg)