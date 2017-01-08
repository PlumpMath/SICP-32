#lang racket

; square 를 쓰는 경우:
;     T[n] = T[n/2] + 1
;     결과: T[n] = O(log n)
; square 를 안쓰고 multiply 하는 경우:
;     T[n] = 2 * T[n/2]
;     결과: T[n] = O(n)