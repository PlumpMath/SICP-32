#lang racket

(define (create-f)
  (define num 1)
  (lambda (arg) (begin (set! num (* num arg))
                       num)))

(define f1 (create-f))
(define f2 (create-f))

(+ (f1 0) (f1 1)) ; 0
(+ (f2 1) (f2 0)) ; 1

; 결론 : Racket 은 subexpression 을 left->right 로 실행한다.