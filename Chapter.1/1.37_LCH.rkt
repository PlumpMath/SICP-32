#lang racket

; cont-frac 정의
(define (cont-frac n d k)
  (define (cont-frac-iter count current)
    (let ((next (/ (n count) (+ (d count) current))))
      (if (= count 1)
          next
          (cont-frac-iter (- count 1) next))))
  (cont-frac-iter (- k 1) (/ (n k) (d k))))

; 테스트 (0.61803398875)
; k=11 부터 0.6180... 으로 유효숫자 4자리 맞춘다.
(define k 11)
(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           k)