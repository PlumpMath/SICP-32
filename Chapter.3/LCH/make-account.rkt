#lang racket

; Exercise 3.7 을 위해서 password 를 확인해주는 메서드를 추가한다.

(provide make-account)

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (password-error . args)
    "Incorrect password")
  (define (dispatch pw m)
    (if (eq? m 'check-password)
        (eq? pw password)
        (if (eq? pw password)
            (cond ((eq? m 'withdraw) withdraw)
                  ((eq? m 'deposit) deposit)
                  (else (error "Unknown request: MAKE-ACCOUNT" m)))
            password-error)))
  dispatch)