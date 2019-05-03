; chapter 10 What is the value of all of this?
;
; Actions do speak louder than words.
;
; define atom? from chapter 02
;
(define atom?
  (lambda (l)
    (and (not (pair? l)) (not (null? l)))))
;
; define add1 from chapter 04
;
(define add1
  (lambda (n)
    (+ n 1)))
;
; define sub1 from chapter 04
;
(define sub1
  (lambda (n)
    (- n 1)))
;
; define first from chapter 07
;
(define first
  (lambda (p)
    (car p)))
;
; define second from chapter 07
;
(define second
  (lambda (p)
    (car (cdr p))))
;
; define build from chapter 07
;
(define build
  (lambda (s1 s2)
    (cons s1 (cons s2 (quote ())))))
;
; define third from chapter 07
;
(define third
  (lambda (p)
    (car (cdr (cdr p)))))
;
; An entry is  a pair of lists whose first list is a set. also, the two lists must be of equal length.
; examples of entry
;
(quote ((appetizer entree beverage) (pate boeuf vin)))
(quote ((appetizer entree beverage) (beer beer beer)))
(quote ((beverage dessert) ((food is) (number one with us))))
;
; define new-entry
(define new-entry build)
;
; define lookup-in-entry
;
(define lookup-in-entry
  (lambda (name entry entry-f)
    (lookup-in-entry-help name (first entry) (second entry) entry-f)))
;
; define lookup-in-entry-help
;
(define lookup-in-entry-help
  (lambda (name names values entry-f)
    (cond
      ((null? names) (entry-f name))
      ((eq? (car names) name) (car values))
      (else (lookup-in-entry-help name (cdr names) (cdr values) entry-f)))))
;
; define entry-help for entry-f
;
(define entry-help
  (lambda (name)
    (quote ())))
;
; examples of lookup-in-entry
;
(lookup-in-entry (quote entree) (quote ((appetizer entree beverage) (food tastes good))) entry-help)
;Value: tastes

(lookup-in-entry (quote dessert) (quote ((appetizer entree beverage) (food tastes good))) entry-help)
;Value: ()

; A table is a list of entries.
;
; examples of table
;
(quote ())
(quote (((appetizer entree beverage) (pate boeuf vin)) ((beverage dessert) ((food is) (number one with us)))))
;
; define extend-table
(define extend-table cons)
;
; define lookup-in-table
;
(define lookup-in-table
  (lambda (name table table-f)
    (cond
      ((null? table) (table-f name))
      (else
        (lookup-in-entry name (car table)
                              (lambda (name)
                                (lookup-in-table name (cdr table) table-f)))))))
;
; examples of lookup-in-table, we use entry-help for table-f
;
(lookup-in-table (quote entree) (quote (((appetizer entree beverage) (pate boeuf vin)) ((beverage dessert) ((food is) (number one with us))))) entry-help)
;Value: boeuf

;
; define expression-to-action
;
(define expression-to-action
  (lambda (e)
    (cond
      ((atom? e) (atom-to-action e))
      (else (list-to-action e)))))
