#lang racket

; 사용된 primitives
; 1) symbol? x
; 2) eq? v1 v2
; 3) number? x

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (exponent exp)
                       (make-product (make-exponentiation (base exp) (- (exponent exp) 1))
                                     (deriv (base exp) var))))
        (else
         (error "unknown expression type: DERIV" exp))))

; predicates
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num) (and (number? exp) (= exp num)))
(define (sum? x) (and (pair? x) (eq? (car x) '+)))
(define (product? x) (and (pair? x) (eq? (car x) '*)))
(define (exponentiation? x) (and (pair? x) (eq? (car x) '**)))

; selectors
(define (addend s) (cadr s))
(define (augend s)
  (if (< (length (cddr s)) 2)
      (caddr s)
      (append '(+) (cddr s))))
(define (multiplier p) (cadr p))
(define (multiplicand p)
  (if (< (length (cddr p)) 2)
      (caddr p)
      (append '(*) (cddr p))))
(define (base x) (cadr x))
(define (exponent x) (caddr x))

; constructors
(define (make-sum . args)
  (cond ((< (length args) 2) (error "summation needs at least two arguments"))
        ((> (length args) 2) (make-sum (car args) (apply make-sum (cdr args))))
        ((=number? (car args) 0) (cadr args))
        ((=number? (cadr args) 0) (car args))
        ((and (number? (car args)) (number? (cadr args))) (+ (car args) (cadr args)))
        (else (list '+ (car args) (cadr args)))))

(define (make-product . args)
  (cond ((< (length args) 2) (error "production needs at least two arguments"))
        ((> (length args) 2) (make-product (car args) (apply make-product (cdr args))))
        ((or (=number? (car args) 0) (=number? (cadr args) 0)) 0)
        ((=number? (car args) 1) (cadr args))
        ((=number? (cadr args) 1) (car args))
        ((and (number? (car args)) (number? (cadr args))) (* (car args) (cadr args)))
        (else (list '* (car args) (cadr args)))))

(define (make-exponentiation base exponent)
  (cond ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        (else (list '** base exponent))))

(deriv '(* x y (+ x 3)) 'x)