#lang racket

; smooth 부터 정의.
(define dx 0.00001)
(define (smooth f) (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3)))

; linear function 은 smooth 해도 결과가 그대로다.
((smooth (lambda (x) (+ (* 2 x) 3))) 5)

; 그냥 repeated 에 파라미터로 smooth 때리면, n-fold smoothed function 이 만들어질것 같은데?