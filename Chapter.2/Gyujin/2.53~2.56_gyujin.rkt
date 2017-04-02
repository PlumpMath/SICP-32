#lang racket

; ##################### 2.3.1 Quotation ########################################################

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(memq 'apple '(pear apple prune))

; 2.53
(list 'a 'b 'c)
(list (list 'george))
(cdr '((x1 x2) (y1 y2)))
(cadr '((x1 x2) (y1 y2)))
(car '(a short list))
(cdr '(a short list))
(pair? (car '(a short list)))
(memq 'red '((red shoed) (blue socks)))
(memq 'red '(red shoed blue socks))

;2.54
(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))

;2.55
(define (customEqual? a b)
  (cond ((and (pair? a) (pair? b)) (and (customEqual? (car a) (car b)) (customEqual? (cdr a) (cdr b))))
        ((and (number? a) (number? b)) (= a b))
        (else (eq? a b))))
(customEqual? '(this is a list) '(this is a list))

;2.56
(car ''abracadabra)
(car (quote (quote abracadabra)))
(list 'quote 'abracadabra)
(car (list 'quote (list 'quote 'abracadabra)))

; ##################### 2.3.2 Symbolic differentiation ########################################################

(define (=number? exp num)
  (and (number? exp) (= exp num)))
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
(define (augend s) (cadr s))
(define (addend s) (caddr s))
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define (multiplicand p) (cadr p))
(define (multiplier p) (caddr p))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))

(deriv '(+ x 3) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)
