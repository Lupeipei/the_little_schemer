; chapter 09 ...and again, and again, and again...
;
; define atom? from chapter 02
;
(define atom?
  (lambda (l)
    (and (not (pair? l)) (not (null? l)))))
;
; define a-pair? from chapter 07
;
(define a-pair?
  (lambda (x)
    (cond
      ((atom? x) #f)
      ((null? x) #f)
      ((null? (cdr x)) #f)
      ((null? (cdr (cdr x))) #t)
      (else #f))))
;
; define revpair from chapter 07
;
(define revpair
  (lambda (pair)
    (build (second pair) (first pair))))
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
; define x from chapter 04
;
(define x
  (lambda (a b)
    (cond
      ((or (zero? a) (zero? b)) (quote 0))
      (else (+ a (x a (sub1 b)))))))
;
; define pick from chapter 04
;
(define pick
  (lambda (n lat)
    (cond
      ((null? lat) (quote ()))
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))
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
; define looking
;
(define looking
  (lambda (a lat)
    (keep-looking a (pick 1 lat) lat)))
;
; define keep-looking, sorn stands for symbol or number.
;
(define keep-looking
  (lambda (a sorn lat)
    (cond
      ((number? sorn) (keep-looking a (pick sorn lat) lat))
      (else (eq? sorn a)))))
;
; examples of looking
;
(looking (quote caviar) (quote (6 2 4 caviar 5 7 3)))
;Value: #t

(looking (quote caviar) (quote (6 2 grits caviar 5 7 3)))
;Value: #f

; functions like looking are called partial
; eternity is the most recursion function.
; define eternity
;
(define eternity
  (lambda (x)
    (eternity x)))
;
; define shift
;
(define shift
  (lambda (pair)
    (build (first (first pair))
      (build (second (first pair)) (second pair)))))
;
; examples of shift
;
(shift (quote ((a b) c)))
;Value : (a (b c))

(shift (quote ((a b) (c d))))
;Value : (a (b (c d)))

;
; define align
;
(define align
  (lambda (pora)
    (cond
      ((atom? pora) pora)
      ((a-pair? (first pora)) (align (shift pora)))
      (else (build (first pora) (align (second pora)))))))
;
; define a function to count the number of atoms in align's arguments
;
(define length*
  (lambda (pora)
    (cond
      ((atom? pora) 1)
      (else
        (+ (length* (first pora)) (length* (second pora)))))))
;
; examples of length*
;
(length* (quote ((a b) c)))
;Value: 3

(length* (quote (a (b c))))
;Value: 3

; define weight* to improve length*
;
(define weight*
  (lambda (pora)
    (cond
      ((atom? pora) 1)
      (else
        (+ (x (weight* (first pora)) 2) (weight* (second pora)))))))
;
; examples of weight*
;
(weight* (quote ((a b) c)))
;Value: 7

(weight* (quote (a (b c))))
;Value: 5

; define shuffle
;
(define shuffle
  (lambda (pora)
    (cond
      ((atom? pora) pora)
      ((a-pair? (first pora)) (shuffle (revpair pora)))
      (else (build (first pora) (shuffle (second pora)))))))
;
; examples of shuffle
;
(shuffle (quote (a (b c))))
;Value : (a (b c))

(shuffle (quote (a b)))
;Value : (a b)

; define C, google for 3x + 1 problem. the steps for positive integer n to reach 1.
;
(define C
  (lambda (n)
    (cond
      ((zero? (sub1 n)) 1)
      ((even? n) (C (/ n 2)))
      (else (C (add1 (x 3 n)))))))
;
; examples of C. no value for (C 0)
(C 1)
;Value: 1

(C 2)
;Value: 1

(C 5)
;Value: 1

; after googling for 3x + 1, I defined a function named C-steps to track the steps as n reaches to 1 , just for fun.^_^
;
(define C-steps
  (lambda (n col)
    (cond
      ((zero? (sub1 n)) (col (quote (1))))
      ((even? n) (C-steps (/ n 2) (lambda (newlat)
                              (col (cons n newlat)))))
      (else (C-steps (add1 (x 3 n)) (lambda (newlat)
                                (col (cons n newlat))))))))
;
; define display as collector to show the steps details and count
;
(define display
  (lambda (l)
    (cons (sub1 (length l)) (cons l (quote ())))))
;
(C-steps 1 display)
;Value : (0 (1))

(C-steps 10 display)
;Value : (6 (10 5 16 8 4 2 1))

(C-steps 12 display)
;Value : (9 (12 6 3 10 5 16 8 4 2 1))

; (C-steps 97 display)
;Value : (118 (97 292 146 73 220 110 55 166 83 250 125 376 188 94 47 142 71 214 107 322 161 484 242 121 364 182 91 274 137 412 206 103 310 155 466 233 700 350 175 526 263 790 395 1186 593 1780 890 445 1336 668 334 167 502 251 754 377 1132 566 283 850 425 1276 638 319 958 479 1438 719 2158 1079 3238 1619 4858 2429 7288 3644 1822 911 2734 1367 4102 2051 6154 3077 9232 4616 2308 1154 577 1732 866 433 1300 650 325 976 488 244 122 61 184 92 46 23 70 35 106 53 160 80 40 20 10 5 16 8 4 2 1))

; define A
;
(define A
  (lambda (n m)
    (cond
      ((zero? n) (add1 m))
      ((zero? m) (A (sub1 n) 1))
      (else (A (sub1 n) (A n (sub1 m)))))))
;
; examples of A
;
(A 1 2)
;Value: 4

; be careful (A 4 3) will run out of your CPU, see details in wiki for Ackermann function

; in the next section, author show us why we cannot define function named will-stop? to check whether a function stops for just the empty list.
; we just skip it.
; let's see the hardest part in this chapter.

; see length again.
;
(define length
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (length (cdr l)))))))
;
; length0
;
(lambda (l)
  (cond
    ((null? l) 0)
    (else (add1 (eternity (cdr l))))))
;
; length<=1
;
(lambda (l)
  (cond
    ((null? l) 0)
    (else
      (add1 (
        (lambda (l)
           (cond
             ((null? l) 0)
             (else (add1 (eternity (cdr l))))))
        (cdr l))))))
;
; length<=2
;
(lambda (l)
  (cond
    ((null? l) 0)
    (else
      (add1 (
        (lambda (l)
          (cond
            ((null? l) 0)
            (else
              (add1 (
                (lambda (l)
                   (cond
                     ((null? l) 0)
                     (else (add1 (eternity (cdr l))))))
                (cdr l))))))
          (cdr l))))))
;
; redefine length0
;
((lambda (length)
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (length (cdr l)))))))
  eternity)
;
; rewrite length<=1 in the same style
;
((lambda (length)
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (length (cdr l)))))))
  ((lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l))))))) eternity))
