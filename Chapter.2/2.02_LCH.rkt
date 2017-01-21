#lang racket

; point 를 우선 정의한다.
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))
; point 정의를 사용해서, segment 를 정의한다.
; 구조가 point 와 동일해진다.
(define (make-segment p1 p2) (cons p1 p2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))


; midpoint-segment procedure 를 정의한다.
(define (midpoint-segment s)
  (make-point (/ (+ (x-point (start-segment s)) (x-point (end-segment s))) 2)
              (/ (+ (y-point (start-segment s)) (y-point (end-segment s))) 2)))
; 테스트를 위한 출력 procedure 를 정의한다.
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

; 테스트
(define p1 (make-point 1 2))
(define p2 (make-point 3 4))
(define s (make-segment p1 p2))
(define mid (midpoint-segment s))
(print-point mid)