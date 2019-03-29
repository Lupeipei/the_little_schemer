; Chapter 4 Numbers Games
;
; all numbers are atoms
;
; define atom?
;
(define atom?
  (lambda (l)
    (and (not (pair? l)) (not (null? l)))))

; examples of number
;
(atom? (quote 14))

; define add1
;
(define add1
  (lambda (n)
    (+ n 1)))

; examples of add1

(add1 (quote 67))

; define sub1
;
(define sub1
  (lambda (n)
    (- n 1)))
; examples of sub1
;
(sub1 67)
(sub1 5)

; examples of zero?
;
(zero? 0)

; define operator +
;
(define o+
  (lambda (a b)
    (cond
      ((zero? b) a)
      (else (add1 (+ a (sub1 b)))))))
; define + in other way. (+ (add1 a) (sub1 b))
;
; examples of +
(+ 1 10)

; define operator -
;
(define o-
  (lambda (a b)
    (cond
      ((zero? b) (quote a))
      (else (add1 (- a (sub1 b)))))))
; examples of -
(- 10 9)

; examples of tup: tup is a list of numbers
;
(quote (2 11 3 79 47 6))
(quote (8 55 5 555))
(quote ())

; ----------------------------------------------------------------------------.
; ; the first commandment                                                     ;
; ; (first revision)                                                          ;
; ; when recurring on a list of atom, lat, ask two questions about it:        ;
; ; (null? lat) and else.                                                     ;
; ; when recurring on a number n, ask two questions about it:                 ;
; ; (zero? n) and else.                                                       ;
; ----------------------------------------------------------------------------.
;
; define addtup
;
(define addtup
  (lambda (tup)
    (cond
      ((null? tup) (quote 0))
      (else (+ (car tup) (addtup (cdr tup)))))))
;
; examples of addtup
(addtup (quote (2 11 3 79 47 6)))
(addtup (quote ()))

; ----------------------------------------------------------------------------.
; ; the fourth commandment                                                    ;
; ; (first revision)                                                          ;
; ; always change at least one arugment while recuring. it must be changed to ;
; ; be closer to termination. The changing argument must be tested in the     ;
; ; termination condition:                                                    ;
; ; when using cdr, test termination with null?                               ;
; ; when using sub1, test termination with zero?                              ;
; ----------------------------------------------------------------------------.
;
; define operator x
;
(define x
  (lambda (a b)
    (cond
      ((or (zero? a) (zero? b)) (quote 0))
      (else (+ a (x a (sub1 b)))))))
; examples of x
;
(x 2 0)
(x 0 2)
(x 12 3)

; ----------------------------------------------------------------------------.
; ; the fifth commandment                                                     ;
; ; when building a value with +, always use 0 for the value of the           ;
; ; terminating line, for adding 0 does not change the value of an addition.  ;
; ; when building a value with x, always use 1 for the value of the           ;
; ; terminating line, for multiplying by 1 does not change the value of an    ;
; ;addition.                                                                  ;
; ; when building a value with cons, always conside () for the value of the   ;
; ; value of the terminating line.                                            ;
; ----------------------------------------------------------------------------.
;
; define tup+
;
(define tup+
  (lambda (tup1 tup2)
    (cond
      ((null? tup1) tup2)
      ((null? tup2) tup1)
      (else (cons (+ (car tup1) (car tup2)) (tup+ (cdr tup1) (cdr tup2)))))))
; examples of tup+
;
(tup+ (quote (2 3)) (quote (4 6)))
(tup+ (quote (3 6 9 11 4)) (quote (8 5 2 0 7)))
; define operator >
;
(define o>
  (lambda (a b)
    (cond
      ((zero? a) #f)
      ((zero? b) #t)
      (else (> (sub1 a) (sub1 b))))))
; define operator <
;
(define o<
  (lambda (a b)
    (cond
      ((zero? b) #f)
      ((zero? a) #t)
      (else (< (sub1 a) (sub1 b))))))

; define operator =
;
(define o=
  (lambda (a b)
    (cond
      ((and (zero? a) (zero? b)) #t)
      ((zero? b) #f)
      ((zero? a) #f)
      (else (= (sub1 a) (sub1 b))))))

; rewrite using > and <
;
(define o=
  (lambda (a b)
    (cond
      ((< a b) #f)
      ((> a b) #f)
      (else #t))))
; examples of <, >, =
(< 2 4)
(< 2 2)
(< 3 2)

(> 2 4)
(> 2 2)
(> 3 2)

(= 2 4)
(= 2 2)

; define operator expt
;
(define expt
  (lambda (a b)
    (cond
      ((zero? b) 1)
      (else (x a (expt a (sub1 b)))))))

; examples of expt
;
(expt 2 2)
(expt 2 0)

; define operator quotient
;
(define quotient
  (lambda (a b)
    (cond
      ((< a b) 0)
      (else (add1 (quotient (- a b) b))))))
; examples of quotient
;
(quotient 2 3)
(quotient 12 3)
(quotient 8 3)

; define length
;
(define length
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else (add1 (length (cdr lat)))))))
; examples of length
;
(length (quote (ham and cheese on rye)))
(length (quote (hotdogs with mustard sauerkraut and pickles)))

; define pick
;
(define pick
  (lambda (n lat)
    (cond
      ((null? lat) (quote ()))
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))
; examples of pick
;
(pick 1 (quote (a)))
(pick 4 (quote (lasagna spaghetti ravioli macaroni meatball)))

; define rempick
;
(define rempick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))
; examples of rempick
;
(rempick 3 (quote (hotdogs with hot mustard)))

; define no-nums
;
(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((number? (car lat)) (no-nums (cdr lat)))
      (else (cons (car lat) (no-nums (cdr lat)))))))
; examples of no-nums
;
(no-nums (quote (5 pears 6 prunes 9 dates)))

; define all-nums
;
(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      ((number? (car lat)) (cons (car lat) (all-nums (cdr lat))))
      (else (all-nums (cdr lat))))))
;
; examples of all-nums
(all-nums (quote (5 pears 6 prunes 9 dates)))

; define eqan?
;
(define eqan?
  (lambda (a b)
    (cond
      ((and (number? a) (number? b)) (= a b))
      ((or (number? a) (number? b)) #f)
      (else (eq? a b)))))
; examples of eqan?
;
(eqan? 1 2)
(eqan? 2 2)
(eqan? 1 (quote hi))
(eqan? (quote hi) (quote wow))
(eqan? (quote hi) (quote hi))

; define occur
;
(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((eqan? a (car lat)) (add1 (occur a (cdr lat))))
      (else (occur a (cdr lat))))))
; examples of occur
;
(occur 1 (quote (1 2 1 3 4)))
(occur (quote apple) (quote ()))
(occur (quote apple) (quote (apple pear apple oranges)))
;
; define one?
;
(define one?
  (lambda (a)
    (= a 1)))
; examples of one?

(one? 1)
(one? 7)

; rewrite rempick with one? function
;
(define rempick
  (lambda (n lat)
    (cond
      ((one? n) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))
