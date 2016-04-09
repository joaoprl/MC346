
p01(L,X) :-
    last(L,X).

last_but1([H,_],H):-!.
last_but1([_|T],X) :-
    last_but1(T,X).

p02(L,X) :-
    last_but1(L,X).

element_at(1,[H|_],H):-!.
element_at(X,[_|T],K):-
    X1 is X - 1,
    element_at(X1,T,K).

p03(X,L,K) :-
    element_at(X,L,K).

p04(L,X):-
    length(L,X).

p05(L,R):-
    reverse(L,R).

palindrome_(L,L):-!.
palindrome_([_|T],T):-!.
palindrome_([H|T],L1):-
    palindrome_(T,[H1|L1]),
    H = H1.
palindrome(L):-
    palindrome_(L,[]).

p06(L):-
    palindrome(L).


flat(H,[H]):-
    \+is_list(H),!.
flat([],[]).
flat([H|T],X):-
    flat(H,H1),
    flat(T,T1),
    append(H1, T1, X).

p07(L,X):-
    flat(L,X).

elim_firsts([],_,[]):-!.
elim_firsts([H|T],E,T1):-
    H =:= E,
    elim_firsts(T,E,T1),!.
elim_firsts(L,E,L):-
    L = [H|_],
    H =\= E.
elim_consec([],[]).
elim_consec([H|T],[H|X]):-
    elim_firsts(T,H,L),
    elim_consec(L,X).

p08(L,X):-
    elim_consec(L,X).

pack_firsts([],_,[],[]):-!.
pack_firsts(L,V,L,[]):-
    \+L = [V|_], !.
pack_firsts([H|T],V,LX,X):-
    H =:= V,
    pack_firsts(T, V, LX, X1),
    append([H],X1,X).

pack([], []):-!.
pack(L,X):-
    L = [H|_],
    pack_firsts(L,H,L1,X1),
    pack(L1, X2),
    append([X1],X2, X).
    
p09(L,X):-
    pack(L,X).

count_pack([],[]).
count_pack([H|T],X):-
    length(H,S),
    count_pack(T,X1),
    append([S],X1,X).

p10(L,X):-
    pack(L,P),
    count_pack(P,X).

count_pack2([],[]).
count_pack2([H|T],X):-
    length(H,1),
    H = [V|_],
    count_pack2(T,X1),
    append([V], X1, X),!.
count_pack2([H|T],X):-
    length(H,S),
    S > 1,
    H = [H1|_],
    V = [S,H1],
    count_pack2(T,X1),
    append([V],X1,X).

p11(L,X):-
    pack(L,P),
    count_pack2(P,X).

generate_list(_,0,[]):-!.
generate_list(V,N,[V|X1]):-
    N > 0,
    N1 is N - 1,
    generate_list(V,N1,X1).

run_length_generator([],[]):-!.
run_length_generator(L,[H|X]):-
    L = [H|T],
    \+is_list(H),
    run_length_generator(T,X),!.
run_length_generator(L,X):-
    L = [[N,V]|T],
    generate_list(V,N,L1),
    run_length_generator(T,X1),
    append(L1,X1,X).

p12(L,X):-
    run_length_generator(L,X).

count_firsts(L,V,L,0):-
    \+L = [V|_],!.
count_firsts([V|T],V,LX,X):-
    count_firsts(T,V,LX,X1),
    X is X1 + 1.

encode_direct_element(1,V,[V]):-!.
encode_direct_element(N,V,[[N,V]]).

encode_direct([],[]).
encode_direct([H|T],X):-
    count_firsts([H|T],H,LX,N),
    encode_direct(LX,X1),
    encode_direct_element(N,H,E),
    append(E,X1,X).

p13(L,X):-
    encode_direct(L,X).

duplicate([],[]).
duplicate([H|T],X):-
    duplicate(T,X1),
    append([H,H],X1,X).

p14(L,X):-
    duplicate(L,X).

