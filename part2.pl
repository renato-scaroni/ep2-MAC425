animal(dog).


read_animal(X) :-
  write('please type animal name:'),
  nl,
  read(X),
  write(X).