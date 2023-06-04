% b

% Model matematic:
% sets(l1...ln, k) =
%	[], k = 0
%	l1 + sets(l2...ln, k - 1), k > 0
%	sets(l2...ln, k), k > 0

% sets(L:list, K:number, R:list)
% sets(i, i, o)

sets(_, 0, []) :- !.
sets([H|T], K, [H|R]) :-
    K1 is K - 1,
    sets(T, K1, R).
sets([_|T], K, R) :-
    sets(T, K, R).

% Model matematic:
% gen_sets(l1..ln) =
%	[], n = 0
%	findall(sets(l1...ln, 2))

% gen_sets(L:list, R:list)
% gen_sets(i, o)

gen_sets([], []).
gen_sets(L, R) :- findall(RS, sets(L, 2, RS), R).
