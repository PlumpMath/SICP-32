#lang racket
(define (square n)
  (* n n))

;==============================================
;1.2 Procedures and the Processes they Generate
;==============================================
#|
Our situation is analogous to that of someone who has learned the rules for how the pieces move in chess
 but knows nothing of typical openings, tactics, or strategy. Like the novice chess player, we don’t yet
know the common paerns of usage in the do- main. We lack the knowledge of which moves are worth making
(which procedures are worth defining). We lack the experience to predict the consequences of making a move (executing a procedure).

The ability to visualize the consequences of the actions under con- sideration is crucial to becoming an
expert programmer, just as it is in any synthetic, creative activity.
|#

;Linear Recursion and Iteration

;Recursive process
(define (factorial n) (if (= n 1)
      1
      (* n (factorial (- n 1)))))
#|
Thee expansion occurs as the process builds up a chain of deferred oper- ations (in this case, a chain of multiplications).
The contraction occurs as the operations are actually performed. is type of process, charac- terized by a chain of deferred operations,
is called a recursive process.

Carrying out this process requires that the interpreter keep track of the operations to be performed later on. In the computation of n!,
the length of the chain of deferred multiplications, and hence the amount of infor- mation needed to keep track of it, grows linearly with n

there is some additional “hidden” information, maintained by the interpreter and not contained in the program variables, which indicates
“where the process is” in negotiating the chain of deferred operations. The longer the chain, the more information must be maintained.
|#



;Iterative process
(define (factorial2 n) (fact-iter 1 1 n))
(define (fact-iter product counter max-count) (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

#|
By contrast, the second process does not grow and shrink. At each step, all we need to keep track of, for any n, are the current values of
the variables product, counter, and max-count. We call this an iterative process. In general, an iterative process is one whose state can be
sum- marized by a fixed number of state variables, together with a fixed rule that describes how the state variables should be updated as the
process moves from state to state and an (optional) end test that specifies con- ditions under which the process should terminate.

When we discuss the implementation of procedures on register machines in Chap- ter 5, we will see that any iterative process can be realized
“in hardware” as a machine that has a fixed set of registers and no auxiliary memory. In contrast, realizing a recursive process requires a
 machine that uses an auxiliary data structure known as a stack.

Scheme will execute an iterative process in constant space, even if the iterative process is described by a recursive procedure. An implementation
with this property is called tail-recursive. With a tail-recursive implementation, iteration can be expressed using the ordinary procedure call mechanism,
so that special iteration constructs are useful only as syntactic sugar.

Tail recursion - Carl Hewitt (1977)explained it in terms of the “message-passing” model of computation that we shall discuss in Chapter 3. 
|#

;Exercise 1.9
;(define (+ a b)
;  (if (= a 0) b (inc (+ (dec a) b))))

#| Recursive
(define (+ 4 5)
  (if (= 4 0) 5 (inc (+ 3 5))))

(define (+ 4 5)
  (if (= 4 0) 5 (inc (inc (+ 2 5))))

(define (+ 4 5)
  (if (= 4 0) 5 (inc (inc (inc (+ 1 5)))))

(define (+ 4 5)
  (if (= 4 0) 5 (inc (inc (inc (inc (+ 0 5))))))

(define (+ 4 5)
  (if (= 4 0) 5 (inc (inc (inc (inc (5))))))
|#

;(define (+ a b)
;  (if (= a 0) b (+ (dec a) (inc b))))

#| Iterative
(define (+ 4 5)
  (if (= 4 0) 5 (+ (dec 4) (inc 5))))

(define (+ 4 5)
  (if (= 4 0) 5 (+ 3 6)))

(define (+ 4 5)
  (if (= 4 0) 5 (+ (dec 3) (inc 6))))

(define (+ 4 5)
  (if (= 4 0) 5 (+ 2 7)))

...
|#

#|
The easiest way to spot that the first process is recursive (without writing out the substitution) is to note that the "+" procedure
 calls itself at the end while nested in another expression; the second calls itself, but as the top expression.
|#

;Exercise 1.10 - Ackermann's function
;f - 2n
;g - 2^n
;h - 2^2^... (n-1 times)

;Tree recursion
#|
It is not hard to show that the number of times the procedue will compute (fib 1) or (fib 0) is precisely Fib(n+1).
Since Fib(n) is the closest integer to φ^n/√5 where φ = 1+√5 ≈ 1.6180, the process uses a number of steps that grows
exponentially with the input. (see Exercise 1.13)

On the other hand, the space required grows only linearly with the input, because we need to keep track only of which
nodes are above us in the tree at any point in the computation. Which means that the space required will be proportional
to the maximum depth of the tree.
|#
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1)) (fib (- n 2))))))

;Iterative version - To formulate the iterative algorithm required noticing that the computation could be recast as an iteration with three state variables.
(define (fib2 n) (fib-iter 1 0 n))
(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))

;Count change

(define (count-change amount) (cc amount 5))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount(- kinds-of-coins 1))
                 (cc (- amount (first-denomination kinds-of-coins)))))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

