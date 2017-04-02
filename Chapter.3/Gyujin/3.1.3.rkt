#lang racket

#|
3 Modularity, Object, and State
3.1 Assignment and Local State
3.1.3 The Costs of Introducing Assignment
|#

(define (make-simplified-withdraw balance)
  (lambda (amount)
    (set! balance (- balance amount))
    balance))

(define W (make-simplified-withdraw 25))
(W 20)
(W 10)

(define (make-decrementer balance)
  (lambda (amount)
    (- balance amount)))

(define D (make-decrementer 25))
(D 20)
((make-decrementer 25) 20)
((lambda (amount) (- 25 amount)) 20)
(- 25 20)

#| A variable can no longer be simply a name,
it somehow refers to a place where a value can be stored. |#

#| Functional Programming vs Imperative Programming |#

(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))

(define (i-factorial n)
  (let ((product 1)
        (counter 1))
    (define (iter)
      (if (> counter n)
          product
          (begin (set! product (* counter product))
                 (set! counter (+ counter 1))
                 (iter))))
    (iter)))

#| Exercise 3.7 |#

(define (make-joint protected-account password additional-password)
  (lambda (p m)
      (cond ((or (eq? p password) (eq? p additional-password))
            (protected-account password m))
            (else (error "Incorrect password")))))

(define (make-protected-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
                balance)
        "Insufficient funds"))
  (define (deposit amount)
    (begin (set! balance (+ balance amount)) balance))
  (define (dispatch p m)
    (cond ((not (eq? p password)) (error "Incorrect password"))
          ((eq? m 'withdraw) withdraw)
          ((eq? m  'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)

(define peter-acc (make-protected-account 100 'thisispassword))

(define paul-acc
  (make-joint peter-acc 'thisispassword 'thisispasswordtoo))

((paul-acc 'thisispassword 'withdraw) 10)
((peter-acc 'thisispassword 'withdraw) 10)
((paul-acc 'thisispasswordtoo 'withdraw) 10)
#|((paul-acc 'blunder 'withdraw) 10)|#

#| Exercise 3.8 (ʘ言ʘ╬) |#

(define (make-f)
  (let ((x 1))
    (lambda (int)
      (begin (set! x (* x int)) x))))

(define f (make-f))

(f 1)
(f 0)
