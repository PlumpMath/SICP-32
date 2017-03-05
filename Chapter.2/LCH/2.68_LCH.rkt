#lang racket

(require "huffman.rkt")
(provide encode)

; given
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

; implementations
(define (encode-symbol symbol tree)
  (define (encode-symbol-1 symbol current-branch current-code)
    (if (element-of-set? symbol (symbols current-branch))
        (cond ((leaf? current-branch) current-code)
              ((element-of-set? symbol (symbols (left-branch current-branch)))
               (encode-symbol-1 symbol (left-branch current-branch) (append current-code '(0))))
              (else (encode-symbol-1 symbol (right-branch current-branch) (append current-code '(1)))))
        (error "bad symbol:" symbol)))
  (encode-symbol-1 symbol tree '()))
(define (element-of-set? symbol symbols)
  (cond ((null? symbols) #f)
        ((eq? symbol (car symbols)) #t)
        (else (element-of-set? symbol (cdr symbols)))))

; test
; expect (0 1 1 0 0 1 0 1 0 1 1 1 0)
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree (make-leaf 'B 2)
                                  (make-code-tree (make-leaf 'D 1)
                                                  (make-leaf 'C 1)))))
(encode '(A D A B B C A) sample-tree)
