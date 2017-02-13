#lang racket

(provide unique-pairs)
(provide enumerate-interval)

; implementation
(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))
(define (unique-pairs n)
  (foldr append null (map (lambda (i)
                            (map (lambda (j) (list j i))
                                 (enumerate-interval 1 (- i 1))))
                          (enumerate-interval 1 n))))
; test
; (unique-pairs 4)
