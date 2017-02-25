#lang racket

; Lisp uses applicative order evaluation. this will evaluate arguments first.
; (square (expmod base (/ exp 2) m)) -> (square ***)
; So, if square procedure not be provided,
; (* (expmod base (/ exp 2) m) (expmod base (/ exp 2) m))
; Lisp will evaluate arguments twice