#lang racket
(define (filter predicate sequence)
  (cond ((null? sequence) null)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (remove item sequence) (filter (lambda (x) (not (= x item))) sequence))

(define (flatmap proc seq) (accumulate append null (map proc seq)))

(define (permutations s)
  (if (null? s) ; empty set?
      (list null) ; sequence containing empty set
      (flatmap (lambda (x) (map (lambda (p) (cons x p))
                                (permutations (remove x s))))
               s)))




(define (square x) (* x x))
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))
(define (prime? n) (= n (smallest-divisor n)))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

(define (prime-sum? pair) (prime? (+ (car pair) (cadr pair))))
(define (make-pair-sum pair) (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (flatmap
                           (lambda (i)
                             (map (lambda (j) (list i j))
                                  (enumerate-interval 1 (- i 1))))
                           (enumerate-interval 1 n)))))

;Exercise 2.40
(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map (lambda (j) (list i j))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

(define (prime-sum-pairs-new n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))

;Exercise 2.41
(define (ordered-triples n)
  (flatmap
   (lambda (i)
     (flatmap (lambda (j)
            (map (lambda (k) (list i j k))
                 (enumerate-interval 1 (- j 1))))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 3 n)))

(ordered-triples 10)

(define (make-triple-sum pair)
  (list (car pair) (car (cdr pair)) (car (cdr (cdr pair))) (+ (car pair) (car (cdr pair)) (car (cdr (cdr pair))))))

(define (s-sum? s)
  (lambda (pair)
        (equal? s (+ (car pair) (car (cdr pair)) (car (cdr (cdr pair)))))))

(define (triple-sum-s n s)
  (map make-triple-sum
       (filter (s-sum? s) (ordered-triples n))))

(triple-sum-s 10 10)