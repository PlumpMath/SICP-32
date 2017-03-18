#lang racket

;;Sets as unordered list
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2) (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))


;Exercise 2.59
(define (union-set set1 set2)
  (append set1 (filter (lambda (x) 
                        (not (element-of-set? x set1))) 
                      set2)))

;Exercise 2.60
(define (element-of-set-dup? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set-dup? x (cdr set)))))

(define (adjoin-set-dup x set)
      (cons x set))

(define (intersection-set-dup set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2) (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set-dup set1 set2)
  (append set1 set2))

;;Sets as ordered list
(define (element-of-set-ordered? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set-ordered? x (cdr set)))))

(define (intersection-set-ordered set1 set2)
  (if (or (null? set1) (null? set2)) '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2) (cons x1 (intersection-set-ordered (cdr set1) (cdr set2))))
              ((< x1 x2) (intersection-set-ordered (cdr set1) set2))
              ((< x2 x1) (intersection-set-ordered set1 (cdr set2)))))))

;Exercise 2.61
(define (adjoin-set-ordered x set) 
   (cond ((or (null? set) (< x (car set))) (cons x set)) 
         ((= x (car set)) set) 
         (else (cons (car set) (adjoin-set-ordered x (cdr set))))))

;Exercise 2.62
(define (union-set-ordered set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (let ((x1 (car set1)) (x2 (car set2)))
          (cond ((= x1 x2) (cons x1 (union-set-ordered (cdr set1) (cdr set2))))
                ((< x1 x2) (union-set-ordered (cdr set1) set2))
                ((< x2 x1) (union-set-ordered set1 (cdr set2))))))))
