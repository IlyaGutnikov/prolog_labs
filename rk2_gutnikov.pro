DOMAINS 
name = string 
age = integer 
list = age* 
list2 = name*

PREDICATES
nondeterm person(name, age) 
sumlist(list, age, integer)
nondeterm execute

nondeterm find_maxelem(list, integer) /* (i, o) */
  	/* запускающий предикат для нахождения наибольшего элемента в списке, вызывает find_maxelem_re. */
  
nondeterm find_maxelem_re(list, integer, integer) /* (i, i, o) */
  	/* рекурсивный предикат для нахождения наибольшего элемента в списке.
  	 * Второй терм - наибольший элемент, из всех рассмотренных к данному моменту */
  
nondeterm append(list, list, list) /* (i, i, o) */
  	/* Предикат для объединения двух списков в один */	
  
nondeterm cut_elem(list, integer, list)	/* (i, i, o) */
  	/* запускающий предикат для исключения элемента из списка, вызывает cut_elem_re */
  
nondeterm cut_elem_re(list, list, integer, list) /* (i, i, i, o) */
  	/* рекурсивный предикат для исключения элемента из списка */
  
nondeterm sort_list_desc(list, list) /* (i, o) */
  	/* рекурсивный предикат для выполнения сортировки списка */

CLAUSES
  /* Аксиомы для нахождения наибольшего элемента списка */
  find_maxelem([H | Tail], Max) :- find_maxelem_re(Tail, H, Max).
  find_maxelem_re([], Max, Max).
  find_maxelem_re([H | Tail], CurMax, Max) :- H > CurMax, find_maxelem_re(Tail, H, Max), !.
  find_maxelem_re([_ | Tail], CurMax, Max) :- find_maxelem_re(Tail, CurMax, Max).
  	/* Если головной элемент H списка оказывается больше текущего максимального значения CurMax, процедура
  	 * запускается рекурсивно для хвостовой части списка со значением CurMax = H. Иначе процедура запускается
  	 * рекурсивно с сохранением значения CurMax. Рекурсия заканчивается, когда мы приходим к пустому списку.
  	 * При этом в текущее значение CurMax принимают за искомое максимальное значение: Max = CurMax.
  	 */
  
  /* Аксиомы для объединения двух списков в один */
  append([], List2, List2).
  append([H1 | Tail1], List2, [H1 | Tail3]) :- append(Tail1, List2, Tail3).
  
  /* Аксиомы для исключения элемента из списка */
  cut_elem(List, X, NewList) :- cut_elem_re([], List, X, NewList).
  cut_elem_re(Head, [], _, Head).	/* на случай, если элемент Х отсутствует в списке. При сортировке невозможно. */
  cut_elem_re(Head, [M | Tail], X, NewList) :- M = X, append(Head, Tail, NewList), !.
  cut_elem_re(Head, [M | Tail], X, NewList) :- append(Head, [M], NewHead), cut_elem_re(NewHead, Tail, X, NewList).
  	 
  /* Аксиомы для выполнения сортировки списка по убыванию */
  sort_list_desc([], []).
  sort_list_desc(List, Result) :- 
  	find_maxelem(List, Max),      	/* находим наибольший элемент списка */
  	person(A,Max),
  	write(A),nl,
  	cut_elem(List, Max, Rest),    	/* исключаем его из списка */
  	sort_list_desc(Rest, Result0), 	/* запускаем сортировку рекурсивно на полученном списке */
  	Result = [Max | Result0].	/* ставим наибольшитй элемент на первое место */

sumlist([], 0, 0). 
sumlist([H|T], Sum, N):-
	sumlist(T, S1, N1), Sum=H+S1, N=1+N1.

person("Anna", 23). /*Age is less than average*/ 
person("Ben", 31).
person("Cate", 21). /*Age is less than average*/ 
person("Danny", 27).
person("Elizabeth", 18). /*Age is less than average*/

execute:-
	findall(Age, person(_, Age), L), /*создает список Age всех возрастов, встречающихся в предикате person b и помещает его в L */
	sort_list_desc(L, Result),
	write("Sort result = ", Result), nl.

GOAL 
execute.