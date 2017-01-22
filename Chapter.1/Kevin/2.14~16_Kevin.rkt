#lang racket

;Exercise 2.14

;Needs discussion.

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval
   x
   (make-interval (/ 1.0 (upper-bound y))
                  (/ 1.0 (lower-bound y)))))

(define (make-interval a b) (cons a b))


(define (upper-bound interval)
  (if (>= (car interval) (cdr interval))
      (car interval)
      (cdr interval)))

(define (lower-bound interval)
  (if (<= (car interval) (cdr interval))
      (car interval)
      (cdr interval)))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y)) (- (upper-bound x) (lower-bound y))))

(define (width-interval interval)
  (- (upper-bound interval) (lower-bound interval)))


(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))



(define (make-center-percent c p)
  (make-interval (- c (* c (/ p 100))) (+ c (* c (/ p 100)))))

(define (tolerance-percent interval)
  (let ((center (/ (+ (upper-bound interval) (lower-bound interval)) 2))
        (tolerance (/ (- (upper-bound interval) (lower-bound interval)) 2)))
    (* (/ tolerance center) 100)))
#|
Demonstrate that Lem is right. Investigate
the behavior of the system on a variety of arithmetic ex-
pressions. Make some intervals A and B, and use them in
computing the expressions A/A and A/B. You will get the
most insight by using intervals whose width is a small per-
centage of the center value. Examine the results of the com-
putation in center-percent form (see Exercise 2.12).
|#

(define R1 (make-center-percent 100 1))
(define R2 (make-center-percent 100 2))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
     one (add-interval (div-interval one r1)
                       (div-interval one r2)))))

(par1 R1 R2)
(par2 R1 R2)

#|
All 3 problems point to the difficulty of "identity" when dealing with intervals. Suppose we have two numbers A and B which are contained in intervals:

  A = [2, 8]
  B = [2, 8]
A could be any number, such as 3.782, and B could be 5.42, but we just don't know.

Now, A divided by itself must be 1.0 (assuming A isn't 0), but of A/B (the same applies to subtraction) we can only say that it's somewhere in the interval

  [0.25, 4]
Unfortunately, our interval package doesn't say anything about identity, so if we calculated A/A, we would also get

  [0.25, 4]
So, any time we do algebraic manipulation of an equation involving intervals, we need to be careful any time we introduce the same interval (e.g. through fraction reduction), since our interval package re-introduces the uncertainty, even if it shouldn't.
|#


;Exercise 2.15
#|
Eva Lu Ator, another user, has also noticed
the different intervals computed by different but algebraically
equivalent expressions. She says that a formula to compute
with intervals using Alyssa’s system will produce tighter
error bounds if it can be wrien in such a form that no vari-
able that represents an uncertain number is repeated. us,
she says, par2 is a “beer” program for parallel resistances
than par1 . Is she right? Why?
|#

#|
If its arguments r1 and/or r2 are uncertain values (i.e., they have non-zero width),
par1 will produce an overly pessimistic error bound for the computed parallel resistance
 because it uses the uncertain values r1 and r2 twice each in two different computations.
 By treating each distinct use of r1 and r2 in the computation as distinct uncertain values,
par1 overcompensates. The two distinct occurrences of r1 in the calculation refer to one actual
resistor, not two resistors with the same uncertainty. Stated another way, the value that
r1 may take is somewhere within its interval, but whatever value it does take, it's the same
value for both occurrences of r1 in the procedure. The interval arithmetic system we've devised
doesn't have a way of communicating that the uncertainty of any given value should only be accounted
 for once in the computation.
|#

;Exercise 2.16
#|
Explain, in general, why equivalent alge-
braic expressions may lead to different answers. Can you
devise an interval-arithmetic package that does not have
this shortcoming, or is this task impossible? (Warning: is
problem is very difficult.)
|#

;http://wiki.drewhess.com/wiki/SICP_exercise_2.16