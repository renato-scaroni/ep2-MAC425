final('.').
final('?').

separa_final(Frase, NovaFrase, Final):-
	atom_concat(F, Final, Frase),
	atom_concat(F, ' ', F2),
	atom_concat(F2, Final, NovaFrase),
	final(Final),
	!. 

separa_final(Frase, NovaFrase, ''):-
	Frase = NovaFrase.

monta_lista(L):-
	read_line_to_codes(user_input, X),
	string_to_atom(X, AX),
	downcase_atom(AX, DAX),
	separa_final(DAX, NDAX, T),
    atomic_list_concat(L, ' ', NDAX).