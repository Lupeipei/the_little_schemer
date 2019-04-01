; Chapter 01 Toys
;
; Examples of atoms:
;
(quote atom)
;Value: atom

(quote turkey)
;Value: turkey

(quote 1492)
;Value: 1492

(quote u)
;Value: u

(quote *abc$)
;Value: *abc$

; Examples of list
;
(quote (atom))
;Value: (atom)

(quote (atom turkey or))
; Value: (atom turkey or)

(quote ((atom turkey) or))
; Value: ((atom turkey) or)

(quote (how are you doing so far))
;Value: (how are you doing so far)

(quote ())
;Value: ()

(quote (() () () ()))
;Value: (() () () ())

;  Examples of S-expressions, all lists and all atoms are S-expressions
;
(quote ((atom turkey) or))
;Value: ((atom turkey) or)

(quote (x y z))
;Value: (x y z)

(quote ((x y) z))
;Value: ((x y) z)

; Examples of car, wiki: car is an abbreviate of Contents of the Address part of Register number
;
(car (quote (a b c)))
;Value: a

(car (quote ((a b c) x y z)))
;Value: (a b c)

; ----------------------------------------------------------------------------.
; ; the law of car                                                            ;
; ; The primitive car is defined only for non-empty lists                     ;
;-----------------------------------------------------------------------------.
; more examples of car
;
(car (quote (((hotdogs)) (and) (pickle) relish)))
;Value: ((hotdogs))

(car (car (quote (((hotdogs)) (and) (pickle) relish))))
;Value: (hotdogs)

; Examples of cdr, wiki: cdr is an abbreviate of Contents of the Decrement part of Register number
;
(cdr (quote (a b c)))
;Value: (b c)

(cdr (quote ((a b c) x y z)))
;Value: (x y z)

(cdr (quote (hamburger)))
;Value: ()

(cdr (quote ((x) t r)))
;Value: (t r)

; ----------------------------------------------------------------------------.
; ; the law of cdr                                                            ;
; ; The primitive cdr is defined only for non-empty lists.                    ;
; ; the cdr of any non-empty list is always another list.                     ;
;-----------------------------------------------------------------------------.
; Examples of car and cdr
;
(car (cdr (quote ((b) (x y) ((c))))))
;Value: (x y)

(cdr (cdr (quote ((b) (x y) ((c))))))
;Value: (((c)))

(cdr (cdr (quote (a (b (c)) d))))
;Value: (d)

; Examples of cons
;
(cons (quote peanut) (quote (butter and jelly)))
;Value: (peanut butter and jelly)

(cons (quote (banana and)) (quote (peanut butter and jelly)))
;Value: ((banana and) peanut butter and jelly)

(cons (quote ((help) this)) (quote (is very ((hard)) to learn)))
;Value: (((help) this) is very ((hard)) to learn)

(cons (quote (a b (c))) (quote ()))
;Value: ((a b (c)))

; ----------------------------------------------------------------------------.
; ; the law of cons                                                           ;
; ; The primitive cons takes two arguments. The second argument to cons must  ;
; ; be a list. The result is a list                                           ;
;-----------------------------------------------------------------------------.
; more examples of cons
;
(cons (quote a) (quote ((b) c d)))
;Value: (a (b) c d)

(cons (quote a) (cdr (quote ((b) c d))))
;Value: (a c d)

; examples of null?
;
(null? (quote ()))
;Value: #t

(null? (quote (a b c)))
;Value: #f

; ----------------------------------------------------------------------------.
; ; the law of null?                                                          ;
; ; The primitive null? is defined only for lists                             ;
;-----------------------------------------------------------------------------.
; define atom?
;
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))
; examples of atom?
;
(atom? (quote Harry))
;Value: #t

(atom? (quote (Harry had a heap of apples)))
;Value: #f

(atom? (car (quote (Harry had a heap of apples))))
;Value: #t

(atom? (cdr (quote (Harry had a heap of apples))))
;Value: #f

(atom? (cdr (quote (Harry))))
;Value: #f

(atom? (car (cdr (quote (swing low sweet cherry oat)))))
;Value: #t

(atom? (car (cdr (quote (swing (low sweet) cherry oat)))))
;Value: #f

; examples of eq?
;
(eq? (quote Harry) (quote Harry))
;Value: #t

(eq? (quote margarine) (quote butter))
;Value: #f

; ----------------------------------------------------------------------------.
; ; the law of eq?                                                            ;
; ; The primitive eq? takes two arguments. Each must be a non-numeric atom.   ;
;-----------------------------------------------------------------------------.
; more examples of eq?
;
(eq? (car (quote (Mary had a little lamb chop))) (quote Mary))
;Value: #t

(eq? (car (quote (beans beans we need jelly beans))) (car (cdr (quote (beans beans we need jelly beans)))))
;Value: #t
