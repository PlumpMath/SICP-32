#lang racket

(define (inc x) (+ x 1))
(define (square x) (* x x))

(define (double proc)
  (lambda (x) (proc (proc x))))

;(((double (double double)) inc) 5) ; 21 인게 신기하다!

; d(d(d))
; = d(dd)
; = dddd
; dddd(p)
; = ddd(pp)
; = dd(pppp)
; = d(pppppppp)
; = pppppppppppppppp
; p = inc 이므로
; +1 을 16번 하므로 5 + 16 = 21