#lang racket

; 음... pseudo random number generator 에 대해서 기억이 안난다.
; Chapter 3의 comment #6 내용을 참고해서 x_n+1 = a*x_n + b 와 같은 점화식을 파라미터로 받도록 하자.
; 라고 생각했지만 귀찮아서 구현은 counter 로 고정했다.

; 구현
(define (rand-generator)
  (let ((seed 0))
    (define (dispatch m)
      (cond ((eq? m 'generate) (begin (set! seed (+ seed 1))
                                      seed))
            ((eq? m 'reset) (lambda (new-seed) (set! seed new-seed)))
            (else (error "Unsupported method" m))))
    dispatch))

; 테스트
(define rand (rand-generator))
(rand 'generate) ; 1
(rand 'generate) ; 2
(rand 'generate) ; 3
((rand 'reset) 100)
(rand 'generate) ; 101
