%% _____________________________________________________
%% связи
%% первый параметр - главный, второй - вспомогательный
parent(nick, john).
parent(nick, kate).
parent(mary, john).
parent(kate, george).
parent(kate, rose).
parent(mike, rose).
parent(john, leo).

male(nick).
male(john).
male(george).
male(mike).

female(kate).
female(mary).
female(rose).

% X - отец Y, если X - мужчина и родитель Y
father(X, Y) :- male(X), parent(X,Y).
% X - мать Y, если Х - женщина и родитель Y
mother(X, Y) :- female(X), parent(X,Y).
% Y - сын X, если Y - мужчина и его родитель X
son(X, Y) :- male(Y), parent(X, Y).
% Y - дочь X, если Y - женщина и ее родитель X
daugther(X, Y) :- female(Y), parent(X, Y).
% Y - брат Z, если Х - мужчина и родитель Y
brother(Y, Z) :- male(Y), parent(X, Y), parent(X, Z), dif(Y, Z).
% Y - сестра Я, если Х - женщина и родитель Y
sister(Y, Z) :- female(Y), parent(X, Y), parent(X, Z), dif(Y, Z).
% X - дедушка Y, если Х - женщина и родитель Z, а Z родитель Y
grandfather(X, Y) :- male(X), parent(X, Z), parent(Z, Y).
% X - бабушка Y, если Х - женщина и родитель Z, а Z родитель Y
grandmother(X, Y) :- female(X), parent(X, Z), parent(Z, Y).
% X - дядя Y, если Х - брат Z, а Z родитель Y
uncle(X, Y) :- parent(Z, Y), brother(X, Z).
% X - тетя Y, если Х - ctcnhf Z, а Z родитель Y
aunt(X, Y) :- parent(Z, Y), sister(X, Z).

%% _____________________________________________________
%% рекурсия

%% рекурсия состоит из базиса и шага
%% базис - ??
%% шаг - ??
%% в шаге рекурсии параметры в заголовке и в рекурсивном вызове должны отличаться хотя бы на 1

ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(X,Z), ancestor(Z,Y).


fact(0, 1).
fact(N, F) :- N>0, N1 is N-1, fact(N1, F1), F is N*F1.

%% хвостовая рекурсия может помочь не хранить все переменные и вызовы в основной рекурсии
%% результат F1 для N1
factT(N, F, N, F):-!.
factT(N, F, N1, F1) :- N2 is N1+1, F2 is N2*F1, factT(N, F, N2, F2).
factT_U(N, F) :- factT(N, F, 0, 1).

%% вычисление чисел Фибоначчи
fib(0, 1).
fib(1, 1).
fib(N, F) :- N > 1, N1 is N-1, N2 is N-2, fib(N1, F1), fib(N2, F2), F is F1+F2.

%% то же самое, только с хвостовой рекурсией
fibT_U(N, F) :- fibT(N, 0, 1, F).
fibT(0, F1, _, F1):-!.
fibT(N, F1, F2, F) :- N>0, N1 is N-1, F3 is F2+F1, fibT(N1, F2, F3, F).

%% _____________________________________________________
%% отсечение
%% ! - это отсечение
%% можно оптимизировать задачу с родственниками при помощи отсечения
sister2(Y, Z) :- parent(X, Y), parent(X, Z), female(Y), !, dif(Y, Z).

%% это актуально при решении задачи с максимумом
%% то есть если X>=Y не выполняется, то других вариантов было не может
max2Т(X, Y, X) :- X>=Y,!.
max2(Y, X, X).

checkX(X, R):- X>100, !, R is X*X.
checkX(X, R):- X>50, !, R is X*X*X.
checkX(X, R):- X>10, !, R is X*X*X*X.

