#lang racket
#|
A symbol is an object with a simple string representation that (by default)
is guaranteed to be interned; i.e., any two symbols that are written the same
are the same object in memory (reference equality).
|#
(pair? '(a b))

;Exercise 2.55
(define one-quote (quote abracadabra))
(define two-quote (quote (quote abracadabra)))

one-quote
(print "pair?")
(pair? one-quote)
(print "string?")
(string? one-quote)

(newline)

two-quote
(print "pair?")
(pair? two-quote)
(car two-quote)
(cdr two-quote)
(cdr (cdr two-quote))

#|
Ah.. so ``abracadabra
is `(quote abracadabra)
which means an object - in this case (list (quote abracadabra)) with a simple string
representation.
|#