%Sa se sorteze o lista cu eliminarea dublurilor. De ex: [4 2 6 2 3 4] =>
% [2 3 4 6]

% Model matematic:
% my_length(l1...ln, c) =
%	c, n = 0
%	my_length(l2...ln, c + 1), otherwise

% my_length(L:list, C:number, R:number)
% flow model: my_length(i, i, o)
%lungime(L:list,N:integer,R:integer)
lungime([],N,N):-!.
lungime([_|T],N,R):-
    N1 is N+1,
    lungime(T,N1,R).

adauga([],E,[E]):-!.
adauga([H|T],E,[H|R]):-
    adauga(T,E,R).

% Model matematic:
% split(l1...ln, c1...cm) =
%	return, abs(m - n) <= 1 -> ori 1 ori 0 altfel merge in apel recursiv
%	split(l2...ln, l1 + c1...cm), n > m

% split(L:list, LC:list, Left:list, Right:list)
% flow model: split(i, i, o, o)
%split(L:list,C:list,S:list,D:list)
split(L,C,C,L):-
    lungime(L,0,RD),
    lungime(C,0,RS),
    DIF is RD-RS,
    abs(DIF,AUX),
    AUX =< 1,!.

split([H|T],C,S,D):-
    adauga(C,H,RC),
    split(T,RC,S,D).

splitList(L,S,D):-split(L,[],S,D).

%Model matematic:
% my_merge(l1...ln, r1...rm) =
%	l1...ln, m = 0
%	r1...rn, n = 0
%	l1 + my_merge(l2...ln, r1...rm), l1 <= r1
%	r1 + my_merge(l1...ln, r2...rm), l1 > r1
%my_merge(S:list,D:list,R:list)
my_merge(S,[],S):-!.
my_merge([],D,D):-!.
my_merge([HS|TS],[HD|TD],[HS|R]):-
    HS=<HD,
    my_merge(TS,[HD|TD],R).
my_merge([HS|TS],[HD|TD],[HD|R]):-
    HS>HD,
    my_merge([HS|TS],TD,R).

% Model matematic:
% merge_sort(l1...ln) =
%	[], n = o
%	[l1], n = 1
%       merge( merge_sort(l1....l(n/2)), merge_sort(l(n/2+1)...ln)),
%       otherwise

% merge_sort(L:list, R:list)
% flow model: merge_sort(i, o)

merge_sort([],[]):-!.
merge_sort([E],[E]):-!.
merge_sort(L,R):-
    splitList(L,S,D),
    merge_sort(S,RS),
    merge_sort(D,RD),
    my_merge(RS,RD,R).

% Model matematic:
% remove_doubles(l1...ln) =
%	[], n = 0
%	[l1], n = 1
%	l1 + remove_doubles(l2...ln), l1 != l2
%	remove_doubles(l2...ln), otherwise

% remove_doubles(L:list, R:list)
% flow model: remove_doubles(i, o)

eliminaDubl([],[]):-!.
eliminaDubl([E],[E]):-!.
eliminaDubl([H1,H2|T],[H1|R]):-
    H1=\=H2,
    eliminaDubl([H2|T],R).
eliminaDubl([H1,H2|T],R):-
    H1=:=H2,
    eliminaDubl([H2|T],R).

sort_list(L,R):-
    merge_sort(L,RL),
    eliminaDubl(RL,R).

