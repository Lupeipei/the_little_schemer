; chapter 08 Lambda and ultimate
;
; define atom? from chapter 02
;
(define atom?
  (lambda (l)
    (and (not (pair? l)) (not (null? l)))))
;
; define eqan? from chapter 04
;
(define eqan?
  (lambda (a b)
    (cond
      ((and (number? a) (number? b)) (= a b))
      ((or (number? a) (number? b)) #f)
      (else (eq? a b)))))
;
; define equal? from chapter 05
;
(define equal?
  (lambda (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2)) (eqan? s1 s2))
      ((or (atom? s1) (atom? s2)) #f)
      (else (eqlist? s1 s2)))))
;
; define eqlist? using equal? from chapter 05
;
(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      (else (and (equal? (car l1) (car l2)) (eqlist? (cdr l1) (cdr l2))))
      )))
;
; redefine rember-f
;
(define rember-f
  (lambda (test? a l)
    (cond
      ((null? l) (quote ()))
      ((test? (car l) a) (cdr l))
      (else (cons (car l) (rember-f test? a (cdr l)))))))
;
; examples of rember-f
;
(rember-f eq? (quote jelly) (quote (jelly beans are good)))
;Value : (beans are good)

(rember-f = (quote 5) (quote (6 2 5 3)))
;Value : (6 2 3)

(rember-f equal? (quote (pop corn)) (quote (lemonade (pop corn) and (cake))))
;Value : (lemonade and (cake))
;
; define eq?-c
;
(define eq?-c
  (lambda (a)
    (lambda (x)
      (eq? a x))))
;
; define eq?-salad using eq?-c
(define eq?-salad (eq?-c (quote salad)))
;
; examples of eq?-salad
;
(eq?-salad (quote salad))
;Value: #t

(eq?-salad (quote tuna))
;Value: #f

; redefine rember-f
;
(define rember-f
  (lambda (test?)
    (lambda (a l)
      (cond
        ((null? l) (quote ()))
        ((test? (car l) a) (cdr l))
        (else (cons (car l) ((rember-f test?) a (cdr l))))))))
;
; examples of rember-f
;
((rember-f eq?) (quote jelly) (quote (jelly beans are good)))
;Value : (beans are good)

((rember-f =) (quote 5) (quote (6 2 5 3)))
;Value : (6 2 3)

((rember-f equal?) (quote (pop corn)) (quote (lemonade (pop corn) and (cake))))
;Value : (lemonade and (cake))

; define rember-eq?
;
(define rember-eq? (rember-f eq?))
;
; examples of rember-eq?
(rember-eq? (quote tuna) (quote (tuna salad is good)))
;Value : (salad is good)

((rember-f eq?) (quote tuna) (quote (shrimp salad and tuna salad)))
;Value : (shrimp salad and salad)

((rember-f eq?) (quote eq?) (quote (equal? eq? eqan? eqlist? eqpair?)))
;Value : (equal? eqan? eqlist? eqpair?)
;
; define insertL-f
;
(define insertL-f
  (lambda (test?)
    (lambda (new old lat)
      (cond
        ((null? lat) (quote ()))
        ((test? (car lat) old) (cons new (cons old (cdr lat))))
        (else (cons (car lat) ((insertL-f test?) new old (cdr lat))))))))
;
; define insertR-f
;
(define insertR-f
  (lambda (test?)
    (lambda (new old lat)
      (cond
        ((null? lat) (quote ()))
        ((test? (car lat) old) (cons old (cons new (cdr lat))))
        (else (cons (car lat) ((insertR-f test?) new old (cdr lat))))))))
;
; define seqL
;
(define seqL
  (lambda (new old l)
    (cons new (cons old l))))
;
; define seqR
(define seqR
  (lambda (new old l)
    (cons old (cons new l))))
;
;
; define insert-g
(define insert-g
  (lambda (seq)
    (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((eq? (car l) old) (seq new old (cdr l)))
      (else (cons (car l) ((insert-g seq) new old (cdr l))))))))
;
; redefine insertL with insert-g
;
(define insertL (insert-g seqL))
;
; redefine insertR with insert-g
;
(define insertR (insert-g seqR))
;
; examples of insertL, insertR
;
(insertL (quote topping) (quote fudge) (quote (ice cream with fudge for dessert)))
;Value : (ice cream with topping fudge for dessert)

(insertR (quote topping) (quote fudge) (quote (ice cream with fudge for dessert)))
;Value : (ice cream with fudge topping for dessert)

; redefine insertL without seqL
;
(define insertL
  (insert-g
    (lambda (new old l)
      (cons new (cons old l)))))
