#lang planet neil/sicp

#| 3.3.3 Representing Tables |#

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        false)))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value) (cdr table))))))

(define (make-table)
  (list '*table*))

(define (lookup2 key-1 key-2 table)
  (let ((subtable (assoc key-1 (cdr table))))
    (if subtable
        (let ((record (assoc key-2 (cdr subtable))))
          (if record
              (cdr record)
              false))
        false)))

(defint (insert! key-1 key-2 value table)
  (let ((subtable (assoc key-1 (cdr table))))
    (if subtable
        (let ((record (assoc key-2 (cdr subtable))))
          (if record
              (set-cdr! record value)
              (set-cdr! subtable
                        (cons (cons key-2 value)
                              (cdr subtable)))))
        (set-cdr! table
                  (cons (list key-1
                              (cons key-2 value))
                        (cdr table)))))
  'ok)


(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                   (cdr record)
                   false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))
 
(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

#| Exercise 3.24 |#

(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    (define (assoc key records)
      (cond ((null? records) false)
        ((same-key? key (caar records)) (car records))
        (else (assoc key (cdr records)))))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                   (cdr record)
                   false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))


#| Exercise 3.25 |#


#|

(define (match-list-iter list-1 list-2)
  (if (not (memq? (car list-1) list-2))
      false
      (match-list-iter (cdr list-1) list-2)))

(define (same-keys? keys-1 keys-2)
  (cond ((eq? keys-1 keys-2) true)
        ((match-list-iter keys-1 keys-2) true)
        (else false)))
        
(define (assoc keys records)
  (let ((record (assoc keys (cdr table))))
    (cond ((null? records) false)
        ((same-keys? keys (caar records)) (car records))
        (else (assoc keys (cdr records))))))

(define (lookup keys-1 keys-2 table)
  (let ((subtable (assoc keys-1 (cdr table))))
    (if subtable
        (let ((record (assoc keys-2 (cdr subtable))))
          (if record
              (cdr record)
              false))
        false)))

(define (insert! keys-1 keys-2 value table)
  (let ((subtable (assoc keys-1 (cdr table))))
    (if subtable
        (let ((record (assoc keys-2 (cdr subtable))))
          (if record
              (set-cdr! record value)
              (set-cdr! subtable
                        (cons (cons keys-2 value)
                              (cdr subtable)))))
        (set-cdr! table
                  (cons (list keys-1
                              (cons keys-2 value))
                        (cdr table)))))
  'ok)

Wrong |#

#|(define (attach-new-pair! keys value pair)
  (let ((new-pair (list (cons (car keys) '()))))
    (set-cdr! pair new-pair)
    (if (null? (cdr keys))
        (set-cdr! (car new-pair) value)
        (attach-new-pair! (cdr keys) value (car new-pair)))))

(define (get-last-pair list)
  (cond (null? (cdr list) list)
        (else (get-last-pair (cdr list)))))

Not efficient|#

(define (make-table)
  (list '*table*))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (lookup keys table)
  (display table)
  (let ((record (assoc (car keys) (cdr table))))
    (if record
        (cond ((null? (cdr keys)) (cdr record))
              ((list? record) (lookup (cdr keys) record))
              (else false))
        false)))

(define (attach-new-pair! keys value pair)
  (let ((new-pair (cons (car keys) '())))
    (set-cdr! pair
              (cons new-pair (cdr pair)))
    (if (null? (cdr keys))
        (set-cdr! new-pair value)
        (attach-new-pair! (cdr keys) value new-pair))))
        
(define (insert! keys value table)
  (let ((record (assoc (car keys) (cdr table))))
    (if record
        (cond ((null? (cdr keys)) (set-cdr! record value))
              ((list? record) (insert! (cdr keys) value record))
              (else (attach-new-pair! (cdr keys) value record)))
        (attach-new-pair! keys value table)))
  'ok)

(define table (make-table))

(insert! (list 'a) 1 table)

(lookup (list 'a) table)

(insert! (list 'a 'b 'c) 2 table)

(lookup (list 'a 'b 'c) table)
   

#| Exercise 3.26 |#

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        ((< key (caar records)) (assoc key (cdar records)))
        ((> key (caar records)) (assoc key (cddr records)))
        (else 'Error)))

(define (insert-bin-tree! key value records)
  (let ((new-pair (cons (cons (key value)) (cons '() '()))))
    (cond ((equal? key (caar records)) (set-cdr! (car records) new-pair) new-pair)
          ((< key (caar records))
           (if (null? (cdar records))
               ((set-car! (cdr records) new-pair) new-pair)
               (insert-bin-tree! key (cdar records)))
           ((> key (caar records))
            (if (null? (cddr records))
                ((set-cdr! (cdr records) new-pair) new-pair)
                (insert-bin-tree! key (cddr records))))
           (else 'Error)))))

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                   (cadr record)
                   false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (insert-bin-tree! key-2 value subtable)
            (let ((new-node-1 (insert-bin-tree key-1 '() local-table)))
              (insert-bin-tree key-2 value new-node-1))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))
 

#| Exercise 3.27 |#


(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let (result (f x)))
              (insert! x result table)
              result)))))

(define memo-fib
  (memoize (lambda (n)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))

