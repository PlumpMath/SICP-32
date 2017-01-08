#lang racket

(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

(sine 12.15)

; procedure 도중에 어떻게 console 에 출력할 수 있을까?
; a. 5회 (12.15 / 243 < 0.1)
; b. number of steps ~ O(log n)
; b. space ~ O(log n)
; recursive process 이므로 number of steps 랑 space 랑 order of growth 가 동일하지 않을까?