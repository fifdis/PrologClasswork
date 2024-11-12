%% деревья (теорию нужно дописать)
%% у дерева есть корень и листья
%% рекурсивное определение бинарного дерева: дерево либо пусто

%% tr(2, tr(7, empty, empty), tr(3, tr(4, empty, empty), tr(1, empty, empty))).

%% пример: предикат, который будет проверять принадлежность значения дереву
%% предикат будет иметь два аргумента: исходнове значение и дерево, где ищем

tree_member(X, tr(X, _, _)) :-!.
tree_member(X, tr(_, L, _)) :- tree_member(X, L), !.
tree_member(X, tr(_, _, R)) :- tree_member(X, R), !.

%% предикат, который будет заменять в дереве все вхождения одного значения на другое
%% --//--
%% --//--
%% двоичные справочники
%% --//--


%% получить количество элементов дерева, принадлежащих указанному диапазону
%% дерево задается параметрами (корень, левое, правое)
count_in_tree(empty, _, _, 0). %% если на вход приходит пустое дерево

%% проверка на нижний диапазон
count_in_tree(tr(X, L, R), Low, High, Count) :- 
				X < Low, 
				count_in_tree(L, Low, High, CountL),
				count_in_tree(R, Low, High, CountR),
				Count is CountL + CountR + 1, !.
%% проверка на верхний диапазон
count_in_tree(tr(X, L, R), Low, High, Count) :- 
				X > High,
				count_in_tree(L, Low, High, CountL),
				count_in_tree(R, Low, High, CountR),
				Count is CountL + CountR + 1, !.
%% когда входит в диапазон
count_in_tree(tr(X, L, R), Low, High, Count) :- 
				X >= Low,
				X =< High,
				count_in_tree(L, Low, High, CountL),
				count_in_tree(R, Low, High, CountR),
				Count is CountL + CountR + 1.
				
%% создать список элементов дерева, принадлежащих указанному диапазону
list_of_elementsU(Tree, Low, High, Elements) :- list_of_elements(Tree, Low, High, [], Elements).
list_of_elements(empty, _, _, Acc, Acc).
list_of_elements(tr(X, _, R), Low, High, Acc, Elements) :- 
				X < Low, 
				list_of_elements(R, Low, High, Acc, Elements).
list_of_elements(tr(X, L, _), Low, High, Acc, Elements) :- 
				X > High,
				list_of_elements(L, Low, High, Acc, Elements).
list_of_elements(tr(X, L, R), Low, High, Acc, Elements) :- 
				X >= Low,
				X =< High,
				list_of_elements(R, Low, High, Acc, ElementsR),
				list_of_elements(L, Low, High, [X|ElementsR], Elements).

%% создать дерево на основе списка, 
%% из которого в дерево переносятся только четные элементы
even_tree([], )