;
; rewrite length<=2
;
((lambda (length)
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (length (cdr l)))))))
((lambda (length)
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (length (cdr l)))))))
  ((lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l))))))) eternity)))
;
;
; mk-length for length0
;
((lambda (mk-length)
    (mk-length eternity))
    (lambda (length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 (length (cdr l))))))))
;
; mk-length for length<=1
;
((lambda (mk-length)
    (mk-length
      (mk-length eternity)))
  (lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l))))))))
;
; mk-length for length<=2
;
((lambda (mk-length)
  (mk-length
    (mk-length
      (mk-length eternity))))
  (lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l))))))))
;
; invoke mk-length on eternity
;
((lambda (mk-length)
    (mk-length mk-length))
    (lambda (length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 (length (cdr l))))))))
;
; use mk-length instead of length
;
((lambda (mk-length)
    (mk-length mk-length))
    (lambda (mk-length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 (mk-length (cdr l))))))))
;
; apply mk-length to get length<=1
;
((lambda (mk-length)
    (mk-length mk-length))
    (lambda (mk-length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 ((mk-length eternity) (cdr l))))))))
;
; examples of above function
(((lambda (mk-length)
    (mk-length mk-length))
    (lambda (mk-length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 ((mk-length eternity) (cdr l)))))))) (quote (apple)))
;Value: 1

; replace eternity with mk-length
;
((lambda (mk-length)
    (mk-length mk-length))
    (lambda (mk-length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 ((mk-length mk-length) (cdr l))))))))
;
; (f x) is the same as (lambda (x) (f x))
; so replace ((mk-length mk-length) (cdr l)) with ((lambda (x) ((mk-length mk-length) x)) (cdr l))
;
((lambda (mk-length)
    (mk-length mk-length))
    (lambda (mk-length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 ((lambda (x) ((mk-length mk-length) x)) (cdr l))))))))
;
; get length back
;
((lambda (mk-length)
    (mk-length mk-length))
    (lambda (mk-length)
      ((lambda (length)
        (lambda (l)
          (cond
            ((null? l) 0)
            (else (add1 (length (cdr l)))))))
        (lambda (x) ((mk-length mk-length) x)))))
;
; abstract again
;
((lambda (le)
  ((lambda (mk-length)
    (mk-length mk-length))
    (lambda (mk-length)
      (le (lambda (x)
            ((mk-length mk-length) x))))))
 (lambda (length)
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (length (cdr l))))))))
;
; remove length defination
;
(lambda (le)
  ((lambda (mk-length)
    (mk-length mk-length))
    (lambda (mk-length)
      (le (lambda (x)
            ((mk-length mk-length) x))))))
;
; Y combinator
;
(define Y
  (lambda (le)
    ((lambda (f)
      (f f))
      (lambda (f)
        (le (lambda (x)
              ((f f) x)))))))
;
; cool!
; define operator x
;
(define x
  (lambda (a b)
    (cond
      ((or (zero? a) (zero? b)) (quote 0))
      (else (+ a (x a (sub1 b)))))))
;
(define F*
 (lambda (func-arg)
   (lambda (n)
     (if (zero? n)
         1
         (* n (func-arg (sub1 n)))))))
;
(define Y
 (lambda (F)
   (let ((W (lambda (x)
              (F (lambda arg (apply (x x) arg))))))
     (W W))))
;
(define Fi
  (lambda (func-arg)
    (lambda (n)
      (cond
        ((zero? (sub1 n)) 1)
        ((zero? (- n 2)) 1)
        (else (+ (func-arg (sub1 n)) (func-arg (- n 2))))))))

((Y F*) 10)

((F* (Y F*)) 10)

((Y Fi) 10)

((Fi (Y Fi)) 10)
