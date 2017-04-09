#lang planet neil/sicp

; 구현
(define (new-pair? x pairs)
  (cond ((not (pair? x)) #f)
        ((= (length pairs) 0) #t)
        ((eq? x (car pairs)) #f)
        (else (new-pair? x (cdr pairs)))))
(define (count-pairs x)
  (define (count-pairs-iter remained visited)
    (if (= (length remained) 0)
        (length visited)
        (let ((candidate (car remained)))
          (if (new-pair? candidate visited)
              (count-pairs-iter (append (cdr remained) (list (car candidate) (cdr candidate)))
                                (append visited (list candidate)))
              (count-pairs-iter (cdr remained) visited)))))
  (count-pairs-iter (list x) '()))

; 테스트 데이터 준비
(define x1 (list 'a 'b 'c))
(define y2 (list 'b))
(define x2 (cons 'a (cons y2 y2)))
(define z3 (list 'a))
(define y3 (cons z3 z3))
(define x3 (cons y3 y3))

; 테스트
(count-pairs x1)
(count-pairs x2)
(count-pairs x3)