#lang racket

; 뭔가 무한루프를 돌 것 같긴 한데, 정확한 terminology 로 설명은 못하겠다...

(define (f g)
  (g 2))