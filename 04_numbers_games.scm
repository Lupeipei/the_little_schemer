; Chapter 04 Numbers Games
;
; all numbers are atoms
;
; define atom? from chapter 02
;
(define atom?
  (lambda (l)
    (and (not (pair? l)) (not (null? l)))))

; examples of number
;
(atom? (quote 14))
;Value: #t

; define add1
;
(define add1
  (lambda (n)
    (+ n 1)))

; examples of add1

(add1 (quote 67))
;Value: 68

; define sub1
;
(define sub1
  (lambda (n)
    (- n 1)))
; examples of sub1
;
(sub1 67)
;Value: 66

(sub1 5)
;Value: 4

; examples of zero?
;
(zero? 0)
;Value: #t

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
;Value: 11

; define operator -
;
(define o-
  (lambda (a b)
    (cond
      ((zero? b) (quote a))
      (else (add1 (- a (sub1 b)))))))
; examples of -
(- 10 9)
;Value: 1

; examples of tup: tup is a list of numbers
;
(quote (2 11 3 79 47 6))
;Value: (2 11 3 79 47 6)

(quote (8 55 5 555))
;Value: (8 55 5 555)

(quote ())
;Value: ()

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
;Value: 148

(addtup (quote ()))
;Value: 0

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
; Value: 0

(x 0 2)
; Value: 0

(x 12 3)
;Value: 36

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
;Value: (6 9)

(tup+ (quote (3 6 9 11 4)) (quote (8 5 2 0 7)))
;Value: (11 11 11 11 11)

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
; Value: #t

(< 2 2)
; Value: #f

(< 3 2)
; Value: #f

(> 2 4)
; Value: #f

(> 2 2)
; Value: #f

(> 3 2)
; Value: #t

(= 2 4)
; Value: #f

(= 2 2)
; Value: #t

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
;Value: 4

(expt 2 0)
;Value: 1

(expt 3 3)
;Value: 27
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
;Value: 0

(quotient 12 3)
;Value: 4

(quotient 8 3)
;Value: 2

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
;Value: 5

(length (quote (hotdogs with mustard sauerkraut and pickles)))
;Value: 6

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
;Value: a

(pick 4 (quote (lasagna spaghetti ravioli macaroni meatball)))
;Value: macaroni

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
;Value: (hotdogs with mustard)

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
;Value: (pears prunes dates)

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
;Value: (5 6 9)

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
;Value: #f

(eqan? 2 2)
;Value: #t

(eqan? 1 (quote hi))
;Value: #f

(eqan? (quote hi) (quote wow))
;Value: #f

(eqan? (quote hi) (quote hi))
;Value: #t

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
;Value: 2

(occur (quote apple) (quote ()))
;Value: 0

(occur (quote apple) (quote (apple pear apple oranges)))
;Value: 2

;
; define one?
;
(define one?
  (lambda (a)
    (= a 1)))
; examples of one?

(one? 1)
;Value: #t

(one? 7)
;Value: #f

; rewrite rempick with one? function
;
(define rempick
  (lambda (n lat)
    (cond
      ((one? n) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))
; examples of rempick
;
(rempick 2 (quote (hotdogs with hot mustard)))
;Value: (hotdogs hot mustard)

; ----------------------------------------------------------------------------.
; ; the first commandment                                                     ;
; ; (first revision)                                                          ;
; ; when recurring on a list of atom, lat, ask two questions about it:        ;
; ; (null? lat) and else.                                                     ;
; ; when recurring on a number n, ask two questions about it:                 ;
; ; (zero? n) and else.                                                       ;
; ----------------------------------------------------------------------------.
