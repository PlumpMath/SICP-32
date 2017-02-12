#lang racket

(define l (list 1 2 3))

;2.17
(define (last-pair l)
  (list (list-ref l (- (length l) 1)))
)

;2.18
(define (reverse l)
  (define (reverse-iter l)
    (if (= (length l) 1)
         (car l)
        (cons (reverse-iter (cdr l)) (car l))))
  (reverse-iter l)
  )

;(reverse (list 1 2 3 4))
#|
 length: contract violation
  expected: list?
  given: '((2) . 1)
|#

;2.19


;2.21
(define (square-list l)
  (if (null? l)
      null
      (cons (* (car l) (car l)) (square-list (cdr l)))
      )
  )
(define (square-list2 l)
  (map (lambda (x) (* x x))
       l)
  )

;2.22
(define (square-list22 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    ((lambda (x) (* x x))(car things))))))
  (iter items null))

;2.23
(define (for-each proc l)
  (define (iter l)
    (if (null? l)
        null
        ((proc (car l))
         (iter (cdr l)))))
  (iter l)
  )

;(for-each (lambda (x) (newline) (display x)) l)
#|
application: not a procedure;
 expected a procedure that can be applied to arguments
  given: #<void>
  arguments...:
|#

;2.24
(define l24 (list 1 (list 2 (list 3 4))))

;2.25
(define l251 (list 1 3 (list 5 7) 9))
(define l252 (list (list 7)))
(define l253 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 (list 7))))))))

;(car (cdr (car (cdr (cdr l251)))))
;(car (car l252))
;(car (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr l253))))))))))))) ; strange

;2.26
(define x26 (list 1 2 3))
(define y26 (list 4 5 6))

;(append x26 y26) ;'(1 2 3 4 5 6)
;(cons x26 y26) ;'((1 2 3) 4 5 6)
;(list x26 y26) ;'((1 2 3) (4 5 6))

;2.27
(define x27 (list (list 1 2) (list 3 4)))
#|
(define (deep-reverse l)
  (define (reverse-iter l)
    (if (and (equal? (list? (car l)) false) (= (length l) 1))
        l
        (append (reverse-iter (cdr l))
              (if (and (list? (car l)) (> (length (car l)) 1))
                  (reverse-iter (car l))
                  (car l)))))
  (reverse-iter l))
(deep-reverse (cdr x27))
|#

;2.28
#|
(define (fringe l)
  (define (iter l)
    (define next (if (list? (car l))
        (iter (car l))
        (if (null? l)
            null
            (iter (cdr l)))))
    (append (car l) next))
  (iter l))
(fringe ((list 1 2) (list 3 4))
|#

;2.29
