#lang racket

; Euclid's Algorithm
(define (gcb a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; 잘 모르겠네.... normal 이랑 applicative 랑 if 문을 어떻게 처리하는지?
; Exercise 1.5 와 연계될 것이다.
(gcd 206 40)
(if (= 40 0) 206 (gcd 40 (remainder 206 40)))
(if (= 40 0) 206
    (if (= (remainder 206 40) 0)
        40
        (gcd (remainder 206 40) (remainder 40 (remainder 206 40)))))
(if (= 40 0) 206
    (if (= (remainder 206 40) 0)
        40
        (if (= (remainder 40 (remainder 206 40)) 0)
            (remainder 206 40)
            (gcd
             (remainder 40 (remainder 206 40))
             (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))
(if (= 40 0) 206
    (if (= (remainder 206 40) 0)
        40
        (if (= (remainder 40 (remainder 206 40)) 0)
            (remainder 206 40)
            (gcd
             (remainder 40 (remainder 206 40))
             (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))
