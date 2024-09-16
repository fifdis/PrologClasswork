%% неоотрицательная степень целого числа
math_pow(_, 0, 1):-!.
math_pow(N, P, F) :- N>0, P>0, P1 is P-1, math_pow(N, P1, F1), F is N*F1.

%% то же самое, но с хвостовой рекурсией
powT(_, 0, R, R) :- !.
powT(N, P, R, F):- P1 is P-1, R1 is R*N, powT(N, P1, R1, F).
powT_U(N, P, F) :- powT(N, P, 1, F).

%% еще вариант
powP(_, N, N, R, R):-!.
powP(X, N, M, G, R):- M<N, N>0, M1 is M+1, G1 is G*X, powP(X, N, M1, G1, R).

%% ! - это отсечение (см. примеры в work1 после fibT)

%% _____________________________________________________

%% случайные числа
%% это функция random(число).
%% 
checkRand(R) :- X is random(10), X >= 5, R = X + 10.
checkRand(R) :- X is random(10), X < 5, R = X - 10.
%% запись выше очень плохая
%% потому что вызываются два random и не факт, что они подойдут по условию

%% checkRandC(R) :- X is random(10), checkRNew(X, R).

checkRNew(X, R) :- X >= 5, !, R = X + 10.
checkRNew(X, R) :- R = X - 10.

%% задача на random
genRand(R):-  X is random(20), genRandCheck(X, R).
genRandCheck(X, R) :- X > 15, !, R is X.
genRandCheck(_, R) :- genRand(R).

%% задача на простые числа - вывести простое число по его номеру

%% проверка на простое число
primeNum(1).
primeNum(N):-M is N-1, primeNumM(N, M).

primeNumM(N, M):- M>1, N mod M > 0, !, M1 is M-1, primeNumM(N, M1).
primeNumM(N, 1).

%% число по индексу
primeNumInd(I, I, N, N).
primeNumInd(Ind, I, N, Num):- I<Ind, primeNum(N), !, I2 is I+1, N2 is N+1, primeNumInd(Ind, I2, N2, Num).
primeNumInd(Ind, I, N, Num):- I<Ind, primeNum(N), N2 is N+1, primeNumInd(Ind, I2, N2, Num).
primeNumInd(Ind, 1, 1, Num).

%% _____________________________________________________
%% крутые и полезные предикаты
%% предикат findall(параметр1, параметр2, параметр3)
%% параметр1 - что из предиката сохраняется в третий параметр
%% параметр2 - предикат, в котором ищем все возможные варианты
%% параметр3 - результат


rpt. %% предикат repeat - просто создает точку возврата
rpt:-rpt. 
%% есть еще системный - repeat, повторяет просто выполнение
%% например repeat, X is random(4). будет выводить рандомные числа в пределах до 4

