#lang racket

; most-frequent :
; root node 에서 symbols 에 포함되어있는지 확인하고, ~~ O(n)
; left branch 에서 most-frequent symbol 을 확인하고, ~~ O(1)
; 바로 encoded code 를 반환하므로 ==> O(n)

; least-frequent :
; O(n) 짜리 탐색을 n-1 번 반복하므로 ==> O(n^2)