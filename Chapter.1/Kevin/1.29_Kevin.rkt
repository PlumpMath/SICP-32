#lang racket
;Exercise 1.29
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc n) (+ n 1))

(define (simpsons-rule f a b n)
  (define h (/ (- b a) n)) 
  (define (yk k) (f (+ a (* h k)))) 
  (define (simpson-term k) 
    (* (cond ((or (= k 0) (= k n)) 1) 
             ((odd? k) 4) 
             (else 2)) 
       (yk k))) 
  (* (/ h 3) (sum simpson-term 0 inc n))) 