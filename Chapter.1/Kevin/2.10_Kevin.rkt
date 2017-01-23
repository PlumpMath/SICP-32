#lang racket

;Exercise 2.10

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

#|
Ben Bitdiddle, an expert systems program-
mer, looks over Alyssa’s shoulder and comments that it is
not clear what it means to divide by an interval that spans
zero. Modify Alyssa’s code to check for this condition and
to signal an error if it occurs.
|#

(define (div-interval-modified x y)
  (if (= (width-interval y) 0)
      (error "Can't divide by an interval with width of 0")
      (mul-interval
       x
       (make-interval (/ 1.0 (upper-bound y))
                      (/ 1.0 (lower-bound y))))))

(define intervalA (make-interval 1.0 3.0))
(define intervalB (make-interval 1.0 1.0))

(div-interval-modified intervalA intervalB)
  
  