#lang racket

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame
                  new-origin
                  (sub-vect (m corner1) new-origin)
                  (sub-vect (m corner2) new-origin)))))))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left (transform-painter painter1 (make-vect 0.0 0.0) split-point (make-vect 0.0 1.0)))
          (paint-right (transform-painter painter2 split-point (make-vect 1.0 0.0) (make-vect 0.5 1.0))))
      (lambda (frame) (paint-left frame) (paint-right frame)))))

;Exercise 2.52
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-below (transform-painter painter1 (make-vect 0.0 0.0) (make-vect 1.0 0.0) split-point))
          (paint-up (transform-painter painter1 split-point (make-vect 1.0 0.5) (make-vect 0.0 1.0))))
      (lambda (frame) (paint-below frame) (pain-up frame)))))

 (define (below-2 painter1 painter2) 
   (rotate90 (beside (rotate270 painter1) (rotate270 painter2))))