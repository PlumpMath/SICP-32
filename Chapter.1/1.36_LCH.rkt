#lang racket

; approximation 들을 출력하도록 fixed-point procedure 를 재정의.
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (average v1 v2)
    (/ (+ v1 v2) 2))
  (define (try guess count)
    (display "guess ")
    (display count)
    (display ": ")
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try (average guess next) (+ count 1)))))
  (try first-guess 0))

; 그냥하면 33번째 guess 에서 4.555540912917957 로 종료.
; average damping 하면 9번째 guess 에서 4.555537551999825 로 종료.
; 확실히 average damping 이 더 빠르다.
(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)