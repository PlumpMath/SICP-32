#lang racket

;3. Modularity, Objects and State (local state variable)
#|
The first organizational strategy concentrates on objects, viewing a large system as a collection
of distinct objects whose behaviors may change over time. An alternative organizational strategy
concentrates on the streams of information that flow in the system, much as an electrical engineer
views a signal-processing system.
|#
(define balance 100)
(define (withdraw amount)
  (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))

;This is a new kind of behavior for a procedure. Until now, all our procedures could be viewed as
;speciﬁcations for comput- ing mathematical functions. A call to a procedure computed the value of
;the function applied to the given arguments, and two calls to the same procedure with the same
;arguments always produced the same result.

;(set! ⟨name⟩ ⟨new-value⟩)
#|
(begin ⟨exp1⟩ ⟨exp2⟩ . . . ⟨expk⟩)
causes the expressions ⟨exp1⟩ through ⟨expk⟩ to be evaluated in sequence and the value of the final
expression ⟨expk ⟩ to be returned as the value of the entire begin form.
|#
(define new-withdraw
  (let ((balance 100))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))))

(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))

#|
We can also create objects that handle deposits as well as withdrawals, and thus we can
represent simple bank accounts. Here is a procedure that returns a “bank-account object” with
a specified initial balance:
|#

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request: MAKE-ACCOUNT"
                       m))))
  dispatch)

