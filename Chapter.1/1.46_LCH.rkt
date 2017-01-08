#lang racket

; iterative-improve procedure 정의.
(define (iterative-improve good-enough? improve)
  (define (try guess)
    (let ((next (improve guess)))
      (if (good-enough? guess next)
          next
          (try next))))
  (lambda (first-guess) (try first-guess)))

; sqrt procedure 재정의.
(define (sqrt n first-guess)
  ((iterative-improve (lambda (v1 v2) (< (abs (- v1 v2)) 0.00001))
                      (lambda (guess) (/ (+ guess (/ n guess)) 2))) first-guess))
; sqrt 간단한 테스트.
(sqrt 25 1.0)

; fixed-point procedure 재정의.
(define (fixed-point f first-guess)
  ((iterative-improve (lambda (v1 v2) (< (abs (- v1 v2)) 0.00001))
                     f) first-guess))
; fixed-point 간단한 테스트: 책에도 언급한 cos (0.7390 언저리)
(fixed-point cos 1.0)