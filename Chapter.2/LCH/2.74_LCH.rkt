#lang racket

; a. division-file 은 해당 파일을 관리하는 division name 을 반환하는 인터페이스를 제공해야한다.
(define (get-record employee-name division-file)
  ((get 'get-record (division-name division-file)) employee-name))
; b. employee-record 도 해당 레코드를 관리하는 division name 을 반환하는 인터페이스를 제공해야한다.
(define (get-salary employee-record)
  ((get 'get-salary (division-name employee-record)) employee-record))
; c. a 에서 정의한 procedure 를 사용할 수 있다.
(define (find-employee-record employee-name division-file-list)
  (let ((get-record-result (get-record employee-name (car division-file-list))))
    (if (null? get-record-result)
        (find-employee-record employee-name (cdr division-file-list))
        get-record-result)))
; d. table 에 (new company name, 'get-record) 등의 identifier 에다가 새로운 procedure 를 put 한다.