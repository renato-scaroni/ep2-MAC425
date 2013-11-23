:- dynamic da/2.
:- dynamic eh/2.

ultimo_elem(X, [E1|T]) :- X = E1, T = [].
ultimo_elem(X, [E1|T]) :- ultimo_elem(X, T).

ultimo_antes(X, Y, [E|T]) :- T = [E2|Bla], Y = E2, X = E.
ultimo_antes(X, Y, [E|T]) :- ultimo_antes(X, Y, T).

eq(X, Y) :- X = Y.

cp(X, Y) :- eq(X, Y).
cp([El1|T], Y) :- cp(T, [El1|Y]).

corta_antes(L1, [Y|T], X) :- \+ Y = X, corta_antes(L1, T, X).
corta_antes(L1, [Y|T], X) :- Y = X, cp([Y|T], L2), L2 = L1.

sentenca(A, S0, S) :- s1p(A, S0, S).
sentenca(A, S0, S) :- s2(A, S0, S).
sentenca(A, S0, S) :- composta(A, S0, S).

composta(A, S0, S) :- s1(A, S0, [aas|T]).
composta(A, S0, S) :- ultimo_antes(X, aas, S0), corta_antes(L1, S0, X), s2(A, L1, S).

s1(A, S0, S) :- suj(X, S0, S1), obj(V, Y, S1, S), V = da, assert(da(X, Y)), A = da(X, Y).
s1p(A, S0, S) :- suj(X, S0, S1), obj(V, Y, S1, S2), S2=['.'], V = da, assert(da(X, Y)), A = da(X, Y).
%s2(A, S0, S) :- suj(X, S0, S1), obj(V, Y, S1, S), V = eh, assert(eh(X, Y)), A = eh(X, Y).
s2(A, S0, S) :- suj(X, S0, S1), obj(V, Y, S1, S2), S2=['.'], V = eh, assert(eh(X, Y)), A = eh(X, Y).

suj(A, S0, S) :- a(S0, S1), subs(A, S1, S).
suj(A, S0, S) :- a(S0, S1), prof(S1, S2), subs(A, S2, S).
suj(A, S0, S) :- subs(A, S0, S).

subs(A, S0, S) :- S0=[H|S], \+ a(H, []), \+ v(H, H, []), \+dias(H, D), A = H.
subs(A, S0, S) :- S0=[H|S], \+ a(H, []), \+ v(H, H, []), dias(H, D), A = D.
subs(A, S0, S) :- S0=[H|S1], \+ a(H, []), \+ v(H, H, []), \+dias(H, D), S1=[e|T], subs(X, T, S), A=[H,X].
subs(A, S0, S) :- S0=[H|S1], \+ a(H, []), \+ v(H, H, []), dias(H, D), S1=[e|T], subs(X, T, S), A=[D,X].

prof(S0, S) :- S0=[professor|S].
prof(S0, S) :- S0=[professora|S].
prof(S0, S) :- S0=[prof|S].

a(S0, S) :- S0=[o|S].
a(S0, S) :- S0=[a|S].

obj(V, A, S0, S) :- v(Y, S0, S1), V = Y, pred(X, S1, S), A = X.

pred(A, S0, S) :- suj(X, S0, S), A = X.

v(V, S0, S) :- S0=[da|S], V = da.
v(V, S0, S) :- S0=[eh|S], V = eh; S0=[eh, aas|S], V = eh;  S0=[aas|S], V = eh.

dias(domingos, 1).
dias(segundas, 2).
dias(tercas, 3).
dias(quartas, 4).
dias(quintas, 5).
dias(sextas, 6).
dias(sabados, 7).