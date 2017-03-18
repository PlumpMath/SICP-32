#lang racket

; a.
; list 길이가 홀수 (2k+1 인 경우) : 첫 k 개로 tree 만들고, 마지막 k 개로 tree 만들고 가운데 하나를 root 로 해서 tree 를 만든다.
; list 길이가 짝수 (2k 인 경우) : 첫 k-1 개로 tree 만들고, 마지막 k 개로 tree 만들고 가운데 하나를 root 로 해서 tree 를 만든다.

; b.
; T[n] = 2 * T[n/2] + O(1)
; ===> T[n] = O(n)

(require "tree.rkt")
(provide list->tree)

(define (list->tree elements)
  (car (partial-tree elements (length elements))))
(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result
               (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result
                   (partial-tree
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts
                     (cdr right-result)))
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))

; (list->tree '(1 3 5 7 9 11))
;         5
;      /     \
;     1       9
;      \     / \
;       3   7   11
