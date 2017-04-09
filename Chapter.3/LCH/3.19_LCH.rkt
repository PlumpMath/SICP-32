#lang planet neil/sicp

; 1칸씩 뛰는 turtle 과 2칸씩 뛰는 rabbit 을 생각하면 된다.
; ----------------
;            /    \
;            \____/
;
; cycle 이 존재하는 list 에 대해서 turtle 도 cycle 에 진입한 시점을 생각한다.
; cycle 이기 때문에 turtle 이 rabbit 에 비해서 N칸 앞서있다고 생각할 수 있다.
; 매 stap 마다 turtle 과 rabbit 의 간격은 1칸씩 줄어들기 때문에 N step 후에 만나게 된다.