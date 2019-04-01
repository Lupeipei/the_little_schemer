; Chapter 02 Do it, do it again, and again, and again.
;
; define atom?
;
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))
; defind lat?
;
(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))
;
; examples of lat?
;
(lat? (quote ()))
;Value: #t

(lat? (quote (Jack Sprate could eat no chiken fat)))
;Value: #t

(lat? (quote (eggs)))
;Value: #t

; define member?
;
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) a) (member? a (cdr lat)))))))
; examples of member?
;
(member? (quote tea) (quote (coffee tea or milk)))
;Value: #t

(member? (quote poached) (quote (fried eggs and scrambled eggs)))
;Value: #f

(member? (quote meat) (quote (mashed potatoes and meat gravy)))
;Value: #t

; ----------------------------------------------------------------------------.
; ; the first commandment                                                     ;
; ; always ask null? as the first question in expressing any function.        ;
; ----------------------------------------------------------------------------.
; more examples of member?
;
(member? (quote liver) (quote ()))
;Value: #f

(member? (quote liver) (quote (lox)))
;Value: #f

(member? (quote liver) (quote (and lox)))
;Value: #f

(member? (quote liver) (quote (bagels and lox)))
;Value: #f
