#lang racket

#|
3 Modularity, Object, and State
3.1 Assignment and Local State
3.1.1 Local State Variables
|#

(define balance 100)

(define (withdraw amount)
  (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))

(withdraw 25)
(withdraw 25)
(withdraw 60)

#| begin, set! |#

(define new-withdraw
  (let ((balance 100))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insuffiecient funds"))))


(new-withdraw 25)
(new-withdraw 25)
(new-withdraw 60)

#| made a new environment with "let" and define variable balance in there |#

(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))
(define W1 (make-withdraw 100))
(define W2 (make-withdraw 100))

(W1 50)
(W2 70)
(W2 40)
(W1 40)

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
                balance)
        "Insufficient funds"))
  (define (deposit amount)
    (begin (set! balance (+ balance amount)) balance))
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m  'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)

(define acc (make-account 100))
((acc 'withdraw) 50)
((acc 'withdraw) 60)
((acc 'deposit) 40)
((acc 'deposit) 60)
(define acc2 (make-account 100))

#| Exercise 3.1 |#

(define (make-accumulator initial)
  (lambda (amount)
    (begin (set! initial (+ initial amount))
           initial)))

(define A (make-accumulator 5))
(A 10)
(A 10)

#| Exercise 3.2 |#

(define (make-monitored procedure)
  (let ((count 0)) 
    (lambda (input)
      (cond ((eq? input 'how-many-calls?) count)
            ((eq? input 'reset-count) (begin (set! count 0) "Reset"))
            (else (begin (set! count (+ count 1)) (procedure input)))))))

(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls?)

#| Exercise 3.3 |#

#|
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

(define acc3 (make-protected-account 100 'secret-password))
((acc3 'secret-password 'withdraw) 40)
((acc3 'blunder 'deposit) 50)
|#

#| Exercise 3.4 |#

(define (call-the-cops m) (error "Freeze!"))

(define (refuse m) "Incorrect passord")

(define (make-protected-account balance password)
  (let ((login-trial-count 0))
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))
    (define (deposit amount)
      (begin (set! balance (+ balance amount)) balance))
    (define (dispatch p m)
      (cond ((not (eq? p password))
             (cond ((>= login-trial-count 7) call-the-cops)
                   (else (begin (set! login-trial-count (+ login-trial-count 1))
                                refuse))))
            ((eq? m 'withdraw) withdraw)
            ((eq? m  'deposit) deposit)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    dispatch))

(define acc3 (make-protected-account 100 'secret-password))
((acc3 'secret-password 'withdraw) 40)
((acc3 'blunder 'deposit) 50)
((acc3 'blunder 'deposit) 50)
((acc3 'blunder 'deposit) 50)
((acc3 'blunder 'deposit) 50)
((acc3 'blunder 'deposit) 50)
((acc3 'blunder 'deposit) 50)
((acc3 'blunder 'deposit) 50)
((acc3 'blunder 'deposit) 50)