#|
Each call to make-account sets up an environment with a local state variable balance. Within this
environment, make-account defines pro- cedures deposit and withdraw that access balance and an
additional procedure dispatch that takes a “message” as input and returns one of the two local
procedures. The dispatch procedure itself is returned as the value that represents the bank-account
object. This is precisely the message-passing style of programming that we saw in Section 2.4.3,
although here we are using it in conjunction with the ability to modify local variables.
|#
(define acc (make-account 100))
((acc 'withdraw) 50)
((acc 'withdraw) 60)
((acc 'deposit) 40) 
((acc 'withdraw) 60)

#|
Exercise 3.1: An accumulator is a procedure that is called repeatedly with a single numeric argument and accumulates
its arguments into a sum. Each time it is called, it returns the currently accumulated sum. Write a procedure make-accumulator
 that generates accumulators, each main- taining an independent sum. e input to make-accumulator should specify the initial
value of the sum; for example
(define A (make-accumulator 5)) (A 10)
15
(A 10)
25
|#
(println "Exercise 3.1")
(define (make-accumulator sum)
  (define (add number)
    (set! sum (+ sum number))
    sum)
  add)

(define A (make-accumulator 5))
(A 10)
(A 10)

#|
Exercise 3.2: In software-testing applications, it is useful to be able to count the number of times a given procedure is
called during the course of a computation. Write a pro- cedure make-monitored that takes as input a procedure, f, that
itself takes one input. e result returned by make- monitored is a third procedure, say mf, that keeps track of the number
of times it has been called by maintaining an internal counter. If the input to mf is the special symbol how-many-calls?,
then mf returns the value of the counter. If the input is the special symbol reset-count, then mf re- sets the counter to zero.
For any other input, mf returns the result of calling f on that input and increments the counter. For instance, we could make a
monitored version of the sqrt procedure:

(define s (make-monitored sqrt))
(s 100)
10
(s 'how-many-calls?)
1
|#
(println "Exercise 3.2")
(define (make-monitored f)
  (let ((called 0))
  (define (callGivenFunc arg)
    (set! called (+ called 1))
    (f arg))
  (define (dispatch m)
    (cond ((eq? m 'how-many-calls?) called)
          ((eq? m 'reset-count) (set! called (+ called 1)))
          (else (callGivenFunc m))))
  dispatch))

(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls?)

#|
The following expression creates and gives initial values to the two variables zebra and tiger.
The body of the let expression is a list which calls the message function.

(let ((zebra "stripes")
      (tiger "fierce"))
  (message "One kind of animal has %s and another is %s."
           zebra tiger))
Here, the varlist is ((zebra "stripes") (tiger "fierce")).
|#


#|
Exercise 3.3: Modify the make-account procedure so that
it creates password-protected accounts. That is, make-account should take a symbol as an additional argument, as in
(define acc (make-account 100 'secret-password))

The resulting account object should process a request only if it is accompanied by the password with which the account was created,
and should otherwise return a complaint:

((acc 'secret-password 'withdraw) 40) 60
((acc 'some-other-password 'deposit) 50) "Incorrect password"
|#
(println "Exercise 3.3")
(define (modified-make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch pw m)
    (if (not (eq? pw password))
        (error "Incorrect password")
        (cond
          ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          ((eq? m 'is-valid-password) (eq? pw password))
          (else (error "Unknown request: MAKE-ACCOUNT"
                       m)))))
  dispatch)

(define acc2 (modified-make-account 100 'secret))
;((acc2 'donno 'withdraw) 40)
((acc2 'secret 'withdraw) 40)

#|
Exercise 3.4: Modify the make-account procedure of Exercise 3.3 by adding another local state variable so that, if an account
is accessed more than seven consecutive times with an incorrect password, it invokes the procedure call-the-cops.
|#
(println "Exercise 3.4")
(define (cops-make-account balance password)
  (let ((wrong 0))
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (call-the-cops)
    (error "You are busted"))
  (define (return-warning arg)
    "Incorrect password")
  (define (dispatch pw m)
    (cond ((not (eq? pw password))
           (set! wrong (+ wrong 1))
           (if (= wrong 7) (call-the-cops)
               return-warning))
          (else (cond ((eq? m 'withdraw) withdraw)
                      ((eq? m 'deposit) deposit)
                      (else (error "Unknown request: MAKE-ACCOUNT"
                       m))))))
  dispatch))

(define acc3 (cops-make-account 100 'secret))
((acc3 'donno 'withdraw) 40)
((acc3 'donno 'withdraw) 40)
((acc3 'donno 'withdraw) 40)
((acc3 'donno 'withdraw) 40)
((acc3 'donno 'withdraw) 40)
((acc3 'donno 'withdraw) 40)
;Uncomment this if you want to call the cops
;((acc3 'donno 'withdraw) 40)

#|
It is tempting to conclude this discussion by saying that, by introducing assignment and the technique of hiding state in local
variables, we are able to structure systems in a more modular fashion than if all state had to be manipulated explicitly, by passing
 additional parameters. Unfortunately, as we shall see, the story is not so simple.
|#

#|
Exercise 3.5: Monte Carlo integration is a method of estimating definite integrals by means of Monte Carlo simulation. Consider
computing the area of a region of space described by a predicate P(x,y) that is true for points (x,y) in the region and false for
points not in the region. For example, the region contained within a circle of radius 3 centered at (5, 7) is described by the
predicate that tests whether (x - 5)^2 + (y - 7)^2 ≤ 32. To estimate the area of the region described by such a predicate, begin by
choosing a rectangle that contains the region. For example, a rectangle with diagonally opposite corners at (2, 4) and (8, 10)
con- tains the circle above. The desired integral is the area of that portion of the rectangle that lies in the region. We can
estimate the integral by picking, at random, points (x,y) that lie in the rectangle, and testing P(x,y) for each point to determine
whether the point lies in the region. If we try this with many points, then the fraction of points that fall in the region should
give an estimate of the proportion of the rectangle that lies in the region. Hence, multiplying this fraction by the area of the
entire rectangle should produce an estimate of the integral.

Implement Monte Carlo integration as a procedure estimate-integral that takes as arguments a predicate P, upper and lower bounds
x1, x2, y1, and y2 for the rectangle, and the number of trials to perform in order to produce the estimate. Your procedure should
use the same monte-carlo procedure that was used above to estimate π . Use your estimate-integral to produce an estimate of π by
measuring the area of a unit circle.

You will find it useful to have a procedure that returns a number chosen at random from a given range. The following
random-in-range procedure implements this in terms of the random procedure used in Section 1.2.6, which returns a nonnegative
number less than its input.

(define (random-in-range low high) (let ((range (- high low)))
    (+ low (random range))))
|#
(println "Exercise 3.5")

(define (rand-update x)
  (modulo (+ (* 214013 x) 253011) 32767))

(define rand (let ((x 7))
               (lambda ()
                 (set! x (rand-update x))
                 x)))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-integral predicate x1 x2 y1 y2 trials)
  (define (experiment)
    (predicate (random-in-range x1 x2) (random-in-range y1 y2)))
  
  (let ((circle-area (* (monte-carlo trials experiment) (* (abs (- x2 x1)) (abs (- y2 y1)))))
        (radius (/ (abs (- x2 x1)) 2)))
    (/ circle-area (expt radius 2))))

(define (is-in-circle x y r)
  (define (in-circle randomX randomY)
    (if (>= (expt r 2) (+ (expt (- x randomX) 2) (expt (- y randomY) 2)))
        #t
        #f))
  in-circle)

(estimate-integral (is-in-circle 5 7 3) 2 8 4 10 100)

#|
Exercise 3.6: It is useful to be able to reset a random-number generator to produce a sequence starting from a given value.
Design a new rand procedure that is called with an argument that is either the symbol generate or the symbol reset and behaves
as follows: (rand 'generate) produces a new random number; ((rand 'reset) ⟨new-value ⟩) resets the internal state variable to the
designated ⟨new-value ⟩. Thus, by resetting the state, one can generate repeatable sequences. These are very handy to have when
testing and debugging programs that use random numbers.
|#
(println "Exercise 3.6")
(define (make-rand-generator seed-number)
  (define (dispatch m)
    (cond ((eq? m 'generate)
             (set! seed-number (rand-update seed-number))
             seed-number)
          ((eq? m 'reset)
           (lambda (new-seed)
             (set! seed-number new-seed)))))
    dispatch)

(define rand-new (make-rand-generator 5))
(rand-new 'generate)
(rand-new 'generate)
(rand-new 'generate)

((rand-new 'reset) 5)
(rand-new 'generate)

  
#|
Programming without any use of assignments, as we did throughout the ﬁrst two chapters of this book,
is accordingly known as functional programming.

In contrast to functional programming, programming that makes extensive use of assignment is known
 as imperative programming. In addition to raising complications about computational models, programs
written in imperative style are susceptible to bugs that cannot occur in functional programs.

The complexity of imperative programs becomes even worse if we consider applications in which several
processes execute concurrently.
|#

;Exercise 3.7
(println "Exercise 3.7")
(define (make-joint account old-password new-password)
  (define (joint-account pw m)
    (if (not (or (eq? pw old-password) (eq? pw new-password)))
        (error "Incorrect password")
        (cond ((eq? m 'withdraw) (account old-password 'withdraw))
              ((eq? m 'deposit) (account old-password 'deposit))
              (else (error "Unknown request:" m)))))
  (if (not (account old-password 'is-valid-password))
      (error "Incorrect password")
      joint-account))

(define kevin-acc (make-joint acc2 'secret 'park))

((kevin-acc 'secret 'deposit) 100)
((kevin-acc 'park 'withdraw) 60)
        
;Exercise 3.8
(println "Exercise 3.8")

(define (f-generator)
  (let ((called #f))
    (lambda (num)
      (cond ((not called)
             (begin (set! called #t)
                  num))
            (else 0)))))

(define f (f-generator))
(+ (f 0) (f 1))