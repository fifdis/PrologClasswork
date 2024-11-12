%% превратить дерево, в котором данные хранятся в листьях, 
%% в дерево, где данные хранятся в узлах

change_tree(Tree, NewTree) :- 
	tree_values(Tree, Acc),
	build_tree(Acc, NewTree).
	
tree_values(leaf(Value), [Value]).
tree_values(node(L, R), Acc) :-
	tree_values(L, NewL),
	tree_values(R, NewR),
	append(NewL, NewR, Acc).
	
build_tree([], empty).
build_tree([H|T], node(H, NewTree)) :- build_tree(T, NewTree).

getTree(Tree) :- Tree = node(node(leaf(2), node(leaf(6), leaf(3))), node(leaf(4), leaf(5))).

%% еще вариант
treeConvert(tr(L, R), InpTr, OutTr) :- treeConvert(L, InpTr, TempTr), treeConvert(R, TempTr, OutTr).
treeConvert(leaf(X), InpTr, OutTr) :- insertIntoTree(X, InpTr, OutTr).
insertIntoTree(X, empty, tree(X, empty, empty)).
insertIntoTree(X, tree(Y, L, R), tree(Y, LX, R)) :- 0 is random(2), !, insertIntoTree(X, L, LX).
insertIntoTree(X, tree(Y, L, R), tree(Y, L, RX)) :- insertIntoTree(X, R, RX).

getTree2(Tree) :- Tree = tr(tr(leaf(2), tr(leaf(6), leaf(3))), tr(leaf(4), leaf(5))).
getTree3(Tree) :- Tree = tr(tr(leaf(2), leaf(3)), tr(leaf(4), leaf(5))).

%% проверка на сбалансированность
balanceTreeCheck(leaf(_)).
balanceTreeCheck(tr(L, R)) :- countValues(L, ResultL),
							  countValues(R, ResultR),
							  balanceTreeCheck(L),
							  balanceTreeCheck(R),
							  Dif is abs(ResultL-ResultR),
							  Dif =< 1.
countValues(empty, 0).
countValues(leaf(_), 1).
countValues(tr(L, R), Res) :- countValues(L, Res1), countValues(R, Res2), Res is Res1+Res2+1. 

%% удаление элемента из дерева (пока не доделано)
deleteValue(_, empty, empty).
deleteValue(X, leaf(X), empty) :- !.
deleteValue(_, leaf(Y), leaf(Y)).
deleteValue(X, tr(L, R), tr(LeftTree, RightTree)) :- deleteValue(X, L, LeftTree), deleteValue(X, R, RightTree), deleteValue(X, L, LeftTree), deleteValue(X, R, RightTree).
deleteValue(X, tr(leaf(_), empty), leaf(_)).
deleteValue(X, tr(empty, leaf(_)), leaf(_)).
%% deleteValue(X, tr(L, R), tr(L, RightTree)) :- deleteValue(X, R, RightTree).



