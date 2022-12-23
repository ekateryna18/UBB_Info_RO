%a
%stergap(L:list, E:Integer, R:List)

stergap([],_,[]):-!.
stergap([H|T],E,[H|R]):-
    H=\=E,
    stergap(T,E,R).
stergap([H|T],E,R):-
    H=:=E,
    stergap(T,E,R).

%transform(L:list,R:list)
transform([],[]):-!.
transform([H|T],[H|R]):-
    stergap(T,H,R1),
    transform(R1,R).

%b
%descomp(L:list, R:List)

descomp([],[0,0,[],[]]):-!.
descomp([H|T],[NP1,NI,[H|R1],R2]):-
    H mod 2 =:= 0,
    descomp(T,[NP,NI,R1,R2]),
    NP1 is NP+1.
descomp([H|T],[NP,NI1,R1,[H|R2]]):-
    H mod 2 =\= 0,
    descomp(T,[NP,NI,R1,R2]),
    NI1 is NI+1.



