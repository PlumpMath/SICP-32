#lang racket

; input: 3 number output: square 2 max num, add

(define (square x) (* x x))

(define a (string->number (read-line)))
(define b (string->number (read-line)))
(define c (string->number (read-line)))

(define sortedList (sort (list a b c) >))

(define result (+ (square (list-ref sortedList 0)) (square (list-ref sortedList 1))))

(print result)