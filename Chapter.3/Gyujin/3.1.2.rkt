#lang racket

#|
3 Modularity, Object, and State
3.1 Assignment and Local State
3.1.2 The Benefits of Introducing Assignment
|#

(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))

(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

(define (mote-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= tirals-remaining 0)
           (/ trials-passed tirals))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

#| Exercise 3.5 |#

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-integral p x1 x2 y1 y2 trials)
  (* (* (- x2 x1) (- y2 y1))
     (monte-carlo trials (p (random-in-rage x1 x2) (random-in-range y1 y2)))))

#| Exercise 3.6 |#

(define (rand2 m)
  (let ((x random-init))
    (cond ((eq? m 'generate) (begin (set! x (rand-update x)) x))
          ((eq? m 'reset) (lambda (init) (set! x init)))
          (else (error "Dunno wut u sayn")))))

