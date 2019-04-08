; chapter 07 Friends and Relations
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
; redefine member? with equal?
;
(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (equal? (car lat) a) (member? a (cdr lat)))))))
;
; define set?
;
(define set?
  (lambda (lat)
    (cond
      ((null? lat) #t)
      ((member? (car lat) (cdr lat)) #f)
      (else (set? (cdr lat))))))
;
; examples of set?
;
(set? (quote ()))
;Value: #t

(set? (quote (apple peaches apple plum)))
;Value: #f

(set? (quote (apple peaches pears plum)))
;Value: #t

(set? (quote (apple 3 pear 4 9 apple 3 4)))
;Value: #f

; define makeset
;
(define makeset
  (lambda (lat)
    (cond
      ((null? lat) lat)
      ((member? (car lat) (cdr lat)) (makeset (cdr lat)))
      (else (cons (car lat) (makeset (cdr lat)))))))
;
; examples of makeset
;
(makeset (quote (apple peach pear peach plum apple lemon peach)))
;Value : (pear plum apple lemon peach)
;
; rewrite makeset using multirember
;
; redefine multirember with equal? from chapter 03
;
(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((equal? a (car lat)) (multirember a (cdr lat)))
      (else (cons (car lat) (multirember a (cdr lat)))))))
;
(define makeset
  (lambda (lat)
    (cond
      ((null? lat) lat)
      (else (cons (car lat) (makeset (multirember (car lat) (cdr lat))))))))
;
; examples of redefine makeset
;
(makeset (quote (apple peach pear peach plum apple lemon peach)))
;Value : (apple peach pear plum lemon)

(makeset (quote (apple 3 pear 4 9 apple 3 4)))
;Value : (apple 3 pear 4 9)
;
; define subset?
;
(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      ((member? (car set1) set2) (subset? (cdr set1) set2))
      (else #f))))
; simplify it.
(define subset?
  (lambda (set1 set2)
    (cond
      ((null? set1) #t)
      (else (and (member? (car set1) set2) (subset? (cdr set1) set2))))))
;
; examples of subset?
;
(subset? (quote (5 chicken wings)) (quote (5 hamburgers 2 pieces fried chicken and light duckling wings)))
;Value: #t

(subset? (quote (4 pounds of horseradish)) (quote (four pounds chicken and 5 ounces horseradish)))
;Value: #f

; define eqset? with subset?
;
(define eqset?
  (lambda (set1 set2)
    (and (subset? set1 set2) (subset? set2 set1))))
;
; examples of eqset?
;
(eqset? (quote (6 large chicken with wings)) (quote (6 chicken with large wings)))
;Value: #t

(eqset? (quote (6 large chicken with wings)) (quote (6 with large wings)))
;Value: #f

; define intersect?
;
(define intersect?
  (lambda (set1 set2)
    (cond
      ((or (null? set1) (null? set2)) #f)
      ((member? (car set1) set2) #t)
      (else (intersect? (cdr set1) set2)))))
;
; examples of intersect?
;
(intersect? (quote (stewed tomatoes and macaroni)) (quote (macaroni and cheese)))
;Value: #t

; define intersect
;
(define intersect
  (lambda (set1 set2)
    (cond
      ((null? set1) (quote ()))
      ((member? (car set1) set2) (cons (car set1) (intersect (cdr set1) set2)))
      (else (intersect (cdr set1) set2)))))
;
; examples of intersect
;
(intersect (quote (stewed tomatoes and macaroni)) (quote (macaroni and cheese)))
;Value : (and macaroni)
;
; define union
;
(define union
  (lambda (set1 set2)
    (cond
      ((null? set1) set2)
      ((member? (car set1) set2) (union (cdr set1) set2))
      (else (cons (car set1) (union (cdr set1) set2))))))
;
; examples of union
;
(union (quote (stewed tomatoes and macaroni casserole)) (quote (macaroni and cheese)))
;Value : (stewed tomatoes casserole macaroni and cheese)
;
;
; define intersectall
;
(define intersectall
  (lambda (l-set)
    (cond
      ((null? (cdr l-set)) (car l-set))
      (else (intersect (car l-set) (intersectall (cdr l-set)))))))
;
; examples of intersectall
;
(intersectall (quote ((6 pears and) (3 peaches and 6 peppers) (8 pears and 6 plums) (and 6 prunes with some apples))))
;Value : (6 and)
;
; define a-pair?
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
; examples of a-pair?
;
(a-pair? (quote (pear pear)))
;Value: #t

(a-pair? (quote (3 7)))
;Value: #t

(a-pair? (quote ((2) (pair))))
;Value: #t

(a-pair? (quote (full (house))))
;Value: #t
;
; define first
;
(define first
  (lambda (p)
    (car p)))
;
; define second
;
(define second
  (lambda (p)
    (car (cdr p))))
;
; define build
;
(define build
  (lambda (s1 s2)
    (cons s1 (cons s2 (quote ())))))
;
; define third
;
(define third
  (lambda (p)
    (car (cdr (cdr p)))))
;
; define firsts from chapter 03
;
(define firsts
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (else (cons (car (car l)) (firsts (cdr l)))))))
;
; define fun?
;
(define fun?
  (lambda (rel)
    (set? (firsts rel))))
;
; examples of fun?
;
(fun? (quote ((8 3) (4 2) (7 6) (6 2) (3 4))))
;Value: #t

(fun? (quote ((d 4) (b 0) (b 9) (e 5) (g 4))))
;Value: #f

;
; define revrel
;
(define revrel
  (lambda (rel)
    (cond
      ((null? rel) (quote ()))
      (else (cons (build (second (car rel)) (first (car rel))) (revrel (cdr rel)))))))
;
; examples of revrel
;
(revrel (quote ((8 a) (pumpkin pie) (got sick))))
;Value : ((a 8) (pie pumpkin) (sick got))
; define revpair
;
(define revpair
  (lambda (pair)
    (build (second pair) (first pair))))
;
; rewrite revrel using revpair
;
(define revrel
  (lambda (rel)
    (cond
      ((null? rel) (quote ()))
      (else (cons (revpair (car rel)) (revrel (cdr rel)))))))
;
; examples of revrel
;
(revrel (quote ((8 a) (pumpkin pie) (got sick))))
;Value : ((a 8) (pie pumpkin) (sick got))
;
; define seconds
;
(define seconds
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (else (cons (second (car l)) (seconds (cdr l)))))))
;
; define fullfun?
;
(define fullfun?
  (lambda (fun)
    (set? (seconds fun))))
;
; examples of fullfun?
;
(fullfun? (quote ((8 3) (4 2) (7 6) (6 2) (3 4))))
;Value: #f

(fullfun? (quote ((8 3) (4 8) (7 6) (6 2) (3 4))))
;Value: #t

(fullfun? (quote ((grape raisin) (plum prune) (stewed prune))))
;Value: #f

(fullfun? (quote ((grape raisin) (plum prune) (stewed grape))))
;Value: #t

;
; define one-to-one?
;
(define one-to-one?
  (lambda (fun)
    (fun? (revrel fun))))
;
; examples of one-to-one?
;
(one-to-one? (quote ((chocolate chip) (doughy cookie))))
;Value: #t
