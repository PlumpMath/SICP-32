#lang racket

#|
golden ratio : phi^2 = phi + 1
적당히 변환한 관계식 : phi = 1 + (1 / phi)
|#

; fixed-point procedure 정의.
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; golden-ratio 값 정의
(define golden-ratio
  (fixed-point (lambda (phi) (+ 1 (/ 1 phi)))1.0))

; 확인 (1.61803398875)
(display "golden ratio: ")
(display golden-ratio)