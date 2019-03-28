; Chapter 3 cons the magnificent
;
; define atom?
;
(define atom?
  (lambda (l)
    (and (not (pair? l)) (not (null? l)))))
; define lat?
;
(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))
; define rember
;
(define rember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) a) (cdr lat))
      (else (cons (car lat) (rember a (cdr lat)))))))
;
; ----------------------------------------------------------------------------.
; ; the second commandment                                                    ;
; ; use cons to build lists                                                   ;
; ----------------------------------------------------------------------------.
; more examples of rember
(rember (quote mint) (quote (lamb chops and mint jelly)))
(rember (quote mint) (quote (lamb chops and mint flavored mint jelly)))
(rember (quote toast) (quote (bacon lettuce and tomato)))
(rember (quote cup) (quote (coffee cup tea cup and hick cup)))
(rember (quote and) (quote (bacon lettuce and tomato)))
(rember (quote sauce) (quote (soy sauce and tomato sauce)))
;
; define firsts
;
(define firsts
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (else (cons (car (car l)) (firsts (cdr l)))))))
; examples of firsts
;
(firsts (quote ((apple peach pumpkins) (plum pear cherry) (grape raisin pea) (bean carrot eggplant))))
(firsts (quote ((a b) (c d) (e f))))
(firsts (quote ((five plums) (four) (eleven green oranges))))
(firsts (quote (((five plums) four) (eleven green oranges) ((no) more))))
;
; ----------------------------------------------------------------------------.
;; the third commandment                                                      ;
;; when building a list, describe the first typical element, and then cons it ;
;; into the natural recursion                                                 ;
; ----------------------------------------------------------------------------.
; define insertR
;
(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? old (car lat)) (cons (car lat) (cons new (cdr lat))))
      (else (cons (car lat) (insertR (new old (cdr lat))))))))
; more examples of insertR
;
(insertR (quote topping) (quote fudge) (quote (ice cream with fudge for dessert)))
(insertR (quote jalapeno) (quote and) (quote (tacos tamales and salsa)))
(insertR (quote e) (quote d) (quote (a b c d f g d h)))
(insertR (quote topping) (quote fudge) (quote (ice cream with fudge for dessert)))

; define insertL
;
(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? old (car lat)) (cons new lat))
      (else (cons (car lat) (insertL new old (cdr lat)))))))

; define subst
;
(define subst
  (labmda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? old (car lat)) (cons new (cdr lat)))
      (else (cons (car lat) (subst new old (cdr lat)))))))

; examples for subst
;
(subst (quote topping) (quote fudge) (quote (ice cream with fudge for dessert)))

; define subst2
;
(define subst2
  (lambda (new old1 old2 lat)
    (cond
      ((null? lat) (quote ()))
      ((or (eq? (car lat) old1) (eq? (car lat) old2)) (cons new (cdr lat)))
      (else (cons (car lat) (subst2 new old1 old2 lat))))))
; examples for subst2
;
(subst2 (quote vanille) (quote chocolate) (quote banana) (quote (vanilla ice cream with chocolate topping)))

; define multirember
;
(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ())
      ((eq? a (car lat)) (multirember a (cdr lat)))
      (else (cons (car lat) (multirember a (cdr lat))))))))

; examples for multirember
;
(multirember (quote cup) (quote (coffee cup tea cup and hick cup)))

; define multiinsertR
;
(define multiinsertR
  (labmda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? old (car lat)) (cons old (cons new (multiinsertR new old (cdr lat)))))
      (else (cons (car lat) (multiinsertR new old (cdr lat)))))))

; examples for multiinsertR
;
(multiinsertR (quote e) (quote d) (quote (a b c d f g d h)))

; define multiinsertL
;
(define multiinsertL
  (labmda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? old (car lat)) (cons new (cons old (multiinsertL new old (cdr lat)))))
      (else (cons (car lat) (multiinsertL new old (cdr lat)))))))

; examples for multiinsertL
;
(multiinsertL (quote e) (quote d) (quote (a b c d f g d h)))
(multiinsertL (quote fried) (quote fish) (quote (chips and fish or fish and fried)))

; define multisutsr
;
(define multisutsr
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? old (car lat)) (cons new (multisutsr new old (cdr lat))))
      (else (cons (car lat) (multisutsr new old (cdr lat)))))))
;
; ----------------------------------------------------------------------------.
;; the fourth commandment                                                    ;
;; always change at least one arugment while recuring. it must be changed to ;
;; be closer to termination. The changing argument must be tested in the     ;
;; termination condition: when using cdr, test termination with null?        ;
; ----------------------------------------------------------------------------.
;
; ok, time for dessert!
;
