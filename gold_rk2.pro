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
    sumlist:(list, age, integer) nondeterm anyflow.
    find_minelem:(list, integer) procedure anyflow./* Нахождение минимального элемента в списке */
    find_minelem_re:(list, integer, integer) procedure anyflow. /* Нахождение минимального элемента в списке, вспомогательная */
    find_maxelem:(list, integer) procedure anyflow. /* Нахождение максимального элемента в списке */
    find_maxelem_re:(list, integer, integer) procedure anyflow. /* Нахождение максимального элемента в списке, вспомогательная */
    append:(list, list, list) procedure anyflow.
    cut_elem:(list, integer, list) procedure anyflow.
    cut_elem_re:(list, list, integer, list) procedure anyflow.
    sort_list_desc:(list, list2) procedure anyflow. /* Сортировка по возрастанию */
    sort_list_esc:(list, list2) procedure anyflow. /* Сортировка по убыванию */
    print_nechet:(list2) procedure anyflow. /* Вывод имен людей с нечетными возрастами */
clauses
    find_minelem([],Min):-!,Min=1.
    find_minelem([H | Tail], Min) :- find_minelem_re(Tail, H, Min).
    find_minelem_re([], Min, Min).
    find_minelem_re([H | Tail], CurMin, Min) :- H < CurMin, find_minelem_re(Tail, H, Min), !.
    find_minelem_re([_ | Tail], CurMin, Min) :- find_minelem_re(Tail, CurMin, Min).

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
    sort_list_desc([], []) :- !.
    sort_list_desc(List, Result) :-
        find_minelem(List, Min),
        personq(A,Min),
        cut_elem(List, Min, Rest),
        sort_list_desc(Rest, Result0),
        Result = [A | Result0].
    sort_list_esc([], []) :- !.
    sort_list_esc(List, Result) :-
        find_maxelem(List, Max),
        personq(A,Max),
        cut_elem(List, Max, Rest),
        sort_list_esc(Rest, Result0),
        Result = [A | Result0].
    sumlist([], 0, 0).
    sumlist([H|T], Sum, N):-
        sumlist(T, S1, N1), Sum=H+S1, N=1+N1.
    personq(A, Min):-
        person(A, Min),!.
    personq(A,_):-!,A="".
    person("Jo", 23).
    person("Anna", 31).
    person("Kate", 21).
    person("Robin", 27).
    person("Ban", 18).
    person("Alex", 54).
    person("Alec", 16).
    person("Troy", 22).
    print_nechet([]).
    print_nechet([H|T]) :-
        person(H, Age),
        Age mod 2=1,!,
        write(H), nl,
        print_nechet(T).
    print_nechet([_H|T]) :-
        print_nechet(T).
clauses
	run() :-
        L = [ Age || person(_, Age) ],
        List = [ Name || person(Name,_ ) ],
        write("Spisok vozrastov"), nl,
        write(L), nl,
        write("Spisok imen"), nl,
        write(List), nl,
        write("Otsortirovaniy spisok imen"), nl,
        sort_list_esc(L, Res1),
        write(Res1), nl,
        write("Imena s nechetnimi vosrastami iz spiska"), nl,
        sort_list_esc(L, Res2),
        print_nechet(Res2),
        _=readLine().
end implement main
goal
	console::run(main::run).
