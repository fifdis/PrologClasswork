%% предикат, который удваивает значение в списке
doubleNum([], []).
doubleNum([X|T], [Y|Res]) :- Y is X * 2, doubleNum(T, Res).

%% предикат, который удаляет элементы списка на четных позициях
del(List, Res) :- del(List, 1, Res).
del([], _, []).
del([_|T], Pos, Res) :- Pos mod 2 =:=0, !, Next is Pos+1, del(T, Next, Res).
del([X|T], Pos, [X|ResT]) :- Next is Pos+1, del(T, Next, ResT).

%% разделить список на два: в одном отрицательные, в другом положительные числа
list_separate([], [], []).
list_separate([X|T], [X|Positive], Negative) :- X > 0, !, list_separate(T, Positive, Negative).
list_separate([X|T], Positive, [X|Negative]) :- X < 0, !, list_separate(T, Positive, Negative).
list_separate([X|T], Positive, Negative) :- X = 0, list_separate(T, Positive, Negative).

%% разделить список на два: в одном на четных позициях, в другом на нечетных
listPosSeparate(List, EvenPos, OddPos) :- listPosSeparate(List, 1, EvenPos, OddPos).
listPosSeparate([], _, [], []).
listPosSeparate([X|T], Pos, [X|Even], Odd) :- Pos mod 2 =:=1, !, Next is Pos+1, listPosSeparate(T, Next, Even, Odd).
listPosSeparate([X|T], Pos, Even, [X|Odd]) :- Next is Pos+1, listPosSeparate(T, Next, Even, Odd).

%% удаление предпослденего элемента из списка
penultimate([], []).
penultimate([_, Y], [Y]) :- !.
penultimate([X|T], [X|Res]) :- penultimate(T, Res).

%% цикл. сдвиг элементов в списке влево
shiftLeft([], []).
shiftLeft([X], [X]).
shiftLeft([F|T], S) :- shift(T, F, S).
shift([], F, [F]).
shift([X|T], F, [X|S]) :- shift(T, F, S).

%% цикл. сдвиг элементов в списке вправо
shiftRight([], []).
shiftRight([X], [X]).
shiftRight(List, Res) :- shiftR(List, Res, []).
shiftR([X], [X|Acc], Acc) :- !.
shiftR([X|T], Res, Acc) :- shiftR(T, Res, [X|Acc]).

%% цикл. сдвиг на определенное число влево


%% цикл. сдвиг на определенное число вправо

%% удаление повторяющися элементов


