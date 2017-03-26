#lang racket

(require "table.rkt")

(require "rational-number-package.rkt")
(require "scheme-number-package.rkt")
(require "complex-number-package.rkt")

(require "apply-generic-3.rkt")

(provide make-rational make-scheme-number)

(define (install-raise-operation)
  (define (rational-to-scheme rational-number)
    (make-scheme-number (/ (car rational-number) (cdr rational-number))))
  (define (scheme-to-complex scheme-number)
    (make-complex-from-real-imag scheme-number 0))
  (put 'raise '(rational) rational-to-scheme)
  (put 'raise '(scheme-number) scheme-to-complex))

(install-raise-operation)