#lang racket

; expmod procedure 를 fast-expt procedure 를 활용해서 구현할 수 있지 않냐는 얘기다.
; 그럴수도 있다. 하지만 굳이 그럴 필요가 없다.
; 정확히 pow(base, exp) 를 계산해서 m 으로 나눠도 값은 정확히 나오겠지만,
; pow(base, exp) 를 계산하는게 낭비다.
; remainder 값만 계산하면 충분하기 때문이다.