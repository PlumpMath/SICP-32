#lang racket

;Exercise 2.22
;NEEDS DISCUSSION
  
 (define (square-list items) 
   (define (iter things answer) 
     (if (null? things) 
         answer 
         (iter (cdr things) 
               (cons (square (car things)) answer)))) 
   (iter items null)) 
  
 (square-list (list 1 2 3 4)) 
  
 ;; The above doesn't work because it conses the last item from the 
 ;; front of the list to the answer, then gets the next item from the 
 ;; front, etc. 
  
 (define (square-list items) 
   (define (iter things answer) 
     (if (null? things) 
         answer 
         (iter (cdr things) 
               (cons answer (square (car things)))))) 
   (iter items null)) 
  
 (square-list (list 1 2 3 4)) 
  
 ;; This new-and-not-improved version conses the answer to the squared 
 ;; value, but the answer is a list, so you'll end up with (list (list 
 ;; ...) lastest-square).