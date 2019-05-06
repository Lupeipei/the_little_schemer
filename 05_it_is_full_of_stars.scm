; Chapter 05 "oh my gawd": it's full of stars
;
; define atom? from chapter 02
;
(define atom?
  (lambda (l)
    (and (not (pair? l)) (not (null? l)))))

; define add1 from chapter 04
;
(define add1
  (lambda (n)
    (+ n 1)))
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
; examples of eqan?
; define rember*
;
(define rember*
  (lambda (a l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
        (cond
          ((eq? a (car l)) (rember* a (cdr l)))
          (else (cons (car l) (rember* a (cdr l))))))
      (else (cons (rember* a (car l)) (rember* a (cdr l)))))))
; examples of rember*
;
(rember* (quote cup) (quote ((coffee) cup ((tea) cup) (and (hick)) cup)))
;Value: ((coffee) ((tea)) (and (hick)))

(rember* (quote sauce) (quote (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))))
;Value: (((tomato)) ((bean)) (and ((flying))))

(rember* (quote sauce) (quote ((((tomato sauce) sauce)) ((bean) sauce) (and ((flying)) sauce))))
;Value: ((((tomato))) ((bean)) (and ((flying))))

; define insertR*
;
(define insertR*
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
        (cond
          ((eq? (car l) old) (cons old (cons new (insertR* new old (cdr l)))))
          (else (cons (car l) (insertR* new old (cdr l))))
        ))
      (else (cons (insertR* new old (car l)) (insertR* new old (cdr l)))))))
;
; examples of insertR*
;
(insertR* (quote roast) (quote chuck) (quote (how much chuck)))
;Value: (how much chuck roast)

(insertR* (quote roast) (quote chuck) (quote ((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood)))
; Value: ((how much (wood)) could ((a (wood) chuck roast)) (((chuck roast))) (if (a) ((wood chuck roast))) could chuck roast wood)

; ----------------------------------------------------------------------------.
; ; the first commandment                                                     ;
; ; (final revision)                                                          ;
; ; when recurring on a list of atom, lat, ask two questions about it:        ;
; ; (null? lat) and else.                                                     ;
; ; when recurring on a number n, ask two questions about it:                 ;
; ; (zero? n) and else.                                                       ;
; ; when recurring on a list of S-expressions, l, ask three questions about it;
; ; (null? l), (atom? (car l)) and else.                                      ;
; ----------------------------------------------------------------------------.
;
;
; ----------------------------------------------------------------------------.
; ; the fourth commandment                                                    ;
; ; (final revision)                                                          ;
; ; always change at least one argument while recuring.                       ;
; ; when recurring on a list of atoms, lat, use (cdr lat). when recurring on  ;
; ; a number, use (sub1 n). and when recurring on a list of S-expressions, l  ;
; ; use (car l) and (cdr l) if neither (null? l) nor (atom? (car l)) are true ;
; ; It must be changing closer to termination. The changing argument must be  ;
; ; tested in the termination condition:                                      ;
; ; when using cdr, test termination with null?                               ;
; ; when using sub1, test termination with zero?                              ;
; ----------------------------------------------------------------------------.
;
;
; define occur*
;
(define occur*
  (lambda (a l)
    (cond
      ((null? l) (quote 0))
      ((atom? (car l))
        (cond
          ((eq? a (car l)) (add1 (occur* a (cdr l))))
          (else (occur* a (cdr l)))
        ))
      (else (+ (occur* a (car l)) (occur* a (cdr l)))))))
;
; examples of occur*
;
(occur* (quote banana) (quote ((banana) (split ((((banana ice)))(cream (banana)) sherbet)) (banana) (bread) (banana brandy))))
;Value: 5

;
;
; define subst*
;
(define subst*
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
        (cond
          ((eq? (car l) old) (cons new (subst* new old (cdr l))))
          (else (cons (car l) (subst* new old (cdr l))))))
      (else (cons (subst* new old (car l)) (subst* new old (cdr l)))))))