;Exercise 1.11
(println "Exercise 1.11")
(define (f n)
  (if (< n 3)
      n
     (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

(define (f-iter n)
  (define (iterate large mid small count)
    (cond ((< count 3) count)
          ((= count 3) large)
          ((> count 3) (iterate (+ large (* 2 mid) (* 3 small)) large mid (- count 1)))))
  (iterate 4 2 1 n))


(f 5)
(f-iter 5)

;Exercise 1.12
(println "Exercise 1.12")
(define (pascalTri row col)
  (cond ((or (= row 1)(= col 1)(= row col)) 1)
        (else (+ (pascalTri (- row 1) (- col 1)) (pascalTri (- row 1) col)))))

(pascalTri 4 2)

;Exercise 1.13
(println "Exercise 1.13")
#|
ψ = (1-√5)/2

[1] φ2 = (1+√5)2/4 = (1 + 2√5 + 5)/4 = (3+√5)/2
[2] ψ2 = (1-√5)2/4 = (3-√5)/2

By induction
Base cases:
Fib(0)= (φ0 – ψ0)/√5 = 0
Fib(1)= (φ – ψ)/√5 = [(1+√5)/2 – (1-√5)/2] / √5 = 1

Induction step:
[3] Fib(k) = (φk – ψk)/√5
[4] Fib(k+1) = (φ.φk – ψ.ψk)/√5
By definition Fib(k+2) = Fib(k) + Fib(k+1)
[3] + [4] Fib(k+2) = [φk(1+φ) – ψk(1+ψ)] / √5
(1+φ) = 1 + (1+√5)/2 = (3+√5)/2 = φ^2 – from [1]
(1+ψ) = 1 + (1-√5)/2 = (3-√5)/2 = ψ^2 – from [2]
Fib(k+2) = φk.φ2 – ψk.ψ2 / √5 = (φk+2 – ψk+2) / √5

Now ψ = (1-√5)/2 and 4 < 5 < 9
=> 2 < √5 < 3
=> -1 < ψ < 0
=> ψn -> 0 as n -> ∞
Fib(n) -> (φ – 0)n/√5 as n -> ∞
Fib(n) -> φn/√5
|#

;Orders of Growth
#|
Let n be a parameter that measures the size of the problem, and let R(n) be the amount of resources the
process requires for a problem of size n.
R(n) might measure the number of internal storage registers used, the number of elementary machine operations
performed, and so on. In computers that do only a fixed number of operations at a time, the time required will be proportional to the number of elementary machine operations performed.
|#

;Exercise 1.14
(println "Exercise 1.14")
#|

|#

;Exponentiation
(define (expt b n) (if (= n 0)
      1
      (* b (expt b (- n 1)))))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (even? n)
(= (remainder n 2) 0))

#|
The process evolved by fast-expt grows logarithmically with n in both space and number of steps. To see this, observe that computing b2n us- ing fast-expt
requires only one more multiplication than computing bn . The size of the exponent we can compute therefore doubles (approx- imately) with every new
multiplication we are allowed. Thus, the num- ber of multiplications required for an exponent of n grows about as fast as the logarithm of n to the base 2.
The process has Θ(log n) growth.
|#

;Exercise 1.16
(println "Exercise 1.15")
(define (fast-expt-iter b n)
  (define (iterate a n)
    (cond ((= n 1) a)
          ((even? n) (iterate (* a (fast-expt-iter b (/ n 2))) (/ n 2)))
          (else (iterate (* a b) (- n 1)))))
  (iterate b n))

(fast-expt-iter 3 5)

;Exercies 1.17
(println "Exercise 1.17")
(define (double x)
  (+ x x))

(define (halve x)
  (/ x 2))

(define (fast-* a b)
  (cond ((= b 0) 0)
        ((even? b) (fast-* (double a) (halve b)))
        (else (+ a (fast-* a (- b 1))))))

(fast-* 5 3)

;Exercise 1.18
(println "Exercise 1.18")
(define (iter-* a b)
  (define (iterate product multiplier)
    (cond ((= multiplier 1) product)
          ((even? multiplier) (iterate (double product) (halve multiplier)))
          (else (iterate (+ a a) (- b 1)))))
  (iterate a b))

(iter-* 3 8)

;Exercise 1.19
(println "Exercise 1.19")
;p` = p^2 + q^2                                      
;q` = 2pq + q^2

;Euclid's Algorithm
(define (gcd a b) (if (= b 0)
      a
      (gcd b (remainder a b))))

;Exercise 1.20
(println "Exercise 1.20")
#|
Normal order
(gcd 206 40)
(gcd 40 (remainder 206 40))
(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

Applicative order
(gcd 206 40)
(gcd 40 6)
(gcd 6 4)
(gcd 4 2)
(gcd 2 0)
2
|#


;Testing for Primality

(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b) (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))


(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m)) m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m)) m))))

;Exercise 1.21
(println "Exercise 1.21")
(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)

;Exercise 1.22
(println "Exercise 1.22")

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (current-inexact-milliseconds) start-time))
      #f))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  #t)

(define (search-for-primes from to count)
  (cond ((or (= count 3) (= from to)) (display "END"))
        ((even? from) (search-for-primes (+ from 1) to count))
        (else (if (timed-prime-test from) (search-for-primes (+ from 2) to (+ count 1))
                  (search-for-primes (+ from 2) to count)))))

(search-for-primes 1000 10000 0)
(search-for-primes 10000 100000 0)
(search-for-primes 100000 1000000 0)
