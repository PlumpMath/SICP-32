#lang racket
;3.2
;Rather, a variable must somehow designate a “place” in which values can be stored.
;In our new model of evaluation, these places will be maintained in structures called environments.

;For example, the idea that + is the sym- bol for addition is captured by saying that the symbol + is
;bound in the global environment to the primitive addition procedure.

;To apply a procedure to arguments, create a new environment containing a frame that binds the paramet
;ers to the values of the arguments. The en- closing environment of this frame is the environment spec
;iﬁed by the procedure. Now, within this new environment, evaluate the procedure body.

;Exercise 3.9
(define (factorial n) (if (= n 1) 1 (* n (factorial (- n 1)))))

;(factorial 6)
;1. E1, n is bound to 6
;2. goes into E2, n is bound to 5
;3. goes into E3, n is bound to 4
;...
;6. goes into E6, n is bound to 1, in which case (factorial 1) returns 1
;goes back to 5, 4, 3, 2, 1 and exits

(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))
;1. E1, n is bound to 6
;2. returns E2(fact-iter), product=1, counter=1, max-count=6
;3. returns E3(fact-iter), product=1, counter=2, max-count=6
;...



;The next time W1 is called, this will build a new frame that binds amount and whose enclosing environ
;ment is E1. We see that E1 serves as the “place” that holds the local state variable for the procedur
;e object W1. Figure 3.9 shows the situation after the call to W1.

;Exercise 3.10
;The only difference is that in the second case, 'let' procedure call creates a new
;environment


;The environment model
;1.The names of the local procedures do not interfere with names external to the enclosing procedure,
;because the local procedure names will be bound in the frame that the procedure creates when it is ru
;n, rather than being bound in the global environment.

;2.The local procedures can access the arguments of the enclosing procedure, simply by using paramete
;r names as free variables. This is because the body of the local procedure is evaluated in an environ
;ment that is subordinate to the evaluation environment for the enclosing procedure.

;Execise 3.11
;balance, withdraw, deposit, dispatch is kept in a seperate environment
;Maybe the procedures are shared between acc and acc2?

;footnote 15
;Whether W1 and W2 share the same physical code stored in the computer, or whether they each keep a co
;py of the code, is a detail of the implementation. For the interpreter we implement in Chapter 4, the code is in fact shared.
