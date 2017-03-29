
% X determinam os valores livres
% Y determinam os valores que multiplicam a variável a ser calculada (dependente)
% A deve ser definida apenas uma vez, se não, a equação possui duas variáveis

% equacao(E, R):- resolve uma equacao E, retornando o resultado em R
%    (termo, float) (+,-)
equacao(E, R) :-
    E =.. L,
    igualdade(L,L1), % equal sign
    (termo(L1, L2, X1, Y1, A) -> true; throw('malformed expression')), % left side
    (termo(L2,[], X2, Y2, A) -> true; throw('malformed expression')), % right side
    X is X2 - X1, % calcula valor livre
    Y is Y1 - Y2, % calcula valor dependente
    (Y =:= 0 -> throw('degree zero') ; true), % dependente não pode ser zero
    R is X / Y. % calcula resultado

% termo(L,T,X,Y,A):- resolve a cabeca H da lista L, retornando em T a calda de tal lista, em X o valor indepentende, em Y o valor dependente e em A a variável encontrada (cujo valor está em Y. 
%   (list, list, float, float, factor) (+,-,-,-,?)
termo([H|T], T, X, Y, A) :-
    make_list(H, L),
    operador(L, L1, O), % get operator O
    termo(L1, L2, X1, Y1, A), % solve left side
    termo(L2, [], X2, Y2, A), % solve right side
    quatern(O, X1, X2, Y1, Y2, X, Y, A),!. % solve operation
termo([H|T], T, X, Y, A) :-
    make_list(H, L),
    unario(L, L1, O), % operador O
    termo(L1, [], X1, Y1, A), % valor do termo
    opera(O, 0, X1, X, _, A), % atribui operador no termo livre
    opera(O, 0, Y1, Y, _, A), % atribui operador no termo dependente
    !.
termo(L, T, X, Y, A) :-    
    operando(L, T, V), % operando (dependente ou livre)
    opera_un(V, X, Y, A). % detemrina se dependente ou livre

% make_list(H,L):- faz uma lista formada pelos termos do item dado
%    (term, list) (+,-)
make_list(H, L):-
    catch(H =.. L, _, throw('malformed expression - use x, not X')), !.

% quatern(op, X1, Y1, X2, Y2, X, Y, A):- realiza uma operação dois a dois, do tipo (X1 + Y1*x)op(X2+Y2*x)=(X+Y*x), onde x é a variável (armazenada em A) e op é a operação (+,-,*,/)
% quartern(op, float, float, float, float, float, float, termo) (+,+,+,+,+,-,-,?)
quatern(+, X1, X2, Y1, Y2, X, Y, A) :-
    opera(+, X1, X2, X, _, A),
    opera(+, Y1, Y2, Y, _, A).
quatern(-, X1, X2, Y1, Y2, X, Y, A) :-
    opera(-, X1, X2, X, _, A),
    opera(-, Y1, Y2, Y, _, A).
quatern(*, X1, X2, Y1, Y2, X, Y, A) :-
    opera(*, X1, X2, X3, _, A),
    opera(*, X1, Y2, Y3, _, A),
    opera(*, Y1, X2, Y4, _, A),
    (Y1 * Y2 =\= 0 -> throw('degree greater than one') ; true),
    X is X3,
    Y is Y3 + Y4.
quatern(/, X1, X2, Y1, 0, X, Y, A) :- % divisão não pode ter variável depende
    opera(/, X1, X2, X, _, A),
    opera(/, Y1, X2, Y, _, A).

% opera(op, V1, V2, X, Y, A):- realiza uma operação entre dois termos V1 e V2, que podem ser dependentes ou independentes
%   (op, termo, termo, float, float, termo) (+,+,+,-,-,?)
opera(+, W, X, Y, Z, A):-
    opera_un(W, Y1, Z1, A), opera_un(X, Y2, Z2, A),
    Y is Y1 + Y2,
    Z is Z1 + Z2.
opera(-, W, X, Y, Z, A):-
    opera_un(W, Y1, Z1, A), opera_un(X, Y2, Z2, A),
    Y is Y1 - Y2,
    Z is Z1 - Z2.
opera(*, W, X, Y, Z, A):-
    opera_un(W, Y1, Z1,A), opera_un(X, Y2, Z2, A),
    (Z1 * Z2 =\= 0 -> throw('degree greater than one') ; true),
    Y is Y1 * Y2,
    Z is Y1 * Z2 + Y2 * Z1.
opera(/, X1, Y1, X, Y, A):-
    opera_un(X1, Y2, Y3,A), number(Y1),
    X is Y2 / Y1,
    Y is Y3 / Y1.

% opera_un(V, X, Y, A):- define se o valor contido em V é dependente ou não. Se independente, seu valor é armazenado em X; se dependente, seu valor é armazenado em Y e a variável em A
%   (termo, float, float, termo) (+,-,-,?)
opera_un(V, X, Y, _):-
    number(V), X is V, Y is 0,!.
opera_un(V, X, Y, A):-
    \+number(V), X is 0, Y is 1,
    (verify(V,A) -> A = V ; throw('zero vars or more than one var')).
% verify:- verifica se os valores são iguais (utilizado para facilitar o tratamento de exceção)
%   (termo, termo) (?,?)
verify(V, A):-
    V = A.

% operando(L1,L2,V):- retira o operando da cabeça da lista L1, retornando a calda em L2 e o operando em V
%   (list, list, V) (+,-,-)
operando([H|T], T, H):-
    atomic(H).

% unario(L1, L2, op):- retira um operador unário da lista L1, retornando a calda em L2 e o operador unário em op
%   (list, list, op) (+,-,-)
unario([+|T], T,+).
unario([-|T], T,-).

% operador(L1, L2, op):- retira um operador da lista L1, retornando a calda em L2 e o operador em op
%   (list, list, op) (+,-,-)
operador([+|T], T,+).
operador([-|T], T,-).
operador([*|T], T,*).
operador([/|T], T,/).

% igualdade(L1, L2):- retira o sinal de igualdade da lista L1, retornando a calda em L2
%   (lista, lista) (+,-)
igualdade([H|T], T) :-
    ([H] =\= [=] -> throw('no equal sign'); true). 

% executa o programa
main:-
    catch(read(E), _, format('erro; syntax error~n')),
    \+var(E),
    catch(equacao(E, R), C, format('erro; ~w~n', C)),
    \+var(R),
    %format('~g', R),
    write(R),
    write('; ok'), nl.
