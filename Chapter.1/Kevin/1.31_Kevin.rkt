#lang racket
;Exercise 1.31 - a
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))


;Product
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

;compute pi
(define (inc x)
  (+ x 1))

(define (compute-pi n)
  (define (top-term x)
    (* (cond ((= x 1) 1)
             ((even? x) (+ 1 (/ x 2)))
             (else (+ 1 (/ (- x 1) 2))))
       2))
  (define (bottom-term x)
    (- (top-term (+ x 1)) 1))
  (* 4 (/ (product top-term 1 inc n) (product bottom-term 1 inc n))))

(compute-pi 50)

;Exercise 1.31 - b
(define (product-iter term a next b) 
   (define (iter a res) 
     (if (> a b) res 
          (iter (next a) (* (term a) res)))) 
    (iter a 1)) 