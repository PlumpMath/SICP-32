#lang racket

(require "make-account.rkt")

(define (make-joint account password new-password)
  (define (password-error . args)
    "Incorrect password.")
  (define (dispatch pw m)
    (if (eq? pw new-password)
        (cond ((eq? m 'withdraw) (account password 'withdraw))
              ((eq? m 'deposit) (account password 'deposit))
              (else (error "Unknown request: MAKE-JOINT" m)))
        password-error))
  (if (account password 'check-password)
      dispatch
      (error "Password mismatch: MAKE-JOINT")))

; 테스트 준비
(define acc (make-account 100 'acc-password))
(define joint (make-joint acc 'acc-password 'joint-password))

; 테스트
((joint 'acc-password 'withdraw) 50) ; "Incorrect password."
((joint 'joint-password 'withdraw) 50) ; 50
((joint 'joint-password 'deposit) 150) ; 200