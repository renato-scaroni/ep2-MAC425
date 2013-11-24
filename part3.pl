:- [part1].
:- [part2].

query(A, S0, S) :- S0=[quando|T], get_obj(X, T), X \= que, eh(X, Y), A = Y.
query(A, S0, S) :- S0=[quem|T], get_obj(X, T), X \= que, da(Y, X), A = Y.
query(A, S0, S) :- S0=[quem|T], get_obj(X, T), X = que, da(Z, Y), A=[Z, Y].
query(A, S0, S) :- S0=[o|T], T = [que|T1], get_suj(X, T1), da(X, Y), A = Y.

get_suj(X, [E|T]) :- E = professora, T = [E1|T1], E1 = X.
get_suj(X, [E|T]) :- E = professor, T = [E1|T1], E1 = X.
get_suj(X, [E|T]) :- get_suj(X, T).

get_obj(X, [E|T]) :- is_verb(E), get_obj(X, T).
get_obj(X, [E|T]) :- E = o, T = [E1|T1], E1 = que, X = E1.
get_obj(X, [E|T]) :- X = E.

is_verb(eh).
is_verb(da).

print_res(A) :- write(A).

programa(X) :- 
	monta_lista(L),
	ultimo_elem(Y, L),
	Y = '.',
	sentenca(Z, L, []).

programa(X) :- 
	monta_lista(X),
	ultimo_elem(Y, X),
	Y = '?',
	query(Z, L, [])
	print_res(Z),
	nl.