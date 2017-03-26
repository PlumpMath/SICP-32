#lang racket

; Racket 은 [0.0, 1.0) 구간의 랜덤 실수를 반환하는 random procedure 가 있는듯.

; 구현
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (* (random) range))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1)
                 trials-passed))))
  (iter trials 0))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (let ((experiment (lambda () (P (random-in-range x1 x2) (random-in-range y1 y2)))))
    (* (- x2 x1) (- y2 y1) (monte-carlo trials experiment))))

; 테스트 준비
(define (square x) (* x x))
(define predicate-circle (lambda (x y) (<= (+ (square (- x 5)) (square (- y 7))) 9)))

; 테스트
; 참값 ~ 28.27
; 실험값 ~ 28.25
(estimate-integral predicate-circle 2.0 8.0 4.0 10.0 1000000)