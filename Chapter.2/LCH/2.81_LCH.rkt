#lang racket

; a. '(complex complex) 에 대해서 procedure 가 존재하지 않으므로 coercion 을 할텐데,
;    complex -> complex coercion 이 존재하기때문에 무한히 apply-generic 을 recursion 하게 된다.

; b. a. 에서의 분석으로 미뤄보아 Louis Reasoner 의 의견은 올바르지 않다.
