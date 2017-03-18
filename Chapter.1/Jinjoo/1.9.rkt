#lang racket
(define (inc a) (+ a 1))
(define (dec a) (- a 1))

; recurive proces

;(define (+ a b)
;  (if (= a 0)
;      b
;      (inc (+ (dec a) b))))

; (inc (+ (dec 4) 5))
; (inc (+ (3) 5))
; (inc ((inc (+ (dec 3) 5))))
; (inc ((inc (+ (2) 5))))
; (inc ((inc ((inc (+ (dec 2) 5))))))
; (inc ((inc ((inc (+ (1) 5))))))
; (inc ((inc ((inc ((inc (+ (dec 1) 5))))))))
; (inc ((inc ((inc ((inc (+ (0) 5))))))))
; (inc ((inc ((inc ((inc 5)))))))
; (inc ((inc ((inc (6))))))
; (inc ((inc (7))))
; (inc (8))))
; 9

; iterative process

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))
; (+ (dec 4) (inc 5))
; (+ (3) (6))
; (+ (dec 2) (inc 7))
; (+ (1) (8))
; (+ (dec 1) (inc 8))
; (+ (0) (9))
; 9

(+ 4 5)