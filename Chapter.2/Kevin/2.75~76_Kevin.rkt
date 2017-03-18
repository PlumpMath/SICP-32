#lang racket

;Exercise 2.75
(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op `real-part) (* r (cos a)))
          ((eq? op `imag-part) (* r (sin a)))
          ((eq? op `magnitude) r)
          ((eq? op `angle) a)
          (else (error "Unknown op: MAKE-FROM-MAG-ANG" op))))
  dispatch)

;Exercise 2.76
#|
As a large system with generic operations evolves, new types of data objects or
new operations may be needed. For each of the three strategies—generic operations
with explicit dispatch, data-directed style, and message-passing style—describe
the changes that must be made to a system in order to add new types or new operations.

Which organization would be most appropriate for a system in which new types must
often be added? Which would be most appropriate for a system in which new operations
must often be added?
|#

;generic operations with explicit dispatch
#|
Let's say I had to add a new type apart from 'rectangular' or 'polar'. Let's say it's called 'another'

For all the interfaces(real-part, imag-part etc.) I have to...
1. Add another check to see if the given representation has a tag 'another'.
2. Call the corresponding procedure which of course has to be newly implemented.
|#


;data-directed style
#|
(put op type procedure)
|#

;message-passing style
#|
add (define (make-from-type ..)
|#