#lang racket

;Exercise 2.12

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

(define (width-interval interval)
  (- (upper-bound interval) (lower-bound interval)))


(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

#|
Define a constructor make-center-percent
that takes a center and a percentage tolerance and pro-
duces the desired interval. You must also define a selector
percent that produces the percentage tolerance for a given
interval. The center selector is the same as the one shown
above.
|#

(define (make-center-percent c p)
  (make-interval (- c (* c (/ p 100))) (+ c (* c (/ p 100)))))

(define (tolerance-percent interval)
  (let ((center (/ (+ (upper-bound interval) (lower-bound interval)) 2))
        (tolerance (/ (- (upper-bound interval) (lower-bound interval)) 2)))
    (* (/ tolerance center) 100)))

(define intervalP (make-center-percent 5.0 10))
(upper-bound intervalP)
(lower-bound intervalP)
(tolerance-percent intervalP)