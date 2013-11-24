% 46 eh .
% 32 eh espaco

ultimo_elem(X, [E1|T]) :- X = E1, T = [].
ultimo_elem(X, [E1|T]) :- ultimo_elem(X, T).

append([], List, List).
append([Head|Tail], List, [Head|Rest]) :- append(Tail, List, Rest).

read_line(L) :- get0(C), char_code_list(C,L).

char_code_list(10,[]) :- !.
char_code_list(C,[C|X]) :- get0(C2), char_code_list(C2,X).


is_word(X) :- ultimo_elem(Y, X), Y = 32.
is_word(X) :- ultimo_elem(Y, X), Y = 46.

get_word(S, X) :- is_word(X), is_subset(S, X).

is_subset([E1|T1], [E2|T2]) :- E1 = E2, is_subset(T1, T2).
is_subset([E1|T1], [E2|T2]) :- E1 \= E2, is_subset(T1, [E2|T2]).
is_subset(T1, T2) :- T2 = [].

monta_lista(X) :-
  read_line(X),
  %atom_codes(Y, X),
  write(X).