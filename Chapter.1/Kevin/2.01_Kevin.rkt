#lang racket

;Exercise 2.1
#|
Define a beer version of make-rat that han-
dles both positive and negative arguments. make-rat should
normalize the sign so that if the rational number is positive,
both the numerator and denominator are positive, and if
the rational number is negative, only the numerator is neg-
ative.
|#

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (make-rat n d)
  (if (< (* n d) 0)
      (cons (* -1 (abs n)) (abs d))
      (cons (abs n) (abs d))))
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
(newline)
(display (numer x))
(display "/")
(display (denom x)))

(define one-half (make-rat 1 2))
(print-rat one-half)
;1/2
(define one-third (make-rat 1 3))
(print-rat (add-rat one-half one-third))
;5/6
(print-rat (mul-rat one-half one-third))
;1/6
(print-rat (add-rat one-third one-third))
;6/9

(define new-one-half (make-rat -1 -2))
(print-rat new-one-half)

(define neg-one-half (make-rat 1 -2))
(print-rat neg-one-half)