#lang racket
(require scheme/mpair)

(define (cons x y)
  (define (set-x! v) (set! x v))
  (define (set-y! v) (set! y v))
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          ((eq? m 'set-car!) set-x!)
          ((eq? m 'set-cdr!) set-y!)
          (else (error "Undefined operation: CONS" m))))
  dispatch)

(define (car z) (z 'car))
(define (cdr z) (z 'cdr))
(define (set-car! z new-value)
  ((z 'set-car!) new-value) z)

(define (set-cdr! z new-value)
  ((z 'set-cdr!) new-value) z)

;Exercise 3.20
(define x (cons 1 2))

;
; +---------------------------+
; |  Global                   |            +-------------------------------------------+
; |    (define x (cons 1 2)  -|--> +-------------+                                     |
; |            |              |    |x:1(17)  y: 2|----context                          |
; |            |              |    | set-x!      |      |                              |
; |            |              |    | set-y!      |    +------+                         |
; |            +--------------|----|-dispatch ---|--- | o  o-|---> paramters: m        |
; |                           |    +-------------+    +------+     body: ~             |
; |                           |                        |            |                  |
; |    (define z (cons x x)  -|--> +-------------+     |            |                  |
; |            |              |    |   +-----+---|-----+            |                  |
; |            |              |    |   x     y   |                  |                  |
; |            +--------------|-+  | set-x!      |                  |                  |
; |   cons                    | |  | set-y!      |    +------+      |                  |
; +---------------------------+ ---|-dispatch ---|--- | o  o-|-------                  |
; | |  |    +---+                  +-------------+    +------+                         |
; | |  +--> | o |--> parameters: x y    |   |           |                              |
; | |       | o |    body : ~           |   +---------context                          |
; | |       +---+                       |                                              |
; | |         |                         |                                              |
; | +------context                      |                                              |
; |                                     |                                              |
; |                                     |                                              |
; |                              +------+                                              |
; |                              |                                                     |
; |                              |            returns y in the previous environment,   |
; |                              |  (cdr z) : which is the dispatch procedure 'x'.     |
; |                              | +---------+                                         |
; |                              --| m: 'cdr |                                         |
; |                                +---------+                                         |
; |                                                                                    |
; |                                                                                    |
; |  (set-car! 'x' 17)                                                                 |
; |  +----------------+                                                                |
; ---| z: 'x'         |                                                                |
;    | new-value: 17  |    +-------------+                                             |
;    | (z 'set-car!) -|--->| m: `set-car!|---------------------------------------------+
;    |                |    +-------------+                                             |
;    |                |    +-------------+                                             |
;    | (set-x 17)    -|--->| v: 17       |---------------------------------------------+
;    |                |    +-------------+
;    +----------------+


(define (front-ptr queue)
  (mcar queue))

(define (rear-ptr queue)
  (mcdr queue))

(define (set-front-ptr! queue item)
  (set-mcar! queue item))

(define (set-rear-ptr! queue item)
  (set-mcdr! queue item))

(define (empty-queue? queue)
  (null? (front-ptr queue)))

(define (make-queue)
  (mcons '() '()))

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (mcar (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (mcons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-mcdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else (set-front-ptr! queue (cdr (front-ptr queue)))
              queue)))

;Exercise 3.21
;It's not that the inserted items are being inserted twice, it's just showing
;that way because currently the queue is printed as the front pointer and the
;rear pointer.

(define (print-queue queue)
  (print (front-ptr queue)))

(define q1 (make-queue))
(insert-queue! q1 'a)
(insert-queue! q1 'b)
(print-queue q1)

(println "")

;Exercise 3.22
(println "Exercise 3.22")
(define (make-queue-proc)
  (let ((front-ptr '())
        (rear-ptr '()))

    (define (empty-queue?)
      (null? front-ptr))
    
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue")
          (mcar front-ptr)))

    (define (insert-queue value)
      (let ((new-pair (mcons value '())))
        (cond ((empty-queue?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair))
              (else
               (set-mcdr! rear-ptr new-pair)
               (set! rear-ptr new-pair)))))

    (define (delete-queue)
      (cond ((empty-queue?) (error "DELETE! called with an empty queue"))
            (else (set! front-ptr (mcdr front-ptr)))))

    (define (print-queue)
      (println front-ptr))
    
    (define (dispatch m)
      (cond ((eq? m 'print-queue) (print-queue))
            ((eq? m 'front-queue) (front-queue))
            ((eq? m 'delete-queue) (delete-queue))
            ((eq? m 'insert-queue) insert-queue)
            (else (error "Undefined operation: " m))))
    dispatch))

(define q2 (make-queue-proc))
(println "initial queue")
(q2 'print-queue)

((q2 'insert-queue) 1)
(println "insert 1")
(q2 'print-queue)
(println "first item")
(q2 'front-queue)

((q2 'insert-queue) 2)
(println "insert 2")
(q2 'print-queue)

(q2 'delete-queue)
(println "delete once")
(q2 'print-queue)

(println "first item")
(q2 'front-queue)

(println "delete twice")
(q2 'delete-queue)
(q2 'print-queue)