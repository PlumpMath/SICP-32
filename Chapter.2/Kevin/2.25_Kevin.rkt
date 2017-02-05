#lang racket

;Exercise 2.25
;NEEDS DISCUSSION

(car (cdr (car (cdr (cdr (list 1 3 (list 5 7) 9))))))
(car (car (list (list 7))))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (list 1 (list 2 (list 3 (list 4 (list 5(list 6 7))))))))))))))))))

;WHY IS (car (list 3 5)) -> 3 BUT (cdr (list 3 5)) '(5)?
;Is it because list is constructed this way?
;(cons 1 (cons 2 (cons 3 (cons 4 null)))) == (list 1 2 3 4)
(cdr (list 3 5))