; examples of subst*
;
(subst* (quote orange) (quote banana) (quote ((banana) (split ((((banana ice)))(cream (banana)) sherbet)) (banana) (bread) (banana brandy))))
;Value: ((orange) (split ((((orange ice))) (cream (orange)) sherbet)) (orange) (bread) (orange brandy))
;
; define insertL*
;
(define insertL*
  (lambda (new old l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l))
        (cond
          ((eq? (car l) old) (cons new (cons old (insertL* new old (cdr l)))))
          (else (cons (car l) (insertL* new old (cdr l))))
        ))
      (else (cons (insertL* new old (car l)) (insertL* new old (cdr l)))))))
;
; examples of insertL*
(insertL* (quote pecker) (quote chuck) (quote ((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood)))
;Value: ((how much (wood)) could ((a (wood) pecker chuck)) (((pecker chuck))) (if (a) ((wood pecker chuck))) could pecker chuck wood)

;
; define member*
;
(define member*
  (lambda (a l)
    (cond
      ((null? l) #f)
      ((atom? (car l))
        (cond
          ((eq? a (car l)) #t)
          (else (member* a (cdr l)))))
      (else (or (member* a (car l)) (member* a (cdr l)))))))
;
; examples of member*
;
(member* (quote chips) (quote ((potatoes) (chips ((with)) fish) (chips))))
;Value: #t
;
; define leftmost
;
(define leftmost
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      ((atom? (car l)) (car l))
      (else (leftmost (car l))))))
;
; examples of leftmost
;
(leftmost (quote ((potato) (chips ((with) fish) (chips)))))
;Value: potato

(leftmost (quote ((((hot)) (tuna (and))) cheese)))
;Value: hot

(leftmost (quote ()))
;Value: ()
;
; define eqlist?
;
(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      ((and (atom? (car l1)) (atom? (car l2))) (and (eqan? (car l1) (car l2)) (eqlist? (cdr l1) (cdr l2))))
      ((or (atom? (car l1)) (atom? (car l2))) #f)
      (else (and (eqlist? (car l1) (car l2)) (eqlist? (cdr l1) (cdr l2))))
      )))
;
; examples of eqlist?
;
(eqlist? (quote (strawberry ice cream)) (quote (strawberry ice cream)))
;Value: #t

(eqlist? (quote (strawberry ice cream)) (quote (strawberry cream ice)))
;Value: #f

(eqlist? (quote (banana ((split)))) (quote ((banana) (split))))
;Value: #f

(eqlist? (quote (beef ((sausage)) (and (soda)))) (quote (beef ((sausage)) (and (soda)))))
;Value: #t

;
; define equal?
;
(define equal?
  (lambda (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2)) (eqan? s1 s2))
      ((or (atom? s1) (atom? s2)) #f)
      (else (eqlist? s1 s2)))))
;
; rewrite eqlist? using equal?
;
(define eqlist?
  (lambda (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)
      ((or (null? l1) (null? l2)) #f)
      (else (and (equal? (car l1) (car l2)) (eqlist? (cdr l1) (cdr l2))))
      )))
;
;
(eqlist? (quote (strawberry ice cream)) (quote (strawberry ice cream)))
;Value: #t

(eqlist? (quote (strawberry ice cream)) (quote (strawberry cream ice)))
;Value: #f

(eqlist? (quote (banana ((split)))) (quote ((banana) (split))))
;Value: #f
; ----------------------------------------------------------------------------.
; ; the sixth commandment                                                     ;
; ; simplify only after the function is correct.                              ;
; ----------------------------------------------------------------------------.
;
; redefine rember
;
(define rember
  (lambda (s l)
    (cond
      ((null? l) (quote ()))
      ((equal? (car l) s) (cdr l))
      (else (cons (car l) (rember s (cdr l)))))))
;
; examples of rember
;
(rember (quote ((tea) cup)) (quote ((coffee) cup ((tea) cup) (and (hick)) cup)))
;Value: ((coffee) cup (and (hick)) cup)

(rember (quote banana) (quote (banana (apple) orange)))
;Value: ((apple) orange)
