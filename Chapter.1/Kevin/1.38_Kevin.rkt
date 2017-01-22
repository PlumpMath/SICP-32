#lang racket
;Exercise 1.38
(define (cont-frac n d k)
  (define (recur n d l)
    (if (= l k)
        (/ (n l) (d l))
        (/ (n l) (+ (d l) (recur n d (+ l 1))))))
  (recur n d 1))

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           30)

;0.618

(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1)
              (/ (n i) (+ (d i) result)))))
  (iter k 0.0))


(cont-frac-iter (lambda (i) 1.0)
                (lambda (i) 1.0)
                30)
;0.618

;Euler
(define (euler k)
  (+ 2.0 (cont-frac (lambda (i) 1.0)
                    (lambda (i)
                      (let ((mod3 (modulo i 3)))
                        (if (= mod3 2)
                            (* 2 (/ (+ i 1) 3))
                            1)))
                    k)))

(euler 30)
