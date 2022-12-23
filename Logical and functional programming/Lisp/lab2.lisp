;6. Sa se construiasca lista nodurilor unui arbore de tipul (1) parcurs in inordine.
;(A 2 B 0 C 2 D 0 E 0)

; pargurg_st(l1l2...ln, nrNoduri, nrMuchii) =
; = nil, daca n = 0
; = nil, daca nrNoduri = 1 + nrMuchii
; = {l1} U {l2} U parcurg_st(l3...ln, nrNoduri + 1, l2 + nrMuchii), altfel

(defun parcurg_st (l nrNoduri nrMuchii)
  (cond
    ((null l) nil)
    ((= nrNoduri ( + 1 nrMuchii)) nil)
    (t (cons (car l) (cons (cadr l) (parcurg_st (cddr l) (+ 1 nrNoduri) (+ (cadr l) nrMuchii)))))
  )
)


; parcurg_dr(l1l2...ln, nrNoduri, nrMuchii) =
; = nil, daca n = 0
; = l1l2...ln, daca nrNoduri = 1 + nrMuchii
; = parcurg_dr(l3...ln, nrNoduri + 1, nrMuchii + l2), altfel


(defun parcurg_dr (l nrNoduri nrMuchii)
  (cond
    ((null l) nil)
    ((= nrNoduri (+ 1 nrMuchii)) l)
    (t (parcurg_dr (cddr l) (+ 1 nrNoduri) (+ (cadr l) nrMuchii)))
  )
)


;stang(l1l2...ln) =
; = parcurg_st(l3...ln, 0,0)

(defun stang(l)
  (parcurg_st (cddr l) 0 0)
)


;drept(l1l2...ln) =
; = parcurg_dr(l3...ln, 0, 0)

(defun drept(l)
  (parcurg_dr (cddr l) 0 0)
)


; myAppend(l1l2...ln, p1p2...pm) =
; = p1p2...pm, daca n = 0
; = {l1} U myAppend(l2...ln, p1p2...pm), altfel

(defun myAppend(l p)
  (cond
    ((null l) p)
    (t (cons (car l) (myAppend (cdr l) p)))
  )
)


; inorder(l1l2...ln) =
; = nil, daca n = 0
; = myAppend(inorder(stang(l1l2...ln)), myAppend(list(l1), inorder(drept(l1l2...ln)))), altfel

(defun inorder (l)
  (cond
    ((null l) nil)
    (t (myAppend (inorder (stang l)) (myAppend (list (car l)) (inorder (drept l)))))
  )
)

(defun ex()
    (inorder '(A 2 B 0 C 2 D 0 E 0))
)
(defun ex2()
  (inorder '(A 2 B 1 H 1 I 2 J 0 K 0 C 2 D 1 G 0 E 0))
)
;(A 2 B 1 H 1 I 2 J 0 K 0 C 2 D 1 G 0 E 0)
;