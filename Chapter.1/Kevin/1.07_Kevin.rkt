#lang racket
;Exercise 1.7
(display "
Exercise 1.7

The good-enough? test will not be very effective for finding the square roots of
very small numbers because it returns true if the difference between '* guess guess' and 'x' is lower than 0.001.

For example, (sqrt 0.9991) would be 1.0.

Also, it is inadequate for very large numbers ... WHY???

an alternative would be

(define (sqrt-iter prevGuess guess x)
  (if (good-enough? prevGuess guess x) guess
      (sqrt-iter guess (improve guess x) x)))

(define (good-enough? prevGuess guess x)
(< (abs (- guess prevGuess)) (/ guess 1000))

")
;(sqrt 1000000000000)
;(sqrt 10000000000000)
;(improve 3162277.6601683795 10000000000000)
;(/ 10000000000000 3162277.6601683795)
