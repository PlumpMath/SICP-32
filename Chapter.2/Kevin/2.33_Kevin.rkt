#lang racket

#|
The key to organizing programs so as to more clearly reflect the signal
flow structure is to concentrate on the “signals” that flow from one stage
in the process to the next. If we represent these signals as lists, then we can
use list operations to implement the processing at each of the stages. For instance,
we can implement the mapping stages of the signal-flow diagrams using the map
procedure from Section 2.2.1:
|#

(define (square x)
  (* x x))

(define (filter predicate sequence)
  (cond ((null? sequence) null)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (sum-odd-squares tree)
  (accumulate + 0 (map square (filter odd? (enumerate-tree tree)))))

#|
The value of expressing programs as sequence operations is that this helps us
make program designs that are modular, that is, designs that are constructed by
combining relatively independent pieces. We can en- courage modular design by
providing a library of standard components together with a conventional interface
for connecting the components in ﬂexible ways.
|#

#|
We can also formulate conventional data-processing applications in terms of
sequence operations. Suppose we have a sequence of personnel records and we
want to ﬁnd the salary of the highest-paid programmer. Assume that we have a
selector salary that returns the salary of a record, and a predicate programmer?
that tests if a record is for a programmer. Then we can write
|#

;(define (salary-of-highest-paid-programmer records) (accumulate max 0 (map salary (filter programmer? records))))

#|
Sequences, implemented here as lists, serve as a conventional interface that
permits us to combine processing modules. Additionally, when we uniformly
represent structures as sequences, we have local- ized the data-structure
dependencies in our programs to a small number of sequence operations.
By changing these, we can experiment with al- ternative representations of
sequences, while leaving the overall design of our programs intact. We will
exploit this capability in Section 3.5, when we generalize the sequence-processing
paradigm to admit inﬁnite sequences.
|#

;Exercise 2.33

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) null sequence))
(define (append seq1 seq2)
  (accumulate cons seq1 seq2))
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))