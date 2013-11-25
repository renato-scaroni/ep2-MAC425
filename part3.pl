:- [part1].
:- [part2].

formata_saida(X, Y, NovaSaida):-
	eh(X, Y),
	atom_concat(X, ' eh aas ', A),
	atom_concat(A, Y, B),
	atom_concat(B, '.', NovaSaida);
	da(X, Y),
	atom_concat('O(a) professor(a) ', X, A),
	atom_concat(A, ' da ', B),
	atom_concat(B, Y, C),
	atom_concat(C, '.', NovaSaida).

query(A, S0, S) :- S0=[quando|T], get_obj(X, T), X \= que, eh(X, Y), formata_saida(X, Y, A).
query(A, S0, S) :- S0=[quem|T], get_obj(X, T), X \= que, da(Y, X), formata_saida(Y, X, A).
query(A, S0, S) :- S0=[quem|T], get_obj(X, T), X = que, da(Z, Y), A=[Z, Y].
query(A, S0, S) :- S0=[o|T], T = [que|T1], get_suj(X, T1), da(X, Y), formata_saida(X, Y, A).

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
	write('adding stuff'),
	sentenca(Z, L, []).

programa(X) :- 
	monta_lista(L),
	ultimo_elem(Y, L),
	Y = '?',
	query(Z, L, []),
	print_res(Z),
	nl.
