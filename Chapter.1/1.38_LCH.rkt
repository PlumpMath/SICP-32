#lang racket

; cont-frac 정의
(define (cont-frac n d k)
  (define (cont-frac-iter count current)
    (let ((next (/ (n count) (+ (d count) current))))
      (if (= count 1)
          next
          (cont-frac-iter (- count 1) next))))
  (cont-frac-iter (- k 1) (/ (n k) (d k))))

; euler number 계산 (2.718281828459045)
; 2.72 정도에서 수렴이 잘 안된다.
(+ 2 (cont-frac (lambda (i) 1.0)
           (lambda (i)
             (cond ((= i 1) 1.0)
                   ((= i 2) 2.0)
                   (else (if (= (remainder i 3) 2)
                             (/ (+ i 1) 3.0)
                             1.0))))
           100000))