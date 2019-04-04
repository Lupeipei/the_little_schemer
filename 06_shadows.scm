; chapter 6 Shadows
;
; define atom? from chapter 02
;
(define atom?
  (lambda (l)
    (and (not (pair? l)) (not (null? l)))))
;
; define sub1 from chapter 04
;
(define sub1
  (lambda (n)
    (- n 1)))
;
; define operator + from chapter 04
;
(define o+
  (lambda (a b)
    (cond
      ((zero? b) a)
      (else (add1 (+ a (sub1 b)))))))
;
; define operator x
;
(define x
  (lambda (a b)
    (cond
      ((or (zero? a) (zero? b)) (quote 0))
      (else (+ a (x a (sub1 b)))))))
;
; define operator expt from chapter 04
;
(define expt
  (lambda (a b)
    (cond
      ((zero? b) 1)
      (else (x a (expt a (sub1 b)))))))
;
; define numbered?
(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      ((eq? (quote +) (car (cdr aexp))) (and (numbered? (car aexp)) (numbered? (car (cdr (cdr aexp))))))
      ((eq? (quote x) (car (cdr aexp))) (and (numbered? (car aexp)) (numbered? (car (cdr (cdr aexp))))))
      ((eq? (quote ^) (car (cdr aexp))) (and (numbered? (car aexp)) (numbered? (car (cdr (cdr aexp)))))))))
; examples of numbered?
;
(numbered? (quote (1 + 2)))
;Value: #t

(numbered? (quote (3 x 2)))
;Value: #t

(numbered? (quote (4 ^ 2)))
;Value: #t

; simplify, suppose the (car (cdr aexp)) is an operator.
(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      (else (and (number? (car aexp)) (numbered? (car (cdr (cdr aexp)))))))))

; examples of simplify numbered?
;
(numbered? (quote (1 + 2)))
;Value: #t

(numbered? (quote (3 x 2)))
;Value: #t

(numbered? (quote (4 ^ 2)))
;Value: #t

; define value
;
(define value
  (lambda (aexp)
    (cond
      ((atom? aexp) aexp)
      ((eq? (quote +) (car (cdr aexp))) (+ (value (car aexp)) (value (car (cdr (cdr aexp))))))
      ((eq? (quote x) (car (cdr aexp))) (x (value (car aexp)) (value (car (cdr (cdr aexp))))))
      ((eq? (quote ^) (car (cdr aexp))) (expt (value (car aexp)) (value (car (cdr (cdr aexp))))))
      )))
; examples of value
(value (quote (1 + (3 ^ 4))))
;Value: 82
;
; ----------------------------------------------------------------------------.
; ; the seventh commandment                                                   ;
; ; Recur on the subparts that are of the same nature:                        ;
; ; - On the sublists of a list                                               ;
; ; - On the subexpressions of an arithmetic expression                       ;
; ----------------------------------------------------------------------------.
;
; redefine value so (+ 3 (2 ^ 3)) is also has value
;
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (quote +) (car nexp)) (+ (value (car (cdr nexp))) (value (car (cdr (cdr nexp))))))
      ((eq? (quote x) (car nexp)) (x (value (car (cdr nexp))) (value (car (cdr (cdr nexp))))))
      ((eq? (quote ^) (car nexp)) (expt (value (car (cdr nexp))) (value (car (cdr (cdr nexp))))))
      )))

; examples of redefine value
(value (quote (+ 1 (^ 3 4))))
;Value: 82

; define 1st-sub-exp
;
(define 1st-sub-exp
  (lambda (aexp)
    (car (cdr aexp))))
;
; define 2nd-sub-exp
;
(define 2nd-sub-exp
  (lambda (aexp)
    (car (cdr (cdr aexp)))))
;
; define operator
;
(define operator
  (lambda (aexp)
    (car aexp)))
;
; redefine value with these three functions
;
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (quote +) (operator nexp)) (+ (value (1st-sub-exp nexp)) (value (2nd-sub-exp nexp))))
      ((eq? (quote x) (operator nexp)) (x (value (1st-sub-exp nexp)) (value (2nd-sub-exp nexp))))
      ((eq? (quote ^) (operator nexp)) (expt (value (1st-sub-exp nexp)) (value (2nd-sub-exp nexp))))
      )))
;
; then by changing the defination of operator and 1st-sub-exp , we can change function value
;
; define 1st-sub-exp again
;
(define 1st-sub-exp
  (lambda (aexp)
    (car aexp)))

; define operator again
;
(define operator
  (lambda (aexp)
    (car (cdr aexp))))
;
; ----------------------------------------------------------------------------.
; ; the eighth commandment                                                   ;
; ; Use help functions to abstract from representations.                     ;
; ----------------------------------------------------------------------------.
;
; define primitives for (() () ())
;(()) represent for 1, (() ()) represent for 2, (() () ()) represent for 3, etc.
;
(define sero?
  (lambda (n)
    (null? n)))
; examples for sero?
;
(sero? (quote (() ())))
;Value: #f
;
; define edd1
;
(define edd1
  (lambda (n)
    (cons (quote ()) n)))
; examples for edd1
;
(edd1 (quote (() ())))
; Value: (() () ())
;
; define zub1
(define zub1
  (lambda (n)
    (cdr n)))
; examples for zub1
(zub1 (quote (() ())))
;Value: (())
;
; define + for (())
;
(define o+
  (lambda (n m)
    (cond
      ((sero? m) n)
      (else (edd1 (o+ n (zub1 m))))
      )))
; examples for +
(o+ (quote (()) (quote (() () ())))
;no output. it is confusing.
;
; define lat?
;
(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))
;
(lat? (quote (() ())))
;also no output. it is confusing.

(lat? (quote ((()) (() ()))))
;also no output. it is confusing.
