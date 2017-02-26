#lang racket

(foldr / 1 (list 2 5 4)) ;3/2
(foldl / 1 (list 2 5 4)) ;3/2
(foldr list null (list 1 2 3))
(foldl list null (list 1 2 3))
