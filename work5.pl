%% сортировки
%% пузырьковая сортировка
permutation([X,Y|T], [Y, X|T]) :- X > Y, !.
permutation([H|T], [H|TN]) :- permutation(T, TN).

%% выше - находится перваяs пара, которая не соответствет условию

bubble(L, LN) :- permutation(L, LL), !, bubble(LL, LN).
bubble(L, L).

%% сортировка слиянием

splitting([], [], []).
splitting([H], [H], []).
splitting([H1, H2|T], [H1|T1], [H2|T2]) :- splitting(T, T1, T2).

fusion(L, [], L) :- !.
fusion([], L, L) :- !.
fusion([H1|T1], [H2|T2], [H1|T]) :- H1<H2, !, fusion(T1, [H2|T2], T).
fusion(L, [H2|T2], [H2|T]) :- fusion(L, T2, T).

fusion_sort([], []) :- !.
fusion_sort([H], [H]) :- !.
fusion_sort(L, TS) :- splitting(L, T1, T2),
					fusion_sort(T1, T1S),
					fusion_sort(T2, T2S),
					fusion(T1S, T2S, TS).
					
%% генерация списка [N, 1] с хвостовой рекурсией (нужно для проверок сортировок)
lgenT2_U(N, T) :- lgenT2(1, N, [], T).
lgenT2(Cur, N, Acc, T):- Cur =< N, Acc2 = [Cur|Acc], Next is Cur+1, lgenT2(Next, N, Acc2, T).
lgenT2(Cur, N, Acc, Acc):-Cur>N.

%% генерация списка [1, N] с хвостовой рекурсией
lgenT_U(N, T) :- lgenT(N, [], T).
lgenT(0, Acc, Acc):-!.
lgenT(N, Acc, S):- N1 is N-1, lgenT(N1, [N|Acc], S).

%% список заданной длины со случайными числами из заданного диапазона
minmax(X1, X2, Min, Max):- X1 > X2, !, Min is X2, Max is X1.
minmax(X1, X2, Min, Max):- Min is X1, Max is X2.
random_list(0, _, _, []).
random_list(L, X1, X2, [Num|T]) :- L>0, minmax(X1, X2, Min, Max), random(Min, Max, Num), L1 is L-1, random_list(L1, X1, X2, T).

					
%% сортировка выбором (поиск минимального эдемента, 
%% он ставится в начало нового списка, снова ищется мин. эелемент и т.д.)

select_sort([], []).
select_sort(List, [Min|SortedT]) :- min_element(List, Min, T), select_sort(T, SortedT).      

min_element([X], X, []).  
min_element([X, Y|T], Min, [Y|TN]) :- X =< Y, !, min_element([X|T], Min, TN).
min_element([X, Y|T], Min, [X|TN]) :- min_element([Y|T], Min, TN).


%% сортировка вставкой (берется текущий элемент списка и вставляется в новый)
insert_sort([], []).

insert_sort([X|XS], Sort) :- insert_sort(XS, SortT), insert(X, SortT, Sort).

insert(X, [], [X]).
insert(X, [Y|YS], [X,Y|YS]) :- X =< Y. 
insert(X, [Y|YS], [Y|Sort]) :- X > Y, insert(X, YS, Sort).

%% быстрая сортировка (барьерный элемент)
quick_sort([], []).
quick_sort([X], [X]).
quick_sort([Pivot|T], Sort) :- 
				partition(T, Pivot, Left, Right), 
				quick_sort(Left, SortedLeft), 
				quick_sort(Right, SortedRight), 
				append(SortedLeft, [Pivot|SortedRight], Sort).  
				
partition([], _, [], []).
partition([X|T], Pivot, [X|Left], Right) :- 
						X =< Pivot, !, 
						partition(T, Pivot, Left, Right).
partition([X|T], Pivot, Left, [X|Right]) :- 
						partition(T, Pivot, Left, Right).

%% множества 
%% практически то же самое, только нет повторяющихся элементов
%% проверка, что элемент принадлежит множеству
member(X, [X|_]).
member(X, [_|T]) :- member(X, T). 

%% пересечение
intersection([], [], []).
intersection([], _, []).
intersection(_, [], []).
intersection([H|T], S, [H|I]) :- member(H, S), !, intersection(T, S, I).
intersection([_|T], S, I) :- intersection(T, S, I).

%% обьединение
union2([], [], []).
union2([], S, S).
union2(S, [], S).
union2([H|T], S, U) :- member(H, S), !, union2(T, S, U).
union2([H|T], S, [H|U]) :- union2(T, S, U).

%% подмножество через обьединение
subset(S1, S2) :- union(S1, S2, S2).
subset(S1, S2) :- intersection(S1, S2, S1).

%% равенство двух множеств
equal_sets(S1, S2) :- intersection(S1, S2, S1), intersection(S2, S1, S2).
equal_sets2(S1, S2) :- subset(S1, S2), subset(S2, S1).