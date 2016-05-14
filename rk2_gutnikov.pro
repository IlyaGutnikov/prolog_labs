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
  	/* ����������� �������� ��� ���������� ����������� �������� � ������, �������� find_maxelem_re. */
  
nondeterm find_maxelem_re(list, integer, integer) /* (i, i, o) */
  	/* ����������� �������� ��� ���������� ����������� �������� � ������.
  	 * ������ ���� - ���������� �������, �� ���� ������������� � ������� ������� */
  
nondeterm append(list, list, list) /* (i, i, o) */
  	/* �������� ��� ����������� ���� ������� � ���� */	
  
nondeterm cut_elem(list, integer, list)	/* (i, i, o) */
  	/* ����������� �������� ��� ���������� �������� �� ������, �������� cut_elem_re */
  
nondeterm cut_elem_re(list, list, integer, list) /* (i, i, i, o) */
  	/* ����������� �������� ��� ���������� �������� �� ������ */
  
nondeterm sort_list_desc(list, list) /* (i, o) */
  	/* ����������� �������� ��� ���������� ���������� ������ */

CLAUSES
  /* ������� ��� ���������� ����������� �������� ������ */
  find_maxelem([H | Tail], Max) :- find_maxelem_re(Tail, H, Max).
  find_maxelem_re([], Max, Max).
  find_maxelem_re([H | Tail], CurMax, Max) :- H > CurMax, find_maxelem_re(Tail, H, Max), !.
  find_maxelem_re([_ | Tail], CurMax, Max) :- find_maxelem_re(Tail, CurMax, Max).
  	/* ���� �������� ������� H ������ ����������� ������ �������� ������������� �������� CurMax, ���������
  	 * ����������� ���������� ��� ��������� ����� ������ �� ��������� CurMax = H. ����� ��������� �����������
  	 * ���������� � ����������� �������� CurMax. �������� �������������, ����� �� �������� � ������� ������.
  	 * ��� ���� � ������� �������� CurMax ��������� �� ������� ������������ ��������: Max = CurMax.
  	 */
  
  /* ������� ��� ����������� ���� ������� � ���� */
  append([], List2, List2).
  append([H1 | Tail1], List2, [H1 | Tail3]) :- append(Tail1, List2, Tail3).
  
  /* ������� ��� ���������� �������� �� ������ */
  cut_elem(List, X, NewList) :- cut_elem_re([], List, X, NewList).
  cut_elem_re(Head, [], _, Head).	/* �� ������, ���� ������� � ����������� � ������. ��� ���������� ����������. */
  cut_elem_re(Head, [M | Tail], X, NewList) :- M = X, append(Head, Tail, NewList), !.
  cut_elem_re(Head, [M | Tail], X, NewList) :- append(Head, [M], NewHead), cut_elem_re(NewHead, Tail, X, NewList).
  	 
  /* ������� ��� ���������� ���������� ������ �� �������� */
  sort_list_desc([], []).
  sort_list_desc(List, Result) :- 
  	find_maxelem(List, Max),      	/* ������� ���������� ������� ������ */
  	person(A,Max),
  	write(A),nl,
  	cut_elem(List, Max, Rest),    	/* ��������� ��� �� ������ */
  	sort_list_desc(Rest, Result0), 	/* ��������� ���������� ���������� �� ���������� ������ */
  	Result = [Max | Result0].	/* ������ ����������� ������� �� ������ ����� */

sumlist([], 0, 0). 
sumlist([H|T], Sum, N):-
	sumlist(T, S1, N1), Sum=H+S1, N=1+N1.

person("Anna", 23). /*Age is less than average*/ 
person("Ben", 31).
person("Cate", 21). /*Age is less than average*/ 
person("Danny", 27).
person("Elizabeth", 18). /*Age is less than average*/

execute:-
	findall(Age, person(_, Age), L), /*������� ������ Age ���� ���������, ������������� � ��������� person b � �������� ��� � L */
	sort_list_desc(L, Result),
	write("Sort result = ", Result), nl.

GOAL 
execute.