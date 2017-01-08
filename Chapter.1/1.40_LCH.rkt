#lang racket

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

; deriv procedure 정의.
(define dx 0.00001)
(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

; newton-transform procedure 정의.
(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

; newtons-method procedure 정의.
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

; cubic procedure 정의.
(define (cubic a b c)
  (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))

; 테스트 (-1.0)
(newtons-method (cubic 1 1 1) 0.0)