#lang racket
;Exercise 2.48

(define (make-vect x y)
  (cons x y))

(define (xcor-vect vector)
  (car vector))

(define (ycor-vect vector)
  (cdr vector))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2)) (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2)) (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect vector factor)
  (make-vect (* factor (xcor-vect vector)) (* factor (ycor-vect vector))))


;Segment
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect (origin-frame frame)
              (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
                        (scale-vect (ycor-vect v) (edge2-frame frame))))))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each (lambda (segment)
                (draw-line
                 ((frame-coord-map frame)
                  (start-segment segment))
                 ((frame-coord-map frame)
                  (end-segment segment))))
              segment-list)))

(define (make-segment v1 v2)
  (cons v1 v2))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

;Exercise 2.49
(define (outline-painter frame)
    (segments->painter (list (make-segment (make-vector 0 0) (make-vector 0 1))
                             (make-segment (make-vector 0 0) (make-vector 1 0))
                             (make-segment (make-vector 1 0) (make-vector 1 1))
                             (make-segment (make-vector 0 1) (make-vector 1 1))))
    frame)

(define (x-painter frame)
    (segments->painter (list (make-segment (make-vector 0 0) (make-vector 1 1))
                              (make-segment (make-vector 0 1) (make-vector 1 0))))
    frame)

(define (diamond-painter frame)
    (segments->painter (list (make-segment (make-vector 0 0.5) (make-vector 0.5 1))
                             (make-segment (make-vector 0 0.5) (make-vector 0.5 0))
                             (make-segment (make-vector 1 0.5) (make-vector 0.5 1))
                             (make-segment (make-vector 1 0.5) (make-vector 0.5 0))))
    frame)


