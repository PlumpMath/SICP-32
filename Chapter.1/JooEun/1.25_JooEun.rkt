#lang racket
; The second version of expmod which is applied fast-expt evaluate n first
; for example
; if a = 3, n = 10
; 3^10 % 10
; 59049 % 10
; 9

; The first version of expmod call remainder every procedures.
; if a = 3, n = 10
; n = 10 -> (remainder (square 3) 10)
; n = 5 -> (remainder (* 3 1) 10)
; n = 4 -> (remainder (square 9) 10) ...

; So, the return values is stable and the process is more faster.
