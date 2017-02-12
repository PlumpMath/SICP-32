#lang racket

(require "2.40_LCH.rkt")

; implementation
(define (find-all-triples n sum)
  (filter (lambda (triple) (= sum (foldr + 0 triple)))
          (foldr append null
                 (map (lambda (i)
                        (map (lambda (pair) (append pair (list i))) (unique-pairs (- i 1))))
                      (enumerate-interval 1 n)))))

; test
(find-all-triples 5 9)