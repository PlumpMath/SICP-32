#lang racket

;(put ⟨op ⟩ ⟨type ⟩ ⟨item ⟩) installs the ⟨item ⟩ in the table, indexed by the ⟨op ⟩ and the ⟨type ⟩.

;(get ⟨op ⟩ ⟨type ⟩) looks up the ⟨op ⟩, ⟨type ⟩ entry in the table and returns the item found there. If no item is found, get returns false.

(define (attach-tag type-tag contents) (cons type-tag contents))
(define (type-tag datum) (if (pair? datum) (car datum) (error "Bad tagged datum: TYPE-TAG" datum)))
(define (contents datum) (if (pair? datum) (cdr datum) (error "Bad tagged datum: CONTENTS" datum)))


(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No method for these types: APPLY-GENERIC"
           (list op type-tags))))))

;Exercise 2.74

(define divisionA-file
  (list
   (cons "Kevin" (list (cons "address" "Korea") (cons "salary" "$")))
   (cons "CH" (list (cons "address" "Seoul") (cons "salary" "$")))
   (cons "MJ" (list (cons "address" "Seoul") (cons "salary" "$")))
   ))

(define (install-divisionA)
  (define (first files) (car files))
  (define (name emp-file) (car emp-file))
  (define (record emp-file) (cdr emp-file))
  (define (salary emp-record) (cdadr emp-record))
           
  (define (get-record employee div-file)
    (cond ((null? div-file) null)
          ((eq? (name (first div-file)) employee) (record (first div-file)))
          (else (get-record employee (cdr div-file)))))

  (define (get-salary employee div-file)
    (let ((emp-record (get-record employee div-file)))
      (cond ((null? emp-record) null)
            (else (salary emp-record)))))
  
  (put `get-record `divisionA get-record)
  (put `get-salary `divisionA get-salary)
  `done)
    

;a - employees should be tagged with their corresponding divisions.
(define (get-record employee div-file)
  (apply-generic `get-record employee div-file))

;b - employees should be tagged with their corresponding divisions.
(define (get-salary employee div-file)
  (apply-generic `get-salary employee div-file))

;c
(define (find-employee-record employee all-files)
  (if (null? all-files) null
      (append (get-record (car all-files)) 
              (find-employee-record name (cdr list)))))

;d
;Represent new personnel information as a list, install new packages if any new division's
;file is organized as a different data structure.