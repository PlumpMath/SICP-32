 #lang racket

;2. Building Abstractions with Data
#|
Why do we want compound data in a programming language? For
the same reasons that we want compound procedures: to elevate the
conceptual level at which we can design our programs, to increase the
modularity of our designs, and to enhance the expressive power of our
language.
|#

(define (linear-combination a b x y)
  (add (mul a x) (mul b y)))

#|
where add and mul are not the primitive procedures + and * but rather
more complex things that will perform the appropriate operations for
whatever kinds of data we pass in as the arguments a , b , x , and y . e
key point is that the only thing linear-combination should need to
know about a , b , x , and y is that the procedures add and mul will per-
form the appropriate manipulations. From the perspective of the pro-
cedure linear-combination , it is irrelevant what a , b , x , and y are and
even more irrelevant how they might happen to be represented in terms
of more primitive data. is same example shows why it is important
that our programming language provide the ability to manipulate com-
pound objects directly: Without this, there is no way for a procedure
such as linear-combination to pass its arguments along to add and
mul without having to know their detailed structure.
|#

;closure
#|
One key idea in dealing with compound data is the notion of
closure —that the glue we use for combining data objects should allow
us to combine not only primitive data objects, but compound data ob-
jects as well. Another key idea is that compound data objects can serve
as conventional interfaces for combining program modules in mix-and-
match ways. We illustrate some of these ideas by presenting a simple
graphics language that exploits closure.
|#

;2.1 Introduction to Data Abstraction
;Data abstraction is a methodology that enables us to isolate how a compound data object is used from
;the details of how it is constructed from more primitive data objects.

;2.1.1. Example: Arithmetic Operations for Rational Numbers
