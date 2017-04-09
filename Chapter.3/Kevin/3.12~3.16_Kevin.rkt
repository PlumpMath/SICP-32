#lang planet neil/sicp
;Chapter 3.3

;Data objects for which mutators are deﬁned are known as mutable data objects.

;Exercise 3.12
(define (append x y) (if (null? x) y (cons (car x) (append (cdr x) y))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
z
; b null
(cdr x)

(define w (append! x y))
w
;b (c d)
(cdr x)

;Exercise 3.13
(define (make-cycle x) (set-cdr! (last-pair x) x) x)

(define cycle (make-cycle (list 'a 'b 'c)))

;  ,-------------------,
;  |                   |
;  v                   |
; ( . ) -> ( . ) -> ( . )
;  |        |        |
;  v        v        v
;  'a       'b       'c

;Exercise 3.14
(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

(define v (list 'a 'b 'c 'd))

;v
;
; ( 'a ) ( . ) --> ( 'b ) ( . ) --> ( 'c ) ( . ) --> ( 'd ) ( null )
;


(define m (mystery v))

;m
;
; ( 'd ) ( . ) --> ( 'c ) ( .) --> ( 'b ) ( . ) --> ( 'a ) ( null )
;


;On the other hand, sharing can also be dangerous, since modi- ﬁcations made to structures will also a
;ﬀect other structures that happen to share the modiﬁed parts. The mutation operations set-car! and se
;t-cdr! should be used with care; unless we have a good understanding of how our data objects are sha
;red, mutation can have unanticipated results.

;Exercise 3.15
;
;     z1
; +-------+
; | . | . |
; +---+---+
;   ↓   ↓
; +---------+    +-------+ 
; | wow | . | -> | b | / |
; +-----+---+    +-------+
;     x

;Exercise 3.16
;
;                         z2
;                     +-------+
;                     | . | . |
;                     +---+---+
;                       ↓   ↓
; +---------+    +-------+  +-------+    +-------+
; | wow | . | -> | . | / |  | a | . | -> | . | / +
; +-----+---+    +-------+  +-------+    +-------+
;                  |                       |
;                  |                       |
;                  +-------> b <-----------+
;
; 'a used be shared, but 'a in (car (car z2)) was replaced by 'wow

;Exercise 3.16
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))



;1. never return
(define a1 (list 1 2))
(define a2 (cons 1 a1))

(set-cdr! (cdr a1) a2)

;(count-pairs a1)

;2. return 4
(define b1 (cons 2 2))
(define b2 (cons 2 2))
(define b3 (cons 2 2))

(set-car! b2 b1)
(set-cdr! b2 b3)
(set-cdr! b3 b1)

b2
(eq? (cdr b3) b1)
(count-pairs b2)

;3. return 7
(define c1 (cons 3 3))
(define c2 (cons 3 3))
(define c3 (cons 3 3))

(set-car! c2 c1)
(set-cdr! c2 c1)

(set-car! c1 c3)
(set-cdr! c1 c3)

(count-pairs c2)

