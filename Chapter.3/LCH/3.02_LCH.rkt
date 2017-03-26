#lang racket

(define (make-monitored f)
  (let ((count 0))
    (lambda (arg)
      (cond ((eq? arg 'how-many-calls?) count)
            ((eq? arg 'reset-count) (set! count 0))
            (else (begin (set! count (+ count 1))
                         (f arg)))))))

(define s (make-monitored sqrt))
(s 100) ; 10
(s 'how-many-calls?) ; 1
(s 'reset-count)
(s 'how-many-calls?) ; 0