:- [part1].
:- [part2].

dias_extenso([], []).

dias_extenso([N0|NT], [D0|DT]):-
	dias(D0, N0),
	dias_extenso(NT, DT).

formata_saida(X, Y, NovaSaida):-
	eh(X, Y),
	atom_concat(X, ' eh aas ', A),
	dias_extenso(Y, D),
	ultimo_elem(U, D),
	select(U, D, L),
	atomic_list_concat(L, ', ', TD),
	atom_concat(TD, ' e ', TDE),
	atom_concat(TDE, U, FIM),
	atom_concat(A, FIM, B),
	atom_concat(B, '.', NovaSaida),
	write(NovaSaida).

formata_saida(X, Y, NovaSaida):-
	da(X, Y),
	genero(X, masc),
	atom_concat('O professor ', X, A),
	atom_concat(A, ' da ', B),
	atom_concat(B, Y, C),
	atom_concat(C, '.', NovaSaida),
	write(NovaSaida).

formata_saida(X, Y, NovaSaida):-
	da(X, Y),
	genero(X, fem),
	atom_concat('A professora ', X, A),
	atom_concat(A, ' da ', B),
	atom_concat(B, Y, C),
	atom_concat(C, '.', NovaSaida),
	write(NovaSaida).

query(A, S0, S) :- S0=[quando|T], get_obj(X, T), X \= que, eh(X, Y), formata_saida(X, Y, A).
query(A, S0, S) :- S0=[quem|T], get_obj(X, T), X \= que, da(Y, X), formata_saida(Y, X, A).
query(A, S0, S) :- S0=[quem|T], get_obj(X, T), X = que, da(Z, Y), formata_saida(Z, Y, A).
query(A, S0, S) :- S0=[o|T], T = [que|T1], get_suj(X, T1), da(X, Y), formata_saida(X, Y, A).

get_suj(X, [E|T]) :- E = professora, T = [E1|T1], E1 = X.
get_suj(X, [E|T]) :- E = professor, T = [E1|T1], E1 = X.
get_suj(X, [E|T]) :- get_suj(X, T).

get_obj(X, [E|T]) :- is_verb(E), get_obj(X, T).
get_obj(X, [E|T]) :- E = o, T = [E1|T1], E1 = que, X = E1.
get_obj(X, [E|T]) :- X = E.

is_verb(eh).
is_verb(da).


programa(X) :- 
	monta_lista(L),
	ultimo_elem(Y, L),
	Y = '.',
	sentenca(Z, L, []).

programa(X) :- 
	monta_lista(L),
	ultimo_elem(Y, L),
	Y = '?',
	query(Z, L, []),
	nl.
