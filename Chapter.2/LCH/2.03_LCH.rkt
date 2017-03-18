#lang racket

; perimeter / area 를 계산하는 procedure 정의
(define (perimeter rect)
  (* 2 (+ (x-length rect) (y-length rect))))
(define (area rect)
  (* (x-length rect) (y-length rect)))

; compound data 정의
(define (make-interval start end) (cons start end))
(define (make-rect x-interval y-interval) (cons x-interval y-interval))
(define (x-length rect) (- (cdr (car rect)) (car (car rect))))
(define (y-length rect) (- (cdr (cdr rect)) (car (cdr rect))))

; 테스트
(define r (make-rect (make-interval 2 5) (make-interval -1 7)))
(perimeter r) ; 22
(area r) ; 24
