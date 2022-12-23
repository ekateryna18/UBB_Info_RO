;Problema 2
;------------------------------------
;a) Definiti o functie care selecteaza al n-lea element al unei liste, sau NIL, daca nu exista.
(defun selectare(l poz n)
    (cond
        ((null l) nil)
        ((eq poz n) (car l))
        (t(selectare (cdr l) (+ poz 1) n))
    )
)
; functia care selecteaza un element de pe pozitia n din lista
(defun elem_select(l n)
    (selectare l 1 n )
)
;>>>>>>>>>>>
;exemple a
(defun exa1()
    (elem_select '(5 7 8 9) 2)
)
(defun exa2()
    (elem_select '(5 6 7 3) 4)
)
(defun exa3()
    (elem_select '(5 6 7 3) 9)
)
(defun exa4()
    (elem_select '() 9)
)
;-------------------------------------
;b) Sa se construiasca o functie care verifica daca un atom e membru al unei liste nu neaparat liniara.
(defun verifica_atom(l e)
    (cond
        ((null l) nil)
        ((AND (atom(car l)) (equal (car l) e)) t)
        ((atom (car l)) (verifica_atom (cdr l) e))
        ((list(car l)) (OR (verifica_atom (car l) e) (verifica_atom (cdr l) e)))
    )
)

;>>>>>>>>>>>
;exemple b
(defun exb1()
    (verifica_atom '(1 c (3 (x y) (1 0) 5 4)) 'x)
)
(defun exb2()
    (verifica_atom '(1 c (3 (x y) (1 0) d 4)) '6)
)
;---------------------------------------------
;c) Sa se construiasca lista tuturor sublistelor unei liste.
;Prin sublista se intelege fie lista insasi, fie un element de pe orice nivel, care este lista.
;Exemplu: (1 2 (3 (4 5) (6 7)) 8 (9 10)) =>
;       ( (1 2 (3 (4 5) (6 7)) 8 (9 10)) (3 (4 5) (6 7)) (4 5) (6 7) (9 10) ).

(defun sublists (l first)
    (cond
        ((null l) nil)
        ((= first 1) (cons l (sublists l 0)) )
        ((listp (car l)) (append (sublists(car l) 1) (sublists(cdr l) 0) ) )
        (T (sublists (cdr l) 0))
    )
)
(defun all_subl(l)
    (sublists l 1)
)
;>>>>>>>>>>>>>
;exemplu
(defun exc1()
    (all_subl '(1 2 (3 (4 5) (6 7)) 8 (9 10)) )
)
;-----------------------------------------------------
;d) Sa se scrie o functie care transforma o lista liniara intr-o multime.
(defun sterge_ap(l e)
    (cond
        ((null l) nil)
        ((= (car l) e) (sterge_ap (cdr l) e))
        (t(cons (car l) (sterge_ap (cdr l) e)))
    )
)

(defun transform_set(l)
    (cond
        ((null l) nil)
        (t(cons(car l) (transform_set (sterge_ap (cdr l) (car l)))))
    )
)
;>>>>>>>>
;exemplu
(defun exd1()
    (transform_set '(1 2 3 2 4 5 6 6 7))
)
;-----------------------------------------------------------