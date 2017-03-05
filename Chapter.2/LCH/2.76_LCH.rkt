#lang racket

; explicit dispatch / data-directed style / message-passing style 을 비교한다.
; explicit dispatch 는 생각하고싶지 않다.
; new operation / new type 이 추가될때 뒤의 두개는 추가해야할 작업이 비슷하지 않나 생각했다.

; data-directed style : new operation 이 추가되면 install 하는 코드마다 procedure 가 하나씩 추가된다.
;                       new type 이 추가되면 install 하는 덩어리 procedure 가 하나 추가된다.
; message-passing style : new operation 이 추가되면 "intelligent data object" 마다 procedure 를 하나 추가한다.
;                         new type 이 추가되면 "intelligent data object" 이 하나 더 생긴다.                          