;
; redefine insertR without seqR
;
(define insertR
  (insert-g
    (lambda (new old l)
      (cons old (cons new l)))))
;
; examples of insertL, insertR
;
(insertL (quote topping) (quote fudge) (quote (ice cream with fudge for dessert)))
;Value : (ice cream with topping fudge for dessert)

(insertR (quote topping) (quote fudge) (quote (ice cream with fudge for dessert)))
;Value : (ice cream with fudge topping for dessert)
;
; define subst from chapter 03
;
(define subst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? old (car lat)) (cons new (cdr lat)))
      (else (cons (car lat) (subst new old (cdr lat)))))))
;
; define seqS
;
(define seqS
  (lambda (new old l)
    (cons new l)))
;
; redefine subst with insert-g
;
(define subst (insert-g seqS))
;
; examples of subst
(subst (quote topping) (quote fudge) (quote (ice cream with fudge for dessert)))
; Value : (ice cream with topping for dessert)
;
; redefine rember as yyy using insert-g
;
(define yyy
  (lambda (a l)
    ((insert-g
      (lambda (new old l)
        l)) #f a l)))
;
; examples of yyy
(yyy (quote sausage) (quote (pizza with sausage and bacon)))
;Value : (pizza with and bacon)
;
; ----------------------------------------------------------------------------.
; ; the ninth commandment                                                     ;
; ; Abstract common patterns with a new function.                            ;
; ----------------------------------------------------------------------------.

; functions from chapter 06 and chapter 04
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
; define value with these three functions
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
; define atom-to-function to simplify
;
(define atom-to-function
  (lambda (a)
    (cond
      ((eq? a (quote x)) x)
      ((eq? a (quote +)) +)
      (else expt))))
;
; redefine value
(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      (else ((atom-to-function (operator nexp)) (value (1st-sub-exp nexp)) (value (2nd-sub-exp nexp)))))))
;
; examples of value
;
(value (quote (+ 1 (^ 3 4))))
;Value: 82
;
; define multirember from chapter 03
;
(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? a (car lat)) (multirember a (cdr lat)))
      (else (cons (car lat) (multirember a (cdr lat)))))))
;
; define multirember-f
;
(define multirember-f
  (lambda (test?)
    (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((test? a (car lat)) ((multirember-f test?) a (cdr lat)))
      (else (cons (car lat) ((multirember-f test?) a (cdr lat)))))
    )))
;
; examples of multirember-f
((multirember-f eq?) (quote tuna) (quote (shrimp salad tuna salad and tuna)))
;Value : (shrimp salad salad and)
;
; redefine multirember with multirember-f
(define multirember (multirember-f eq?))
;
; examples for multirember
;
(multirember (quote cup) (quote (coffee cup tea cup and hick cup)))
;Value : (coffee tea and hick)
;
(define multirember-eq? (multirember-f eq?))
;
; examples for multirember-eq?
;
(multirember-eq? (quote cup) (quote (coffee cup tea cup and hick cup)))
;Value : (coffee tea and hick)
;
; define eq?-tuna with a is tuna, we will use it later.
;
(define eq?-tuna
  (eq?-c (quote tuna)))
;
; define multiremberT
;
(define multiremberT
  (lambda (test? lat)
    (cond
      ((null? lat) (quote ()))
      ((test? (car lat)) (multiremberT test? (cdr lat)))
      (else (cons (car lat) (multiremberT test? (cdr lat)))))))
;
; examples of multiremberT
(multiremberT eq?-tuna (quote (shrimp salad tuna salad and tuna)))
;Value : (shrimp salad salad and)
;
; Here, something looks complicated coming.
; define multirember&co
;
(define multirember&co
  (lambda (a lat col)
    (cond
      ((null? lat)
        (col (quote ()) (quote ())))
      ((eq? (car lat) a)
        (multirember&co a (cdr lat)
          (lambda (newlat seen)
            (col newlat (cons (car lat) seen)))))
      (else
        (multirember&co a
          (cdr lat)
          (lambda (newlat seen)
            (col (cons (car lat) newlat) seen)))))))
;
;
; let's see col
; remember : col is short for "collector", A collector is sometimes called a "continuation"
; define a-friend
;
(define a-friend
  (lambda (x y)
    (null? y)))
;
; examples of multirember&co
;
(multirember&co (quote tuna) (quote (strawberries tuna and swordfish)) a-friend)
;Value: #f

;
(multirember&co (quote tuna) (quote (and tuna)) a-friend)
;Value: #f
;
; define new-friend with col
;
(define new-friend
  (lambda (newlat seen)
    (col newlat
      (cons (car lat) seen))))
