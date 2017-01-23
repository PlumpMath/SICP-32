#lang racket

(define (make-interval a b) (cons a b))
(define lower-bound car)
(define upper-bound cdr)

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
  (make-interval (min p1 p2 p3 p4)
                 (max p1 p2 p3 p4))))
(define (div-interval x y)
  (mul-interval
   x
   (make-interval (/ 1.0 (upper-bound y))
                  (/ 1.0 (lower-bound y)))))

; Exercise 2.8
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

; Exercise 2.9
; added interval 의 width = 두 interval width 의 sum
; multiplied interval 의 width 는 간단한 arithmetic 관계가 아니다.
; [8 12] x [8 12] = [64 144] 가 된다.
; 2 x 2 != 40

; Exercise 2.10
(define (check-zero-contained x)
  (and (< (lower-bound x) 0) (> (upper-bound x) 0)))
(define (mul-interval-2 x y)
  (if (or (check-zero-contained x) (check-zero-contained y))
      (error "interval contains zero")
      (mul-interval x y)))

; Exercise 2.11
; mul-interval 에 대한 9가지 경우의 수를 고려하라는 문제다.
; 각 interval 이 (음, 음) / (음, 양) / (양, 양) 이 가능하므로 9가지인가보다.
; 귀찮으므로 스킵한다.

; Exercise 2.12
; percentage tolerance 에 대한 getter/setter 를 제공하는 문제다.
; 이 또한 귀찮으므로 스킵한다.

; Exercise 2.13
; 수식 계산해보면 percentage tolerance 에 대해서는 mul / div interval 연산에서 tolernace 가 간단한 관계로 나온다.

; Exercise 2.14
; add / sub interval 을 위해서는 본래 interval 을 쓰는게 좋고,
; mul / div interval 을 위해서는 percentage tolerance 를 쓰는게 좋다.
; 병렬연결된 저항의 합성저항을 계산하려면, 두 representation 을 혼용해야하므로 계산하기 힘들다.
; 스킵한다.

; Exercise 2.15 / Exercise 2.16
; 굉장히 수학적이라서 스킵한다.