#lang racket
(require scheme/mpair)

(define (count-pairs x)
  (if (not (mpair? x))
      0
      (+ (count-pairs (mcar x))
         (count-pairs (mcdr x))
         1)))

;Exercise 3.17
(define (count-pairs-new x)
  (let ((counted-pairs (make-hasheq)))

    (define (in-counted-pairs? x)
      (hash-has-key? counted-pairs x))

    (define (put-in-counted-pairs x)
      (hash-set! counted-pairs x 1))
    
    (define (count-pairs x)
      (cond ((not (mpair? x)) 0)
            ((in-counted-pairs? x) 0)
            (else (put-in-counted-pairs x)
                  (+ (count-pairs (mcar x))
                     (count-pairs (mcdr x))
                     1))))

    (count-pairs x)))


;never return
(define a1 (mlist 1 2))
(define a2 (mcons 1 a1))

(set-mcdr! (mcdr a1) a2)

;(count-pairs a1)

(println "never return, now 3")
(count-pairs-new a1)


;return 4
(define b1 (mcons 2 2))
(define b2 (mcons 2 2))
(define b3 (mcons 2 2))

(set-mcar! b2 b1)
(set-mcdr! b2 b3)
(set-mcdr! b3 b1)

;4
(println "return 4")
(count-pairs b2)

;3
(println "now 3")
(count-pairs-new b2)


;return 7
(define c1 (mcons 3 3))
(define c2 (mcons 3 3))
(define c3 (mcons 3 3))

(set-mcar! c2 c1)
(set-mcdr! c2 c1)

(set-mcar! c1 c3)
(set-mcdr! c1 c3)

;7
(println "return 7")
(count-pairs c2)

;3
(println "now 3")
(count-pairs-new c2)

;Exercise 3.18
(define (is-loop-list? list)
  (let ((counted-list (make-hasheq)))
    (define (in-counted-list? list)
      (hash-has-key? counted-list list))

    (define (put-in-counted-list list)
      (hash-set! counted-list list 1))
    
    (define (traverse list)
      (cond ((null? list) #f)
            ((in-counted-list? list) #t)
            (else (put-in-counted-list list)
                  (traverse (mcdr list)))))
    (traverse list)))

;(println "no loop")
;(is-loop-list? (list 1 2 3 4))

(define (make-cycle x) (set-mcdr! (mcdr x) x) x)
(define z (make-cycle (mlist 'a 'b)))

(println "loop")
(is-loop-list? z)

;Exercise 3.19
(define (is-loop-list-const? list)
  (define (did-rabbit-reach-the-end? rabbit)
    (null? rabbit))

  (define (did-turtle-meet-the-rabbit? turtle rabbit)
    (eq? turtle rabbit))

  (define (walk-turtle turtle)
    (set! turtle (mcdr turtle))
    turtle)

  (define (walk-rabbit rabbit)
    
      (if (null? (mcdr rabbit))
          (set! rabbit (mcdr rabbit))
          (set! rabbit (mcdr (mcdr rabbit))))
      rabbit)
  
  (define (traverse turtle rabbit)
    (cond ((did-rabbit-reach-the-end? rabbit) #f)
          ((did-turtle-meet-the-rabbit? turtle rabbit) #t)
          (else (traverse (walk-turtle turtle) (walk-rabbit rabbit)))))

  (if (null? list)
      #f
      (let ((turtle list)
            (rabbit (mcdr list)))
        (traverse turtle rabbit))))

(println "constant space loop")
(is-loop-list-const? z)

(println "constant space no loop")
(is-loop-list-const? (mlist 1 2 3 4 5))


