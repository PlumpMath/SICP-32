#lang racket

#|
prime number 이면 Fermat 소정리를 만족한다.

fast-prime? procedure 는 Fermat 소정리에 기반한다.
정해진 횟수만큼 랜덤한 정수에 대해서 Fermat 소정리가 성립하는지 확인하고,
모두 성립한다면 이를 prime number 로 간주한다.

하지만 prime number 가 아니지만, 모든 정수에 대해서 Fermat 소정리가 성립하는 숫자들이 있다.
이를 Carmichael number 라고 한다.
그러므로 fast-prime? procedure 를 속일 수 있다.

ex) 561 은 심지어 3으로 나눠지지만, Fermat 소정리를 만족한다.

|#