;
; replace col with a-friend and (car lat) with tuna
;
(define new-friend
  (lambda (newlat seen)
    (a-friend newlat
      (cons (quote tuna) seen))))
;
; define latest-friend
;
(define latest-friend
  (lambda (newlat seen)
    (a-friend (cons (car lat) newlat) seen)))
;
; define length from chapter 04
;
(define length
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else (add1 (length (cdr lat)))))))
;
; define last-friend
;
(define last-friend
  (lambda (x y)
    (length x)))
;
; examples of multirember&co when col is last-friend
;
(multirember&co (quote tuna) (quote (strawberries tuna and swordfish)) last-friend)
;Value: 3

; ----------------------------------------------------------------------------.
; ; the tenth commandment                                                     ;
; ; Build functions to collect more than one value at a time.                 ;
; ----------------------------------------------------------------------------.
;
; define multiinsertR from chapter 03
;
(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? old (car lat)) (cons old (cons new (multiinsertR new old (cdr lat)))))
      (else (cons (car lat) (multiinsertR new old (cdr lat)))))))
;
; define multiinsertL from chapter 03
;
(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? old (car lat)) (cons new (cons old (multiinsertL new old (cdr lat)))))
      (else (cons (car lat) (multiinsertL new old (cdr lat)))))))
;
; define multiinsertLR
;
(define multiinsertLR
  (lambda (new oldL oldR lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? oldL (car lat)) (cons new (cons oldL (multiinsertLR new oldL oldR (cdr lat)))))
      ((eq? oldR (car lat)) (cons oldR (cons new (multiinsertLR new oldL oldR (cdr lat)))))
      (else (cons (car lat) (multiinsertLR new oldL oldR (cdr lat)))))))
;
;
; define multiinsertLR&co
;
(define multiinsertLR&co
  (lambda (new oldL oldR lat col)
    (cond
      ((null? lat)
       (col (quote ()) 0 0))
      ((eq? oldL (car lat))
       (multiinsertLR&co new oldL oldR (cdr lat)
        (lambda (newlat L R)
          (col (cons new (cons oldL newlat)) (add1 L) R))))
      ((eq? oldR (car lat))
       (multiinsertLR&co new oldL oldR (cdr lat)
        (lambda (newlat L R)
          (col (cons oldR (cons new newlat)) L (add1 R)))))
      (else (multiinsertLR&co new oldL oldR (cdr lat)
             (lambda (newlat L R)
              (col (cons (car lat) newlat) L R)))))))
;
; define combine for col to check my definition of multiinsertLR&co
;
(define combine
  (lambda (lat L R)
    (cons L (cons R (cons lat (quote ()))))))
;
; examples of multiinsertLR&co
(multiinsertLR&co (quote cranberries) (quote fish) (quote chips) (quote ()) combine)
;Value 21: (0 0 ())
;
(multiinsertLR&co (quote salty) (quote fish) (quote chips) (quote (chips and fish or fish and chips)) combine)
;Value 22: (2 2 (chips salty and salty fish or salty fish and chips salty))
;
; so perfect!
; using primitive function even?
(even? (quote 10))
;Value: #t

(even? (quote 7))
;Value: #f

; define even-only*
;
(define even-only*
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
        (cond
          ((even? (car l)) (cons (car l) (even-only* (cdr l))))
          (else (even-only* (cdr l)))))
      (else (cons (even-only* (car l)) (even-only* (cdr l)))))))
;
; examples of even-only*
;
(even-only* (quote ((9 1 2 8) 3 10 ((9 9) 7 6) 2)))
;Value : ((2 8) 10 (() 6) 2)
;
; define even-only*&co
;
(define even-only*&co
  (lambda (l col)
    (cond
      ((null? l) (col (quote ()) 1 0))
      ((atom? (car l))
        (cond
          ((even? (car l))
           (even-only*&co (cdr l)
            (lambda (newlat p s)
              (col (cons (car l) newlat) (x (car l) p) s))))
          (else (even-only*&co (cdr l)
                 (lambda (newlat p s)
                  (col newlat p (+ (car l) s)))))))
      (else (even-only*&co (car l)
                           (lambda (al ap as)
                            (even-only*&co (cdr l)
                              (lambda (dl dp ds)
                                (col (cons al dl) (x ap dp) (+ as ds))))))))))
;
; define the-last-friend for col to check the even-only*&co
;
(define the-last-friend
  (lambda (lat p s)
    (cons s (cons p (cons lat (quote ()))))))
;
;
; examples of even-only*&co
;
(even-only*&co (quote ((9 1 2 8) 3 10 ((9 9) 7 6) 2)) the-last-friend)
;Value : (38 1920 ((2 8) 10 (() 6) 2))
