#lang racket

;Exercise 2.26
;NEEDS DISCUSSION
(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y)

;The cons function constructs lists; it is the inverse of car and cdr. For example, cons can be used to make a four element list from the three element list, (fir oak maple):

;(cons 'pine '(fir oak maple))
;After evaluating this list, you will see

;(pine fir oak maple)
;appear in the echo area. cons causes the creation of a new list in which the element is followed by the elements of the original list.

;We often say that cons puts a new element at the beginning of a list, or that it attaches or pushes elements onto the list, but this phrasing can be misleading, since cons does not change an existing list, but creates a new one.

;Like car and cdr, cons is non-destructive.
(cons x y)
(list x y)