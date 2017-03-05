#lang racket

;(define (deriv exp var)
;  (cond ((number? exp) 0)
;        ((variable? exp)
;         (if (same-variable? exp var) 1 0))
;        ((sum? exp)
;         (make-sum (deriv (addend exp) var)
;                   (deriv (augend exp) var)))
;        ((product? exp)
;         (make-sum (make-product
;                    (multiplier exp)
;                    (deriv (multiplicand exp) var))
;                   (make-product
;                    (deriv (multiplier exp) var)
;                    (multiplicand exp))))
;        ; more rules can be added here
;        (else (error "unknown expression type: DERIV " exp))))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

; a. number? variable? procedure 는 expression 의 operator 에 대한 generic 이 아니다.
; b~c. get / set procedure 가 없으니까 맛이 안나네~~~ 3절을 먼저 봐야하나 ㅎㅎ
; d. table 에서 operator / exp 순서 바뀐다고 많은게 바뀌지는 않을 것 같은데?
;    그에 맞춰서 set 에도 순서를 바꾸면 될 것이다.