dupli([],_,[]).
dupli([H|T],N,X):-
    dupli(T,N,X2),
    generate_list(H,N,X1),
    append(X1,X2,X).

p15(L,N,X):-
    dupli(L,N,X).

drop_([],_,_,[]).
drop_([_|T],N,1,X):-
    drop_(T,N,N,X),!.
drop_([H|T],N,NC,[H|X]):-
    NC > 1,
    N1 is NC - 1,
    drop_(T,N,N1,X).

drop(L,N,X):-
    drop_(L,N,N,X).

p16(L,N,X):-
    drop(L,N,X).

split([],_,[],[]).
split([H|T],0,L1,[H|L2]):-
    split(T,0,L1,L2),!.
split([H|T],N,[H|L1],L2):-
    N > 0,
    N1 is N - 1,
    split(T, N1, L1, L2).

p17(L,N,L1,L2):-
    split(L,N,L1,L2).

slice([],_,_,[]).
slice(_,1,0,[]).
slice([H|T],1,K,[H|X]):-
    K > 0,
    K1 is K - 1,
    slice(T,1,K1,X),!.
slice([_|T],I,K,X):-
    I > 1, K > 1,
    I1 is I - 1,
    K1 is K - 1,
    slice(T,I1,K1,X).

p18(L,I,K,X):-
    slice(L,I,K,X).

take_last([H|[]],H,[]):-!.
take_last([H|T],E,[H|X]):-
    take_last(T,E,X).

rotate_left([H|T],X):-
    append(T,[H],X).
rotate_right(L,[E|X]):-
    take_last(L,E,X).

rotate(L,0,L):-!.
rotate(L,N,X):-
    N < 0,
    rotate_right(L,X1),
    N1 is N + 1,
    rotate(X1,N1,X),!.
rotate(L,N,X):-
    N > 0,
    rotate_left(L,X1),
    N1 is N - 1,
    rotate(X1,N1,X).

p19(L,N,X):-
    rotate(L,N,X).

remove_at(_,[],_,[]).
remove_at(H,[H|T],1,T):-!.
remove_at(X,[H|T],N,[H|R]):-
    N > 1,
    N1 is N - 1,
    remove_at(X,T,N1,R).
    
p20(X,L,N,R):-
    remove_at(X,L,N,R).

insert_at(V,L,1,[V|L]):-!.
insert_at(V,[H|T],N,[H|X]):-
    N > 1,
    N1 is N - 1,
    insert_at(V,T,N1,X).

p21(V,L,N,R):-
    insert_at(V,L,N,R).

range(A,A,[A]):-!.
range(A,B,[A|L]):-
    A1 is A + 1,
    range(A1,B,L).

p22(A,B,L):-
    range(A,B,L).

rnd_select([],_,[]).
rnd_select(_,0,[]):- !.
rnd_select(L,N,[E|X]):-
    N > 0,
    N1 is N - 1,
    length(L,S),
    R is random(S) + 1,
    remove_at(E,L,R,L1),
    rnd_select(L1,N1,X).

p23(L,N,X):-
    rnd_select(L,N,X).

rnd_lotto(N,M,L):-
    range(1,M,R),
    rnd_select(R,N,L).

p24(N,M,L):-
    rnd_lotto(N,M,L).

rnd_rmv(L,E,X):-
    length(L,S),
    R is random(S) + 1,
    remove_at(E,L,R,X).

rnd_permu([],[]):-!.
rnd_permu(L,[E|X]):-
    rnd_rmv(L,E,X1),
    rnd_permu(X1, X).

p25(L,R):-
    rnd_permu(L,R).

combination(0,_,[]).
combination(N,[H|T],[H|X]):-
    N > 0,
    N1 is N - 1,
    combination(N1,T,X).
combination(N,[_|T],X):-
    N > 0,
    combination(N,T,X).

p26(N,L,X):-
    combination(N,L,X).
