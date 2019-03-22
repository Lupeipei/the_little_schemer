; Chapter 1 toys
;
; Examples of atoms:
;
(quote atom)
(quote turkey)
(quote 1492)
(quote u)
(quote *abc$)
; Examples of list
;
(quote (atom))
(quote (atom turkey or))
(quote ((atom turkey) or))
(quote (how are you doing so far))
(quote ())
(quote (() () () ()))
;  Examples of S-expressions, all lists and all atoms are S-expressions
;
(quote ((atom turkey) or))
(quote (x y z))
(quote ((x y) z))

; Examples of car, wiki: car is an abbreviate of Contents of the Address part of Register number
;
(car (quote (a b c)))
(car (quote ((a b c) x y z)))
; (car (quote ()))

; ----------------------------------------------------------------------------.
; ; the law of car                                                            ;
; ; The primitive car is defined only for non-empty lists                     ;
;-----------------------------------------------------------------------------.
; more examples of car
;
(car (quote (((hotdogs)) (and) (pickle) relish)))
(car (car (quote (((hotdogs)) (and) (pickle) relish))))

; Examples of cdr, wiki: cdr is an abbreviate of Contents of the Decrement part of Register number
;
(cdr (quote (a b c)))
(cdr (quote ((a b c) x y z)))
(cdr (quote (hamburger)))
(cdr (quote ((x) t r)))
; (cdr (quote ()))
; ----------------------------------------------------------------------------.
; ; the law of cdr                                                            ;
; ; The primitive cdr is defined only for non-empty lists.                    ;
; ; the cdr of any non-empty list is always another list.                     ;
;-----------------------------------------------------------------------------.
; Examples of car and cdr
;
(car (cdr (quote ((b) (x y) ((c))))))
(cdr (cdr (quote ((b) (x y) ((c))))))
(cdr (cdr (quote (a (b (c)) d))))
; Examples of cons
;
(cons (quote peanut) (quote (butter and jelly)))
(cons (quote (banana and)) (quote (peanut butter and jelly)))
(cons (quote ((help) this)) (quote (is very ((hard)) to learn)))
(cons (quote (a b (c))) (quote ()))
; ----------------------------------------------------------------------------.
; ; the law of cons                                                           ;
; ; The primitive cons takes two arguments. The second argument to cons must  ;
; ; be a list. The result is a list                                           ;
;-----------------------------------------------------------------------------.
; more examples of cons
;
(cons (quote a) (quote ((b) c d)))
(cons (quote a) (cdr (quote ((b) c d))))

; examples of null?
;
(null? (quote ()))
(null? (quote (a b c)))
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
(atom? (quote (Harry had a heap of apples)))
(atom? (car (quote (Harry had a heap of apples))))
(atom? (cdr (quote (Harry had a heap of apples))))
(atom? (cdr (quote (Harry))))
(atom? (car (cdr (quote (swing low sweet cherry oat)))))
(atom? (car (cdr (quote (swing (low sweet) cherry oat)))))

; examples of eq?
;
(eq? (quote Harry) (quote Harry))
(eq? (quote margarine) (quote butter))

; ----------------------------------------------------------------------------.
; ; the law of eq?                                                            ;
; ; The primitive eq? takes two arguments. Each must be a non-numeric atom.   ;
;-----------------------------------------------------------------------------.
; more examples of eq?
;
(eq? (car (quote (Mary had a little lamb chop))) (quote Mary))
(eq? (car (quote (beans beans we need jelly beans))) (car (cdr (quote (beans beans we need jelly beans)))))
