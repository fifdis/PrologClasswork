%% операция =..
%% позвляет динамически создать предикат
%% работает в обе стороны

mul(X, Y, Z) :- P=..[Y, X, Z], P.


%% операции ввода-вывода (write() и read())
%% если не указано откуда и куда вводим - используется поток по умолчанию (консоль)
%% открытие и закрытие файла обязательно
%% октрытие файла - open(где, как именно (read/write/append), где будет располагаться поток)
%% write(сам поток, комментарий какой-то)
%% nl(поток) - перевод на новую строку
%% current_output(CurOUT) - сохраняет текущий поток в переменную (туда будет записан поток консоли)
%% set_output(новый поток) - смена потока

%% сформировать двоичный справочник, который формируется на основе пользовательского
%% ввода каждого элемента по отдельности, который продолжается до тех пор, пока 
%% пользователь не введет элемент, который уже был (повторяющийся элемент). Ввод через консоль

build_tree(Tree) :- read_element(empty, Tree).

read_element(Tree, ResTree) :- 
				writeln('Your number:'), 
				read(X), 
				check_input(X, Tree, ResTree).

check_input(X, Tree, Tree) :- 
				insert(Tree, X, Tree), 
				writeln('Element is already exist').
check_input(X, Tree, ResTree) :- 
				insert(Tree, X, NewTree), 
				NewTree \= Tree, 
				read_element(NewTree, ResTree).

insert(empty, X, tr(empty, X, empty)).
insert(tr(L, X, R), X, tr(L, X, R)).
insert(tr(L, Root, R), X, tr(NewL, Root, R)) :- X < Root, insert(L, X, NewL).
insert(tr(L, Root, R), X, tr(L, Root, NewR)) :- X > Root, insert(R, X, NewR). 

%% обход по ширине с выводом в файл
getTree(Tree) :- Tree = tr(tr(tr(empty, 1, empty), 8, empty), 10, tr(empty, 12, tr(empty, 13, tr(empty, 15, empty)))).
main(Tree) :- open('D:\\Work\\Prolog\\output.txt', write, NewStream),
			  breadth_search([Tree], NewStream),
			  close(NewStream).
breadth_search([], _).
breadth_search([empty|T], NewStream) :- breadth_search(T, NewStream).	  
breadth_search([tr(L, X, R)|T], NewStream) :- write(NewStream, X),
										      write(NewStream, ' '),
											  breadth_search([L|T], NewStream),
											  breadth_search([R|T], NewStream).
