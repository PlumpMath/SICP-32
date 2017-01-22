#lang racket
;1.3 Formulating Abstractions with Higher-Order Procedures
;1.3.1 Procedures as Arguments
(define (cube x) (* x x x))

(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))

(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a)
         (sum-cubes (+ a 1) b))))

(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2)))
         (pi-sum (+ a 4) b))))


#|
These three procedures clearly share a common underlying pattern.
they are for the most part identical, differing only in the name of the
procedure, the function of a used to compute the term to be added, and
the function that provides the next value of a . We could generate each
of the procedures by filling in slots in the same template:
(define ( ⟨ name ⟩ a b)
(if (> a b)
0
(+ ( ⟨ term ⟩ a)
( ⟨ name ⟩ ( ⟨ next ⟩ a) b))))
The presence of such a common paern is strong evidence that there is
a useful abstraction waiting to be brought to the surface. Indeed, math-
ematicians long ago identified the abstraction of summation of a series
and invented “sigma notation,” for example
b
∑f (n) = f (a) + · · · + f (b),
n=a
|#

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc n) (+ n 1))
(define (sum-cubes-general a b)
  (sum cube a inc b))

(sum-cubes-general 1 10)


(define (pi-sum-general a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))


(* 8 (pi-sum-general 1 1000))

;1.3.2 Constructing Procedures Using lambda

((lambda (x) (+ x 4)) 4)

(define (pi-sum-lambda a b)
  (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
       a
       (lambda (x) (+ x 4))
       b))

#|
The resulting procedure is just as much a procedure as one that is cre-
ated using define . The only difference is that it has not been associated
with any name in the environment. In fact,

(define (plus4 x) (+ x 4))

is equivalent to

(define plus4 (lambda (x) (+ x 4)))
|#

((lambda (x y z) (+ x y ((lambda(x)(* x x)) z)))
 1 2 3)
12

;local variable `let`
#|
The general form of a let expression is
(let (( ⟨ var 1 ⟩
( ⟨ var 2 ⟩ ⟨ exp 1 ⟩ )
⟨ exp 2 ⟩ )
( ⟨ var n ⟩ ⟨ exp n ⟩ ))
...
⟨ body ⟩ )
which can be thought of as saying
⟨ var 1 ⟩ have the value ⟨ exp 1 ⟩ and
⟨ var 2 ⟩ have the value ⟨ exp 2 ⟩ and
...
⟨ var n ⟩ have the value ⟨ exp n ⟩
in ⟨ body ⟩
|#

#|
The variables’ values are computed outside the let . This matters
when the expressions that provide the values for the local vari-
ables depend upon variables having the same names as the local
variables themselves. For example, if the value of x is 2, the ex-
pression will have the value 12 because, inside the body of the let, x will
be 3 and y will be 4(which ist the outer x plus 2).
|#
(define x
  2)
(let ((x 3)
      (y (+ x 2)))
  (* x y))

#|
Sometimes we can use internal definitions to get the same effect as with
let . For example, we could have defined the procedure f above as
(define (f x y)
(define a (+ 1 (* x y)))
(define b (- 1 y))
(+ (* x (square a))
(* y b)
(* a b)))
We prefer, however, to use let in situations like this and to use internal
define only for internal procedures
|#

;1.3.3 Procedures as General Methods
(define (average a b)
  (/ (+ a b) 2))
(define (close-enough? x y) (< (abs (- x y)) 0.001))

(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                 (search f neg-point midpoint))
                ((negative? test-value)
                 (search f midpoint pos-point))
                (else midpoint))))))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
           (error "Values are not of opposite sign" a b)))))

;The following example uses the half-interval method to approximate π
;as the root between 2 and 4 of sin x = 0:
(half-interval-method sin 2.0 4.0) ;3.14111328125

;Finding fixed points of functions
#|
A number x is called a fixed point of a function if x satisfies the equation f(x) = x
|#

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;1.3.4 Procedures as Returned Values
;We can express the idea of average damping by means of the following procedure:
(define (average-damp f)
  (lambda (x) (average x (f x))))
#|
average-damp is a procedure that takes as its argument a procedure
f and returns as its value a procedure (produced by the lambda ) that,
when applied to a number x , produces the average of x and (f x) . For
example, applying average-damp to the square procedure produces a
procedure whose value at some number x is the average of x and x 2 .
Applying this resulting procedure to 10 returns the average of 10 and
100, or 55:
|#
(define (square x)
  (* x x))
((average-damp square) 10) ;5

;Using average-damp , we can reformulate the square-root procedure as follows:

(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))

#|
Notice how this formulation makes explicit the three ideas in the method:
fixed-point search, average damping, and the function y 7→ x/y. It is in-
structive to compare this formulation of the square-root method with
the original version given in Section 1.1.7. Bear in mind that these pro-
cedures express the same process, and notice how much clearer the idea
becomes when we express the process in terms of these abstractions. In
general, there are many ways to formulate a process as a procedure. Ex-
perienced programmers know how to choose procedural formulations
that are particularly perspicuous, and where useful elements of the pro-
cess are exposed as separate entities that can be reused in other appli-
cations.
|#

#|
As programmers, we should be alert to opportunities to identify the
underlying abstractions in our programs and to build upon them and
generalize them to create more powerful abstractions. is is not to
say that one should always write programs in the most abstract way
possible; expert programmers know how to choose the level of abstrac-
tion appropriate to their task.
|#

#|
In general, programming languages impose restrictions on the ways
in which computational elements can be manipulated. Elements with
the fewest restrictions are said to have first-class status. Some of the
“rights and privileges” of first-class elements are:


• They may be named by variables.
• They may be passed as arguments to procedures.
• They may be returned as the results of procedures.
• They may be included in data structures.

The major implementation cost of first-class procedures is that allowing procedures
to be returned as values requires reserving storage for a procedure’s free variables even
while the procedure is not executing. In the Scheme implementation we will study in
Section 4.1, these variables are stored in the procedure’s environment.
|#

;NEWTON'S METHOD GG



