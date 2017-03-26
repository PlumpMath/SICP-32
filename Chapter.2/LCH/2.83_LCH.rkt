#lang racket

; 책에서는 integer / rational / real / complex 를 다루라고 했지만, integer 는 구현 안했으므로 제낀다.
; 다른 operation 들과 마찬가지로 'raise 를 각 package 에서 put 한다.
; 그러고나서 apply-generic 을 사용해서 raise procedure 를 선언하면 된다.
; 한가지 문제점은 Figure 2.26 같이 multiple-supertypes issue 의 경우를 커버하기 힘들어진다.
; 사실 much current research 라고 책에서 언급했으므로, 이를 해결할 필요는 없다.

; 문제점 발견 : 위의 구현으로는 superior type 인 경우 raise 를 더 할 수 없음을 알리기가 힘들다.
; apply-generic 에서는 procedure 가 존재하지 않을 경우 궁극적으로 error 를 발생시키기 때문이다.

; 한가지 방법은 apply-generic 대신에 새롭게 raise-generic 을 만들고 경우를 잘 분류하는 것이다.
; raise operation 이 존재하지 않는 type 일 경우에 #f 를 반환시키는 것이다.

(require "raise.rkt")
(require "apply-generic-3.rkt")

; 테스트 준비
(define test-rational-number (make-rational 2 3))
(define test-scheme-number (apply-generic 'raise test-rational-number))
(define test-complex-number (apply-generic 'raise test-scheme-number))

; 테스트
test-rational-number
test-scheme-number
test-complex-number