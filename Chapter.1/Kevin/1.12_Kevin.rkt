#lang racket

;Exercise 1.12
(println "Exercise 1.12")
(define (pascalTri row col)
  (cond ((or (= row 1)(= col 1)(= row col)) 1)
        (else (+ (pascalTri (- row 1) (- col 1)) (pascalTri (- row 1) col)))))

(pascalTri 4 2)