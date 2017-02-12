#lang racket

;Exercise 2.5
#|
Here is an alternative procedural representa-
tion of pairs. For this representation, verify that (car (cons
x y)) yields x for any objects x and y .

What is the corresponding definition of cdr ? (Hint: To ver-
ify that this works, make use of the substitution model of
Section 1.1.5.)
|#

;; helper
(define (times-until-not-divisible num divisor)
  (let ((count 0))
    (define (iter num count)
      (if (not (= (modulo num divisor) 0))
          count
          (iter (/ num divisor) (+ count 1))))
    (iter num 0)))
        
 
;; cons, car, cdr 
(define (cons a b) (* (expt 2 a) (expt 3 b))) 
(define (car z) (times-until-not-divisible z 2)) 
(define (cdr z) (times-until-not-divisible z 3)) 
  
  
;; Usage: 
(define pair (cons 11 17)) 
(car pair) 
(cdr pair) 
  
