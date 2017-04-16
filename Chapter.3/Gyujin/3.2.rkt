#lang racket

((lambda (balance)
  (lambda (amount)
         (if (>= balance amount)
             (begin (set! balance (- balance amount))
                    balance)
             "Insufficient funds")))
 initial-amount)

