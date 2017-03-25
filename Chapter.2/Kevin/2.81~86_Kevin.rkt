#lang racket

(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) '()))

(define (attach-tag type-tag contents) (cons type-tag contents))
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: CONTENTS" datum)))

(define *coercion-table* make-hasheq)

(define (put-coercion type-from type-to proc)
  (hash-set! 
    *coercion-table* 
    (list type-from type-to) 
    proc))

(define (get-coercion type-from type-to)
  (hash-ref! 
    *coercion-table* 
    (list type-from type-to) 
    #f))


;Exercise 2.81
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (if (equal? type1 type2)
                    (error "No method for this type" (list op type1))
                    (let ((t1->t2 (get-coercion type1 type2))
                          (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2 (apply-generic op (t1->t2 a1) a2))
                            (t2->t1 (apply-generic op a1 (t2->t1 a2)))
                            (else (error "No method for these types"
                                         (list op type-tags)))))))
                (error "No method for these types" (list op type-tags)))))))

;a - infinite recursion
;b - it just works as is

;Eli Bendersky's solutions
;Exercise 2.82
(define (apply-generic-new op . args)
  (define (can-coerce-into? types target-type)
    "Can all _types_ be coerced into _target-type_ ?" 
    (andmap 
      (lambda (type)
        (or
          (equal? type target-type)
          (get-coercion type target-type)))
      types))
  (define (find-coercion-target types)
    "Find a type among _types_ that all _types_ can be
    coerced into." 
    (ormap
      (lambda (target-type)
        (if (can-coerce-into? types target-type)
          target-type
          #f))
      types))
  (define (coerce-all args target-type)
    "Coerce all _args_ to _target-type_" 
    (map 
      (lambda (arg)
        (let ((arg-type (type-tag arg)))
          (if (equal? arg-type target-type)
            arg
            ((get-coercion arg-type target-type) arg))))
      args))
  (define (no-method type-tags)
    (error "No method for these types" 
      (list op type-tags)))      
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (let ((target-type (find-coercion-target type-tags)))
          (if target-type
            (apply
              apply-generic
              (append 
                (list op)
                (coerce-all args target-type)))
            (no-method type-tags)))))))

;Exercise 2.83
;; Into integer package
(define (integer->rational n)
  (make-rational n 1))

(put 'raise '(integer)
  (lambda (i) (integer->rational i)))

;; Into rational package
(define (rational->real r)
  (make-real
    (exact->inexact
      (/ (numer r) (denom r)))))

(put 'raise '(rational)
  (lambda (r) (rational->real r)))

;; Into real package
(define (real->complex r)
  (make-complex-from-real-imag r 0))

(put 'raise '(real)
  (lambda (r) (real->complex r)))

(define (raise x)
  (apply-generic 'raise x))

;Exercise 2.84
(define (apply-generic-r op . args)
  (define (no-method type-tags)
    (error "No method for these types" 
      (list op type-tags)))      
  (define (raise-into s t)
    "Tries to raise s into the type of t. On success, 
    returns the raised s. Otherwise, returns #f" 
    (let ((s-type (type-tag s))
          (t-type (type-tag t)))
      (cond 
        ((equal? s-type t-type) s)
        ((get 'raise (list s-type))
          (raise-into ((get 'raise (list s-type)) (contents s)) t))
        (t #f))))

  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
            (let ((o1 (car args))
                  (o2 (cadr args)))
              (cond 
                ((raise-into o1 o2)
                  (apply-generic-r op (raise-into o1 o2) o2))
                ((raise-into o2 o1)
                  (apply-generic-r op o2 (raise-into o2 o1)))
                (t (no-method type-tags))))
            (no-method type-tags))))))


;Exercise 2.85
(define (drop num)
  (let ((project-proc 
          (get 'project (list (type-tag num)))))
    (if project-proc
      (let ((dropped (project-proc (contents num))))
        (if (equ? num (raise dropped))
          (drop dropped)
          num))
      num)))

(define (apply-generic-r op . args)
  (define (no-method type-tags)
    (error "No method for these types" 
      (list op type-tags)))      
  (define (raise-into s t)
    "Tries to raise s into the type of t. On success, 
    returns the raised s. Otherwise, returns #f" 
    (let ((s-type (type-tag s))
          (t-type (type-tag t)))
      (cond 
        ((equal? s-type t-type) s)
        ((get 'raise (list s-type))
          (raise-into ((get 'raise (list s-type)) (contents s)) t))
        (t #f))))

  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (drop (apply proc (map contents args)))
          (if (= (length args) 2)
            (let ((o1 (car args))
                  (o2 (cadr args)))
              (cond 
                ((raise-into o1 o2)
                  (apply-generic-r op (raise-into o1 o2) o2))
                ((raise-into o2 o1)
                  (apply-generic-r op o2 (raise-into o2 o1)))
                (t (no-method type-tags))))
            (no-method type-tags))))))

