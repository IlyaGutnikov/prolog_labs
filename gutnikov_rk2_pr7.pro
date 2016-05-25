implement main
	open core, console
domains
    name = string.
    age = integer.
    list = age*.
    list2 = name*.
class predicates
    person:(name, age) nondeterm anyflow.
    personq:(name, age) procedure anyflow.
    find_maxelem:(list, integer) procedure anyflow. /* Нахождение максимального элемента в списке */
    find_maxelem_re:(list, integer, integer) procedure anyflow. /* Нахождение максимального элемента в списке, вспомогательная */
    append:(list, list, list) procedure anyflow.
    cut_elem:(list, integer, list) procedure anyflow.
    cut_elem_re:(list, list, integer, list) procedure anyflow.
    sort_list_esc:(list, list2) procedure anyflow. /* Сортировка по убыванию */
clauses
    find_maxelem([],Max):-Max=1.
    find_maxelem([H | Tail], Max) :- find_maxelem_re(Tail, H, Max).
    find_maxelem_re([], Max, Max) :- !.
    find_maxelem_re([H | Tail], CurMax, Max) :- H > CurMax, find_maxelem_re(Tail, H, Max), !.
    find_maxelem_re([_ | Tail], CurMax, Max) :- find_maxelem_re(Tail, CurMax, Max).
    append([], List2, List2).
    append([H1 | Tail1], List2, [H1 | Tail3]) :- append(Tail1, List2, Tail3).
    cut_elem(List, X, NewList) :- cut_elem_re([], List, X, NewList).
    cut_elem_re(Head, [], _, Head).
    cut_elem_re(Head, [M | Tail], X, NewList) :- M = X, append(Head, Tail, NewList), !.
    cut_elem_re(Head, [M | Tail], X, NewList) :- append(Head, [M], NewHead), cut_elem_re(NewHead, Tail, X, NewList).
    sort_list_esc([], []) :- !.
    sort_list_esc(List, Result) :-
        find_maxelem(List, Max),
        personq(A,Max),
        cut_elem(List, Max, Rest),
        sort_list_esc(Rest, Result0),
        Result = [A | Result0].
    personq(A, Min):-
        person(A, Min),!.
    personq(A,_):-!,A="".
    person("Anna", 23).
    person("Ben", 31).
    person("Cate", 21).
    person("Danny", 27).
    person("Elizabeth", 18).
clauses
	run() :-
        L = [ Age || person(_, Age) ],
        List = [ Name || person(Name,_ ) ],
        write("Список возрастов"), nl,
        write(L), nl,
        write("Список имен"), nl,
        write(List), nl,
        write("Отсортированный список имен"), nl,
        sort_list_esc(L, Res1),
        write(Res1), nl,
        _=readLine().
end implement main
goal
	console::run(main::run).