;
; define atom-to-action
;
(define atom-to-action
  (lambda (e)
    (cond
      ((number? e) *const)
      ((eq? e #t) *const)
      ((eq? e #f) *const)
      ((eq? e (quote cons)) *const)
      ((eq? e (quote car)) *const)
      ((eq? e (quote cdr)) *const)
      ((eq? e (quote null?)) *const)
      ((eq? e (quote eq?)) *const)
      ((eq? e (quote atom?)) *const)
      ((eq? e (quote zero?)) *const)
      ((eq? e (quote add1)) *const)
      ((eq? e (quote sub1)) *const)
      ((eq? e (quote number?)) *const)
      (else *identifier))))
;
; define list-to-action
;
(define list-to-action
  (lambda (e)
    (cond
      ((atom? (car e))
        (cond
          ((eq? (car e) (quote quote)) *quote)
          ((eq? (car e) (quote lambda)) *lambda)
          ((eq? (car e) (quote cond)) *cond)
          (else *application)))
      (else *application))))
;
;
; define value
;
(define value
  (lambda (e)
    (meaning e (quote ()))))
;
; define meaning
;
(define meaning
  (lambda (e table)
    ((expression-to-action e) e table)))
;
; funcall expression-to-action e, get *const / *identifier / *quote / *lambda / *cond / *application, those are actions
; action receives two arguments: e table.
;
; next, define all actions
;
; define *const
;
(define *const
  (lambda (e table)
    (cond
      ((number? e) e)
      ((eq? e #t) #t)
      ((eq? e #f) #f)
      (else (build (quote primitive) e)))))
;
; define *quote
;
(define *quote
  (lambda (e table)
    (text-of e)))
;

; define text-of
;
(define text-of second)
;
; define *identifier
;
(define *identifier
  (lambda (e table)
    (lookup-in-table e table initial-table)))
;
; define initial-table
;
(define initial-table
  (lambda (name)
    (car (quote ()))))
;
; define *lambda
;
(define *lambda
  (lambda (e table)
    (build (quote non-primitive) (cons table (cdr e)))))
;
; define table-of
(define table-of first)
;
; define formals-of
(define formals-of second)
;
; define body-of
(define body-of third)
;

; define evcon
;
(define evcon
  (lambda (lines table)
    (cond
      ((else? (question-of (car lines)))
       (meaning (answer-of (car lines)) table))
      ((meaning (question-of (car lines)) table)
       (meaning (answer-of (car lines)) table))
      (else (evcon (cdr lines) table)))))
;
; define else?
;
(define else?
  (lambda (x)
    (cond
      ((atom? x) (eq? x (quote else)))
      (else #f))))
;
; define question-of
(define question-of first)
;
; define answer-of
(define answer-of second)
;

; define *cond with evcon
;
(define *cond
  (lambda (e table)
    (evcon (cond-lines-of e) table)))
;
; define cond-lines-of
(define cond-lines-of cdr)
;
; examples of *cond
(*cond (quote (cond (coffee klatsch) (else party))) (quote (((coffee) (#t)) ((klatsch party) (5 (6))))))
;Value: 5
;
; at last, *application
;
; define evlis
;
(define evlis
  (lambda (args table)
    (cond
      ((null? args) (quote ()))
      (else
        (cons (meaning (car args) table)
          (evlis (cdr args)))))))
;
; define *application
;
(define *application
  (lambda (e table)
    (applyz
      (meaning (function-of e) table)
      (evlis (arguments-of e) table))))
;
; define function-of
(define function-of car)
;
; define arguments-of
(define arguments-of cdr)
;
; we need to define applyz.
; define applyz
;
(define applyz
  (lambda (fun vals)
    (cond
      ((primitive? fun)
       (apply-primitive (second fun) vals))
       ((non-primitive? fun)
        (apply-closure (second fun) vals)))))
;
;
; define primitive?
;
(define primitive?
  (lambda (l)
    (eq? (first l) (quote primitive))))
;
; define non-primitive?
;
(define non-primitive?
  (lambda (l)
    (eq? (first l) (quote non-primitive))))
;
; define apply-primitive
;
(define apply-primitive
  (lambda (name vals)
    (cond
      ((eq? name (quote cons)) (cons (first vals) (second vals)))
      ((eq? name (quote car)) (car (first vals)))
      ((eq? name (quote cdr)) (cdr (first vals)))
      ((eq? name (quote null?)) (null? (first vals)))
      ((eq? name (quote eq?)) (eq? (first vals) (second vals)))
      ((eq? name (quote atom?)) (:atom? (first vals)))
      ((eq? name (quote zero?)) (zero? (first vals)))
      ((eq? name (quote add1)) (add1 (first vals)))
      ((eq? name (quote sub1)) (sub1 (first vals)))
      ((eq? name (quote number?)) (number? (first vals))))))
;
;
; define :atom?
;
(define :atom?
  (lambda (x)
    (cond
      ((atom? x) #t)
      ((null? x) #f)
      ((eq? (car x) (quote primitive)) #t)
      ((eq? (car x) (quote non-primitive)) #t)
      (else #f))))
;
;
; define apply-closure
;
(define apply-closure
  (lambda (closure vals)
    (meaning (body-of closure)
      (extend-table
        (new-entry
          (formals-of closure)
          vals)
          (table-of closure)))))
;
; examples of value
(value 1)
;Value: 1

(value (add1 6))
;Value: 7

(value (quote ((lambda (nothing) (cons nothing ((quote ())))) (quote (from nothing comes something)))))
