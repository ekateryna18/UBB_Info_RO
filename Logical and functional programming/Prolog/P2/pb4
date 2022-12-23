%4a
%Sa se interclaseze fara pastrarea dublurilor doua liste sortate.
%interclasare(LS:list,LD:list,R:list)

interclasare(LS,[],LS):-!.
interclasare([],LD,LD):-!.
interclasare([HS|TS],[HD|TD],[HS|R]):-
    HS<HD,
    interclasare(TS,[HD|TD],R).
interclasare([HS|TS],[HD|TD],[HD|R]):-
    HD<HS,
    interclasare([HS|TS],TD,R).
interclasare([HS|TS],[HD|TD],R):-
    HD=:=HS,
    interclasare([HS|TS],TD,R).
