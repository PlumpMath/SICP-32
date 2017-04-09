#lang planet neil/sicp

; 구현
(define (new-ref? x refs)
  (cond ((= (length refs) 0) #t)
        ((eq? x (car refs)) #f)
        (else (new-ref? x (cdr refs)))))
(define (is-cycle? x)
  (define (is-cycle?-iter remained visited)
    (if (not (pair? remained))
        #f
        (let ((candidate (cdr remained)))
          (if (not (new-ref? candidate visited))
              #t
              (is-cycle?-iter (cdr remained) (append visited (list candidate)))))))
  (is-cycle?-iter x '()))

; cyclic/acyclic list 준비
(define x1 (list 'a 'b 'c))
(set-cdr! (cddr x1) x1)
(define x2 (list 'd 'e 'f))

; 테스트
(is-cycle? x1) ; #t
(is-cycle? x2) ; #f