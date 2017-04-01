#lang racket

(require "make-account.rkt")

(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)
((acc 'some-other-password 'deposit) 50)

