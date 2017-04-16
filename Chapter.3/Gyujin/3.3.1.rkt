#lang planet neil/sicp

#| Exercise 3.12 |#

#|(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define x (list 'a 'b))
(define y (list 'c 'd))|#
#|(define z (append x y))

z

(cdr x)
#| (b) |#

(define w (append! x y))

w

(cdr x)
#| (b c d) |#
|#

#| Exercise 3.13 |#

#|(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c)))|#

#|(last-pair z)|#

#| Exercise 3.14 |#

#|(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

(define v (list 'a 'b 'c 'd))

(define w (mystery v))

(list 'a 'b 'c 'd)

v
#| (a b c d) |#

w
#| (d c b a) |#

#|||||||||||||||||||||||||||#


(define x2 (list 'a 'b))
(define z2 (cons x2 x2))
x2
z2|#

#| Exercise 3.16 |#

#|(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define test (cons (list 'x 'y) '()))
(pair? test)
(car test)
(cdr test)

(count-pairs test)|#

#| It cannot cover if any pair is shared or makes cycle |#

#| Exercise 3.17
Right count-pairs function should cache counted pairs in separate list and compare with eq? while preceeding counting |#


#| Exercise 3.18
End procedure if it meets the start of cycle, like the first cached pair
|#

#| Exercise 3.19
No idea. 
|#

#|
(define (cons x y)
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          (else (error "Undefined operation -- CONS" m))))
  dispatch)
(define (car z) (z 'car))
(define (cdr z) (z 'cdr))
|#

(define (cons x y)
  (define (set-x! v) (set! x v))
  (define (set-y! v) (set! y v))
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          ((eq? m 'set-car!) set-x!)
          ((eq? m 'set-cdr!) set-y!)
          (else (error "Undefined operation -- CONS" m))))
  dispatch)

(define (car z) (z 'car))
(define (cdr z) (z 'cdr))
(define (set-car! z new-value)
  ((z 'set-car!) new-value)
  z)
#|(define (set-cdr! z new-value)
  ((z 'set-cdr!) new-value)
  z|#

(define x4 (cons 1 2))
(define z4 (cons x4 x4))
x4
z4
(set-car! (cdr z4) 17)

(car x4)




