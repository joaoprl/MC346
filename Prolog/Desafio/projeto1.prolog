

equacao(E, R) :-
    E =.. L,
    igualdade(L,L1),
    (termo(L1, L2, X1, Y1,A) -> true; throw('malformed expression')),
    (termo(L2,[], X2, Y2,A) -> true; throw('malformed expression')),
    X is X2 - X1,
    Y is Y1 - Y2,
    (Y =:= 0 -> throw('degree zero') ; true),
    R is X / Y.

termo([H|T],T,X,Y,A) :-
    H =.. L,
    operador(L,L1,O),
    termo(L1,L2,X1,Y1,A),
    termo(L2,[],X2,Y2,A),
    quatern(O,X1,X2,Y1,Y2,X,Y,A),!.
termo([H|T],T,X,Y,A) :-
    H =.. L,
    unario(L,L1,O),
    termo(L1,[],X1,X2,A),
    opera(O,0,X1,W,_,A),
    opera(O,0,X2,Z,_,A),
    X is W,
    Y is Z,
    !.
termo(L,T, X, Y, A) :-    
    operando(L,T,V),
    opera_un(V,X,Y,A).

quatern(+,X1,X2,Y1,Y2,X,Y,A) :-
    opera(+,X1,X2,X,_,A),
    opera(+,Y1,Y2,Y,_,A).
quatern(-,X1,X2,Y1,Y2,X,Y,A) :-
    opera(-,X1,X2,X,_,A),
    opera(-,Y1,Y2,Y,_,A).
quatern(*,X1,X2,Y1,Y2,X,Y,A) :-
    opera(*,X1,X2,X3,_,A),
    opera(*,X1,Y2,Y3,_,A),
    opera(*,Y1,X2,Y4,_,A),
    (Y1 * Y2 =\= 0 -> throw('degree greater than one') ; true),
    X is X3,
    Y is Y3 + Y4.
quatern(/,X1,X2,Y1,0,X,Y,A) :-
    opera(/,X1,X2,X,_,A),
    opera(/,Y1,X2,Y,_,A).

opera(+,W,X,Y,Z,A):-
    opera_un(W,Y1,Z1,A), opera_un(X,Y2,Z2,A),
    Y is Y1 + Y2,
    Z is Z1 + Z2.
opera(-,W,X,Y,Z,A):-
    opera_un(W,Y1,Z1,A), opera_un(X,Y2,Z2,A),
    Y is Y1 - Y2,
    Z is Z1 - Z2.
opera(*,W,X,Y,Z,A):-
    opera_un(W, Y1, Z1,A), opera_un(X, Y2, Z2,A),
    (Z1 * Z2 =\= 0 -> throw('degree greater than one') ; true),
    Y is Y1 * Y2,
    Z is Y1 * Z2 + Y2 * Z1.
opera(/,W,X,Y,Z,A):-
    opera_un(W, Y1, Z1,A), number(X),
    Y is Y1 / X,
    Z is Z1 / X.
opera_un(V, X, Y, _):-
    number(V), X is V, Y is 0,!.
opera_un(V, X, Y, A):-
    \+number(V), X is 0, Y is 1,
    (verify(V,A) -> A = V ; throw('zero vars or more than one var')).

verify(V,A):-
    V = A.

operando([H|T],T,H):-
    atomic(H).

unario([+|T], T,+).
unario([-|T], T,-).

operador([+|T], T,+).
operador([-|T], T,-).
operador([*|T], T,*).
operador([/|T], T,/).
igualdade([H|T], T) :-
    ([H] =\= [=] -> throw('no equal sign'); true). 

main:-
    catch(read(E), _, format('erro; syntax error~n')),
    \+var(E),
    catch(equacao(E, R), C, format('erro; ~w~n', C)),
    \+var(R),
    %format('~g', R),
    write(R),
    write('; ok'), nl.
