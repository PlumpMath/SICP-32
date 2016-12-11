#lang racket
;==========================================
;1. Building Abstractions with Procedures
;==========================================

;==========================================
;1.1 The Elements of Programming
;==========================================

;Expressions
;The interpreter displays the results of its 'evaluating' the expression.
3

#|
may be combined with a primitive procedure to form a compound expression, which represents the application of the procedure.
This is an expression(formed by delimiting a list of expressions within parentheses to denote procedure application.)
(operator operand operand)
|#
(+ 3 5)

;This is a procedure.
+ 3 5

;Naming and the Environment
#|define is lisp's simplest means of abstraction.
 (define (name parameters) (body))
|#

;sqare
(define (square x) (* x x))

(square (+ 2 5))

;Conditional Expressions and Predicates
#|(cond ((predicate) (expression))
        ((predicate) (expression))
        ((predicate) (expression)))
|#

;absolute
(define (abs1 x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))

;could also be written as
(define (abs2 x)
  (cond ((< x 0) (- x))
        (else x)))

;could also be written as
;(if (predicate) (consequent) (alternative))
(define (abs3 x)
  (if (< x 0) (- x) (x)))

(abs1 (- 27))
(abs2 (- 27))
(abs3 (- 27))

;Evaluating Combinations
#|The interpreter follows the following procedure
 1. Evaluate the subexpressions of the combination.
 2. Apply the procedure that is the value of the leftmost subexpression (the oprator)
    to the arguments that are the values of the other subexpresisons(the operands)

 *THE EVALUATION RULE IS RECURSIVE IN NATURE. IT NEED TO INVOKE THE RULE ITSELF.

 (* (+ 2 (* 4 6))
    (+ 3 5 7)

 For example, in this example, repeated application of the first step brings us to the
 point where we need to evaluate, not combinations, but primitive expressions such as
 numerals, built-in operators or other names.
|#


;The Substitution Model for Procedure Application, Applicative order vs Normal order
#|
 To apply a compound procedure to arguments, evaluate the body of the procedure with each
 formal parameter replaced by the corresponding argument.

 Applicative order - "evaluate" the arguments and then apply (Lisp uses applicative-order evaluation)
 (f 5)
 (sum-of-squares (+ a 1) (* a 2))
 (sum-of-squares (+ 5 1) (* 5 2))
 (+ (square(6) square(10))
 (+ (* 6 6) (* 10 10))
 (+ 36 100)
 136

 Normal Order - fully expand then reduce. 

 (f 5)
 (sum-of-squares (+ a 1) (* a 2))
 (sum-of-squares (+ 5 1) (* 5 2))
 (+ (square(+ 5 1) square(* 5 2))
 (+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2))
 (+ (* 6 6) (* 10 10))
 (+ 36 100)
 136
|#

;Clause - paires of expressions, in this case,
;((predicate expression) (consequent expression))
;((> x 0) x)

;Predicate expression - it either evaluates to true or false. ( > is a primitive predicate )
;(> x 0)


(define a 3)
(define b (+ a 1))

(println "(+ a b (* a b))")
(+ a b (* a b))

(println "(= a b)")
(= a b)

(println "(if (and (> b a) (< b (* a b))) b a")
(if (and (> b a) (< b (* a b))) b a)

;Exercise 1.2
(display "Exercise 1.2")
(/ (+ 5 4 (- 2 (- 3 (+ 6 4/5))))
   (* 3 (- 6 2) (- 2 7)))

;Exercise 1.3
(display "Exercise 1.3")
(display "Define a procedure that takes three numbers as arguments and returns the sum
of the squares of the two larger numbers.")
(define (sumOfTwoLargeNumbers a b c)
  (cond ((and (< a b) (< a c)) (+ (square b) (square c)))
        ((and (< b c) (< b a)) (+ (square a) (square c)))
        ((and (< c a) (< c b)) (+ (square a) (square b)))))

(println "sum of two large numbers, 5 3 2")
(sumOfTwoLargeNumbers 5 3 2)

;Exercise 1.4
(display "Exercise 1.4")
(display "operators can be compound expressions")
(define (a-plus-abs-b a b) ((if (> b 0) + -) a b))
(a-plus-abs-b 3 -5)

;Exercise 1.5
(display "Exercise 1.5")
(define (p) (p))
(define (test x y) (if (= x 0) 0 y))

(display "
Exercise 1.5
 In applicative order (test 0 (p)) never terminates,
 because in trying to evaluate (p) first and then apply 'test' procedure,
 (p) does not end.

 However, in normal order evaluation, it is first expanded like this,
 (test 0 (p))
 (if (= 0 0) 0 (p))
 (if #t 0 (p))

 and then start evaluating, which will return 0
")

;Exercise 1.6
(display "Exercise 1.6")
(define (sqrt-iter guess x)
  (if (good-enough? guess x) guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) (/ (+ x y) 2))

(define (good-enough? guess x)
  (display "guess\n")
  (display guess)
  (display "\n\n")
  (display "(square guess)\n")
  (display (square guess))
  (display "\n\n")
  (display "x\n")
  (display x)
  (display "\n\n")
  (display "- x (square guess)))\n")
  (display (- x (square guess)))
  (display "\n\n")
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x) (sqrt-iter 1.0 x))

(define (new-if predicate then-clause else-clause) (cond (predicate then-clause)
(else else-clause)))

;(define (sqrt-iter guess x) (new-if (good-enough? guess x)
;               guess
;               (sqrt-iter (improve guess x) x)))

(display "
Since Lisp uses applicative-order evaluation, the new-if procedure(different from if, if is a special form)
would need to perform the evaluation of '(sqrt-iter (improve guess x) x)' before evaluating the whole procedure,
which would end up being a recursive, non-ending procedure.
")

;Exercise 1.7
(display "
Exercise 1.7

The good-enough? test will not be very effective for finding the square roots of
very small numbers because it returns true if the difference between '* guess guess' and 'x' is lower than 0.001.

For example, (sqrt 0.9991) would be 1.0.

Also, it is inadequate for very large numbers ... WHY???

an alternative would be

(define (sqrt-iter prevGuess guess x)
  (if (good-enough? prevGuess guess x) guess
      (sqrt-iter guess (improve guess x) x)))

(define (good-enough? prevGuess guess x)
(< (abs (- guess prevGuess)) (/ guess 1000))

")
;(sqrt 1000000000000)
;(sqrt 10000000000000)
;(improve 3162277.6601683795 10000000000000)
;(/ 10000000000000 3162277.6601683795)

;Exercise 1.8
(println "Exercise 1.8")
(define (cube x)
  (cube-iter 1.0 x))

(define (cube-iter guess x)
  (if (cube-good-enough? guess x)
      guess
      (cube-iter (cube-improve guess x) x)))

(define (cube-good-enough? guess x)
  (< (abs (- (cube-improve guess x) guess)) 
     (* guess .001))) 
  
(define (cube-improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(cube 27)

;Procedures as Black-Box Abstractions
#|
The entire sqrt program can be viewed as a cluster of procedures that mirrors the decomposition
of the problem into subproblems.

It is crucial that each procedure accomplishes an identifiable task that can be used as a MODULE
ind defining other procedures.

We are able to regart the square procedure as a "black box". We are not at that moment concerned
with how the procedure computes its result, only with the fact that it computes the square.
|#


;Local names
#|
A formal parameter of a procedure has a very special role in the procedure definition, in that
it doesn’t maer what name the formal parameter has. Such a name is called a bound variable, and
we say that the procedure definition binds its formal parameters.

If a variable is not bound, we say that it is free. e set of expressions for which a binding defines
 a name is called the scope of that name. In a procedure definition, the bound variables declared as
the formal parameters of the procedure have the body of the procedure as their scope.

We would like to localize the subprocedures, hiding them inside sqrt so that sqrt could coexist with
other successive approximations, each hav- ing its own private good-enough? procedure. To make this
possible, we allow a procedure to have internal definitions that are local to that pro- cedure.
For example, in the square-root problem we can write

(define (sqrt x)
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x) (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1.0 x))

OR better,

(define (sqrt x)
  (define (good-enough? guess )
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess) (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
|#