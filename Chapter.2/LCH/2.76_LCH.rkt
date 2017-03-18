#lang racket

; explicit dispatch / data-directed style / message-passing style 을 비교한다.
; 세 가지 방식 모두 type 이 T개, operation 이 O개 있다고 했을때 이를 표현하기 위한 코드의 양은 T*O 수준으로 비슷하다고 생각한다.
; 그러므로 더 나은 방법이다를 가르는 기준은, 코드를 추가할때 기존 코드를 건드리냐/아니냐로 갈린다고 생각한다.

; explicit dispatch 는 functional programming 과 유사하다.
; 새로운 operation 을 추가하는건 기존 코드를 수정하지 않아도 된다.
; 그냥 새로운 operation 을 나타내는 procedure 를 추가로 정의한다. 이 procedure 에서 type 에 따른 분기가 이뤄진다.
; 새로운 type 을 추가하기 위해서는 기존의 모든 procedure(operation) 을 수정해야 한다.

; data-directed style 은 새로운 느낌이다.
; 새로운 operation / type 을 모두 기존 코드를 건드리지않고 수행할 수 있다.
; 새로운 operation 을 추가할때는 각 type 에 대한 install procedure 를 수정해야한다고 생각했다.
; 하지만 꼭 그럴 필요는 없다. 같은 table 에 대한 put/get 을 할 수 있다면, install-type 은 그대로 두고, install-type-addition procedure 를 새롭게 정의해도 된다.
; 새로운 type 을 추가할때는 새로운 install-type procedure 를 정의하면 된다.

; message-passing style 은 object-oriented programming 과 유사하다.
; 새로운 type 을 추가하는건 새로운 intelligent data object 를 나타내는 procedure 를 추가하는 것이므로 기존 코드를 건드리지 않는다.
; 하지만 새로운 operation 을 추가하기 위해서는 type 을 나타내는 procedure 마다 코드를 추가해줘야하므로 기존 코드를 건드린다.