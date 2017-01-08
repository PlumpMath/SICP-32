#lang racket

#|

timed-prime-test 를 fast-prime? 을 사용하도록 수정하는 Exercise.

* square
* expmod
* fermat-test
* fast-prime?
* timed-prime-test (fast-prime? 를 적용한 버전)

|#

; square procedure 를 정의한다.
(define (square x)
  (* x x))
; expmod procedure 를 정의한다.
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))
; fermat-test procedure 를 정의한다.
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
; fast-prime? procedure 를 정의한다.
(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))
; timed-prime-test 를 재정의한다.
(define (timed-prime-test n)
  (start-prime-test n (current-inexact-milliseconds)))
(define (start-prime-test n start-time)
  (if (fast-prime? n times)
      (begin
        (newline)
        (display n)
        (report-prime (- (current-inexact-milliseconds) start-time))
        #true)
      #false))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; 테스트를 위해 times 값을 정의한다.
; 이 엄밀하지 않은 fast-prime? 을 쓰는게 불만족스럽다.
(define times 100)

#|
(timed-prime-test 10000019)
(timed-prime-test 100000007)
(timed-prime-test 1000000007)
|#

(provide fast-prime?)