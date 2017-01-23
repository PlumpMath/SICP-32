#lang racket

;Exercise 2.11

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
In passing, Ben also cryptically comments:
“By testing the signs of the endpoints of the intervals, it is
possible to break mul-interval into nine cases, only one
of which requires more than two multiplications.” Rewrite
this procedure using Ben’s suggestion.
|#

  
 (define (mul-interval-modified x y) 
   (define (positive? x) (>= x 0)) 
   (define (negative? x) (< x 0)) 
   (let ((xl (lower-bound x)) 
         (xu (upper-bound x)) 
         (yl (lower-bound y)) 
         (yu (upper-bound y))) 
     (cond ((and (positive? xl) (positive? yl)) 
            (make-interval (* xl yl) (* xu yu))) 
           ((and (positive? xl) (negative? yl)) 
            (make-interval (* xu yl) (* (if (negative? yu) xl xu) yu))) 
           ((and (negative? xl) (positive? yl)) 
            (make-interval (* xl yu) (* xu (if (negative? xu) yl yu)))) 
           ((and (positive? xu) (positive? yu)) 
            (let ((l (min (* xl yu) (* xu yl))) 
                  (u (max (* xl yl) (* xu yu)))) 
              (make-interval l u))) 
           ((and (positive? xu) (negative? yu)) 
            (make-interval (* xu yl) (* xl yl))) 
           ((and (negative? xu) (positive? yu)) 
            (make-interval (* xl yu) (* xl yl))) 
           (else 
            (make-interval (* xu yu) (* xl yl)))))) 
