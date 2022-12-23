%inverseaza lista
% Model matematic:
% inv_list(l1...ln) =
% 	[], n = 0
% 	my_append(inv_list(l2...ln), l1), otherwise

% inv_list(L:list, R:list)
% flow model: inv_list(i, o)
inverseaza([],C,C):-!.
inverseaza([H|T],C,R):-
    inverseaza(T,[H|C],R).

inverseazaLista([H|T],R):-inverseaza([H|T],[],R).

% Model matematic:
% suma(a1...an, b1...bm, c) =
% 	[], n = 0 and m = 0 and c = 0
% 	[1], n = 0 and m = 0 and c = 1
% 	(b1 + c) + suma([], b2...bm, 0), n = 0 and b1 + c < 10
% 	((b1 + c) % 10) + suma([], b2...bm, 1), n = 0 and b1 + c > 10
% 	(a1 + b1 + c) + suma(a2...an, b2...bm, 0), a1 + b1 + c < 10
% 	((a1 + b1 + c) % 10) + suma(a2...an, b2...bm, 1), a1 + b1 + c > 10
%suma(A,B,C,R)

suma([],0,[]).
suma([],1,[1]).
suma([BH|BT],C,[B|R]):-
    B is (BH+C) mod 10,
    B-BH-C=:=0,
    suma(BT,0,R).
suma([BH|BT],C,[B|R]):-
    B is (BH+C) mod 10,
    B-BH-C=\=0,
    suma(BT,1,R).

succesor(B,R):-
    inverseazaLista(B,RB),
    suma(RB,1,RS),
    inverseazaLista(RS,R).

% Model matematic:
% sum_lists(a1...an, b1...bm) =
% 	a1...an, m = 0
% 	b1...bm, n = 0
% 	inv_list(suma(inv_list(a1...an), inv_list(b1...bm), 0)), n <= m
% 	inv_list(suma(inv_list(b1...bm), inv_list(a1...an), 0)), otherwise

% sum_lists(A:list, B:list, R:list)
% flow model: sum_lists(i, i, o)
