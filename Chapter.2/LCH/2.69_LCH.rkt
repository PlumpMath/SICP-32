#lang racket

(require "huffman.rkt")
(provide generate-huffman-tree)

; implementations
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))
(define (successive-merge leaf-set)
  (if (< (length leaf-set) 2)
      (car leaf-set)
      (successive-merge (adjoin-set
                         (make-code-tree (car leaf-set) (cadr leaf-set))
                         (cddr leaf-set)))))

; test
(define pairs (list '(A 4) '(B 2) '(D 1) '(C 1)))
; (symbols (generate-huffman-tree pairs))