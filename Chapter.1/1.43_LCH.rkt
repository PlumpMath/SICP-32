#lang racket

; Hint 에서 compose procedure 를 활용하라길래 가져왔다.
(define (compose f g)
  (lambda (x) (f (g x))))
; compose procedure 활용해서, repeated procedure 를 정의.
(define (repeated f n)
  (define (repeated-iter composed n)
    (if (= n 0)
        composed
        (repeated-iter (compose f composed) (- n 1))))
  (repeated-iter (lambda (x) x) n))

; 테스트 (625)
((repeated (lambda (x) (* x x)) 2) 5)
