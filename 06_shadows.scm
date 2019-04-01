; chapter 6 Shadows
;
; define atom? from chapter 02
;
(define atom?
  (lambda (l)
    (and (not (pair? l)) (not (null? l)))))
