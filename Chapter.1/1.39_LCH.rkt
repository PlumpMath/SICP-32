#lang racket

; J.H.Lambert 라는 수학자가 tan 의 표현식을 구해냈다.
; 1.37 에서 일단 + 를 - 로 바꿔줘야겠다.

; cont-frac 재정의.
(define (cont-frac n d k)
  (define (cont-frac-iter count current)
    (let ((next (/ (n count) (- (d count) current))))
      (if (= count 1)
          next
          (cont-frac-iter (- count 1) next))))
  (cont-frac-iter (- k 1) (/ (n k) (d k))))

; tan 를 계산해봅시다.
(define (tan-cf x k)
  (cont-frac (lambda (i) (expt x i))
             (lambda (i) (- (* i 2.0) 1.0))
             k))

; pi/4 계산하면 1.0 나와야지 ㅎㅎ
; 0.9974 에서 더 값이 좋아지지 않는다.
(tan-cf (/ pi 4) 100)