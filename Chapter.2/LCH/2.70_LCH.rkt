#lang racket

(require "2.69_LCH.rkt" "2.68_LCH.rkt")

(define pairs (list '(A 2) '(GET 2) '(SHA 3) '(WAH 1) '(BOOM 1) '(JOB 2) '(NA 16) '(YIP 9)))
(define messages (list 'GET 'A 'JOB
                       'SHA 'NA 'NA 'NA 'NA 'NA 'NA 'NA 'NA
                       'GET 'A 'JOB
                       'SHA 'NA 'NA 'NA 'NA 'NA 'NA 'NA 'NA
                       'WAH 'YIP 'YIP 'YIP 'YIP 'YIP 'YIP 'YIP 'YIP 'YIP
                       'SHA 'BOOM))
(define tree (generate-huffman-tree pairs))
(define encoded-messages (encode messages tree))
(length encoded-messages) ;84
; fixed-length 일 경우 8 symbols 이므로 3 bit/symbol
; 36 symbols 이므로 총 108 bits 가 필요하다.