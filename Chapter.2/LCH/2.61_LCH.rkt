#lang racket

; 맞게 짜기는 했는데, append 를 사용하려면 element -> singleton list 로 만들어야하는게 번거롭다.
; 다른 사람들은 어떻게 했을까?

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set (cdr set1)
                                          (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((> x1 x2)
               (intersection-set set1 (cdr set2)))))))

(define (adjoin-set x set)
  (define (adjoin-set-iter x prev remained)
    (cond ((null? remained) (append prev (list x)))
          ((< x (car remained)) (append prev (list x) remained))
          (else (adjoin-set-iter x (append prev (list (car remained))) (cdr remained)))))
  (adjoin-set-iter x '() set))