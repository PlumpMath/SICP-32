#lang racket

; Theta(n) 짜리 union-set / intersection-set 을 만들라....
; 각각의 tree-set 을 list-set 으로 펼치고, (
; list-set 을 union-set 하고,
; 그 결과를 다시 tree-set 으로 만든다.

(require "tree.rkt" "2.62_LCH.rkt" "2.64_LCH.rkt")

(define tree1 (make-tree 2
                         (make-tree 1 '() '())
                         (make-tree 3 '() '())))
(define tree2 (make-tree 5
                         (make-tree 4 '() '())
                         (make-tree 6
                                    '()
                                    (make-tree 7 '() '()))))

(define (union-set tree-set1 tree-set2)
  (let ((list-set1 (tree->list-2 tree-set1))
        (list-set2 (tree->list-2 tree-set2)))
    (let ((unified-list-set (union-list-set list-set1 list-set2)))
      (list->tree unified-list-set))))

(union-set tree1 tree2)